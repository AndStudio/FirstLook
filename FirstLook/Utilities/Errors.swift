//
//  Errors.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

// MARK: - Error Definitions
extension MovieAPI {
    
    enum Error: Swift.Error {
        case noData
        case jsonSerializationFailed(reason: String)
        case requestFailed(reason: String)
        case processingMoviesFailed(reason: String)
        case imageCreationFailed
    }
}

extension MovieAPI.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data returned with response"
        case .jsonSerializationFailed(let reason):
            return reason
        case .requestFailed(let reason):
            return reason
        case .processingMoviesFailed(let reason):
            return reason
        case .imageCreationFailed:
            return "Could not create image from returned data"
        }
    }
}
