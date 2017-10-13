//
//  Onboarding.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

protocol OnboardingScreen where Self: UIViewController {
    
    var page: OnboardingState.Page { get }
    
}

class Onboarding: UIViewController {
    
    // MARK: - Properties
    
    var pageViewController: UIPageViewController!
    var currentPage = OnboardingState(currentPage: .title)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.setViewControllers([TitlePage.initializeFromStoryboard()], direction: .forward, animated: true, completion: nil)
    }
    
}

// MARK: - Navigation

extension Onboarding {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedPageViewController:
            pageViewController = segue.destination as! UIPageViewController
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    
}

// MARK: - Page ViewController Datasource and Delegate

extension Onboarding: UIPageViewControllerDataSource {
    
    func createVCFrom(page: OnboardingState.Page) -> OnboardingScreen {
        switch page {
        case .title:
            let titlePage = TitlePage.initializeFromStoryboard()
            return titlePage
        case .genre1:
            let genre1 = SelectionPage.initializeFromStoryboard()
            return genre1
        case .genre2:
            let genre2 = SelectionPage.initializeFromStoryboard()
            genre2.page = .genre2
            return genre2
        case .genre3:
            let genre3 = SelectionPage.initializeFromStoryboard()
            genre3.page = .genre3
            return genre3
        case .permissions:
            let permissions = PermissionsPage.initializeFromStoryboard()
            return permissions
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let page = currentPage.previousPage()
        let vc = createVCFrom(page: page)
        return vc as? UIViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let page = currentPage.nextPage()
        let vc = createVCFrom(page: page)
        return vc as? UIViewController
    }
    
}

extension Onboarding: UIPageViewControllerDelegate {
    
}

// MARK: - Segue Handling

extension Onboarding: SegueHandling {
    
    enum SegueIdentifier: String {
        case embedPageViewController
    }
    
}

// MARK: - Storyboard Initializable

extension Onboarding: StoryboardInitializable { }
