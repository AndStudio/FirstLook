//
//  TitlePage.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

class TitlePage: UIViewController, OnboardingScreen {
    
    // MARK: - Internal properties
    
    var page: OnboardingState.Page = .title
    
}

// MARK: - Storyboard Initializable

extension TitlePage: StoryboardInitializable { }
