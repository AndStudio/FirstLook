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
    
}

// MARK: - Storyboard Initializable

extension SelectionPage: StoryboardInitializable { }
