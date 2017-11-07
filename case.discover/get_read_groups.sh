# Given a case, process all entries in samples_from_case data file, and obtain all read groups associated
# with each entry

if [ "$#" -ne 2 ]; then
    echo Error: Wrong number of arguments
    echo Usage: get_read_groups.sh CASE TOKEN
    exit
fi

CASE=$1
TOKEN=$2

function read_group_from_sample_query {
    SAMPLE=$1 # E.g C3L-00004-31
    cat <<EOF
    {
        read_group(with_path_to: {type: "sample", submitter_id:"$SAMPLE"}, first:1000)
        {
            submitter_id
            library_strategy
            experiment_name
        }
    }
EOF
}

DAT="dat/$CASE/sample_from_case.$CASE.dat"
OUTD="dat/$CASE"
mkdir -p $OUTD
OUT="$OUTD/read_group_from_case.$CASE.dat"
rm -f $OUT

>&2 echo Reading $DAT

while read L; do
# sample line
# C3L-00561-31	a19a4c9e-9421-4473-a1d1-78b066504679	Blood Derived Normal

    SAMPLE=$(echo "$L" | cut -f 1)

    Q=$(read_group_from_sample_query $SAMPLE)

    >&2 echo QUERY: $Q

    R=$(echo $Q | queryGDC -r -v -t $TOKEN -)

    echo $R | jq -r '.data.read_group[] | "\(.submitter_id)\t\(.library_strategy)\t\(.experiment_name)"' | sed "s/^/$SAMPLE\t/" >> $OUT

    printf "\n"

done < $DAT

echo Written to $OUT
printf "\n"
