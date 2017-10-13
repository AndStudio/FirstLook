//
//  OnboardingState.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

class OnboardingState {
    
    // MARK: - Additional Types
    
    enum PageType {
        case title
        case selection
        case permissions
    }
    
    enum Page: Int {
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
    
    // MARK: - Initializers
    
    init(currentPage: Page) {
        self.currentPage = currentPage
    }
    
    // MARK: - Internal methods
    
    func previousPage() -> Page {
        switch currentPage {
        case .title: return .title
        case .genre1: return .title
        case .genre2: return .genre1
        case .genre3: return .genre2
        case .permissions: return .genre3
        }
    }
    
    func nextPage() -> Page {
        switch currentPage {
        case .title: return .genre1
        case .genre1: return .genre2
        case .genre2: return .genre3
        case .genre3: return .permissions
        case .permissions: return .permissions
        }
    }
    
}
