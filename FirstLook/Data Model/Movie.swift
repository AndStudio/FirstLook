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

// favorite computed property
extension Movie {
    var isFavorite: Bool {
        get {
            return UserDefaults.standard.bool(forKey: title)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: title)
        }
    }
}

// equatable
extension Movie {
    static func ==(_ lhs: Movie, _ rhs: Movie) -> Bool {
        return lhs.title == rhs.title
    }
}
