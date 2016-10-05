//
//  ReversiBoardView.swift
//  Othello
//
//  Created by Lê Hà Thành on 10/5/16.
//  Copyright © 2016 Lê Hà Thành. All rights reserved.
//

import UIKit

class ReversiBoardView: UIView {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implementing")
    }
    
    init(frame: CGRect, board: ReversiBoard) {
        super.init(frame: frame)
        
        let rowHeight = frame.size.height / CGFloat(board.boardSize)
        let columnWidth = frame.size.width / CGFloat(board.boardSize)
        
        board.cellVisitor {
            (location: BoardLocation) in
            let left = CGFloat(location.column) * columnWidth
            let top = CGFloat(location.row) * rowHeight
            let squareImage = CGRect(x: left, y: top, width: columnWidth, height: rowHeight)
            let square = BoardSquare(frame: squareImage, location: location, board: board)
            self.addSubview(square)
        }
    }
}
