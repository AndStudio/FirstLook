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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - Private methods

private extension TitlePage {
    
    func setupUI() {
        print("Title Page")
    }
    
}

// MARK: - Storyboard Initializable

extension TitlePage: StoryboardInitializable {
    
    static var storyboardName: String { return String(describing: Onboarding.self) }
    
}
