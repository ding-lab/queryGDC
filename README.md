Useful links:

* [Definition of GraphQL language](http://facebook.github.io/graphql/October2016/#sec-Overview)
* [Tutorial about GraphQL queries](http://graphql.org/learn/queries/)
* [graphQL at GDC](https://docs.gdc.cancer.gov/API/Users_Guide/Submission/#querying-submitted-data-using-graphql)
* [GDC Data Model](https://gdc.cancer.gov/developers/gdc-data-model/gdc-data-model-components)

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

3. perform query with,

```
   queryGDC TOKEN QUERY
```
 
