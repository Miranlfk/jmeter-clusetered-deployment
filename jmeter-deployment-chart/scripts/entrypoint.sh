#!/bin/sh
set -e

SLAVES=$(getent hosts jmeter-slaves | awk '{print $1}' | paste -sd "," -)
echo "Detected slave IPs: $SLAVES"

jmeter -n -t /tests/$TEST_PLAN_FILE -R $SLAVES -l /results/results.jtl

echo "Uploading to S3: $S3_BUCKET/results-$(date +%Y%m%d%H%M%S).jtl"
aws s3 cp /results/results.jtl $S3_BUCKET/results-$(date +%Y%m%d%H%M%S).jtl
