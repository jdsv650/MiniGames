//
//  HomeViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var TicTacToe: UIImageView!
    @IBOutlet weak var ConnectFour: UIImageView!
    @IBOutlet weak var PegBoard: UIImageView!
    @IBOutlet weak var EightPuzzle: UIImageView!
    
    var height: CGFloat!
    var width: CGFloat!
    
    var origTicTacToeWidth: CGFloat!
    var origTicTacToeHeight: CGFloat!
    var origConnectWidth: CGFloat!
    var origConnectHeight: CGFloat!
    var origPegWidth: CGFloat!
    var origPegHeight: CGFloat!
    var origEightWidth: CGFloat!
    var origEightHeight: CGFloat!
    

    
    @IBAction func ticTacToePressed(sender: UIButton) {
        
      //  self.performSegueWithIdentifier("TicTacToeSegue", sender: self)
    }
    
    
    @IBAction func connect4Pressed(sender: UIButton) {
        
       // self.performSegueWithIdentifier("ConnectFourSegue", sender: self)
    }
    
    
    @IBAction func pegBoardPressed(sender: UIButton) {
       // self.performSegueWithIdentifier("PegBoardSegue", sender: self)
    }
    
    
    
    @IBAction func eightPuzzlePressed(sender: UIButton) {
        
        // self.performSegueWithIdentifier("EightPuzzleSegue", sender: self)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("TouchesBegan")
        
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInView(self.view)
            //TicTacToe.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition
            var count = 0
            
            if EightPuzzle.layer.presentationLayer()?.hitTest(touchLocation) != nil { count++ }
            
            if PegBoard.layer.presentationLayer()?.hitTest(touchLocation) != nil { count++ }
            
            if ConnectFour.layer.presentationLayer()?.hitTest(touchLocation) != nil { count++ }
            
            if TicTacToe.layer.presentationLayer()?.hitTest(touchLocation) != nil { count++ }
            
            if count > 1 { return } // don't allow overlap
           
            if EightPuzzle.layer.presentationLayer()?.hitTest(touchLocation) != nil
            {
                print("NEW **Eight Puzzle while moving***")
                self.performSegueWithIdentifier("EightPuzzleSegue", sender: self)
                print("layer = \(EightPuzzle.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition)")
                
            }
            
            else if PegBoard.layer.presentationLayer()?.hitTest(touchLocation) != nil
            {
                print("NEW **Peg Board while moving***")
                self.performSegueWithIdentifier("PegBoardSegue", sender: self)
                print("layer = \(PegBoard.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition)")

            }
            
            else if ConnectFour.layer.presentationLayer()?.hitTest(touchLocation) != nil
            {
                print("NEW **Connect 4 while moving***")
                self.performSegueWithIdentifier("ConnectFourSegue", sender: self)
                print("layer = \(ConnectFour.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition)")
                
            }
            
            else if TicTacToe.layer.presentationLayer()?.hitTest(touchLocation) != nil
            {
                print("NEW **HIT TIC TAC while moving***")
                self.performSegueWithIdentifier("TicTacToeSegue", sender: self)
                print("layer = \(TicTacToe.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition)")
                
            }
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: (UIImage (named: "BubblesBackground.png"))!)

        origTicTacToeWidth = self.TicTacToe.frame.size.width
        origTicTacToeHeight = self.TicTacToe.frame.size.height
        
        origPegWidth = self.PegBoard.frame.size.width
        origPegHeight = self.PegBoard.frame.size.height
        
        origEightWidth = self.EightPuzzle.frame.size.width
        origEightHeight = self.EightPuzzle.frame.size.height
        
        origConnectWidth = self.ConnectFour.frame.size.width
        origConnectHeight = self.ConnectFour.frame.size.height
        
        height = self.mainView.frame.height
        width = self.mainView.frame.width
        
        let TicTacLabel = UILabel(frame: CGRectMake(30, 25, 95, 40))
        TicTacLabel.text = "Tic Tac Toe"
        TicTacLabel.textAlignment = NSTextAlignment.Center
        TicTacToe.layer.zPosition = 1
        TicTacToe.addSubview(TicTacLabel)
        
        let EightLabel = UILabel(frame: CGRectMake(25, 35, 95, 40))
        EightLabel.text = "8 Puzzle"
        EightLabel.textAlignment = NSTextAlignment.Center
        EightPuzzle.layer.zPosition = 1
        EightPuzzle.addSubview(EightLabel)
        
        let Connect4Label = UILabel(frame: CGRectMake(40, 30, 95, 40))
        Connect4Label.text = "Connect 4"
        Connect4Label.textAlignment = NSTextAlignment.Center
        ConnectFour.layer.zPosition = 1
        ConnectFour.addSubview(Connect4Label)
        
        let PegLabel = UILabel(frame: CGRectMake(25, 40, 95, 40))
        PegLabel.text = "Peg Board"
        PegLabel.textAlignment = NSTextAlignment.Center
        PegBoard.layer.zPosition = 1
        PegBoard.addSubview(PegLabel)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {

         animateTicTacToe(self.TicTacToe.frame.origin.x, newOriginY: self.TicTacToe.frame.origin.y)
         animatePegBoard(self.PegBoard.frame.origin.x, newOriginY: self.PegBoard.frame.origin.y)
         animateEightPuzzle(self.EightPuzzle.frame.origin.x, newOriginY: self.EightPuzzle.frame.origin.y)
         animateConnectFour(self.ConnectFour.frame.origin.x, newOriginY: self.ConnectFour.frame.origin.y)

    }

    
    func animateTicTacToe(newOriginX: CGFloat, newOriginY: CGFloat)
    {
        /**
        let isAdd = random() % 2
        var newWidth: CGFloat!
        var newHeight: CGFloat!
        
        if isAdd == 1
        {
            newWidth = origTicTacToeWidth + origTicTacToeWidth % 40
            newHeight = origTicTacToeHeight + origTicTacToeHeight % 40
        }
        else
        {
            newWidth = origTicTacToeWidth - origTicTacToeWidth % 40
            newHeight = origTicTacToeHeight - origTicTacToeHeight % 40
        }
***/
        
        let randX = CGFloat(random() % Int(width))
        let randY = CGFloat(random() % Int(height))
        let randTime = Double((random() % 20) + 2)
        
        UIView.animateWithDuration(randTime, delay: 0, options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState ], animations: {
            self.TicTacToe.frame = CGRectMake(randX, randY, self.TicTacToe.frame.size.width, self.TicTacToe.frame.size.height)
            }, completion: { (Bool) in self.animateTicTacToe(randX, newOriginY: randY)
        })
    }
    
    
    func animatePegBoard(newOriginX: CGFloat, newOriginY: CGFloat)
    {
        
        /**
        let isAdd = random() % 2
        var newWidth: CGFloat!
        var newHeight: CGFloat!
        
        if isAdd == 1
        {
            newWidth = origPegWidth + origPegWidth % 40
            newHeight = origPegHeight + origPegHeight % 40
        }
        else
        {
            newWidth = origPegWidth - origPegWidth % 40
            newHeight = origPegHeight - origPegHeight % 40
        }

    **/

        
        let randX = CGFloat(random() % Int(width))
        let randY = CGFloat(random() % Int(height))
        let randTime = Double((random() % 10) + 4)
        
       // let newPegHeight = origPegHeight + CGFloat(random() % 30)
       // let newPegWidth = origPegWidth + CGFloat(random() % 30)
        
        //self.PegBoard.transform = CGAffineTransformIdentity
       // self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //  self.PegBoard.transform = CGAffineTransformMakeScale(self.randomBetween(1.0, secondNum: 2.0), self.randomBetween(1.0, secondNum: 2.0))

        
        UIView.animateWithDuration(randTime, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.PegBoard.frame = CGRectMake(randX, randY, self.PegBoard.frame.size.width, self.PegBoard.frame.size.height)
         //  self.PegBoard.transform = CGAffineTransformMakeTranslation(randX, randY)
            //self.PegBoard.transform = CGAffineTransformIdentity
            //self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion:
                { (Bool) in
                   // self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                   // self.PegBoard.transform = CGAffineTransformIdentity
                    
                    self.animatePegBoard(randX, newOriginY: randY)
                }
        )
    }
    
    func randomBetween(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    func animateEightPuzzle(newOriginX: CGFloat, newOriginY: CGFloat)
    {
        let randX = CGFloat(random() % Int(width))
        let randY = CGFloat(random() % Int(height))
        let randTime = Double((random() % 5) + 10)
        
        UIView.animateWithDuration(randTime, delay: 0, options:  [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: {
            self.EightPuzzle.frame = CGRectMake(randX, randY, self.EightPuzzle.frame.size.width, self.EightPuzzle.frame.size.height)
            }, completion: { (Bool) in self.animateEightPuzzle(randX, newOriginY: randY)
        })
    }
    
    
    func animateConnectFour(newOriginX: CGFloat, newOriginY: CGFloat)
    {
        let randX = CGFloat(random() % Int(width))
        let randY = CGFloat(random() % Int(height))
        let randTime = Double((random() % 5) + 6)
        
        UIView.animateWithDuration(randTime, delay: 0, options:  [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: {
            self.ConnectFour.frame = CGRectMake(randX, randY, self.ConnectFour.frame.size.width, self.ConnectFour.frame.size.height)
            }, completion: { (Bool) in self.animateConnectFour(randX, newOriginY: randY)
        })
    }




}
