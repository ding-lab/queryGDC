# Return details on all samples for a given case
# writes "sample_from_case" file

if [ "$#" -ne 2 ]; then
    echo Error: Wrong number of arguments
    echo Usage: 2_get_sample.sh CASE TOKEN
    exit
fi

CASE=$1
TOKEN=$2

function sample_from_case_query {
CASE=$1 # E.g C3L-00004
cat <<EOF
{
    sample(with_path_to: {type: "case", submitter_id:"$CASE"})
    {
        submitter_id
        id
        sample_type
    }
}
EOF
}

OUTD="dat/$CASE"
mkdir -p $OUTD
OUT="$OUTD/sample_from_case.$CASE.dat"

Q=$(sample_from_case_query $CASE)

>&2 echo QUERY: $Q

R=$(echo $Q | queryGDC -r -v -t $TOKEN -)

echo $R | jq -r '.data.sample[] | "\(.submitter_id)\t\(.id)\t\(.sample_type)"' > $OUT

echo Written to $OUT
printf "\n"
