//
//  StoryboardInitializable.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

public protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String { get }
}

public extension StoryboardInitializable where Self: UIViewController {
    
    public static var storyboardName: String {
        return String(describing: Self.self)
    }
    
    public static var viewControllerIdentifier: String {
        return String(describing: Self.self)
    }
    
    public static func initializeFromStoryboard() -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else { fatalError("Error instantiating \(self) from storyboard") }
        return vc
    }
    
}
