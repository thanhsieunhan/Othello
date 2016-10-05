//
//  BoardDelegate.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(_ location: BoardLocation)
}
