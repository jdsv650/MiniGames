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
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}

class Board
{
    enum Slot {
        case Red
        case Black
        case None
    }
    
    let rows = 6
    let cols = 7
    
    
    private struct Static {
        private static let instance: Board = Board()
    }
    
    class func shared() -> Board
    {
        return Static.instance
    }
    
    private var theBoard : [[Slot]] = [[.None, .None, .None, .None, .None, .None, .None]]
    
    
    private init()
    {
        theBoard.append( [.None, .None, .None, .None, .None, .None, .None] )
        theBoard.append( [.None, .None, .None, .None, .None, .None, .None] )
        theBoard.append( [.None, .None, .None, .None, .None, .None, .None] )
        theBoard.append( [.None, .None, .None, .None, .None, .None, .None] )
        theBoard.append( [.None, .None, .None, .None, .None, .None, .None] )
    }
    
    func dropToken(atRow atRow: Int, andCol: Int, withSlotType: Slot) -> Bool
    {
        // row in range
        if atRow >= rows || atRow < 0
        { return false  }
        
        // col in range
        if andCol >= cols || andCol < 0
        { return false }
        
        if theBoard[atRow][andCol] == Slot.None
        {
            theBoard[atRow][andCol] = withSlotType
            return true
        }
        
        //slot taken
        return false
    }
    
    func dropTokenAtSlotWithTagNumber(number number: Int, withSlotType: Slot) -> Bool
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

        row-- ; col--
        
        // row in range
        if row >= rows || row < 0
        { return false  }
        
        // col in range
        if col >= cols || col < 0
        { return false }
        
        // if bottom row and free take it
        if row == 5 &&  theBoard[row][col] == Slot.None
        {
            theBoard[row][col] = withSlotType
            return true
            
        } else if theBoard[row][col] == Slot.None && theBoard[row+1][col] != Slot.None
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
        
        return (false, [], Slot.None)
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
        if theBoard[3][0] == Board.Slot.Black && theBoard[2][1] == Board.Slot.Black
            && theBoard[1][2] == Board.Slot.Black && theBoard[0][3] == Board.Slot.Black
        {
            return (true, [41,32,23,12], Slot.Black)
        } else if theBoard[4][0] == Board.Slot.Black && theBoard[3][1] == Board.Slot.Black
            && theBoard[2][2] == Board.Slot.Black && theBoard[1][3] == Board.Slot.Black
        {
            return (true, [51,42,33,24], Slot.Black)
        }
        else if theBoard[5][0] == Board.Slot.Black && theBoard[4][1] == Board.Slot.Black
            && theBoard[3][2] == Board.Slot.Black && theBoard[2][3] == Board.Slot.Black
        {
            return (true, [61,52,43,34], Slot.Black)
        }
        else if theBoard[3][1] == Board.Slot.Black && theBoard[2][2] == Board.Slot.Black
            && theBoard[1][3] == Board.Slot.Black && theBoard[0][4] == Board.Slot.Black
        {
            return (true, [42,33,24,15], Slot.Black)
        }
        
        else if theBoard[4][1] == Board.Slot.Black && theBoard[3][2] == Board.Slot.Black
            && theBoard[2][3] == Board.Slot.Black && theBoard[1][4] == Board.Slot.Black
        {
            return (true, [52,43,34,25], Slot.Black)
        } else if theBoard[5][1] == Board.Slot.Black && theBoard[4][2] == Board.Slot.Black
            && theBoard[3][3] == Board.Slot.Black && theBoard[2][4] == Board.Slot.Black
        {
            return (true, [62,53,44,35], Slot.Black)
        }
        else if theBoard[3][2] == Board.Slot.Black && theBoard[2][3] == Board.Slot.Black
            && theBoard[1][4] == Board.Slot.Black && theBoard[0][5] == Board.Slot.Black
        {
            return (true, [43,34,25,16], Slot.Black)
        }
        else if theBoard[4][2] == Board.Slot.Black && theBoard[3][3] == Board.Slot.Black
            && theBoard[2][4] == Board.Slot.Black && theBoard[1][5] == Board.Slot.Black
        {
            return (true, [53,44,35,26], Slot.Black)
        }
        
        else if theBoard[5][2] == Board.Slot.Black && theBoard[4][3] == Board.Slot.Black
            && theBoard[3][4] == Board.Slot.Black && theBoard[2][5] == Board.Slot.Black
        {
            return (true, [63,54,45,36], Slot.Black)
        } else if theBoard[3][3] == Board.Slot.Black && theBoard[2][4] == Board.Slot.Black
            && theBoard[1][5] == Board.Slot.Black && theBoard[0][6] == Board.Slot.Black
        {
            return (true, [44,35,26,17], Slot.Black)
        }
        else if theBoard[4][3] == Board.Slot.Black && theBoard[3][4] == Board.Slot.Black
            && theBoard[2][5] == Board.Slot.Black && theBoard[1][6] == Board.Slot.Black
        {
            return (true, [54,45,36,27], Slot.Black)
        }
        else if theBoard[5][3] == Board.Slot.Black && theBoard[4][4] == Board.Slot.Black
            && theBoard[3][5] == Board.Slot.Black && theBoard[2][6] == Board.Slot.Black
        {
            return (true, [64,55,46,37], Slot.Black)
        }
        
        // black for \\\\\\\\\\\\
        
        if theBoard[0][3] == Board.Slot.Black && theBoard[1][4] == Board.Slot.Black
            && theBoard[2][5] == Board.Slot.Black && theBoard[3][6] == Board.Slot.Black
        {
            return (true, [14,25,36,47], Slot.Black)
        } else if theBoard[1][3] == Board.Slot.Black && theBoard[2][4] == Board.Slot.Black
            && theBoard[3][5] == Board.Slot.Black && theBoard[4][6] == Board.Slot.Black
        {
            return (true, [24,35,46,57], Slot.Black)
        }
        else if theBoard[2][3] == Board.Slot.Black && theBoard[3][4] == Board.Slot.Black
            && theBoard[4][5] == Board.Slot.Black && theBoard[5][6] == Board.Slot.Black
        {
            return (true, [34,45,56,67], Slot.Black)
        }
        else if theBoard[0][2] == Board.Slot.Black && theBoard[1][3] == Board.Slot.Black
            && theBoard[2][4] == Board.Slot.Black && theBoard[3][5] == Board.Slot.Black
        {
            return (true, [13,24,35,46], Slot.Black)
        } //
            
        else if theBoard[1][2] == Board.Slot.Black && theBoard[2][3] == Board.Slot.Black
            && theBoard[3][4] == Board.Slot.Black && theBoard[4][5] == Board.Slot.Black
        {
            return (true, [23,34,45,56], Slot.Black)
        } else if theBoard[2][2] == Board.Slot.Black && theBoard[3][3] == Board.Slot.Black
            && theBoard[4][4] == Board.Slot.Black && theBoard[5][5] == Board.Slot.Black
        {
            return (true, [33,44,55,66], Slot.Black)
        }
        else if theBoard[0][1] == Board.Slot.Black && theBoard[1][2] == Board.Slot.Black
            && theBoard[2][3] == Board.Slot.Black && theBoard[3][4] == Board.Slot.Black
        {
            return (true, [12,23,34,45], Slot.Black)
        }
        else if theBoard[1][1] == Board.Slot.Black && theBoard[2][2] == Board.Slot.Black
            && theBoard[3][3] == Board.Slot.Black && theBoard[4][4] == Board.Slot.Black
        {
            return (true, [22,33,44,55], Slot.Black)
        }
            
        else if theBoard[2][1] == Board.Slot.Black && theBoard[3][2] == Board.Slot.Black
            && theBoard[4][3] == Board.Slot.Black && theBoard[5][4] == Board.Slot.Black
        {
            return (true, [32,43,54,65], Slot.Black)
        } else if theBoard[0][0] == Board.Slot.Black && theBoard[1][1] == Board.Slot.Black
            && theBoard[2][2] == Board.Slot.Black && theBoard[3][3] == Board.Slot.Black
        {
            return (true, [11,22,33,44], Slot.Black)
        }
        else if theBoard[1][0] == Board.Slot.Black && theBoard[2][1] == Board.Slot.Black
            && theBoard[3][2] == Board.Slot.Black && theBoard[4][3] == Board.Slot.Black
        {
            return (true, [21,32,43,54], Slot.Black)
        }
        else if theBoard[2][0] == Board.Slot.Black && theBoard[3][1] == Board.Slot.Black
            && theBoard[4][2] == Board.Slot.Black && theBoard[5][3] == Board.Slot.Black
        {
            return (true, [31,42,53,64], Slot.Black)
        }
        // end black checks on diagonal ---------------------------------------------
        
        // copy paste - check red  for //////// direction
        if theBoard[3][0] == Board.Slot.Red && theBoard[2][1] == Board.Slot.Red
            && theBoard[1][2] == Board.Slot.Red && theBoard[0][3] == Board.Slot.Red
        {
            return (true, [41,32,23,12], Slot.Red)
        } else if theBoard[4][0] == Board.Slot.Red && theBoard[3][1] == Board.Slot.Red
            && theBoard[2][2] == Board.Slot.Red && theBoard[1][3] == Board.Slot.Red
        {
            return (true, [51,42,33,24], Slot.Red)
        }
        else if theBoard[5][0] == Board.Slot.Red && theBoard[4][1] == Board.Slot.Red
            && theBoard[3][2] == Board.Slot.Red && theBoard[2][3] == Board.Slot.Red
        {
            return (true, [61,52,43,34], Slot.Red)
        }
        else if theBoard[3][1] == Board.Slot.Red && theBoard[2][2] == Board.Slot.Red
            && theBoard[1][3] == Board.Slot.Red && theBoard[0][4] == Board.Slot.Red
        {
            return (true, [42,33,24,15], Slot.Red)
        }
            
        else if theBoard[4][1] == Board.Slot.Red && theBoard[3][2] == Board.Slot.Red
            && theBoard[2][3] == Board.Slot.Red && theBoard[1][4] == Board.Slot.Red
        {
            return (true, [52,43,34,25], Slot.Red)
        } else if theBoard[5][1] == Board.Slot.Red && theBoard[4][2] == Board.Slot.Red
            && theBoard[3][3] == Board.Slot.Red && theBoard[2][4] == Board.Slot.Red
        {
            return (true, [62,53,44,35], Slot.Red)
        }
        else if theBoard[3][2] == Board.Slot.Red && theBoard[2][3] == Board.Slot.Red
            && theBoard[1][4] == Board.Slot.Red && theBoard[0][5] == Board.Slot.Red
        {
            return (true, [43,34,25,16], Slot.Red)
        }
        else if theBoard[4][2] == Board.Slot.Red && theBoard[3][3] == Board.Slot.Red
            && theBoard[2][4] == Board.Slot.Red && theBoard[1][5] == Board.Slot.Red
        {
            return (true, [53,44,35,26], Slot.Red)
        }
            
        else if theBoard[5][2] == Board.Slot.Red && theBoard[4][3] == Board.Slot.Red
            && theBoard[3][4] == Board.Slot.Red && theBoard[2][5] == Board.Slot.Red
        {
            return (true, [63,54,45,36], Slot.Red)
        } else if theBoard[3][3] == Board.Slot.Red && theBoard[2][4] == Board.Slot.Red
            && theBoard[1][5] == Board.Slot.Red && theBoard[0][6] == Board.Slot.Red
        {
            return (true, [44,35,26,17], Slot.Red)
        }
        else if theBoard[4][3] == Board.Slot.Red && theBoard[3][4] == Board.Slot.Red
            && theBoard[2][5] == Board.Slot.Red && theBoard[1][6] == Board.Slot.Red
        {
            return (true, [54,45,36,27], Slot.Red)
        }
        else if theBoard[5][3] == Board.Slot.Red && theBoard[4][4] == Board.Slot.Red
            && theBoard[3][5] == Board.Slot.Red && theBoard[2][6] == Board.Slot.Red
        {
            return (true, [64,55,46,37], Slot.Red)
        }
        
        // red for \\\\\\\\\\\\
        
        if theBoard[0][3] == Board.Slot.Red && theBoard[1][4] == Board.Slot.Red
            && theBoard[2][5] == Board.Slot.Red && theBoard[3][6] == Board.Slot.Red
        {
            return (true, [14,25,36,47], Slot.Red)
        } else if theBoard[1][3] == Board.Slot.Red && theBoard[2][4] == Board.Slot.Red
            && theBoard[3][5] == Board.Slot.Red && theBoard[4][6] == Board.Slot.Red
        {
            return (true, [24,35,46,57], Slot.Red)
        }
        else if theBoard[2][3] == Board.Slot.Red && theBoard[3][4] == Board.Slot.Red
            && theBoard[4][5] == Board.Slot.Red && theBoard[5][6] == Board.Slot.Red
        {
            return (true, [34,45,56,67], Slot.Red)
        }
        else if theBoard[0][2] == Board.Slot.Red && theBoard[1][3] == Board.Slot.Red
            && theBoard[2][4] == Board.Slot.Red && theBoard[3][5] == Board.Slot.Red
        {
            return (true, [13,24,35,46], Slot.Red)
        } //
            
        else if theBoard[1][2] == Board.Slot.Red && theBoard[2][3] == Board.Slot.Red
            && theBoard[3][4] == Board.Slot.Red && theBoard[4][5] == Board.Slot.Red
        {
            return (true, [23,34,45,56], Slot.Red)
        } else if theBoard[2][2] == Board.Slot.Red && theBoard[3][3] == Board.Slot.Red
            && theBoard[4][4] == Board.Slot.Red && theBoard[5][5] == Board.Slot.Red
        {
            return (true, [33,44,55,66], Slot.Red)
        }
        else if theBoard[0][1] == Board.Slot.Red && theBoard[1][2] == Board.Slot.Red
            && theBoard[2][3] == Board.Slot.Red && theBoard[3][4] == Board.Slot.Red
        {
            return (true, [12,23,34,45], Slot.Red)
        }
        else if theBoard[1][1] == Board.Slot.Red && theBoard[2][2] == Board.Slot.Red
            && theBoard[3][3] == Board.Slot.Red && theBoard[4][4] == Board.Slot.Red
        {
            return (true, [22,33,44,55], Slot.Red)
        }
            
        else if theBoard[2][1] == Board.Slot.Red && theBoard[3][2] == Board.Slot.Red
            && theBoard[4][3] == Board.Slot.Red && theBoard[5][4] == Board.Slot.Red
        {
            return (true, [32,43,54,65], Slot.Red)
        } else if theBoard[0][0] == Board.Slot.Red && theBoard[1][1] == Board.Slot.Red
            && theBoard[2][2] == Board.Slot.Red && theBoard[3][3] == Board.Slot.Red
        {
            return (true, [11,22,33,44], Slot.Red)
        }
        else if theBoard[1][0] == Board.Slot.Red && theBoard[2][1] == Board.Slot.Red
            && theBoard[3][2] == Board.Slot.Red && theBoard[4][3] == Board.Slot.Red
        {
            return (true, [21,32,43,54], Slot.Red)
        }
        else if theBoard[2][0] == Board.Slot.Red && theBoard[3][1] == Board.Slot.Red
            && theBoard[4][2] == Board.Slot.Red && theBoard[5][3] == Board.Slot.Red
        {
            return (true, [31,42,53,64], Slot.Red)
        }
        
        return (false, [], Slot.None)
    }
    
    func checkHorizontal(row :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[row][0] == Board.Slot.Black && theBoard[row][1] == Board.Slot.Black
          && theBoard[row][2] == Board.Slot.Black && theBoard[row][3] == Board.Slot.Black
        {
            return (true, [0,1,2,3], Slot.Black)
        } else if theBoard[row][1] == Board.Slot.Black && theBoard[row][2] == Board.Slot.Black
        && theBoard[row][3] == Board.Slot.Black && theBoard[row][4] == Board.Slot.Black
        {
            return (true, [1,2,3,4], Slot.Black)
        }
        else if theBoard[row][2] == Board.Slot.Black && theBoard[row][3] == Board.Slot.Black
            && theBoard[row][4] == Board.Slot.Black && theBoard[row][5] == Board.Slot.Black
        {
            return (true, [2,3,4,5], Slot.Black)
        }
        else if theBoard[row][3] == Board.Slot.Black && theBoard[row][4] == Board.Slot.Black
            && theBoard[row][5] == Board.Slot.Black && theBoard[row][6] == Board.Slot.Black
        {
            return (true, [3,4,5,6], Slot.Black)
        }
        
        // copy paste for red
        if theBoard[row][0] == Board.Slot.Red && theBoard[row][1] == Board.Slot.Red
            && theBoard[row][2] == Board.Slot.Red && theBoard[row][3] == Board.Slot.Red
        {
            return (true, [0,1,2,3], Slot.Red)
        } else if theBoard[row][1] == Board.Slot.Red && theBoard[row][2] == Board.Slot.Red
            && theBoard[row][3] == Board.Slot.Red && theBoard[row][4] == Board.Slot.Red
        {
            return (true, [1,2,3,4], Slot.Red)
        }
        else if theBoard[row][2] == Board.Slot.Red && theBoard[row][3] == Board.Slot.Red
            && theBoard[row][4] == Board.Slot.Red && theBoard[row][5] == Board.Slot.Red
        {
            return (true, [2,3,4,5], Slot.Red)
        }
        else if theBoard[row][3] == Board.Slot.Red && theBoard[row][4] == Board.Slot.Red
            && theBoard[row][5] == Board.Slot.Red && theBoard[row][6] == Board.Slot.Red
        {
            return (true, [3,4,5,6], Slot.Red)
        }
        
        return (false, [], Slot.None)
    }
    
    
    
    func checkVertical(col :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[0][col] == Board.Slot.Black && theBoard[1][col] == Board.Slot.Black
            && theBoard[2][col] == Board.Slot.Black && theBoard[3][col] == Board.Slot.Black
        {
            return (true, [0,1,2,3], Slot.Black)
        } else if theBoard[1][col] == Board.Slot.Black && theBoard[2][col] == Board.Slot.Black
            && theBoard[3][col] == Board.Slot.Black && theBoard[4][col] == Board.Slot.Black
        {
            return (true, [1,2,3,4], Slot.Black)
        }
        else if theBoard[2][col] == Board.Slot.Black && theBoard[3][col] == Board.Slot.Black
            && theBoard[4][col] == Board.Slot.Black && theBoard[5][col] == Board.Slot.Black
        {
            return (true, [2,3,4,5], Slot.Black)
        }
       
        
        // copy paste for red
        if theBoard[0][col] == Board.Slot.Red && theBoard[1][col] == Board.Slot.Red
            && theBoard[2][col] == Board.Slot.Red && theBoard[3][col] == Board.Slot.Red
        {
            return (true, [0,1,2,3], Slot.Red)
        } else if theBoard[1][col] == Board.Slot.Red && theBoard[2][col] == Board.Slot.Red
            && theBoard[3][col] == Board.Slot.Red && theBoard[4][col] == Board.Slot.Red
        {
            return (true, [1,2,3,4], Slot.Red)
        }
        else if theBoard[2][col] == Board.Slot.Red && theBoard[3][col] == Board.Slot.Red
            && theBoard[4][col] == Board.Slot.Red && theBoard[5][col] == Board.Slot.Red
        {
            return (true, [2,3,4,5], Slot.Red)
        }
    
        return (false, [], Slot.None)
    }
    
    
    func isFull() -> Bool
    {
        for row in theBoard {
            for col in row
            {
                if col == Slot.None
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func getSlot(row row: Int, andCol : Int) -> Slot
    {
        return theBoard[row][andCol]
    }
    
    func clear()
    {
        theBoard = [[.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None]]
    }
    
}
