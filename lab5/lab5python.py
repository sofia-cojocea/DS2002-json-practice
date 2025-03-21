#!/usr/bin/env python3

import json
import csv

with open('/home/scojocea1/DS2002-json-practice/data/schacon.repos.json', 'r') a>
    data = json.load(file)

with open('chacon.csv', 'w', newline='') as csvfile:
        fieldnames = ['name', 'html_url', 'updated_at', 'visibility']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for entry in data[:5]:
                writer.writerow({
                        'name' : entry.get('name', ''),
                        'html_url' : entry.get('html_url', ''),
                        'updated_at': entry.get('updated_at', ''),
                        'visibility': entry.get('visibility', '')
                })


