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
 
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func callApi(sometitle: String) {
        // adding this v allows for spacing
        let newsearch = sometitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var req = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?query=\(newsearch ?? "not working")&include_adult=false&language=en-US&page=1")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.8)
        
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = headers
       
        let dataTask = URLSession.shared.dataTask(with: req) { dataz, resz, error in
            if error != nil {
                print(error?.localizedDescription ?? "something crashed")
            } else {
                let httpResponse = resz as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    print("success")
                }
            }
            if let someData = dataz {
                print(someData, "insude our api call")
                do {
                    let decoder = try JSONDecoder().decode(MovieParse.self, from: dataz!)
                    self.movieParseArray.append(decoder)
                    self.resultsArray.append(contentsOf: decoder.results)
                    let movieTtitle = decoder.results
                        for title in movieTtitle {
                            self.titleArray.append(title.originalTitle)
                            print(title.originalTitle)
                         
                            if self.titleArray.isEmpty == true {
                                print("i am empty!")
                            }
                        }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    */
    
    
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NzhmZGI1ODc5MGZhNWI0MTJjNWY4ZjFhYjM4Mzg4OSIsInN1YiI6IjY0ZTU3OTFlYzYxM2NlMDBjOWYwOGI1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5C7Ur8HaUD5xNzdFrTXYMKbTkqaxZZsCHkcgod9YjIw"
    ]
    
    
}
