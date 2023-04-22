#!/bin/bash
#
# Credit to original author: mrlongshen https://github.com/mrlongshen/blockpublictorrent-iptables
# GitHub:   https://github.com/Heclalava/blockpublictorrent-iptables
# Author:   Heclalava

TRACKERS_URL="https://raw.githubusercontent.com/Heclalava/blockpublictorrent-iptables/main/trackers"
HOSTS_TRACKERS_URL="https://raw.githubusercontent.com/Heclalava/blockpublictorrent-iptables/main/hostsTrackers"
ETC_HOSTS="/etc/hosts"

echo -n "Blocking public trackers ... "

# Download a list of public trackers to block
if ! wget -q -O /etc/trackers $TRACKERS_URL; then
    echo "Failed to download list of trackers."
    exit 1
fi

# Add iptables rules to block the public trackers if they don't already exist
IFS=$'n'
L=$(/usr/bin/sort /etc/trackers | /usr/bin/uniq)
for fn in $L; do
    # Check if the rule already exists before adding it
    if ! /sbin/iptables-save | grep -q " DROP .* $fn$"; then
        /sbin/iptables -A INPUT -d $fn -j DROP
        /sbin/iptables -A FORWARD -d $fn -j DROP
        /sbin/iptables -A OUTPUT -d $fn -j DROP
    fi
done

# Create a cron job to run the iptables rule daily
cat >/etc/cron.daily/denypublic<<'EOF'
#!/bin/bash
IFS=$'n'
L=$(/usr/bin/sort /etc/trackers | /usr/bin/uniq)
for fn in $L; do
    /sbin/iptables -D INPUT -d $fn -j DROP
    /sbin/iptables -D FORWARD -d $fn -j DROP
    /sbin/iptables -D OUTPUT -d $fn -j DROP
    /sbin/iptables -A INPUT -d $fn -j DROP
    /sbin/iptables -A FORWARD -d $fn -j DROP
    /sbin/iptables -A OUTPUT -d $fn -j DROP
done
EOF
chmod +x /etc/cron.daily/denypublic

# Download a list of hosts used by public trackers and add them to /etc/hosts
if ! wget -q -O - $HOSTS_TRACKERS_URL | while read line; do
        if ! grep -q "^$line" $ETC_HOSTS; then
            echo "$line" >> $ETC_HOSTS
        fi
    done; then
    echo "Failed to download and add list of trackers to /etc/hosts."
    exit 1
fi

echo "Done."
