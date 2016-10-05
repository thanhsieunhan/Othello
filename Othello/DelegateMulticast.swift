//
//  DelegateMulticast.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    fileprivate var delegates = [T]()
    
    func addDelegate(_ delegate: T) {
        delegates.append(delegate)
    }
    
    func invokeDelegates(_ invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}
