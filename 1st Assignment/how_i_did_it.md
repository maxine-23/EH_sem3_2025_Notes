
# Website Monitoring Project - Implementation & GitHub Upload Guide

This document outlines how I implemented a website monitoring system using a Bash script, logged the response time data, converted an image of the data to CSV, and uploaded everything to GitHub.

---

## Step 1: Writing the Monitoring Script

- I created a Bash script named `monitor.sh` that:
  - Pings a domain (e.g., `google.com`) every 5 minutes
  - Logs the timestamp, domain, and response time
  - Saves all logs in a file named `ping_log.csv`

### Sample Snippet from `monitor.sh`

```bash
#!/bin/bash

DOMAIN="google.com"
LOG_FILE="ping_log.csv"

if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Domain,ResponseTime(ms)" >> "$LOG_FILE"
fi

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    PING_RESULT=$(ping -c 1 -W 2 $DOMAIN | grep 'time=')
    if [ $? -eq 0 ]; then
        RESPONSE_TIME=$(echo "$PING_RESULT" | sed -n 's/.*time=\(.*\) ms//p')
    else
        RESPONSE_TIME="DOWN"
    fi
    echo "$TIMESTAMP,$DOMAIN,$RESPONSE_TIME" >> "$LOG_FILE"
    sleep 300
done
```

## Step 2: Extracting Data from an Image
- I had a screenshot of a CSV log
- Using OCR (Optical Character Recognition), I extracted the text data from the image
- I cleaned and structured the data into:
  - Timestamps
  - Domain names
  - Response times
- I saved this as a new file: `ping_log.csv`

## Step 3: Running the Script on Windows (Using WSL)
- Installed Windows Subsystem for Linux (WSL) and Ubuntu
- Opened the Ubuntu terminal and ran the Bash script
- Let it run to generate sample log data

## Files in My GitHub Repo
- `monitor.sh` — Bash script that performs website monitoring
- `ping_log.csv` — Log of pings and response times
- `website_monitoring_report.md` — 1-page report for submission
- `how_i_did_it.md` — Step-by-step documentation
