//
//  BoardLocation.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

struct BoardLocation: Equatable {
    let row: Int, column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
}

func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
