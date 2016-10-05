//
//  ComputerOpponent.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation


func delay(_ delay: Double, closure: @escaping () -> ()) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
}

class ComputerOpponent: ReversiBoardDelegate {
    fileprivate let board: ReversiBoard
    fileprivate let color: BoardCellState
    
    init(board: ReversiBoard, color: BoardCellState) {
        self.board = board
        self.color = color
        
        board.addDelegate(self)
    }
    
    func boardStateChanged() {
        if board.nextMove == color {
//            delay(1.0) {
                self.makeNextMove()
//            }
        }
    }
    
    private func makeNextMove() {
        var bestScore = Int.min
        var bestLocation: BoardLocation?
        
        board.cellVisitor{
            (location: BoardLocation) in
            if self.board.isValidMove(location) {
                let score = self.scoreForMove(location)
                if (score > bestScore) {
                    bestScore = score
                    bestLocation = location
                }
            }
        }
        
        if bestScore > Int.min {
            board.makeMove(bestLocation!)
        }
    }
    
    private func scoreForMove(_ location: BoardLocation) -> Int {
        let testBoard = ReversiBoard(board: board)
        testBoard.makeMove(location)
        
        let score = color == BoardCellState.white ?
            testBoard.whiteScore - testBoard.blackScore :
            testBoard.blackScore - testBoard.whiteScore;
        print("\(location) + \(score) + \(color)")
        return score
    }
}
