//
//  PegBoard.swift
//  PegBoard
//
//  Created by James on 8/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

open class PegBoard
{

    enum Hole
    {
        case open
        case filled
        case off
    
    }
    

    let rows = 5
    let cols = 9
    
    var board :[[Hole]] =
    
    [[Hole.off,     Hole.off,   Hole.off,   Hole.off,   Hole.open, Hole.off,    Hole.off,    Hole.off,    Hole.off],
     [Hole.off,     Hole.off,   Hole.off,   Hole.filled, Hole.off,   Hole.filled, Hole.off,    Hole.off,    Hole.off],
     [Hole.off,     Hole.off,   Hole.filled, Hole.off,  Hole.filled, Hole.off,    Hole.filled, Hole.off,    Hole.off],
     [Hole.off,     Hole.filled, Hole.off,  Hole.filled, Hole.off,   Hole.filled, Hole.off,    Hole.filled, Hole.off],
     [Hole.filled,  Hole.off,   Hole.filled, Hole.off,  Hole.filled, Hole.off,    Hole.filled, Hole.off,    Hole.filled]]

    
    init()
    {
        fillBoard()     // fill board with pegs
        selectOpenHole()   // select one open hole to start game
    }
    
    func resetBoard()
    {
        fillBoard()
        selectOpenHole()
    }
    
    func getHoleStatus(_ indexFromTagNum: Int) -> Hole
    {
       //  04,
       //13, 15,
     //22, 24, 26
   // 31, 33, 35, 37
  // 40, 42, 44, 46, 48
        
        switch indexFromTagNum
        {
        case 4:  return board[0][4]
        case 13: return board[1][3]
        case 15: return board[1][5]
        case 22: return board[2][2]
        case 24: return board[2][4]
        case 26: return board[2][6]
        case 31: return board[3][1]
        case 33: return board[3][3]
        case 35: return board[3][5]
        case 37: return board[3][7]
        case 40: return board[4][0]
        case 42: return board[4][2]
        case 44: return board[4][4]
        case 46: return board[4][6]
        case 48: return board[4][8]
        default:
            print("Unknown tag")
            return Hole.off
        }
        
    }
    
    
    
    func checkForValidDiagonalMove(_ startTagNum: Int, finishTagnumber: Int) -> Bool
    {
        let start = getIndexFromTagNumber(startTagNum)
        let startRow = start.row
        let startCol = start.col
      
        let finish = getIndexFromTagNumber(finishTagnumber)
        let finishRow = finish.row
        let finishCol = finish.col
        
        if (startRow - 2 == finishRow && startCol - 2 == finishCol)
        {
            if board[startRow-1][startCol-1] != Hole.filled
            {
               return false
            }
            return true
        }
        if (startRow - 2 == finishRow && startCol + 2 == finishCol)
        {
            if board[startRow-1][startCol+1] != Hole.filled
            {
                return false
            }
            return true
        }
        if (startRow + 2 == finishRow && startCol - 2 == finishCol)
        {
            if board[startRow+1][startCol-1] != Hole.filled
            {
                return false
            }
            return true
        }
        if (startRow + 2 == finishRow && startCol + 2 == finishCol)
        {
            if board[startRow+1][startCol+1] != Hole.filled
            {
                return false
            }
            return true
        }

        return false
    }
    
    func removePeg(_ tagNum: Int) -> Bool
    {
        let start = getIndexFromTagNumber(tagNum)
        let startRow = start.row
        let startCol = start.col
        
        board[startRow][startCol] = Hole.open
        return true
    }
    
    func removeJumpedPeg(_ startTagNum: Int, finishTagnumber: Int) -> Bool
    {
        let start = getIndexFromTagNumber(startTagNum)
        let startRow = start.row
        let startCol = start.col
        
        let finish = getIndexFromTagNumber(finishTagnumber)
        let finishRow = finish.row
        let finishCol = finish.col
        
        if finishRow < startRow && finishCol < startCol
        {
            board[finishRow+1][finishCol+1] = Hole.open
            return true
        }
        
        if finishRow < startRow && finishCol > startCol
        {
            board[finishRow+1][finishCol-1] = Hole.open
            return true
        }
        
        if finishRow > startRow && finishCol < startCol
        {
            board[finishRow-1][finishCol+1] = Hole.open
            return true
        }
        
        if finishRow > startRow && finishCol > startCol
        {
            board[finishRow-1][finishCol-1] = Hole.open
            return true
        }
        
        return false
    }

    
    func getIndexFromTagNumber(_ tagNumber: Int) -> (row: Int, col: Int)
    {
        var row = 0
        var col = 0
        
        switch tagNumber
        {
        case 4:  row = 0; col = 4
        case 13: row = 1; col = 3
        case 15: row = 1; col = 5
        case 22: row = 2; col = 2
        case 24: row = 2; col = 4
        case 26: row = 2; col = 6
        case 31: row = 3; col = 1
        case 33: row = 3; col = 3
        case 35: row = 3; col = 5
        case 37: row = 3; col = 7
        case 40: row = 4; col = 0
        case 42: row = 4; col = 2
        case 44: row = 4; col = 4
        case 46: row = 4; col = 6
        case 48: row = 4; col = 8
        default:
            print("Unknown tag")
        }
        
        return (row,col)
    }
    
    func updateHoleStatus(_ indexFromTagNum: Int, status: Hole) -> Bool
    {
        //  04,
        //13, 15,
        //22, 24, 26
        // 31, 33, 35, 37
        // 40, 42, 44, 46, 48
        
        switch indexFromTagNum
        {
        case 4:  board[0][4] = status; return true
        case 13: board[1][3] = status; return true
        case 15: board[1][5] = status; return true
        case 22: board[2][2] = status; return true
        case 24: board[2][4] = status; return true
        case 26: board[2][6] = status; return true
        case 31: board[3][1] = status; return true
        case 33: board[3][3] = status; return true
        case 35: board[3][5] = status; return true
        case 37: board[3][7] = status; return true
        case 40: board[4][0] = status; return true
        case 42: board[4][2] = status; return true
        case 44: board[4][4] = status; return true
        case 46: board[4][6] = status; return true
        case 48: board[4][8] = status; return true
        default:
            print("Unknown tag")
            return false
        }
        
    }
    
    
    func fillBoard()
    {
        for i in 0 ..< rows
        {
            for j in 0 ..< cols
            {
                if board[i][j] != Hole.off
                {
                    board[i][j] = Hole.filled
                }
                
            }
        }
        
    }
    
    func selectOpenHole()
    {
        var randomRow = Int(arc4random_uniform(5))
        var randomCol = Int(arc4random_uniform(9))
        
        while (board[randomRow][randomCol] != Hole.filled)
        {
            randomRow = Int(arc4random_uniform(5))
            randomCol = Int(arc4random_uniform(9))
        }
        
        board[randomRow][randomCol]  = Hole.open
    }
    
    
}
