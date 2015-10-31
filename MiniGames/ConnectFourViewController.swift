//
//  ConnectFourViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class ConnectFourViewController: UIViewController
{
    
    var theBoard :Board = Board.shared()
    var p1 : Player = Player(colorChosen: Board.Slot.Red)
    var p2 : Player = Player(colorChosen: Board.Slot.Black)
    var p1Turn : Bool = true
    
    
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    @IBOutlet weak var loc0_0: UIButton!
    @IBOutlet weak var loc0_1: UIButton!
    @IBOutlet weak var loc0_2: UIButton!
    @IBOutlet weak var loc0_3: UIButton!
    @IBOutlet weak var loc0_4: UIButton!
    @IBOutlet weak var loc0_5: UIButton!
    @IBOutlet weak var loc0_6: UIButton!
    @IBOutlet weak var loc1_0: UIButton!
    @IBOutlet weak var loc1_1: UIButton!
    @IBOutlet weak var loc1_2: UIButton!
    @IBOutlet weak var loc1_3: UIButton!
    @IBOutlet weak var loc1_4: UIButton!
    @IBOutlet weak var loc1_5: UIButton!
    @IBOutlet weak var loc1_6: UIButton!
    @IBOutlet weak var loc2_0: UIButton!
    @IBOutlet weak var loc2_1: UIButton!
    @IBOutlet weak var loc2_2: UIButton!
    @IBOutlet weak var loc2_3: UIButton!
    @IBOutlet weak var loc2_4: UIButton!
    @IBOutlet weak var loc2_5: UIButton!
    @IBOutlet weak var loc2_6: UIButton!
    @IBOutlet weak var loc3_0: UIButton!
    @IBOutlet weak var loc3_1: UIButton!
    @IBOutlet weak var loc3_2: UIButton!
    @IBOutlet weak var loc3_3: UIButton!
    @IBOutlet weak var loc3_4: UIButton!
    @IBOutlet weak var loc3_5: UIButton!
    @IBOutlet weak var loc3_6: UIButton!
    @IBOutlet weak var loc4_0: UIButton!
    @IBOutlet weak var loc4_1: UIButton!
    @IBOutlet weak var loc4_2: UIButton!
    @IBOutlet weak var loc4_3: UIButton!
    @IBOutlet weak var loc4_4: UIButton!
    @IBOutlet weak var loc4_5: UIButton!
    @IBOutlet weak var loc4_6: UIButton!
    @IBOutlet weak var loc5_0: UIButton!
    @IBOutlet weak var loc5_1: UIButton!
    @IBOutlet weak var loc5_2: UIButton!
    @IBOutlet weak var loc5_3: UIButton!
    @IBOutlet weak var loc5_4: UIButton!
    @IBOutlet weak var loc5_5: UIButton!
    @IBOutlet weak var loc5_6: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        // board tags
        // 11,12,13,14,15,16,17
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        if p1Turn == true
        {
            if theBoard.dropTokenAtSlotWithTagNumber(number: sender.tag, withSlotType: Board.Slot.Red)
            {
                sender.setBackgroundImage(UIImage(named: "red.png"), forState: UIControlState.Normal)
                
                if theBoard.isFull()
                {
                    self.handelTie()
                }
                
                let results = theBoard.checkWin()
                if results.0 == true
                {
                    handleWin(results)
                    return
                }
                p1Turn = false
                player.text = "Player 2"
                imageView.image = UIImage(named: "black.png")
            }
            
        }
        else  // p2 turn
        {
            if theBoard.dropTokenAtSlotWithTagNumber(number: sender.tag, withSlotType: Board.Slot.Black)
            {
                sender.setBackgroundImage(UIImage(named: "black.png"), forState: UIControlState.Normal)
                
                if theBoard.isFull()
                {
                    self.handelTie()
                }
                
                let results = theBoard.checkWin()
                if results.0 == true
                {
                    handleWin(results)
                    return
                }
                p1Turn = true
                player.text = "Player 1"
                imageView.image = UIImage(named: "red.png")
                
            }
            
        }
        
    }
    
    func handelTie()
    {
        resetGame()
    }
    
    
    func resetGame()
    {
        self.theBoard.clear()
        self.resetBackgroundImages()
        self.player.text = "Player 1"
        self.p1Turn = true
        self.imageView.image = UIImage(named: "red.png")
    }
    
    
    @IBAction func resetPressed(sender: AnyObject) {
        
    }
    
    
    
    func handleWin(t:(didWin: Bool, atPositions: [Int], withSlotColor: Board.Slot))
    {
        var player = ""
        
        if  t.withSlotColor == Board.Slot.Black
        {
            player = "Player 2"
        }
        else
        {
            player = "Player 1"
        }
        
        let alertVC = UIAlertController(title: "Winner", message: "\(player) wins!", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.resetGame()
        }
        
        alertVC.addAction(action)
        self.presentViewController(alertVC, animated: true) { () -> Void in
            
        }
    }
    
    
    
    func resetBackgroundImages()
    {
        // 11,12,13,14,15,16,17
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        loc0_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc0_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc1_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc2_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc3_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc4_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_0.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_1.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_2.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_3.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_4.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_5.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
        loc5_6.setBackgroundImage(UIImage(named: "white.png"), forState: UIControlState.Normal)
    }
    
}

