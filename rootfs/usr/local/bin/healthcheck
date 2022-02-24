#!/bin/bash

resp_code=$(/usr/bin/curl --output "/dev/null" --silent --show-error --write-out %{http_code} "http://127.0.0.1:9117/jackett/api/v2.0/indexers/all/results/torznab/api?apikey=$JACKETT_API_KEY&t=indexers&limit=1&configured=true")

if [ $resp_code == '200' ]; then 
  echo "OK [$resp_code]" 
  exit 0
else
  echo "NO [$resp_code]"
  exit 1
fi

exit 1
