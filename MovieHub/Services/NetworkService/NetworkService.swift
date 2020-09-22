//
//  NetworkService.swift
//  MovieHub
//
//  Created by a on 19.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func downloadMovies(completionHandler: @escaping ((Result<Movie, Error>) -> Void))
}

class NetworkService: NetworkServiceProtocol {
    func downloadMovies(completionHandler: @escaping ((Result<Movie, Error>) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=62efe0c91e2b68511bf20a79656c8e1c") else { return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            do {
                guard let data = data else { return }
                let moovieData = try JSONDecoder().decode(Movie.self, from: data)
                print(moovieData)
                completionHandler(.success(moovieData))
            }
                
            catch let jsonError {
                print(jsonError)
                completionHandler(.failure(jsonError))
            }
        }
        
        task.resume()
        
        
    }
    
   
    
    
    
}
