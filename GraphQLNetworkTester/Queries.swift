//
//  Queries.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 8/20/23.
//

import Foundation

struct GraphQLQuery {
    let query: String
}

extension GraphQLQuery {
    static func getPRsInRepository(forOwner owner: String, inRepo repo: String) -> GraphQLQuery {
        return GraphQLQuery(
            query: """
                query {
                  repository(owner:"\(owner)", name:"\(repo)") {
                    pullRequests(last:100, states:OPEN) {
                      nodes {
                        number
                      }
                    }
                  }
                }
            """
        )
    }
    
    static func getPullRequestData(forOwner owner: String, inRepo repo: String, withNumber number: Int) -> GraphQLQuery {
    //static func getPullRequestData() -> GraphQLQuery {
        return GraphQLQuery(
            query: """
                query {
                  repository(owner: "realm", name: "realm-cpp"){
                    pullRequest(number: 92) {
                      title
                      updatedAt
                      number
                      permalink
                      state
                      createdAt
                      updatedAt
                      closedAt
                      mergedAt
                      mergeable
                      author {
                        login
                        avatarUrl
                      }
                      body
                      headRefOid
                      reviewRequests(last: 100){
                        nodes {
                          requestedReviewer {
                            ... on User {
                              avatarUrl
                              login
                            }
                          }
                        }
                      }
                      
                      assignees(last: 100) {
                        nodes {
                          avatarUrl
                          login
                        }
                      }
                      comments(last: 100) {
                        nodes {
                          author {
                            avatarUrl
                            login
                          }
                          body
                          updatedAt
                          url
                        }
                      }
                      commits(last: 100) {
                        nodes {
                          commit {
                            author {
                              name
                              avatarUrl
                              user {
                                avatarUrl
                                login
                              }
                            }
                            authoredDate
                            message
                            commitUrl
                            oid
                            checkSuites(last: 90) {
                              nodes {
                                id
                                conclusion
                                updatedAt
                                url
                                checkRuns(last: 50) {
                                  nodes {
                                    id
                                    name
                                    permalink
                                    conclusion
                                    startedAt
                                    completedAt
                                    summary
                                  }
                                }
                                workflowRun {
                                  workflow {
                                    name
                                  }
                                }
                                app {
                                  logoUrl
                                }
                              }
                            }
                            status {
                              combinedContexts(last: 100) {
                                nodes {
                                  ... on CheckRun {
                                    id
                                    name
                                    permalink
                                    conclusion
                                    startedAt
                                    completedAt
                                    summary
                                  }
                                  ... on StatusContext {
                                    id
                                    context
                                    description
                                    state
                                    createdAt
                                    targetUrl
                                    avatarUrl
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                      reviews(last: 100) {
                        nodes {
                          id
                          author {
                            avatarUrl
                            login
                          }
                          body
                          updatedAt
                          state
                          url
                          comments(last: 100) {
                            nodes {
                              author {
                                avatarUrl
                                login
                              }
                              body
                              id
                              updatedAt
                              url
                            }
                          }
                        }
                      }
                    }
                  }
                }
            """
        )
    }
}
