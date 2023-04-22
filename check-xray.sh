#!/bin/bash

# Define the name of the service to monitor
service_name=xray

while true
do
    # Check if the service is running with systemctl
    if systemctl is-active --quiet $service_name ; then
        echo "$service_name is running"
    else
        echo "$service_name is NOT running. Starting $service_name ..."
        systemctl start $service_name
    fi

    # Wait for some time before checking the status again
    sleep 10
done

