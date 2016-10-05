//
//  ReversiBoard.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import Foundation


class ReversiBoard: Board {
    private (set) var blackScore = 0, whiteScore = 0
    private (set) var nextMove = BoardCellState.white
    private (set) var gameHasFinished = false
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    
    override init() {
        super.init()
    }
    
    init(board: ReversiBoard) {
        super.init(board: board)
        nextMove = board.nextMove
        blackScore = board.blackScore
        whiteScore = board.whiteScore
    }
    
    func isValidMove(_ location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    fileprivate func isValidMove(_ location: BoardLocation, toState: BoardCellState) -> Bool {
        if self[location] != BoardCellState.empty {
            return false
        }
        
        for direction in MoveDirection.directions {
            if moveSurroundsSounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        return false
    }
    
    fileprivate func flipOpponentsCounter(_ location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
        if !moveSurroundsSounters(location, direction: direction, toState: toState) {
            return
        }
        
        let opponentsState = toState.invert()
        var currentState = BoardCellState.empty
        var currentLocation = location
        
        repeat {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }
    
    fileprivate func checkIfGameHasFinished() -> Bool {
        return !canPlayerMakeMove(BoardCellState.black) && !canPlayerMakeMove(BoardCellState.white)
    }
    
    fileprivate func canPlayerMakeMove(_ toState: BoardCellState) -> Bool {
        return anyCellsMatchCondition{ self.isValidMove($0, toState: toState) }
    }
    
    func makeMove(_ location: BoardLocation) {
        self[location] = nextMove
        
        for direction in MoveDirection.directions {
            flipOpponentsCounter(location, direction: direction, toState: nextMove)
        }
        
        switchTurns()
        
        gameHasFinished = checkIfGameHasFinished()
        
        whiteScore = countMatches{ self[$0] == BoardCellState.white }
        blackScore = countMatches{ self[$0] == BoardCellState.black }
        
        reversiBoardDelegates.invokeDelegates{ $0.boardStateChanged() }
    }
    
    func switchTurns() {
        let intendedNextMove = nextMove.invert()
        
        if canPlayerMakeMove(intendedNextMove) {
            nextMove = intendedNextMove
        }
    }
    
    
    func setInitialState() {
        clearBoard()
        
        super[3, 3] = .white
        super[4, 4] = .white
        super[3, 4] = .black
        super[4, 3] = .black
        
        blackScore = 2
        whiteScore = 2
    }
    
    func moveSurroundsSounters(_ location:BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
        
        while isWithinBounds(currentLocation) {
            let currentState = self[currentLocation]
            if index == 1 {
                if currentState != toState.invert() {
                    return false
                }
            } else {
                if currentState == toState {
                    return true
                }
                
                if currentState == BoardCellState.empty {
                    return false
                }
            }
            
            index += 1
            
            currentLocation = direction.move(currentLocation)
        }
        return false
    }
    
    
    func addDelegate(_ delegate: ReversiBoardDelegate) {
        reversiBoardDelegates.addDelegate(delegate)
    }
}
