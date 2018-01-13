//
//  Board.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substring(with: (index(startIndex, offsetBy: r.lowerBound) ..< index(startIndex, offsetBy: r.upperBound)))
    }
}

class Board
{
    enum Slot {
        case red
        case black
        case none
    }
    
    let rows = 6
    let cols = 7
    
    
    fileprivate struct Static {
        fileprivate static let instance: Board = Board()
    }
    
    class func shared() -> Board
    {
        return Static.instance
    }
    
    fileprivate var theBoard : [[Slot]] = [[.none, .none, .none, .none, .none, .none, .none]]
    
    
    fileprivate init()
    {
        theBoard.append( [.none, .none, .none, .none, .none, .none, .none] )
        theBoard.append( [.none, .none, .none, .none, .none, .none, .none] )
        theBoard.append( [.none, .none, .none, .none, .none, .none, .none] )
        theBoard.append( [.none, .none, .none, .none, .none, .none, .none] )
        theBoard.append( [.none, .none, .none, .none, .none, .none, .none] )
    }
    
    func dropToken(atRow: Int, andCol: Int, withSlotType: Slot) -> Bool
    {
        // row in range
        if atRow >= rows || atRow < 0
        { return false  }
        
        // col in range
        if andCol >= cols || andCol < 0
        { return false }
        
        if theBoard[atRow][andCol] == Slot.none
        {
            theBoard[atRow][andCol] = withSlotType
            return true
        }
        
        //slot taken
        return false
    }
    
    func dropTokenAtSlotWithTagNumber(number: Int, withSlotType: Slot) -> Bool
    {
        // empty slot ?
        // board tags
        // 11,12,13,14,15,16,17
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        let numAsString = "\(number)"
        var row = Int(numAsString[0])!
        var col = Int(numAsString[1])!

        row -= 1 ; col -= 1
        
        // row in range
        if row >= rows || row < 0
        { return false  }
        
        // col in range
        if col >= cols || col < 0
        { return false }
        
        // if bottom row and free take it
        if row == 5 &&  theBoard[row][col] == Slot.none
        {
            theBoard[row][col] = withSlotType
            return true
            
        } else if theBoard[row][col] == Slot.none && theBoard[row+1][col] != Slot.none
        {
          // free slot and supported by token under me -- no floating tokens
            theBoard[row][col] = withSlotType
            return true
        }
       
        // slot taken
        return false
    }
    
    func checkWin() -> (Bool, [Int], Slot)
    {
        // 11,12,13,14,15,16,17    (-1 for index)
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        for i in 0...5  // 6 rows
        {
            let results = checkHorizontal(i)
            if results.0 == true
            {
                return results
            }
        }
        
        for i in 0...6  // 7 cols
        {
            let results = checkVertical(i)
            if results.0 == true
            {
                return results
            }
        }
        
       let results = checkDiagonal()
        if results.0 == true
        {
            return results
        }
        
        return (false, [], Slot.none)
    }
    
    
    func checkDiagonal() -> (Bool, [Int], Slot)
    {
        // 11,12,13,14,15,16,17    (-1 for index)
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        // check black   for //////// direction
        if theBoard[3][0] == Board.Slot.black && theBoard[2][1] == Board.Slot.black
            && theBoard[1][2] == Board.Slot.black && theBoard[0][3] == Board.Slot.black
        {
            return (true, [41,32,23,12], Slot.black)
        } else if theBoard[4][0] == Board.Slot.black && theBoard[3][1] == Board.Slot.black
            && theBoard[2][2] == Board.Slot.black && theBoard[1][3] == Board.Slot.black
        {
            return (true, [51,42,33,24], Slot.black)
        }
        else if theBoard[5][0] == Board.Slot.black && theBoard[4][1] == Board.Slot.black
            && theBoard[3][2] == Board.Slot.black && theBoard[2][3] == Board.Slot.black
        {
            return (true, [61,52,43,34], Slot.black)
        }
        else if theBoard[3][1] == Board.Slot.black && theBoard[2][2] == Board.Slot.black
            && theBoard[1][3] == Board.Slot.black && theBoard[0][4] == Board.Slot.black
        {
            return (true, [42,33,24,15], Slot.black)
        }
        
        else if theBoard[4][1] == Board.Slot.black && theBoard[3][2] == Board.Slot.black
            && theBoard[2][3] == Board.Slot.black && theBoard[1][4] == Board.Slot.black
        {
            return (true, [52,43,34,25], Slot.black)
        } else if theBoard[5][1] == Board.Slot.black && theBoard[4][2] == Board.Slot.black
            && theBoard[3][3] == Board.Slot.black && theBoard[2][4] == Board.Slot.black
        {
            return (true, [62,53,44,35], Slot.black)
        }
        else if theBoard[3][2] == Board.Slot.black && theBoard[2][3] == Board.Slot.black
            && theBoard[1][4] == Board.Slot.black && theBoard[0][5] == Board.Slot.black
        {
            return (true, [43,34,25,16], Slot.black)
        }
        else if theBoard[4][2] == Board.Slot.black && theBoard[3][3] == Board.Slot.black
            && theBoard[2][4] == Board.Slot.black && theBoard[1][5] == Board.Slot.black
        {
            return (true, [53,44,35,26], Slot.black)
        }
        
        else if theBoard[5][2] == Board.Slot.black && theBoard[4][3] == Board.Slot.black
            && theBoard[3][4] == Board.Slot.black && theBoard[2][5] == Board.Slot.black
        {
            return (true, [63,54,45,36], Slot.black)
        } else if theBoard[3][3] == Board.Slot.black && theBoard[2][4] == Board.Slot.black
            && theBoard[1][5] == Board.Slot.black && theBoard[0][6] == Board.Slot.black
        {
            return (true, [44,35,26,17], Slot.black)
        }
        else if theBoard[4][3] == Board.Slot.black && theBoard[3][4] == Board.Slot.black
            && theBoard[2][5] == Board.Slot.black && theBoard[1][6] == Board.Slot.black
        {
            return (true, [54,45,36,27], Slot.black)
        }
        else if theBoard[5][3] == Board.Slot.black && theBoard[4][4] == Board.Slot.black
            && theBoard[3][5] == Board.Slot.black && theBoard[2][6] == Board.Slot.black
        {
            return (true, [64,55,46,37], Slot.black)
        }
        
        // black for \\\\\\\\\\\\
        
        if theBoard[0][3] == Board.Slot.black && theBoard[1][4] == Board.Slot.black
            && theBoard[2][5] == Board.Slot.black && theBoard[3][6] == Board.Slot.black
        {
            return (true, [14,25,36,47], Slot.black)
        } else if theBoard[1][3] == Board.Slot.black && theBoard[2][4] == Board.Slot.black
            && theBoard[3][5] == Board.Slot.black && theBoard[4][6] == Board.Slot.black
        {
            return (true, [24,35,46,57], Slot.black)
        }
        else if theBoard[2][3] == Board.Slot.black && theBoard[3][4] == Board.Slot.black
            && theBoard[4][5] == Board.Slot.black && theBoard[5][6] == Board.Slot.black
        {
            return (true, [34,45,56,67], Slot.black)
        }
        else if theBoard[0][2] == Board.Slot.black && theBoard[1][3] == Board.Slot.black
            && theBoard[2][4] == Board.Slot.black && theBoard[3][5] == Board.Slot.black
        {
            return (true, [13,24,35,46], Slot.black)
        } //
            
        else if theBoard[1][2] == Board.Slot.black && theBoard[2][3] == Board.Slot.black
            && theBoard[3][4] == Board.Slot.black && theBoard[4][5] == Board.Slot.black
        {
            return (true, [23,34,45,56], Slot.black)
        } else if theBoard[2][2] == Board.Slot.black && theBoard[3][3] == Board.Slot.black
            && theBoard[4][4] == Board.Slot.black && theBoard[5][5] == Board.Slot.black
        {
            return (true, [33,44,55,66], Slot.black)
        }
        else if theBoard[0][1] == Board.Slot.black && theBoard[1][2] == Board.Slot.black
            && theBoard[2][3] == Board.Slot.black && theBoard[3][4] == Board.Slot.black
        {
            return (true, [12,23,34,45], Slot.black)
        }
        else if theBoard[1][1] == Board.Slot.black && theBoard[2][2] == Board.Slot.black
            && theBoard[3][3] == Board.Slot.black && theBoard[4][4] == Board.Slot.black
        {
            return (true, [22,33,44,55], Slot.black)
        }
            
        else if theBoard[2][1] == Board.Slot.black && theBoard[3][2] == Board.Slot.black
            && theBoard[4][3] == Board.Slot.black && theBoard[5][4] == Board.Slot.black
        {
            return (true, [32,43,54,65], Slot.black)
        } else if theBoard[0][0] == Board.Slot.black && theBoard[1][1] == Board.Slot.black
            && theBoard[2][2] == Board.Slot.black && theBoard[3][3] == Board.Slot.black
        {
            return (true, [11,22,33,44], Slot.black)
        }
        else if theBoard[1][0] == Board.Slot.black && theBoard[2][1] == Board.Slot.black
            && theBoard[3][2] == Board.Slot.black && theBoard[4][3] == Board.Slot.black
        {
            return (true, [21,32,43,54], Slot.black)
        }
        else if theBoard[2][0] == Board.Slot.black && theBoard[3][1] == Board.Slot.black
            && theBoard[4][2] == Board.Slot.black && theBoard[5][3] == Board.Slot.black
        {
            return (true, [31,42,53,64], Slot.black)
        }
        // end black checks on diagonal ---------------------------------------------
        
        // copy paste - check red  for //////// direction
        if theBoard[3][0] == Board.Slot.red && theBoard[2][1] == Board.Slot.red
            && theBoard[1][2] == Board.Slot.red && theBoard[0][3] == Board.Slot.red
        {
            return (true, [41,32,23,12], Slot.red)
        } else if theBoard[4][0] == Board.Slot.red && theBoard[3][1] == Board.Slot.red
            && theBoard[2][2] == Board.Slot.red && theBoard[1][3] == Board.Slot.red
        {
            return (true, [51,42,33,24], Slot.red)
        }
        else if theBoard[5][0] == Board.Slot.red && theBoard[4][1] == Board.Slot.red
            && theBoard[3][2] == Board.Slot.red && theBoard[2][3] == Board.Slot.red
        {
            return (true, [61,52,43,34], Slot.red)
        }
        else if theBoard[3][1] == Board.Slot.red && theBoard[2][2] == Board.Slot.red
            && theBoard[1][3] == Board.Slot.red && theBoard[0][4] == Board.Slot.red
        {
            return (true, [42,33,24,15], Slot.red)
        }
            
        else if theBoard[4][1] == Board.Slot.red && theBoard[3][2] == Board.Slot.red
            && theBoard[2][3] == Board.Slot.red && theBoard[1][4] == Board.Slot.red
        {
            return (true, [52,43,34,25], Slot.red)
        } else if theBoard[5][1] == Board.Slot.red && theBoard[4][2] == Board.Slot.red
            && theBoard[3][3] == Board.Slot.red && theBoard[2][4] == Board.Slot.red
        {
            return (true, [62,53,44,35], Slot.red)
        }
        else if theBoard[3][2] == Board.Slot.red && theBoard[2][3] == Board.Slot.red
            && theBoard[1][4] == Board.Slot.red && theBoard[0][5] == Board.Slot.red
        {
            return (true, [43,34,25,16], Slot.red)
        }
        else if theBoard[4][2] == Board.Slot.red && theBoard[3][3] == Board.Slot.red
            && theBoard[2][4] == Board.Slot.red && theBoard[1][5] == Board.Slot.red
        {
            return (true, [53,44,35,26], Slot.red)
        }
            
        else if theBoard[5][2] == Board.Slot.red && theBoard[4][3] == Board.Slot.red
            && theBoard[3][4] == Board.Slot.red && theBoard[2][5] == Board.Slot.red
        {
            return (true, [63,54,45,36], Slot.red)
        } else if theBoard[3][3] == Board.Slot.red && theBoard[2][4] == Board.Slot.red
            && theBoard[1][5] == Board.Slot.red && theBoard[0][6] == Board.Slot.red
        {
            return (true, [44,35,26,17], Slot.red)
        }
        else if theBoard[4][3] == Board.Slot.red && theBoard[3][4] == Board.Slot.red
            && theBoard[2][5] == Board.Slot.red && theBoard[1][6] == Board.Slot.red
        {
            return (true, [54,45,36,27], Slot.red)
        }
        else if theBoard[5][3] == Board.Slot.red && theBoard[4][4] == Board.Slot.red
            && theBoard[3][5] == Board.Slot.red && theBoard[2][6] == Board.Slot.red
        {
            return (true, [64,55,46,37], Slot.red)
        }
        
        // red for \\\\\\\\\\\\
        
        if theBoard[0][3] == Board.Slot.red && theBoard[1][4] == Board.Slot.red
            && theBoard[2][5] == Board.Slot.red && theBoard[3][6] == Board.Slot.red
        {
            return (true, [14,25,36,47], Slot.red)
        } else if theBoard[1][3] == Board.Slot.red && theBoard[2][4] == Board.Slot.red
            && theBoard[3][5] == Board.Slot.red && theBoard[4][6] == Board.Slot.red
        {
            return (true, [24,35,46,57], Slot.red)
        }
        else if theBoard[2][3] == Board.Slot.red && theBoard[3][4] == Board.Slot.red
            && theBoard[4][5] == Board.Slot.red && theBoard[5][6] == Board.Slot.red
        {
            return (true, [34,45,56,67], Slot.red)
        }
        else if theBoard[0][2] == Board.Slot.red && theBoard[1][3] == Board.Slot.red
            && theBoard[2][4] == Board.Slot.red && theBoard[3][5] == Board.Slot.red
        {
            return (true, [13,24,35,46], Slot.red)
        } //
            
        else if theBoard[1][2] == Board.Slot.red && theBoard[2][3] == Board.Slot.red
            && theBoard[3][4] == Board.Slot.red && theBoard[4][5] == Board.Slot.red
        {
            return (true, [23,34,45,56], Slot.red)
        } else if theBoard[2][2] == Board.Slot.red && theBoard[3][3] == Board.Slot.red
            && theBoard[4][4] == Board.Slot.red && theBoard[5][5] == Board.Slot.red
        {
            return (true, [33,44,55,66], Slot.red)
        }
        else if theBoard[0][1] == Board.Slot.red && theBoard[1][2] == Board.Slot.red
            && theBoard[2][3] == Board.Slot.red && theBoard[3][4] == Board.Slot.red
        {
            return (true, [12,23,34,45], Slot.red)
        }
        else if theBoard[1][1] == Board.Slot.red && theBoard[2][2] == Board.Slot.red
            && theBoard[3][3] == Board.Slot.red && theBoard[4][4] == Board.Slot.red
        {
            return (true, [22,33,44,55], Slot.red)
        }
            
        else if theBoard[2][1] == Board.Slot.red && theBoard[3][2] == Board.Slot.red
            && theBoard[4][3] == Board.Slot.red && theBoard[5][4] == Board.Slot.red
        {
            return (true, [32,43,54,65], Slot.red)
        } else if theBoard[0][0] == Board.Slot.red && theBoard[1][1] == Board.Slot.red
            && theBoard[2][2] == Board.Slot.red && theBoard[3][3] == Board.Slot.red
        {
            return (true, [11,22,33,44], Slot.red)
        }
        else if theBoard[1][0] == Board.Slot.red && theBoard[2][1] == Board.Slot.red
            && theBoard[3][2] == Board.Slot.red && theBoard[4][3] == Board.Slot.red
        {
            return (true, [21,32,43,54], Slot.red)
        }
        else if theBoard[2][0] == Board.Slot.red && theBoard[3][1] == Board.Slot.red
            && theBoard[4][2] == Board.Slot.red && theBoard[5][3] == Board.Slot.red
        {
            return (true, [31,42,53,64], Slot.red)
        }
        
        return (false, [], Slot.none)
    }
    
    func checkHorizontal(_ row :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[row][0] == Board.Slot.black && theBoard[row][1] == Board.Slot.black
          && theBoard[row][2] == Board.Slot.black && theBoard[row][3] == Board.Slot.black
        {
            return (true, [0,1,2,3], Slot.black)
        } else if theBoard[row][1] == Board.Slot.black && theBoard[row][2] == Board.Slot.black
        && theBoard[row][3] == Board.Slot.black && theBoard[row][4] == Board.Slot.black
        {
            return (true, [1,2,3,4], Slot.black)
        }
        else if theBoard[row][2] == Board.Slot.black && theBoard[row][3] == Board.Slot.black
            && theBoard[row][4] == Board.Slot.black && theBoard[row][5] == Board.Slot.black
        {
            return (true, [2,3,4,5], Slot.black)
        }
        else if theBoard[row][3] == Board.Slot.black && theBoard[row][4] == Board.Slot.black
            && theBoard[row][5] == Board.Slot.black && theBoard[row][6] == Board.Slot.black
        {
            return (true, [3,4,5,6], Slot.black)
        }
        
        // copy paste for red
        if theBoard[row][0] == Board.Slot.red && theBoard[row][1] == Board.Slot.red
            && theBoard[row][2] == Board.Slot.red && theBoard[row][3] == Board.Slot.red
        {
            return (true, [0,1,2,3], Slot.red)
        } else if theBoard[row][1] == Board.Slot.red && theBoard[row][2] == Board.Slot.red
            && theBoard[row][3] == Board.Slot.red && theBoard[row][4] == Board.Slot.red
        {
            return (true, [1,2,3,4], Slot.red)
        }
        else if theBoard[row][2] == Board.Slot.red && theBoard[row][3] == Board.Slot.red
            && theBoard[row][4] == Board.Slot.red && theBoard[row][5] == Board.Slot.red
        {
            return (true, [2,3,4,5], Slot.red)
        }
        else if theBoard[row][3] == Board.Slot.red && theBoard[row][4] == Board.Slot.red
            && theBoard[row][5] == Board.Slot.red && theBoard[row][6] == Board.Slot.red
        {
            return (true, [3,4,5,6], Slot.red)
        }
        
        return (false, [], Slot.none)
    }
    
    
    
    func checkVertical(_ col :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[0][col] == Board.Slot.black && theBoard[1][col] == Board.Slot.black
            && theBoard[2][col] == Board.Slot.black && theBoard[3][col] == Board.Slot.black
        {
            return (true, [0,1,2,3], Slot.black)
        } else if theBoard[1][col] == Board.Slot.black && theBoard[2][col] == Board.Slot.black
            && theBoard[3][col] == Board.Slot.black && theBoard[4][col] == Board.Slot.black
        {
            return (true, [1,2,3,4], Slot.black)
        }
        else if theBoard[2][col] == Board.Slot.black && theBoard[3][col] == Board.Slot.black
            && theBoard[4][col] == Board.Slot.black && theBoard[5][col] == Board.Slot.black
        {
            return (true, [2,3,4,5], Slot.black)
        }
       
        
        // copy paste for red
        if theBoard[0][col] == Board.Slot.red && theBoard[1][col] == Board.Slot.red
            && theBoard[2][col] == Board.Slot.red && theBoard[3][col] == Board.Slot.red
        {
            return (true, [0,1,2,3], Slot.red)
        } else if theBoard[1][col] == Board.Slot.red && theBoard[2][col] == Board.Slot.red
            && theBoard[3][col] == Board.Slot.red && theBoard[4][col] == Board.Slot.red
        {
            return (true, [1,2,3,4], Slot.red)
        }
        else if theBoard[2][col] == Board.Slot.red && theBoard[3][col] == Board.Slot.red
            && theBoard[4][col] == Board.Slot.red && theBoard[5][col] == Board.Slot.red
        {
            return (true, [2,3,4,5], Slot.red)
        }
    
        return (false, [], Slot.none)
    }
    
    
    func isFull() -> Bool
    {
        for row in theBoard {
            for col in row
            {
                if col == Slot.none
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func getSlot(row: Int, andCol : Int) -> Slot
    {
        return theBoard[row][andCol]
    }
    
    func clear()
    {
        theBoard = [[.none, .none, .none, .none, .none, .none, .none],
        [.none, .none, .none, .none, .none, .none, .none],
        [.none, .none, .none, .none, .none, .none, .none],
        [.none, .none, .none, .none, .none, .none, .none],
        [.none, .none, .none, .none, .none, .none, .none],
        [.none, .none, .none, .none, .none, .none, .none]]
    }
    
}
