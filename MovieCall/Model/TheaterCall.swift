//
//  TheaterCall.swift
//  MovieCall
//
//  Created by Juanito Martinon on 11/9/23.
//

import Foundation

class TheaterCall {
    
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NzhmZGI1ODc5MGZhNWI0MTJjNWY4ZjFhYjM4Mzg4OSIsInN1YiI6IjY0ZTU3OTFlYzYxM2NlMDBjOWYwOGI1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5C7Ur8HaUD5xNzdFrTXYMKbTkqaxZZsCHkcgod9YjIw"
    ]


    // MARK: IN THEATERS CALL
    func theaterCallUsingAsync() async throws -> [TheatersResult] {
        var req = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = headers
        
        
      
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw CallError.runtimeerror("something went wrong")
        }
        
        
        let decoder = JSONDecoder()
        let returnThis = try decoder.decode(TheatersParse.self, from: data)
        let returns = returnThis.results
        return returns
    }
    
    // MARK: UPCOMING MOVIES CALL
    func upcomingCallAsync() async throws -> [UpcomingResults] {
        
        var req = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = headers
        
        
      
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw CallError.runtimeerror("something went wrong")
        }
        
        
        let decoder = JSONDecoder()
        let returnThis = try decoder.decode(UpcomingParse.self, from: data)
        let returns = returnThis.results
        return returns
    }
    
    func popularCallAsync() async throws -> [PopularResults] {
        
        var req = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = headers
        
        
      
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw CallError.runtimeerror("something went wrong")
        }
        
        
        let decoder = JSONDecoder()
        let returnThis = try decoder.decode(PopularParse.self, from: data)
        let returns = returnThis.results
        return returns

    }
    
}
