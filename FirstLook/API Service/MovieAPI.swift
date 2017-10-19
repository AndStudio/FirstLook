//
//  MovieAPI.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

struct MovieSearchResults {
    let searchTerm: String
    let searchResults: [Movie]
}

class MovieAPI {
    static let _defaultSession = URLSession(configuration: .default)
    static var _dataTask: URLSessionDataTask?
}

//MARK: - Search API
extension MovieAPI {
    
    // search api method
    static func searchForMovie(_ searchTerm: String, completion: @escaping ((Result<MovieSearchResults>) -> Void)) {
        guard let searchURL = movieSearchURLForSearchTerm(searchTerm) else { return }
        _dataTask?.cancel()
        let request = URLRequest(url: searchURL)
        _dataTask = _defaultSession.dataTask(with: request) { (data, response, error) in
            defer { self._dataTask = nil }
            let result = processSearchRequest(forSearchTerm: searchTerm, data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        _dataTask?.resume()
    }
    
    // movie search URL for search term requestURL
    private static func movieSearchURLForSearchTerm(_ searchTerm: String) -> URL? {
        if let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            guard let url = Keys.baseURL else { fatalError("No URL") }
            let urlParameters = ["api_key": "\(Keys.apiKey)", "query": "\(escapedTerm)"]
            let requestURL = buildURL(byAddingParameters: urlParameters, toURL: url)
            
            return requestURL
        }
        return nil
    }
    
    //video endpoint https://api.themoviedb.org/3/movie/6479/videos?api_key=1796c09fd7616b8f1534c86ee98cc305&language=en-US
    
    //build the data endpoitn for a movie's video key
    private static func fetchVideoForMovie(_ movie: Movie) -> URL? {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/videos") else { return nil }
        let urlParameters = ["api_key": "\(Keys.apiKey)"]
        var requestURL = buildURL(byAddingParameters: urlParameters, toURL: url)
        return requestURL
    }
    
    // build the data endpoint for a movie's credits
    private static func fetchCastForMovie(_ movie: Movie) -> URL? {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits") else { return nil }
        let urlParameters = ["api_key": "\(Keys.apiKey)"]
        let requestURL = buildURL(byAddingParameters: urlParameters, toURL: url)
        return requestURL
    }
    
    // add endpoint components to url and return endpoint
    static func buildURL(byAddingParameters parameters: [String: String]?,
                       toURL url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
    
    // process search request
    private static func processSearchRequest(forSearchTerm searchTerm: String, data: Data?, error: Swift.Error?) -> Result<MovieSearchResults> {
        
        if let error = error {
            return .failure(error)
        }
        
        guard let data = data else {
            return .failure(Error.noData)
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let results = json as? JSONDictionary else {
                return .failure(Error.requestFailed(reason: "Failed to parse json into data"))
        }
        
        // decode serialize movie objects
        guard let moviesContainer = results["results"] as? [JSONDictionary],
            let moviesData = jsonToString(moviesContainer)?.data(using: .utf8),
            var movies = try? JSONDecoder().decode([Movie].self, from: moviesData) else {
                return .failure(Error.processingMoviesFailed(reason: "Could not get movies back from JSON payload"))
        }
        
        // TODO: - clean this up
        for movie in movies {
            fetchVideoEndpoints(forMovie: movie, completion: {
                
            })
            fetchCredits(forMovie: movie, completion: {
                
            })
        }
        
        
        return .success(MovieSearchResults(searchTerm: searchTerm, searchResults: movies))
        
    }
    
    private static func fetchVideoEndpoints(forMovie movie: Movie, completion: @escaping () -> Void) {
        var movie = movie
        guard let url = fetchVideoForMovie(movie) else { return }
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print(error)
            }
            
            guard let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary,
                let videosContainer = jsonDictionary!["results"] as? [JSONDictionary] else { return }
            
            for item in videosContainer {
                
                guard let key = item["key"] as? String else { return }
                let youtubeURL = "https://www.youtube.com/watch?v=\(key)"
                
//                movie.cast = youtubeURL
                movie.update(cast: [], video: youtubeURL)
                
            }
        }
        dataTask.resume()
    }
    
    private static func fetchCredits(forMovie movie: Movie, completion: @escaping () -> Void) {
        var movie = movie 
        guard let url = fetchCastForMovie(movie) else { return }
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print(error)
            }
            
            guard let data = data,
                let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary,
                let creditsContainer = jsonDict!["cast"] as? [JSONDictionary] else {
                    return
            }
            
            let cast = creditsContainer.flatMap { $0["id"] as? Int }
            movie.cast = cast
            
        }
        dataTask.resume()
    }
    
    private static func jsonToString(_ json: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let converted = String(data: data, encoding: .utf8) else { return nil }
        return converted
    }
    
    
}
















