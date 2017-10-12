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
            
        }
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
        
        guard let moviesContainer = results["results"] as? [JSONDictionary],
            let moviesData = jsonToString(moviesContainer)?.data(using: .utf8),
            let movies = try? JSONDecoder().decode([Movie].self, from: moviesData) else {
                return .failure(Error.processingMoviesFailed(reason: "Could not get movies back from JSON payload"))
        }
        return .success(MovieSearchResults(searchTerm: searchTerm, searchResults: movies))
        
    }
    
    private static func jsonToString(_ json: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let converted = String(data: data, encoding: .utf8) else { return nil }
        return converted
    }
    
    
}
















