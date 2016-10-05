//
//  BoardCellState.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

enum BoardCellState {
    case empty, black, white
    
    func invert() -> BoardCellState {
        if self == .black {
            return .white
        } else if self == .white {
            return .black
        }
        
        assert(self != .empty, "cannot invert the empty state")
        return .empty
    }
}
