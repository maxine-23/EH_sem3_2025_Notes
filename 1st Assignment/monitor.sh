BASH SCRIPT:
#!/bin/bash

# Domain to monitor
DOMAIN="google.com"

# CSV log file name
LOG_FILE="ping_log.csv"

# Add CSV header if the file doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Domain,ResponseTime(ms)" >> "$LOG_FILE"
fi

# Infinite loop to ping every 5 minutes
while true; do
    # Get current date and time
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # Perform ping and check if it succeeds
    PING_RESULT=$(ping -c 1 -W 2 $DOMAIN | grep 'time=')
    if [ $? -eq 0 ]; then
        # Extract response time using sed
        RESPONSE_TIME=$(echo "$PING_RESULT" | sed -n 's/.*time=\(.*\) ms/\1/p')
    else
        RESPONSE_TIME="DOWN"
    fi

    # Log the result in CSV
    echo "$TIMESTAMP,$DOMAIN,$RESPONSE_TIME" >> "$LOG_FILE"

    # Wait for 5 minutes (300 seconds)
    sleep 300
done

To execute the Bash script, I first created a new file using the nano text editor by running nano monitor.sh in the terminal. I then pasted the monitoring script into the editor, saved the file by pressing Ctrl + O, hit Enter to confirm, and exited using Ctrl + X. After that, I made the script executable by running chmod +x monitor.sh. Finally, I started the script with ./monitor.sh, and it began running in an infinite loop, pinging the target domain every 5 minutes and logging the results into ping_log.csv.

