#!/bin/bash

# Fetch weather data and save it to a file
curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbo>

# Extract receipt times
jq -r '.[].receiptTime' aviation.json | head -n 6

# Extract temperatures and calculate average
temperatures=$(jq -r '[.[].temp]' aviation.json)
sum=0
count=0
for temp in $temperatures; do
    sum=$((sum + temp))
    count=$((count + 1))
done

# Avoid division by zero
if ((count > 0)); then
    averagetemp=$((sum / count))
else
    averagetemp=0
fi

# Count clouds
cloudcount=0
jq -r '.[] | .clouds ' aviation.json | while read cloud; do
    if [[ "$cloud" != "CLR" ]]; then
        cloudcount=$((cloudcount + 1))
    fi
done

# Check if it's mostly cloudy
mostlycloudy=false
if ((cloudcount > count / 2)); then
    mostlycloudy=true
fi

# Output results
echo "Average temperature: $averagetemp"
echo "Mostly cloudy: $mostlycloudy"
