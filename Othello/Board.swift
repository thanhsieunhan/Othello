//
//  Board.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation

class Board {
    private let boardDelegates = DelegateMulticast<BoardDelegate>()
    private var cells: [BoardCellState]
    let boardSize = 8
    
    init() {
        cells = Array(repeating: BoardCellState.empty, count: boardSize * boardSize)
    }
    
    init(board: Board) {
        cells = board.cells
    }
    
    func isWithinBounds(_ location: BoardLocation) -> Bool {
        return location.row >= 0 && location.row < boardSize &&
            location.column >= 0 && location.column < boardSize
    }
    
    subscript(location: BoardLocation) -> BoardCellState {
        get {
            assert(isWithinBounds(location), "row or column index out of bounds")
            return cells[location.row * boardSize + location.column]
        }
        set {
            assert(isWithinBounds(location), "row or column index out of bounds")
            cells[location.row * boardSize + location.column] = newValue
            boardDelegates.invokeDelegates{ $0.cellStateChanged(location) }
        }
    }
    
    subscript(row: Int, column: Int) -> BoardCellState {
        get {
            return self[BoardLocation(row: row, column: column)]
        }
        set {
            self[BoardLocation(row: row, column: column)] = newValue
        }
    }
    
    func cellVisitor(_ fn: (BoardLocation) -> ()) {
        for column in 0..<boardSize {
            for row in 0..<boardSize {
                let location = BoardLocation(row: row, column: column)
                fn(location)
            }
        }
    }
    
    func countMatches(_ fn: (BoardLocation) -> Bool) -> Int {
        var count = 0
        cellVisitor{ if fn($0) { count += 1 } }
        return count
    }
    
    func clearBoard() {
        cellVisitor{ self[$0] = .empty }
    }
    
    func addDelegate(_ delegate: BoardDelegate) {
        boardDelegates.addDelegate(delegate)
    }
    
    func anyCellsMatchCondition(_ fn: (BoardLocation) -> Bool) -> Bool {
        for column in 0..<boardSize {
            for row in 0..<boardSize {
                if fn(BoardLocation(row: row, column: column)) {
                    return true
                }
            }
        }
        return false
    }
}
