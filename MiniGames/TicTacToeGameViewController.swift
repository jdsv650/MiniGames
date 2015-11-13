//
//  TicTacToeGameViewController.swift
//  MiniGames
//
//  Created by James on 11/1/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class TicTacToeGameViewController: UIViewController {

    var tictac = Array(count: 3, repeatedValue: Array(count: 3, repeatedValue: "-")) // char tictac[3][3]
    var row :Int?
    var col :Int?
    
    @IBOutlet weak var button1_1_Outlet : UIButton!
    @IBOutlet weak var button1_2_Outlet : UIButton!
    @IBOutlet weak var button1_3_Outlet : UIButton!
    @IBOutlet weak var button2_1_Outlet : UIButton!
    @IBOutlet weak var button2_2_Outlet : UIButton!
    @IBOutlet weak var button2_3_Outlet : UIButton!
    @IBOutlet weak var button3_1_Outlet : UIButton!
    @IBOutlet weak var button3_2_Outlet : UIButton!
    @IBOutlet weak var button3_3_Outlet : UIButton!
    @IBOutlet weak var level_Outlet: UISegmentedControl!
    @IBOutlet weak var level_Label: UILabel!
    @IBOutlet weak var boardView: UIView!
    
    
    var isPlayerX :Bool = true
    var buttonBackStr: String?
    var buttonXStr: String?
    var buttonOStr: String?
    
    // set in prepareForSegue
    var isVersusComp : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.backgroundColor = UIColor(patternImage: UIImage(named: "beachsand4.png")!)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BubblesBackground.png")!)
        
        buttonBackStr = "poolWater.png"
        buttonXStr = "poolX.png"
        buttonOStr = "poolO.png"
        
        self.initialize() // Clear board '-'
        
        isPlayerX = true
        
        if isVersusComp
        {
            level_Outlet.hidden = false
            level_Label.hidden = false
        }
        else
        {
            level_Outlet.hidden = true
            level_Label.hidden = true
        }
    }
    
    
    func initialize()
    {
        var i :Int = 0
        var j :Int = 0
        
        for  i=0; i<3; i++  /* set elements = to dash - */
        {
            for j=0; j<3; j++
            {
                tictac[i][j] = ("-")
            }
        }
        
        button1_1_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button1_2_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button1_3_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button2_1_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button2_2_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button2_3_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button3_1_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button3_2_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        button3_3_Outlet.setBackgroundImage(UIImage(named: buttonBackStr!), forState: UIControlState.Normal)
        
    }
    
    
    func computerMove()
    {
        var rowInd = 0
        var colInd = 0
        
        if level_Outlet.selectedSegmentIndex == 2  {
            if tictac[2][1] == "X" && tictac [1][2] == "X" && tictac[2][2] == "-" {
                tictac[2][2] = "O"
                // drawO(2,2,2);
                button3_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState: UIControlState.Normal)
            }
            else if(tictac[1][1] == "-")  {
                tictac[1][1] = "O"
                // drawO(1,1,2);
                button2_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if(tictac[0][0] == "-" && (tictac[0][2] != "X" || tictac[2][0] != "X"))  {
                tictac[0][0] = "O"
                // drawO(0,0,2);
                button1_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[2][2] == "-" && (tictac[0][2] != "X" || tictac[2][0] != "X"))   {
                tictac[2][2] = "O"
                //drawO(2,2,2);
                button3_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[2][0] == "-" && (tictac[0][0] != "X" || tictac[2][2] != "X")) {
                tictac[2][0] = "O"
                //drawO(2,0,2);
                button3_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[0][2] == "-" && (tictac[0][0] != "X" || tictac[2][2] != "X")) {
                tictac[0][2] = "O"
                // drawO(0,2,2);
                button1_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[1][0] == "-") {
                tictac[1][0] = "O"
                // drawO(1,0,2);
                button2_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[2][1] == "-") {
                tictac[2][1] = "O"
                // drawO(2,1,2);
                button3_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[1][2] == "-") {
                tictac[1][2] = "O"
                // drawO(1,2,2);
                button2_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if (tictac[0][1] == "-")  {
                tictac[0][1] = "O"
                // drawO(0,1,2);
                button1_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else
            {
                print("TIE GAME\n")
                self.showWin("T")
            }
        }
        
        
        if level_Outlet.selectedSegmentIndex == 0  // just choose a random space
        {
            print("Easy level")
            
            if self.isBoardFull()
            {
                self.showWin("T")
                return
            }
            
            rowInd = Int(arc4random() % 3)
            colInd = Int(arc4random() % 3)
            
            while tictac[rowInd][colInd] != "-"
            {
                rowInd = Int(arc4random() % 3)
                colInd = Int(arc4random() % 3)
            }
            
            tictac[rowInd][colInd] = "O"
            self.makeMoveWithRowandCol(rowInd, col: colInd)
        }
        
        
        if level_Outlet.selectedSegmentIndex == 1  // medium level block and take win if avail
        {
            print("Medium level")
            
            if self.isBoardFull()
            {
                self.showWin("T")
                return
            }
            
            if self.winPossible("O") == 1
            {
                return
            }
            else if self.winPossible("X") == 1 //block?
            {
                return
            }
            else // no win or block make random move
            {
                rowInd = Int(arc4random() % 3)
                colInd = Int(arc4random() % 3)
                
                while self.tictac[rowInd][colInd] != "-"
                {
                    rowInd = Int(arc4random() % 3)
                    colInd = Int(arc4random() % 3)
                }
                
                self.tictac[rowInd][colInd] = "O"
                self.makeMoveWithRowandCol(rowInd, col: colInd)
            }
        }
    }
    
    
    
    func makeMoveWithRowandCol(row :Int, col :Int)
    {
        switch (row) {
        case 0:
            if(col == 0)
            {
                button1_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
            }
            else if(col == 1)
            {
                button1_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if(col == 2)
            {
                button1_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            break
        case 1:
            if(col == 0)
            {
                button2_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
            }
            else if(col == 1)
            {
                button2_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if(col == 2)
            {
                button2_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            break
        case 2:
            if(col == 0)
            {
                button3_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
            }
            else if(col == 1)
            {
                button3_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            else if(col == 2)
            {
                button3_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                
            }
            break
        default:
            break
        }
        
    }
    
    
    func checkIfWon(letter :String) -> Int
    {
        var i = 0
        var j = 0
        var winner = 0
        
        
        for (i=0; i<3; i++)
        {
            if tictac[i][0]==letter && tictac[i][1]==letter && tictac[i][2]==letter { winner = 1 }
        }
        
        for (j=0;j<3;j++)
        {
            if tictac[0][j]==letter && tictac[1][j]==letter && tictac[2][j]==letter { winner = 1 }
        }
        
        if tictac[0][0]==letter && tictac[1][1]==letter && tictac[2][2]==letter { winner = 1 }
        if tictac[0][2]==letter && tictac[1][1]==letter && tictac[2][0] == letter { winner = 1 }
        
        return (winner)
    }
    
    
    func winPossible(letter :String) -> Int
    {
        var row = 0
        var col = 0
        
        for(row = 0; row < 3; row++)
        {
            for(col = 0; col < 3; col++)
            {
                if (tictac[row][col] == "-")
                {
                    tictac[row][col] = letter
                    if self.checkIfWon(letter) == 0 { tictac[row][col] = "-" }
                    else
                    {
                        tictac[row][col] = "O"
                        // drawO(row,col,2);
                        //block
                        if(row == 0 && col == 0) {
                            button1_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 0 && col == 1)
                        {
                            button1_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 0 && col == 2)
                        {
                            button1_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 1 && col == 0)
                        {
                            button2_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 1 && col == 1)
                        {
                            button2_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 1 && col == 2)
                        {
                            button2_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 2 && col == 0)
                        {
                            button3_1_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 2 && col == 1)
                        {
                            button3_2_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        if(row == 2 && col == 2)
                        {
                            button3_3_Outlet.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                        }
                        return 1
                    }
                }
            }
        }
        
        return 0
    }
    
    
    @IBAction func getUserMove(sender: AnyObject)
    {
        switch sender.tag
        {
        case 11:
            row = 0
            col = 0
            break
        case 12:
            row = 0
            col = 1
            break
        case 13:
            row = 0
            col = 2
            break
        case 21:
            row = 1
            col = 0
            break
        case 22:
            row = 1
            col = 1
            break
        case 23:
            row = 1
            col = 2
            break
        case 31:
            row = 2
            col = 0
            break
        case 32:
            row = 2
            col = 1
            break
        case 33:
            row = 2
            col = 2
            break
        default:
            break
        }
        
        if tictac[row!][col!] != "-"
        {
            return
        }
        
        if isPlayerX && !isVersusComp {
            sender.setBackgroundImage(UIImage(named: buttonXStr!), forState:UIControlState.Normal)
            tictac[row!][col!] = "X"  /* make move for 'X' */
            if self.checkIfWon("X") == 1  {
                print("X wins\n")
                self.showWin("X")
            }
            else
                if self.isBoardFull()
                {
                    self.showWin("T")
            }
            isPlayerX = false
        }
        else
            if !isPlayerX && !isVersusComp
            {
                sender.setBackgroundImage(UIImage(named: buttonOStr!), forState:UIControlState.Normal)
                tictac[row!][col!] = "O"  /* make move for 'O' */
                if self.checkIfWon("O") == 1 {
                    print("O wins\n")
                    self.showWin("O")
                }
                else
                    if self.isBoardFull()
                    {
                        self.showWin("T")
                }
                isPlayerX = true
            }
            else  // versus computer
            {
                sender.setBackgroundImage(UIImage(named: buttonXStr!),forState:UIControlState.Normal)
                tictac[row!][col!] = "X"  /* make move for 'X' */
        }
        
        if isVersusComp && level_Outlet.selectedSegmentIndex == 2
        {
            if self.checkIfWon("X") == 1  {
                print("X wins\n")
                self.showWin("X")
            }
            else
                if self.winPossible("O") == 1 {
                    print("O WINS\n")
                    self.showWin("O")
                }
                else
                    if self.winPossible("X") == 0 {
                        /* if opponent does not have to be blocked make move */
                        self.computerMove()
            }
        }
        else  if isVersusComp && level_Outlet.selectedSegmentIndex == 0
        {
            if self.checkIfWon("X") == 1  {
                print("X wins\n")
                self.showWin("X")
            }
            else
                if self.checkIfWon("O") == 1 {
                    print("O WINS\n")
                    self.showWin("O")
                }
                else
                {
                    self.computerMove()
                    if self.checkIfWon("O") == 1 {
                        print("O WINS\n")
                        self.showWin("O")
                    }
            }
            
        }
        else  if isVersusComp && level_Outlet.selectedSegmentIndex == 1 //medium diff
        {
            if self.checkIfWon("X") == 1  {
                print("X wins\n")
                self.showWin("X")
            }
            else
                if self.checkIfWon("O") == 1 {
                    print("O WINS\n")
                    self.showWin("O")
                }
                else
                {
                    self.computerMove()
                    if self.checkIfWon("O") == 1 {
                        print("O WINS\n")
                        self.showWin("O")
                    }
            }
            
        }
    }
    
    func isBoardFull() -> Bool
    {
        var isFull = true
        var i = 0
        var j = 0
        
        for(i = 0; i < 3; i++)
        {
            for(j = 0; j < 3; j++)
            {
                if tictac[i][j] == "-"
                {
                    isFull = false
                }
            }
        }
        
        return isFull
    }
    
    @IBAction func versusComputer(sender: AnyObject)
    {
        //reset
        self.initialize()
        
        if sender.isOn!
        {
            isVersusComp = true
        }
        else
        {
            isVersusComp = false
        }
        
    }
    
    @IBAction func levelSelected(sender: AnyObject)
    {
        if level_Outlet.selectedSegmentIndex == 0
        {
            level_Label.text = "Easy"
        }
        else if level_Outlet.selectedSegmentIndex == 1
        {
            level_Label.text = "Medium"
        }
        else
        {
            level_Label.text = "Hard"
        }
        self.initialize()
        
    }
    
    
    func showWin(letterToWin: String)
    {
        if letterToWin == "T"  // Tie
        {
            showUserMessage("Game Over", theMessage: "Cat's Game")
        }
        else
        {
            
            showUserMessage("Game Over", theMessage: "\(letterToWin) wins")
        }
    }
    
    func showUserMessage(title: String, theMessage: String)
    {
        let alert = UIAlertController(title: title, message: theMessage, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {  (action) in self.initialize() })
        
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
}
