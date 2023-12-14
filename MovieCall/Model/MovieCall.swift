//
//  MovieCall.swift
//  MovieCall
//
//  Created by Juanito Martinon on 8/22/23.
//

import Foundation
import UIKit

enum CallError: Error {
    case runtimeerror(String)
}


// MARK: Make it a query!
class MovieCall {
    
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NzhmZGI1ODc5MGZhNWI0MTJjNWY4ZjFhYjM4Mzg4OSIsInN1YiI6IjY0ZTU3OTFlYzYxM2NlMDBjOWYwOGI1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5C7Ur8HaUD5xNzdFrTXYMKbTkqaxZZsCHkcgod9YjIw"
    ]
    
    
    var mysearch = "spiderman"
    var movieParseArray = [MovieParse]()
    var resultsArray = [Results]()


    
    func callApiUsingAsync(sometitle: String) async throws -> [Results] {
        let newsearch = sometitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var req = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?query=\(newsearch ?? "not working")&include_adult=false&language=en-US&page=1")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = headers
        
        
      
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw CallError.runtimeerror("something went wrong")
        }
        
        
        let decoder = JSONDecoder()
        let returnThis = try decoder.decode(MovieParse.self, from: data)
        let returns = returnThis.results
        return returns
    }
 
  // MARK: FORGOT WHERE I USED THIS 
    func gettingDatafromapi(sometitle: String,_ completion: @escaping (Results?) -> Void) {
        Task {
            do {
                let call = try await callApiUsingAsync(sometitle: sometitle)
            } catch {
                print(error)
            }
        }
    }
}
