# Background

Simple command line tool to perform graphGL queries for NCI Genomics Data Commons.  Given a "bare GraphQL" query ([as described here](https://docs.gdc.cancer.gov/API/Users_Guide/Submission/#querying-submitted-data-using-graphql)), this script constructs and passes a JSON query, and writes out the response.

# Sample Usage

1. [Obtain GDC authentication token](https://docs.gdc.cancer.gov/Data_Submission_Portal/Users_Guide/Authentication/)
2. Construct GraphQL query, e.g.,

```
{
  case (project_id: "TCGA-ALCH", first: 0) {
    id
    submitter_id

  }
  _case_count (project_id: "TCGA-ALCH")
}
```

3. Perform query with,

```
   queryGDC TOKEN QUERY
```

# Case Discover

`case.discover` directory contains several scripts for discovering and summarizing all SR (`submitted_aligned_reads` and `submitted_unaligned_reads`)
associated with a given case.  These scripts are,

1. `get_sample.sh`: Get information about all samples for a given case
2. `get_read_groups.sh`: Get information about all read groups for a given case (using sample information)
3. `get_submitted_reads.sh`: Get information about SR for a given case (using `read_group` information)
4. `merge_submitted_reads.sh`: Summarize SR information, writing the following for every unique submitted read file, ` case, disease, experimental_strategy, sample_type, samples, filename, filesize, UUID, md5sum `

These scripts were developed for CPTAC3 Genomic project but should be of general use.
 
# Useful links:

* [Definition of GraphQL language](http://facebook.github.io/graphql/October2016/#sec-Overview)
* [Tutorial about GraphQL queries](http://graphql.org/learn/queries/)
* [graphQL documentation at GDC](https://docs.gdc.cancer.gov/API/Users_Guide/Submission/#querying-submitted-data-using-graphql)
* [GDC Data Model](https://gdc.cancer.gov/developers/gdc-data-model/gdc-data-model-components)
* [GraphiQL](https://portal.gdc.cancer.gov/submission/graphiql) A graphical interface for the GDC GraphQL
