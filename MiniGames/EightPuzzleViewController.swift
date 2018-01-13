//
//  EightPuzzleViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class EightPuzzleViewController: UIViewController {

    var theBoard = EightBoard()
    
    @IBOutlet weak var topLeft: UIButton!
    @IBOutlet weak var topMiddle: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var centerLeft: UIButton!
    @IBOutlet weak var centerMiddle: UIButton!
    @IBOutlet weak var centerRight: UIButton!
    @IBOutlet weak var bottomLeft: UIButton!
    @IBOutlet weak var bottomMiddle: UIButton!
    @IBOutlet weak var bottomRight: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BubblesBackground.png")!)
        drawBoard()
    }
    
    
    
    func drawBoard()
    {
        if let topL = theBoard.board["TopLeft"] {
            topLeft.setTitle("\(topL)", for: UIControlState())
            colorTile(topLeft)
        }
        
        if let topM = theBoard.board["TopMiddle"] {
            topMiddle.setTitle("\(topM)", for: UIControlState())
            colorTile(topMiddle)
        }
        
        if let topR = theBoard.board["TopRight"] {
            topRight.setTitle("\(topR)", for: UIControlState())
            colorTile(topRight)
        }
        
        if let centerL = theBoard.board["CenterLeft"] {
            centerLeft.setTitle("\(centerL)", for: UIControlState())
            colorTile(centerLeft)
        }
        
        if let centerM = theBoard.board["CenterMiddle"] {
            centerMiddle.setTitle("\(centerM)", for: UIControlState())
            colorTile(centerMiddle)
        }
        
        if let centerR = theBoard.board["CenterRight"] {
            centerRight.setTitle("\(centerR)", for: UIControlState())
            colorTile(centerRight)
        }
        
        if let bottomL = theBoard.board["BottomLeft"] {
            bottomLeft.setTitle("\(bottomL)", for: UIControlState())
            colorTile(bottomLeft)
        }
        
        if let bottomM = theBoard.board["BottomMiddle"] {
            bottomMiddle.setTitle("\(bottomM)", for: UIControlState())
            colorTile(bottomMiddle)
        }
        
        if let bottomR = theBoard.board["BottomRight"] {
            bottomRight.setTitle("\(bottomR)", for: UIControlState())
            colorTile(bottomRight)
        }
    }
    
    
    func colorTile(_ theButton: UIButton!)
    {
        if theButton.title(for: UIControlState()) == ""
        {
            theButton.backgroundColor = UIColor.white
        }
        else
        {
            theButton.backgroundColor = UIColor(red: 0.98, green: 0.50, blue: 0.01, alpha: 1.0)
                // blue UIColor(red: 0.40, green: 0.80, blue: 1.0, alpha: 1.0)
        }
    }
    
    
    @IBAction func topLeftPressed(_ sender: UIButton)
    {
        if theBoard.board["TopMiddle"] == ""
        {
            theBoard.board["TopMiddle"] = theBoard.board["TopLeft"]
            theBoard.board["TopLeft"] = ""
        }
        
        if theBoard.board["CenterLeft"] == ""
        {
            theBoard.board["CenterLeft"] = theBoard.board["TopLeft"]
            theBoard.board["TopLeft"] = ""
        }
        
        drawBoard()
        
    }
    
    
    @IBAction func topMiddlePressed(_ sender: UIButton) {
        
        if theBoard.board["TopLeft"] == ""
        {
            theBoard.board["TopLeft"] = theBoard.board["TopMiddle"]
            theBoard.board["TopMiddle"] = ""
        }
        
        if theBoard.board["CenterMiddle"] == ""
        {
            theBoard.board["CenterMiddle"] = theBoard.board["TopMiddle"]
            theBoard.board["TopMiddle"] = ""
        }
        
        if theBoard.board["TopRight"] == ""
        {
            theBoard.board["TopRight"] = theBoard.board["TopMiddle"]
            theBoard.board["TopMiddle"] = ""
        }
        
        drawBoard()
        
    }
    
    
    @IBAction func topRightPressed(_ sender: UIButton) {
        
        if theBoard.board["TopMiddle"] == ""
        {
            theBoard.board["TopMiddle"] = theBoard.board["TopRight"]
            theBoard.board["TopRight"] = ""
        }
        
        if theBoard.board["CenterRight"] == ""
        {
            theBoard.board["CenterRight"] = theBoard.board["TopRight"]
            theBoard.board["TopRight"] = ""
        }
        
        drawBoard()
        
    }
    
    
    @IBAction func centerLeftPressed(_ sender: UIButton) {
        
        if theBoard.board["TopLeft"] == ""
        {
            theBoard.board["TopLeft"] = theBoard.board["CenterLeft"]
            theBoard.board["CenterLeft"] = ""
        }
        
        if theBoard.board["CenterMiddle"] == ""
        {
            theBoard.board["CenterMiddle"] = theBoard.board["CenterLeft"]
            theBoard.board["CenterLeft"] = ""
        }
        
        if theBoard.board["BottomLeft"] == ""
        {
            theBoard.board["BottomLeft"] = theBoard.board["CenterLeft"]
            theBoard.board["CenterLeft"] = ""
        }
        
        drawBoard()
        
        
    }
    
    @IBAction func centerMiddlePressed(_ sender: UIButton) {
        
        if theBoard.board["TopMiddle"] == ""
        {
            theBoard.board["TopMiddle"] = theBoard.board["CenterMiddle"]
            theBoard.board["CenterMiddle"] = ""
        }
        
        if theBoard.board["CenterLeft"] == ""
        {
            theBoard.board["CenterLeft"] = theBoard.board["CenterMiddle"]
            theBoard.board["CenterMiddle"] = ""
        }
        
        if theBoard.board["CenterRight"] == ""
        {
            theBoard.board["CenterRight"] = theBoard.board["CenterMiddle"]
            theBoard.board["CenterMiddle"] = ""
        }
        
        if theBoard.board["BottomMiddle"] == ""
        {
            theBoard.board["BottomMiddle"] = theBoard.board["CenterMiddle"]
            theBoard.board["CenterMiddle"] = ""
        }
        
        drawBoard()
        
    }
    
    
    @IBAction func centerRightPressed(_ sender: UIButton) {
        
        if theBoard.board["TopRight"] == ""
        {
            theBoard.board["TopRight"] = theBoard.board["CenterRight"]
            theBoard.board["CenterRight"] = ""
        }
        
        if theBoard.board["CenterMiddle"] == ""
        {
            theBoard.board["CenterMiddle"] = theBoard.board["CenterRight"]
            theBoard.board["CenterRight"] = ""
        }
        
        if theBoard.board["BottomRight"] == ""
        {
            theBoard.board["BottomRight"] = theBoard.board["CenterRight"]
            theBoard.board["CenterRight"] = ""
        }
        
        drawBoard()
        
        
    }
    
    @IBAction func bottomLeftPressed(_ sender: UIButton) {
        
        if theBoard.board["BottomMiddle"] == ""
        {
            theBoard.board["BottomMiddle"] = theBoard.board["BottomLeft"]
            theBoard.board["BottomLeft"] = ""
        }
        
        if theBoard.board["CenterLeft"] == ""
        {
            theBoard.board["CenterLeft"] = theBoard.board["BottomLeft"]
            theBoard.board["BottomLeft"] = ""
        }
        
        drawBoard()
        
    }
    
    @IBAction func bottomMiddlePressed(_ sender: UIButton) {
        
        if theBoard.board["BottomLeft"] == ""
        {
            theBoard.board["BottomLeft"] = theBoard.board["BottomMiddle"]
            theBoard.board["BottomMiddle"] = ""
        }
        
        if theBoard.board["CenterMiddle"] == ""
        {
            theBoard.board["CenterMiddle"] = theBoard.board["BottomMiddle"]
            theBoard.board["BottomMiddle"] = ""
        }
        
        if theBoard.board["BottomRight"] == ""
        {
            theBoard.board["BottomRight"] = theBoard.board["BottomMiddle"]
            theBoard.board["BottomMiddle"] = ""
        }
        
        drawBoard()
        
    }
    
    
    @IBAction func bottomRightPressed(_ sender: UIButton) {
        
        if theBoard.board["BottomMiddle"] == ""
        {
            theBoard.board["BottomMiddle"] = theBoard.board["BottomRight"]
            theBoard.board["BottomRight"] = ""
        }
        
        if theBoard.board["CenterRight"] == ""
        {
            theBoard.board["CenterRight"] = theBoard.board["BottomRight"]
            theBoard.board["BottomRight"] = ""
        }
        
        drawBoard()
        
    }
    
    
    
    @IBAction func shufflePressed(_ sender: UIButton) {
        
        var numbers = [Int]()
        
        // get 9 unique random numbers in range
        while numbers.count < 9
        {
            let randomTileNumber = Int(arc4random_uniform(0)) % 9
            var isFound = false
            
            for num in numbers
            {
                if num == randomTileNumber
                {
                    isFound = true
                }
            }
            
            if !isFound
            {
                numbers.append(randomTileNumber)
            }
        }
        
        // switch 0 to ""
        var numbersAsStrings = [String]()
        for num in numbers
        {
            if num == 0
            {
                numbersAsStrings.append("")
            }
            else
            {
                numbersAsStrings.append("\(num)")
            }
        }
        
        
        theBoard.board["TopLeft"] = "\(numbersAsStrings[0])"
        theBoard.board["TopMiddle"] = "\(numbersAsStrings[1])"
        theBoard.board["TopRight"] = "\(numbersAsStrings[2])"
        theBoard.board["CenterLeft"] = "\(numbersAsStrings[3])"
        theBoard.board["CenterMiddle"] = "\(numbersAsStrings[4])"
        theBoard.board["CenterRight"] = "\(numbersAsStrings[5])"
        theBoard.board["BottomLeft"] = "\(numbersAsStrings[6])"
        theBoard.board["BottomMiddle"] = "\(numbersAsStrings[7])"
        theBoard.board["BottomRight"] = "\(numbersAsStrings[8])"
        
        drawBoard()
        
}

}
