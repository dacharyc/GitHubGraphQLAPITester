//
//  ContentView.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 8/20/23.
//

import SwiftUI

struct ContentView: View {
    @State var owner = ""
    @State var repo = ""
    @State var number = 0
    @State var listRepoOwner = ""
    @State var listRepo = ""
    
    var body: some View {
        HStack {
            VStack {
                Text("Fetch Data for Pull Request")
                    .padding(1)
                Form {
                    TextField("Repo owner", text: $owner)
                    TextField("Repo name", text: $repo)
                    TextField("PR Number", value: $number, formatter: NumberFormatter())
                    Button("Fetch PR") {
                        Task {
                            print("Attempting to fetch data for owner: \(owner), repo: \(repo), number: \(number)")
                            let result = try await DataLoader().request(forQraphQLQuery: .getPullRequestData(forOwner: owner, inRepo: repo, withNumber: number))
                            if let validData = result {
                                print("We're in the unwrapped return value and have some data!")
                                let stringData = String(data: validData, encoding: String.Encoding.ascii)
                                print("String data is: \(String(describing: stringData))")
                                
                                let decodedPRData = try? JSONDecoder().decode(DecodePRStartingPoint.self, from: validData)
                                if let unwrappedDecodedData = decodedPRData {
                                    print("Successfully decoded data! The PR number is: ")
                                    print(unwrappedDecodedData.data.repository.pullRequest.number)
                                } else {
                                    print("No data here! Couldn't decode it.")
                                }
                            }
                        }
                    }
                    Button("Fetch Status Checks") {
                        Task {
                            print("Attempting to fetch status check data for owner: \(owner), repo: \(repo), number: \(number)")
                            let result = try await DataLoader().request(forQraphQLQuery: .getPullRequestStatusCheckData(forOwner: owner, inRepo: repo, withNumber: number))
                            if let validData = result {
                                print("We're in the unwrapped return value and have some data!")
                                let stringData = String(data: validData, encoding: String.Encoding.ascii)
                                print("String data is: \(String(describing: stringData))")
                                
                                let decodedPRData = try? JSONDecoder().decode(DecodeStatusCheckStartingPoint.self, from: validData)
                                if let unwrappedDecodedData = decodedPRData {
                                    print("Successfully decoded data! The PR number is: ")
                                    print(unwrappedDecodedData.data.repository.pullRequest.number)
                                } else {
                                    print("No data here! Couldn't decode it.")
                                }
                            }
                        }
                    }
                }
            }
            .padding(1)
            VStack {
                Text("Fetch Open PRs in Repo")
                    .padding(1)
                Form {
                    TextField("Repo owner", text: $listRepoOwner)
                    TextField("Repo name", text: $listRepo)
                    Button("Fetch List") {
                        Task {
                            print("Attempting to fetch list of open PRs for owner: \(listRepoOwner), repo: \(listRepo)")
                            let result = try await DataLoader().request(forQraphQLQuery: .getPRsInRepository(forOwner: listRepoOwner, inRepo: listRepo))
                            if let validData = result {
                                print("We're in the unwrapped return value and have some data!")
                                let stringData = String(data: validData, encoding: String.Encoding.ascii)
                                print("String data is: \(String(describing: stringData))")
                                
                                let decodedPRData = try? JSONDecoder().decode(DecodePRListInRepoStartingPoint.self, from: validData)
                                if let unwrappedDecodedData = decodedPRData {
                                    print("Successfully decoded data! The PRs List is: ")
                                    print(unwrappedDecodedData.data.repository.pullRequests.nodes)
                                } else {
                                    print("No data here! Couldn't decode it.")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
