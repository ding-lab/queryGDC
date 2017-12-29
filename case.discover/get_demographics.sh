# Get demographics information about all cases in given cases file
# Writes one line per CASE to stdout

if [ "$#" -ne 2 ]; then
    echo Error: Wrong number of arguments
    echo Usage: get_demographics.sh CASE_FILE TOKEN_FILE
    exit
fi

CASES=$1
TOKEN=$2

function demo_from_case_query {
CASE=$1 # E.g C3L-00004
cat <<EOF
{
    demographic(with_path_to: {type: "case", submitter_id:"$CASE"})
    {
        ethnicity
        gender
        race
        days_to_birth
    }
}
EOF
}

# print header
printf "# case\tethnicity\tgender\trace\tdays_to_birth\n"

# Loop over all case names in file $CASES
while read CASE; do

    [[ $CASE = \#* ]] && continue  # Skip commented out entries

    Q=$(demo_from_case_query $CASE)
    R=$(echo $Q | queryGDC -r -t $TOKEN -)
    LINE=$(echo $R | jq -r '.data.demographic[] | "\(.ethnicity)\t\(.gender)\t\(.race)\t\(.days_to_birth)"')

    printf "$CASE\t$LINE\n" 

done < $CASES

