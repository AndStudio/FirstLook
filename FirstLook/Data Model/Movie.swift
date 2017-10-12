//
//  Movie.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    enum CodingKeys: String, CodingKey { case title }
    let title: String
}

// equatable
extension Movie {
    static func ==(_ lhs: Movie, _ rhs: Movie) -> Bool {
        return lhs.title == rhs.title
    }
}
