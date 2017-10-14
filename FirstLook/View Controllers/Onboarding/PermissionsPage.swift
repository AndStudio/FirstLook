//
//  PermissionsPage.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

class PermissionsPage: UIViewController, OnboardingScreen {
    
    // MARK: - Internal properties
    
    var page: OnboardingState.Page = .permissions
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - Private methods

private extension PermissionsPage {
    
    func setupUI() {
        print("Permissions Page")
    }
    
}

// MARK: - Storyboard Initializable

extension PermissionsPage: StoryboardInitializable {
    
    static var storyboardName: String { return String(describing: Onboarding.self) }
    
}
