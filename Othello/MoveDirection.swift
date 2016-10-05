//
//  MoveDirection.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

enum MoveDirection {
    case north, south, east, west, northEast, northWest, southEast, southWest
    
    func move(_ loc: BoardLocation) -> BoardLocation {
        switch self {
        case .north:
            return BoardLocation(row: loc.row-1, column: loc.column)
        case .south:
            return BoardLocation(row: loc.row+1, column: loc.column)
        case .east:
            return BoardLocation(row: loc.row, column: loc.column-1)
        case .west:
            return BoardLocation(row: loc.row, column: loc.column+1)
        case .northEast:
            return BoardLocation(row: loc.row-1, column: loc.column-1)
        case .northWest:
            return BoardLocation(row: loc.row-1, column: loc.column+1)
        case .southEast:
            return BoardLocation(row: loc.row+1, column: loc.column-1)
        case .southWest:
            return BoardLocation(row: loc.row+1, column: loc.column+1)
        }
    }
    
    static let directions: [MoveDirection] = [
        .north, .south, .east, .west, .northEast, .northWest, .southWest, .southEast
    ]
}
