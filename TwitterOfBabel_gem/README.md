# TwitterOfBabel

A reinterpretation of [the Borgesian Library of Babel](https://libraryofbabel.info/), for the medium of Twitter.

## How does it work?

A hex address of 195 characters is used to "index" into the "database" of tweets. Basically that hex address gets converted to a big number that Ruby uses as a seed for a random number generator. It then generates a random sequence of characters using that seed.

## What are the env variables that have to be set?

```bash
TOB_API_KEY # API key
TOB_SECRET # API secret
TOB_BEARER # Your bearer token
TOB_ACCESS # Your access key
TOB_ACCESS_SECRET # Your access secret
TOB_MEMOIZE_FILE # Where to save the memoization file
```