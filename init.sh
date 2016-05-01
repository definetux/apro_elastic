#!/bin/bash

# Init
mapping_file=$1
data_file=$2
index='github'
type='repository'
url='localhost'
port='9292'

# Create mapping
curl -X PUT "$url:$port/$index" -d @$mapping_file

# Seed data
cat $data_file | jq -c '.[] | {"index": {"_index": "github", "_type": "repository"}}, .' | curl -XPOST $url:$port/_bulk --data-binary @-

# Check result
curl -X GET "$url:$port/$index/$type/_search?pretty"