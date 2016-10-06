//
//  DelegateMulticast.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    private var delegates = [T]()
    
    
    // thêm vào list delegates
    func addDelegate(_ delegate: T) {
        delegates.append(delegate)
    }
    
    // lấy ra
    func invokeDelegates(_ invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}
