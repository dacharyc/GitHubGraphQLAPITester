//
//  RepoFetchObject.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 9/12/23.
//

import Foundation

class RepoFetchObject {
    var repoOwner: String
    var repoName: String
    var repoId: String
    var pullRequestNumbersToFetch: [Int]
    
    init(repoOwner: String, repoName: String, repoId: String, pullRequestNumbersToFetch: [Int]) {
        self.repoOwner = repoOwner
        self.repoName = repoName
        self.repoId = repoId
        self.pullRequestNumbersToFetch = pullRequestNumbersToFetch
    }
}

class RepoFetchResult {
    var repoFetchObject: RepoFetchObject
    var prObjects: [PullRequest_Temp] = []
    var prStatusChecks: [StatusCheckPullRequest_Temp] = []
    
    init(repoFetchObject: RepoFetchObject) {
        self.repoFetchObject = repoFetchObject
    }
}

extension RepoFetchObject {
    static let realmSwift = RepoFetchObject(repoOwner: "realm", repoName: "realm-swift", repoId: "Some string", pullRequestNumbersToFetch: [3578,4744,4827,4923,5686,6021,6041,6533,6746,7050,7160,7229,7301,7448,7482,7498,7686,7715,7722,7724,7742,7755,8004,8034,8054,8100,8109,8136,8142,8153,8244,8249,8261,8295,8319,8324,8334,8335,8344])
    static let docsRealm = RepoFetchObject(repoOwner: "mongodb", repoName: "docs-realm", repoId: "another sstring", pullRequestNumbersToFetch: [2524,2823,2877,2943,2966,2974,2979,3000,3001,3002,3003,3005,3009,3010])
    static let docsAppServices = RepoFetchObject(repoOwner: "mongodb", repoName: "docs-app-services", repoId: "the best string", pullRequestNumbersToFetch: [183,548,577])
    static let realmKotlin = RepoFetchObject(repoOwner: "realm", repoName: "realm-kotlin", repoId: "my favorite string", pullRequestNumbersToFetch: [881,1272,1429,1504,1510,1514])
    static let realmJS = RepoFetchObject(repoOwner: "realm", repoName: "realm-js", repoId: "dsodsm", pullRequestNumbersToFetch: [2018,2666,2733,3825,3935,4019,4027,4030,4061,4153,4316,4376,4544,4559,4678,4769,4770,4871,4942,5053,5057,5065,5081,5369,5384,5448,5452,5479,5482,5525,5528,5621,5672,5691,5692,5694,5754,5861,5866,5895,5908,5931,5934,5943,5998,6032,6038,6067,6116,6118,6121,6125,6126])
    static let realmCpp = RepoFetchObject(repoOwner: "realm", repoName: "realm-cpp", repoId: "dasjlkds", pullRequestNumbersToFetch: [19,24,33,35,38,39,40,45,91,92,93,94])
}
