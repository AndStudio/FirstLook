//
//  Keys.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

struct Keys {
    
    //MARK: - API Keys
    
    static let apiKey = "1796c09fd7616b8f1534c86ee98cc305"
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let imageURL = URL(string: "http://image.tmdb.org/t/p/w500")
    
    //MARK: - API Keys
    
    static let titleKey = "title"
    static let ratingKey = "vote_average"
    static let descriptionKey = "overview"
    static let posterKey = "poster_path"
    static let movieDetailKey = "toMoveDetail"
    
}

typealias JSONDictionary = [String: Any]
