import subprocess
import requests

# Replace <telegram_bot_token> with your actual bot token
telegram_bot_token = '<telegram_bot_token>'
# Replace <telegram_chat_id> with your actual chat ID to send the message to
telegram_chat_id = '<telegram_chat_id>'

# Get the 24-hour network usage data using vnstat
usage_command = ['vnstat', '-h']
usage_data = subprocess.check_output(usage_command).decode()

# Send the usage data to Telegram using the bot API
telegram_message = f'Network Usage in the last 24 hours:n{usage_data}'
telegram_url = f'https://api.telegram.org/bot{telegram_bot_token}/sendMessage'
telegram_data = {'chat_id': telegram_chat_id, 'text': telegram_message}
requests.post(telegram_url, json=telegram_data)
