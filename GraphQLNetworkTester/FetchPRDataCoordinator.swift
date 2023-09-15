//
//  FetchPRDataCoordinator.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 9/12/23.
//

import Foundation
import Queue

class FetchPRDataCoordinator {
    var repoFetchResultsDocsRealm = RepoFetchResult(repoFetchObject: RepoFetchObject.docsRealm)
    var repoFetchResultsDocsAppx = RepoFetchResult(repoFetchObject: RepoFetchObject.docsAppServices)
    var repoFetchResultsRealmSwift = RepoFetchResult(repoFetchObject: RepoFetchObject.realmSwift)
    var repoFetchResultsRealmKotlin = RepoFetchResult(repoFetchObject: RepoFetchObject.realmKotlin)
    var repoFetchResultsRealmJS = RepoFetchResult(repoFetchObject: RepoFetchObject.realmJS)
    var repoFetchResultsRealmCpp = RepoFetchResult(repoFetchObject: RepoFetchObject.realmCpp)
    
    var reposToFetch: [RepoFetchResult] = []
    
    init() {
        self.reposToFetch = [repoFetchResultsRealmSwift, repoFetchResultsDocsAppx, repoFetchResultsDocsRealm, repoFetchResultsRealmJS, repoFetchResultsRealmCpp, repoFetchResultsRealmKotlin]
    }
    
    func addPRsToPRToFetchList(for repo: RepoFetchResult, _ openPRList: [Int]) -> RepoFetchResult {
        for openPRNumber in openPRList {
            if !repo.repoFetchObject.pullRequestNumbersToFetch.contains(openPRNumber) {
                repo.repoFetchObject.pullRequestNumbersToFetch.append(openPRNumber)
                print("Added PR # \(openPRNumber) to list of PRs to fetch for repo \(repo.repoFetchObject.repoOwner)/\(repo.repoFetchObject.repoName)")
            }
        }
        return repo
    }
    
    func getPRs() async {
        let queue = AsyncQueue()
        var updatedRepo: RepoFetchResult? = nil
        
        for repo in reposToFetch {
            let openPRs = await fetchOpenPRsFromGitHub(forOwner: repo.repoFetchObject.repoOwner, inRepo: repo.repoFetchObject.repoName)
            if let openPRs {
                updatedRepo = self.addPRsToPRToFetchList(for: repo, openPRs)
            } else {
                print("Did not get a valid list of open PRs from GitHub for repo \(repo.repoFetchObject.repoOwner)/\(repo.repoFetchObject.repoName)")
            }
            if let updatedRepo {
                for prNumber in updatedRepo.repoFetchObject.pullRequestNumbersToFetch {
                    queue.addOperation {
                        let tempPR = await fetchPRDataFromGitHub(forOwner: updatedRepo.repoFetchObject.repoOwner, inRepo: updatedRepo.repoFetchObject.repoName, forNumber: prNumber)
                        let tempStatusCheckPR = await fetchPRStatusCheckDataFromGitHub(forOwner: updatedRepo.repoFetchObject.repoOwner, inRepo: updatedRepo.repoFetchObject.repoName, forNumber: prNumber)
                        if let tempPR {
                            updatedRepo.prObjects.append(tempPR)
                            print("Fetched PR \(prNumber) in repo \(updatedRepo.repoFetchObject.repoName)")
                        }
                        if let tempStatusCheckPR {
                            updatedRepo.prStatusChecks.append(tempStatusCheckPR)
                        }
                    }
                }
                reposToFetch.removeAll(where: {
                    $0.repoFetchObject.repoId == updatedRepo.repoFetchObject.repoId
                })
                reposToFetch.append(updatedRepo)
            } else {
                for prNumber in repo.repoFetchObject.pullRequestNumbersToFetch {
                    queue.addOperation {
                        let tempPR = await fetchPRDataFromGitHub(forOwner: repo.repoFetchObject.repoOwner, inRepo: repo.repoFetchObject.repoName, forNumber: prNumber)
                        let tempStatusCheckPR = await fetchPRStatusCheckDataFromGitHub(forOwner: repo.repoFetchObject.repoOwner, inRepo: repo.repoFetchObject.repoName, forNumber: prNumber)
                        if let tempPR {
                            repo.prObjects.append(tempPR)
                            print("Fetched PR \(prNumber) in repo \(repo.repoFetchObject.repoName)")
                        }
                        if let tempStatusCheckPR {
                            repo.prStatusChecks.append(tempStatusCheckPR)
                        }
                    }
                }
            }
            updatedRepo = nil
        }
        
        queue.addBarrierOperation {
            let realmSwiftFetchedPRs = self.reposToFetch[0].prObjects.count
            let realmSwiftFetchedStatusCheckPRs = self.reposToFetch[0].prStatusChecks.count
            print("The count for realm Swift is \(realmSwiftFetchedPRs) PRs fetched and \(realmSwiftFetchedStatusCheckPRs) PR status checks")
            
            let docsAppxFetchedPRs = self.reposToFetch[1].prObjects.count
            let docsAppxFetchedStatusCheckPRs = self.reposToFetch[1].prStatusChecks.count
            print("The count for docs appx is \(docsAppxFetchedPRs) PRs fetched and \(docsAppxFetchedStatusCheckPRs) PR status checks")
            
            let docsRealmFetchedPRs = self.reposToFetch[2].prObjects.count
            let docsRealmFetchedStatusCheckPRs = self.reposToFetch[2].prStatusChecks.count
            print("The count for docs realm is \(docsRealmFetchedPRs) PRs fetched and \(docsRealmFetchedStatusCheckPRs) PR status checks")
            
            let realmJSFetchedPRs = self.reposToFetch[3].prObjects.count
            let realmJSFetchedStatusCheckPRs = self.reposToFetch[3].prStatusChecks.count
            print("The count for realm JS is \(realmJSFetchedPRs) PRs fetched and \(realmJSFetchedStatusCheckPRs) PR status checks")
            
            let realmCPPFetchedPRs = self.reposToFetch[4].prObjects.count
            let realmCPPFetchedStatusCheckPRs = self.reposToFetch[4].prStatusChecks.count
            print("The count for realm CPP is \(realmCPPFetchedPRs) PRs fetched and \(realmCPPFetchedStatusCheckPRs) PR status checks")
            
            let realmKotlinFetchedPRs = self.reposToFetch[5].prObjects.count
            let realmKotlinFetchedStatusCheckPRs = self.reposToFetch[5].prStatusChecks.count
            print("The count for realm kotlin is \(realmKotlinFetchedPRs) PRs fetched and \(realmKotlinFetchedStatusCheckPRs) PR status checks")
        }
    }
}

func fetchOpenPRsFromGitHub(forOwner owner: String, inRepo repo: String) async -> [Int]? {
    do {
        let data = try await DataLoader().request(forQraphQLQuery: .getPRsInRepository(forOwner: owner, inRepo: repo))
        guard let data else {
            print("There was an error fetching data from GitHub")
            return nil
        }
        let decodedPRList = try? JSONDecoder().decode(DecodePRListInRepoStartingPoint.self, from: data)
        let decodedPRNumbers = decodedPRList?.data.repository.pullRequests.nodes
        if let decodedPRNumbers {
            var pullRequestNumbers: [Int] = []
            for decodedPR in decodedPRNumbers {
                pullRequestNumbers.append(decodedPR.number)
            }
            return pullRequestNumbers
        }
    } catch {
        // TODO: Surface this error
        print("Error fetching data or something: \(error.localizedDescription)")
    }
    return nil
}

func fetchPRDataFromGitHub(forOwner owner: String, inRepo repo: String, forNumber number: Int) async -> PullRequest_Temp? {
    do {
        let data = try await DataLoader().request(forQraphQLQuery: .getPullRequestData(forOwner: owner, inRepo: repo, withNumber: number))
        guard let data else {
            print("There was an error fetching data from GitHub")
            return nil
        }
        let decodedPRData = try? JSONDecoder().decode(DecodePRStartingPoint.self, from: data)
        if let unwrappedDecodedPRData = decodedPRData?.data.repository.pullRequest {
            return unwrappedDecodedPRData
        }
    } catch {
        print("Error fetching data or something: \(error.localizedDescription)")
    }
    return nil
}

func fetchPRStatusCheckDataFromGitHub(forOwner owner: String, inRepo repo: String, forNumber number: Int) async -> StatusCheckPullRequest_Temp? {
    do {
        let data = try await DataLoader().request(forQraphQLQuery: .getPullRequestData(forOwner: owner, inRepo: repo, withNumber: number))
        guard let data else {
            print("There was an error fetching data from GitHub")
            return nil
        }
        let decodedPRData = try? JSONDecoder().decode(DecodeStatusCheckStartingPoint.self, from: data)
        if let unwrappedDecodedPRStatusCheckData = decodedPRData?.data.repository.pullRequest {
            return unwrappedDecodedPRStatusCheckData
        }
    } catch {
        print("Error fetching data or something: \(error.localizedDescription)")
    }
    return nil
}
