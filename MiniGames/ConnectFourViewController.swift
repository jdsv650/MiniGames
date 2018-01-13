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
    var p1 : Player = Player(colorChosen: Board.Slot.red)
    var p2 : Player = Player(colorChosen: Board.Slot.black)
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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BubblesBackground.png")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resetGame()
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // board tags
        // 11,12,13,14,15,16,17
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        if p1Turn == true
        {
            if theBoard.dropTokenAtSlotWithTagNumber(number: sender.tag, withSlotType: Board.Slot.red)
            {
                sender.setBackgroundImage(UIImage(named: "red.png"), for: UIControlState())
                
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
            if theBoard.dropTokenAtSlotWithTagNumber(number: sender.tag, withSlotType: Board.Slot.black)
            {
                sender.setBackgroundImage(UIImage(named: "black.png"), for: UIControlState())
                
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
    
    
    @IBAction func resetPressed(_ sender: AnyObject) {
        
    }
    
    
    
    func handleWin(_ t:(didWin: Bool, atPositions: [Int], withSlotColor: Board.Slot))
    {
        var player = ""
        
        if  t.withSlotColor == Board.Slot.black
        {
            player = "Player 2"
        }
        else
        {
            player = "Player 1"
        }
        
        let alertVC = UIAlertController(title: "Winner", message: "\(player) wins!", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
            self.resetGame()
        }
        
        alertVC.addAction(action)
        self.present(alertVC, animated: true) { () -> Void in
            
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
        
        loc0_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc0_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc1_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc2_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc3_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc4_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_0.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_1.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_2.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_3.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_4.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_5.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
        loc5_6.setBackgroundImage(UIImage(named: "white.png"), for: UIControlState())
    }
    
}

