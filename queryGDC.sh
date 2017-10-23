#!/bin/bash -l

# Execute given GraphQL file as a query to GDC
# Usage: bash queryGDC.sh token.txt query.dat

function run_query {
    QUERY=$1
    curl -s -XPOST -H "X-Auth-Token: $t" https://gdc-api.nci.nih.gov/v0/submission/graphql --data "$QUERY" 
}

function get_json {
# Creates valid GDC query JSON string based on graphQL data
# For testing, this content of GQL file works:
# { sample(with_path_to: {type: "case", submitter_id:"C3L-00004"}) { id submitter_id sample_type } }
GQL=$1

PY="import json, sys; query = sys.stdin.read().rstrip(); d = { 'query': query, 'variables': 'null' }; print(json.dumps(d))"

python -c "$PY" < $GQL
}


# Run a query in a given file against GDC server
# where query is file with bare_graphql query (as described here
# https://docs.gdc.cancer.gov/API/Users_Guide/Submission/#querying-submitted-data-using-graphql )

if [ "$#" -ne 2 ]; then
echo Incorrect number of arguments passed: got $#, expecting 2
echo Usage: bash queryGDC.sh token.txt query.json
exit
fi

#TOKEN="config/gdc-user-token.2017-10-23T18-08-47.214Z.txt"
TOKEN=$1
if [ ! -f $TOKEN ]; then
    echo Token $TOKEN not found
    exit
fi

export t=$(cat $TOKEN)

JSON=$(get_json $2)

run_query "$JSON"

