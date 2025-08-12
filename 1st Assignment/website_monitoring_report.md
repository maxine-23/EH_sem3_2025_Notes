
# Website Monitoring System Report

## Objective

To implement an **automated monitoring system** that checks if a website is responsive and logs its **response time** every **5 minutes**. The purpose is to enable early detection of service disruptions, performance degradation, and potential cyber threats such as **DDoS attacks**.

---

## Methodology

A **Bash script** was created to continuously:

- **Ping** a specified domain (`google.com` by default)
- **Extract the response time** from the ping result
- **Log the timestamp, domain, and response time** to a CSV file (`ping_log.csv`)
- Sleep for 5 minutes and repeat the process indefinitely

If the ping fails (e.g., due to network or DNS issues), the script logs `"DOWN"` as the response time.

### Script Snippet

```bash
while true; do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  PING_RESULT=$(ping -c 1 -W 2 google.com | grep 'time=')
  RESPONSE_TIME=$(echo "$PING_RESULT" | sed -n 's/.*time=\(.*\) ms//p')
  echo "$TIMESTAMP,google.com,${RESPONSE_TIME:-DOWN}" >> ping_log.csv
  sleep 300
done
```

---

## Sample Output (CSV Log)

```
Timestamp,Domain,ResponseTime(ms)
2025-07-31 17:00:00,google.com,18.4
2025-07-31 17:05:00,google.com,20.1
2025-07-31 17:10:00,google.com,DOWN
```

---

## Benefits for Security Monitoring

- **Outage Alerts:** Detects when a server becomes unreachable.
- **Performance Trends:** Response time increases may indicate overload or attacks.
- **Forensic Support:** Timestamps help correlate with incident logs or external events.
- **Anomaly Detection:** Sudden spikes in latency or repeated “DOWN” entries signal potential threats.

---

## Future Enhancements

- Email or SMS alerts on failures  
- Graphical dashboard to view trends  
- Integration with tools like Prometheus or Grafana  
- Logging to centralized monitoring systems  
