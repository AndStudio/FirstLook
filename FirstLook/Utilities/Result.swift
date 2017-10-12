//
//  Result.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
