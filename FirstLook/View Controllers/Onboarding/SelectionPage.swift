//
//  SelectionPage.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

class SelectionPage: UIViewController, OnboardingScreen {
    
    // MARK: - Internal properties
    
    var page: OnboardingState.Page = .genre1
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - Private methods

private extension SelectionPage {
    
    func setupUI() {
        var genre = ""
        switch page {
        case .genre1: genre = "genre1"
        case .genre2: genre = "genre2"
        case .genre3: genre = "genre3"
        default: break
        }
        
        print("Selection Page: \(genre)")
    }
    
}

// MARK: - Storyboard Initializable

extension SelectionPage: StoryboardInitializable { }
