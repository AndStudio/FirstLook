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
    
    var page: Page
    
    // MARK: - Initializers
    
    init(currentPage: Page) {
        self.page = currentPage
    }
    
    // MARK: - Internal methods
    
    func previousPage() -> Page {
        switch page {
        case .title: page = .title
        case .genre1: page = .title
        case .genre2: page = .genre1
        case .genre3: page = .genre2
        case .permissions: page = .genre3
        }
        return page
    }
    
    func nextPage() -> Page {
        switch page {
        case .title: page = .genre1
        case .genre1: page = .genre2
        case .genre2: page = .genre3
        case .genre3: page = .permissions
        case .permissions: page = .permissions
        }
        return page
    }
    
}
