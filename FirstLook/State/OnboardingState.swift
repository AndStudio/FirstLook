//
//  OnboardingState.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

struct OnboardingState {
    
    // MARK: - Additional Types
    
    enum PageType {
        case title
        case selection
        case permissions
    }
    
    enum Page {
        case title
        case genre1
        case genre2
        case genre3
        case permissions
        
        var type: PageType {
            switch self {
            case .title: return .title
            case .genre1, .genre2, .genre3: return .selection
            case .permissions: return .permissions
            }
        }
        
        static var all: [Page] = [.title, .genre1, .genre2, .genre3, .permissions]
    }
    
    // MARK: - Internal Properties
    
    var currentPage: Page
    
}
