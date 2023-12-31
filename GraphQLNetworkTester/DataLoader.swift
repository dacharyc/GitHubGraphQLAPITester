//
//  DataLoader.swift
//  GraphQLNetworkTester
//
//  Created by Dachary Carey on 8/20/23.
//

import Foundation

class DataLoader {
    func request(forQraphQLQuery: GraphQLQuery) async throws -> Data? {
        let token = "<INSERT_YOUR_TOKEN_HERE>"
        
        let gitHubGraphQLURL = URL(string: "https://api.github.com/graphql")
        
        guard let gitHubGraphQLURL else {
            print("GitHub GraphQL URL is invalid")
            throw DataFetcherError.invalidURL
        }
        
        let query = ["query": forQraphQLQuery.query]
        
        var json: Data?
        
        do {
            json = try JSONSerialization.data(withJSONObject: query)
        } catch {
            print("There was an error converting the dictionary to JSON: \(error.localizedDescription)")
        }
        
        guard let json else {
            print("There was no JSON and we failed")
            return nil
        }
        
        var apiRequest = URLRequest(url: gitHubGraphQLURL)

        apiRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        apiRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        apiRequest.httpMethod = "POST"
        apiRequest.httpBody = json
        
        print(apiRequest)
        
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, response) = try await URLSession.shared.data(for: apiRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataFetcherError.serverError
        }
        
        //print(response as? HTTPURLResponse)
        
        return data
    }
}

enum DataFetcherError: Error {
    case invalidURL
    case notFound
    case typeNotFound
    case serverError
}
