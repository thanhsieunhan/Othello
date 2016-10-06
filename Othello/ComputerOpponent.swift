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
    private let board: ReversiBoard
    private let color: BoardCellState
    let maxDepth : Int
    init(board: ReversiBoard, color: BoardCellState, maxDepth: Int) {
        self.board = board
        self.color = color
        self.maxDepth = maxDepth
        board.addDelegate(self)
    }
    
    func boardStateChanged() {
        if board.nextMove == color {
            delay(1.0) {
                self.makeNextMove()
            }
        }
    }
    
//    private func makeNextMove() {
//        var bestScore = Int.min
//        var bestLocation: BoardLocation?
//        
//        board.cellVisitor{
//            (location: BoardLocation) in
//            if self.board.isValidMove(location) {
//                let score = scoreForMove(location)
//                if (score > bestScore) {
//                    bestScore = score
//                    bestLocation = location
//                }
//            }
//        }
//        
//        if bestScore > Int.min {
//            board.makeMove(bestLocation!)
//        }
//    }
    
//    private func scoreForMove(_ location: BoardLocation) -> Int {
//        let testBoard = ReversiBoard(board: board)
//        testBoard.makeMove(location)
//        
//        let score = color == BoardCellState.white ?
//            testBoard.whiteScore - testBoard.blackScore :
//            testBoard.blackScore - testBoard.whiteScore;
//        print("\(location) + \(score) + \(color)")
//        return score
//    }
    
    private func makeNextMove(){
        var bestMove = BoardLocation(row: -1, column: -1)
        var bestScore = Int.min
        
        board.cellVisitor {
            (location: BoardLocation) in
            if self.board.isValidMove(location) {
                let testBoard = ReversiBoard(board: board)
                testBoard.makeMove(location)
                let scoreForMove = scoreForBoard(testBoard, depth: 1)
                
                if scoreForMove > bestScore || bestScore == Int.min {
                    bestScore = scoreForMove
                    bestMove = location
                }
            }
            
        }
        
        if bestMove.column != -1 && bestMove.row != -1 {
            board.makeMove(bestMove)
        }
    }
    
    private func scoreForBoard(_ board_test : ReversiBoard, depth: Int) -> Int {
        if depth >= maxDepth {
            return color == BoardCellState.white ?
            board_test.whiteScore - board_test.blackScore :
            board_test.blackScore - board_test.whiteScore
        }
        
        var minMax = Int.min
        
        board_test.cellVisitor { (location: BoardLocation) in
            if board_test.isValidMove(location){
                let testBoard = ReversiBoard(board: board_test)
                testBoard.makeMove(location)
                
                let score = scoreForBoard(testBoard, depth: depth + 1)
                
                if depth % 2 == 0 {
                    if score > minMax || minMax == Int.min {
                        minMax = score
                    }
                } else {
                    if score < minMax || minMax == Int.min {
                        minMax = score
                    }
                }
            }
        }
        
        return minMax
    }
}
