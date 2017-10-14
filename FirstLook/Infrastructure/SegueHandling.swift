//
//  SegueHandling.swift
//  FirstLook
//
//  Created by Michael J. Huber Jr. on 10/13/17.
//  Copyright © 2017 And. All rights reserved.
//

import UIKit

public protocol SegueHandling {
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueHandling where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    public func performSegue(withIdentifier segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { fatalError("Invalid segue identifier \(String(describing: segue.identifier)).") }
        return segueIdentifier
    }
    
}
