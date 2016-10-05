//
//  BoardSquare.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import UIKit

class BoardSquare: UIView, BoardDelegate{

    fileprivate let board: ReversiBoard
    fileprivate let location: BoardLocation
    fileprivate let blackView: UIImageView
    fileprivate let whiteView: UIImageView
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, location: BoardLocation, board: ReversiBoard) {
        self.board = board
        self.location = location
        
        let blackImage = UIImage(named: "ReversiBlackPiece.png")
        blackView = UIImageView(image: blackImage)
        blackView.alpha = 0
        
        let whiteImage = UIImage(named: "ReversiWhitePiece.png")
        whiteView = UIImageView(image: whiteImage)
        whiteView.alpha = 0
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        addSubview(blackView)
        addSubview(whiteView)
        
        update()
        
        board.addDelegate(self)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BoardSquare.cellTapped))
        addGestureRecognizer(tapRecognizer)
    }
    
    fileprivate func update() {
        let state = board[location]
        
        UIView.animate(withDuration: 0.2, animations: {
            switch state {
            case .white:
                self.whiteView.alpha = 1.0
                self.blackView.alpha = 0.0
                self.whiteView.transform = CGAffineTransform.identity
                self.blackView.transform = CGAffineTransform(translationX: 0, y: 20)
            case .black:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 1.0
                self.whiteView.transform = CGAffineTransform(translationX: 0, y: -20)
                self.blackView.transform = CGAffineTransform.identity
            case .empty:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 0.0
            }
        })
    }
    
    func cellTapped() {
        if board.isValidMove(location) {
            board.makeMove(location)
        }
    }
    
    func cellStateChanged(_ location: BoardLocation) {
        if self.location == location {
            update()
        }
    }

}
