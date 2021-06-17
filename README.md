DBT Project to ingest and transform Xetra financial data from AWS (https://registry.opendata.aws/deutsche-boerse-pds/)

Data Dictionary (https://github.com/Deutsche-Boerse/dbg-pds/blob/master/docs/data_dictionary.md)

What I learned:
DBT allows data/analytics engineers to drive transformations inside of the MPP platforms such as Snowflake, BigQuery, or Redshift. Additional features I found interesting:
1. Macros can be leveraged via Python Jinja Templating to create reusable code
2. Tests, column description, other properties that need to be applied to a column can be easily configured via YAML
3. Can use sources and refs to build DAGs for processing

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
