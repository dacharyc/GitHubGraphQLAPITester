//
//  GeneratedModels.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 8/20/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(DecodePRListInRepoStartingPoint.self, from: jsonData)
//   let welcome = try? JSONDecoder().decode(DecodePRStartingPoint.self, from: jsonData)

import Foundation

// MARK: DecodePRListInRepoStartingPoint
struct DecodePRListInRepoStartingPoint: Codable {
    let data: InterimRepositoryStruct
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - InterimRepositoryStruct
struct InterimRepositoryStruct: Codable {
    let repository: RepositoryListStruct
    
    enum CodingKeys: String, CodingKey {
        case repository
    }
}

// MARK: - RepositoryListStruct
struct RepositoryListStruct: Codable {

    let pullRequests: PullRequestListNodes
    
    enum CodingKeys: String, CodingKey {
        case pullRequests
    }
}

// MARK: - PullRequestListNodes
struct PullRequestListNodes: Codable {
    let nodes: [PRNumbersInList]
    
    enum CodingKeys: String, CodingKey {
        case nodes
    }
}

// MARK: - PRNumbersInList
struct PRNumbersInList: Codable {
    let number: Int

    enum CodignKeys: String, CodingKey {
        case number
    }
}

// MARK: - DecodePRStartingPoint
struct DecodePRStartingPoint: Codable {
    let data: IntermediaryStruct
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - IntermediaryStruct
struct IntermediaryStruct: Codable {
    let repository: Repository_Temp
    
    enum CodingKeys: String, CodingKey {
        case repository
    }
}

// MARK: - Repository_Temp
struct Repository_Temp: Codable {
    let pullRequest: PullRequest_Temp
    
    enum CodingKeys: String, CodingKey {
        case pullRequest
    }
}

// MARK: - PullRequest_Temp: Confirmed
struct PullRequest_Temp: Codable {
    let title: String
    let updatedAt: String
    let number: Int
    let permalink: String
    let state: PullRequestState
    let createdAt: String
    let closedAt, mergedAt: String?
    let mergeable: MergeableState
    let author: GitUser?
    let body: String
    let reviewRequests: ReviewRequestConnection?
    let assignees: AssigneesConnection
    let comments: IssueCommentConnection
    let reviews: PullRequestReviewConnection?
    let commits: PullRequestCommitConnection
    
    enum CodingKeys: String, CodingKey {
        case title, updatedAt, number, permalink, state, createdAt, closedAt, mergedAt, mergeable, author, body, reviewRequests, assignees, comments, reviews, commits
    }
}

// MARK: - PullRequestState: Confirmed
enum PullRequestState: String, Codable {
    case open = "OPEN"
    case closed = "CLOSED"
    case merged = "MERGED"
}

// MARK: - MergeableState: Confirmed
enum MergeableState: String, Codable {
    case mergeable = "MERGEABLE"
    case conflicting = "CONFLICTING"
    case unknown = "UNKNOWN"
}

// MARK: - ReviewRequestConnection: Confirmed
struct ReviewRequestConnection: Codable {
    let nodes: [ReviewRequest]
}

// MARK: - ReviewRequest: Confirmed
struct ReviewRequest: Codable {
    let requestedReviewer: GitUser?
}

// MARK: - AssigneesConnection: Confirmed
struct AssigneesConnection: Codable {
    let nodes: [GitUser]
}

// MARK: - GitUser: Confirmed
struct GitUser: Codable {
    let avatarURL: String
    let login: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatarUrl"
        case login
    }
}

// MARK: - IssueCommentConnection: Confirmed
struct IssueCommentConnection: Codable {
    let nodes: [CommentsNode]?
}

// MARK: - CommentsNode: Confirmed
struct CommentsNode: Codable {
    let author: GitUser?
    let body: String
    let updatedAt: String
    let url: String
}

// MARK: - PullRequestCommitConnection: Confirmed
struct PullRequestCommitConnection: Codable {
    let nodes: [CommitNode]
}

// MARK: - CommitNode: Confirmed
struct CommitNode: Codable {
    let commitObject: CommitObject
    
    enum CodingKeys: String, CodingKey {
        case commitObject = "commit"
    }
}

// MARK: - Commit: Confirmed
struct CommitObject: Codable {
    let author: CommitAuthor?
    let authoredDate: String
    let message: String
    let commitURL: String
    let oid: String
    let checkSuites: CheckSuitesConnection?
    let status: CommitStatus?
    
    enum CodingKeys: String, CodingKey {
        case author, authoredDate, message, oid, checkSuites, status
        case commitURL = "commitUrl"
    }
}

// MARK: - CommitAuthor: Confirmed
struct CommitAuthor: Codable {
    let user: GitUser?
    let avatarUrl: String?
    let name: String?
}

// MARK: - CheckSuitesConnection: Confirmed
struct CheckSuitesConnection: Codable {
    let nodes: [CheckSuite]
}

// MARK: - CheckSuite: Confirmed
struct CheckSuite: Codable {
    let id: String
    let conclusion: CheckRunConclusion?
    let updatedAt: String
    let url: String
    let workflowRun: WorkflowRun?
    let app: CheckSuiteApp?
}

// MARK: - CheckRunConclusion: Confirmed
enum CheckRunConclusion: String, Codable {
    case actionRequired = "ACTION_REQUIRED"
    case timedOut = "TIMED_OUT"
    case cancelled = "CANCELLED"
    case failure = "FAILURE"
    case success = "SUCCESS"
    case neutral = "NEUTRAL"
    case skipped = "SKIPPED"
    case startupFailure = "STARTUP_FAILURE"
    case stale = "STALE"
}

// MARK: - WorkflowRun: Confirmed
struct WorkflowRun: Codable {
    let workflow: Workflow
}

// MARK: - Workflow: Confirmed
struct Workflow: Codable {
    let name: String
}

// MARK: - App: Confirmed
struct CheckSuiteApp: Codable {
    let logoURL: String

    enum CodingKeys: String, CodingKey {
        case logoURL = "logoUrl"
    }
}

// MARK: - CommitStatus: Confirmed
struct CommitStatus: Codable {
    let combinedContexts: CombinedContexts
}

// MARK: - CombinedContexts: Confirmed
struct CombinedContexts: Codable {
    let nodes: [CombinedContextRun]
}

// MARK: - CombinedContextRun: Confirmed
struct CombinedContextRun: Codable {
    // CheckRun
    let id: String
    let name: String?
    let permalink: String?
    let conclusion: CheckRunConclusion?
    let startedAt: String?
    let completedAt: String?

    // StatusContext
    let context: String?
    let description: String?
    let state: CheckRunStatus?
    let createdAt: String?
    let targetURL: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, permalink, conclusion, startedAt, completedAt, context, description, state, createdAt
        case targetURL = "targetUrl"
        case avatarURL = "avatarUrl"
    }
}

// MARK: - CheckRunStatus: Confirmed
enum CheckRunStatus: String, Codable {
    case expected = "EXPECTED"
    case error = "ERROR"
    case failure = "FAILURE"
    case pending = "PENDING"
    case success = "SUCCESS"
}

// MARK: - PullRequestReviewConnection
struct PullRequestReviewConnection: Codable {
    let nodes: [ReviewsNode]
}

// MARK: - ReviewsNode: Confirmed
struct ReviewsNode: Codable {
    let id: String
    let author: GitUser?
    let body: String
    let updatedAt: String
    let state: PullRequestReviewState
    let url: String
    let comments: PullRequestReviewCommentConnection
}

// MARK: - PullRequestReviewCommentConnection: Confirmed
struct PullRequestReviewCommentConnection: Codable {
    let nodes: [CommentsNode]
}

// MARK: - PullRequestReviewStateEnum: Confirmed
enum PullRequestReviewState: String, Codable {
    case pending = "PENDING"
    case commented = "COMMENTED"
    case approved = "APPROVED"
    case changesRequested = "CHANGES_REQUESTED"
    case dismissed = "DISMISSED"
}
