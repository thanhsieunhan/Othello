//
//  ViewController.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReversiBoardDelegate {
    
    @IBOutlet var blackScore : UILabel!
    @IBOutlet var whiteScore : UILabel!
    @IBOutlet var restartButton : UIButton!
    
    fileprivate let board: ReversiBoard
    fileprivate let computer: ComputerOpponent
    
    required init(coder aDecoder: NSCoder) {
        board = ReversiBoard()
        board.setInitialState()
        computer = ComputerOpponent(board: board, color: BoardCellState.black)
        
        super.init(coder: aDecoder)!
        
        board.addDelegate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardFrame = CGRect(x: 88, y: 152, width: 600, height: 600)
        let boardView = ReversiBoardView(frame: boardFrame, board: board)
        
        view.addSubview(boardView)
        boardStateChanged()
        
        restartButton.addTarget(self, action: #selector(ViewController.restartTapped), for: UIControlEvents.touchUpInside)
    }
    
    func restartTapped() {
        if board.gameHasFinished {
            board.setInitialState()
            boardStateChanged()
        }
    }
    
    func boardStateChanged() {
        blackScore.text = "\(board.blackScore)"
        whiteScore.text = "\(board.whiteScore)"
        restartButton.isHidden = !board.gameHasFinished
    }
}
