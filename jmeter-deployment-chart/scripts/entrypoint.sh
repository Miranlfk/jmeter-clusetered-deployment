#!/bin/sh
set -e

SLAVES=$(getent hosts jmeter-slaves | awk '{print $1}' | paste -sd "," -)
echo "Detected slave IPs: $SLAVES"

jmeter -Jserver.rmi.ssl.disable=true -n -t /tests/$TEST_PLAN_FILE -R $SLAVES 

# echo "Uploading to S3: $S3_BUCKET/results-$(date +%Y%m%d%H%M%S).jtl"
# aws s3 cp /results/results.jtl $S3_BUCKET/results-$(date +%Y%m%d%H%M%S).jtl
echo "Test completed."