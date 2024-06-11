#!/bin/bash
CLIENTS=("https://test.robinrams.com" "https://demo.robinrams.com")
METRICS_PATH="/var/www/html/metrics"
> $METRICS_PATH/curl_metrics_.prom
for CLIENT in "${CLIENTS[@]}"
do
        echo "CURLING $CLIENT"
        RESPONSE=$(curl -o /dev/null -s -w "%{http_code}" $CLIENT)
        if [ "$RESPONSE" -eq 200 ]; then
          echo "curl_check_success_{url=\"$CLIENT\"} 1" >> $METRICS_PATH/curl_metrics_.prom
        else
          echo "curl_check_success_{url=\"$CLIENT\"} 0" >> $METRICS_PATH/curl_metrics_.prom
        fi
done
