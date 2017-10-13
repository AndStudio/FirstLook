//
//  Movie.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    
    var title: String
    var id: Int
    var hasVideo: Bool
    var releaseDate: String
    var poster: String?
    var overview: String?
    var cast: [Int]? = []
    var video: String? = ""
    
    private enum CodingKeys: String, CodingKey {
        case title
        case id 
        case hasVideo = "video"
        case releaseDate = "release_date"
        case poster = "poster_path"
        case overview
    }
}

// equatable
extension Movie {
    static func ==(_ lhs: Movie, _ rhs: Movie) -> Bool {
        return lhs.title == rhs.title
    }
}
