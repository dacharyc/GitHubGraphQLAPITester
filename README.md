# Manual Test App for GitHub GraphQL API

This app uses a GitHub API token to make calls to the [GitHub GraphQL API](https://docs.github.com/graphql) and make one of two queries:

- A list of all open PRs in a repository
- A specific subset of details for a given PR in a repository

There's a small GUI screen where you can provide inputs for owner/repository/PR number to check out a variety of numbers, and press a button to run the corresponding query.

I used this to work out GraphQL queries for my needs, and will likely use it as a tester in the future as I add pagination, or to troubleshoot deserialization of the data I get back from the endpoint.

## Usage

To use this tester:

- Go to `DataLoader.swift` and replace the `token` placeholder in ln 12 with your GitHub API Token. I hard-coded it in the test app, but obviously you can save it in the keychain or otherwise deal with this more securely for your eneds.
- Run the app. 
  - Enter Owner/Repository/PR number and press the `Fetch` button to get all the details about a specific PR. 
  - Enter Owner/Repository and press the `Fetch` button to get a list of all open PRs in the repository.

The `GeneratedModels.swift` file has all the models required to deserialize data for the given GraphQL queries. This simple test app is deserializing data right in the `ContentView` in the Button action. It deserializes and prints the data to the console as a string so you can see what's returned from the API, and then attempts to deserialize it using the Swift models and prints the result to the console.

If you have trouble getting a response, make sure your GitHub API token has the right permissions to access the repositories you're trying to test.

## GraphQL Queries

I only needed two specific static GraphQL queries for my app, so I didn't want to add a GraphQL library as a dependency.

I used [Altair GraphQL Client](https://altairgraphql.dev) to figure out the queries I needed for the [GitHub GraphQL API](https://docs.github.com/graphql). The schema enforcement was helpful while iterating on the manual queries. 

After I figured out the queries I needed, I used [quicktype](https://app.quicktype.io) to generate the Swift object models for the JSON structures I got back from the GraphQL queries. I manually validated these against the GitHub GraphQL Schema documentation, and then refined them as I manually tested different PRs in different repositories. 

You can find the GraphQL queries in `Queries.swift`. 
