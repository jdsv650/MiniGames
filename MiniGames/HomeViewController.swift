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
    

    @IBAction func ticTacToePressed(_ sender: UIButton) {
        
      //  self.performSegueWithIdentifier("TicTacToeSegue", sender: self)
    }
    
    
    @IBAction func connect4Pressed(_ sender: UIButton) {
        
       // self.performSegueWithIdentifier("ConnectFourSegue", sender: self)
    }
    
    
    @IBAction func pegBoardPressed(_ sender: UIButton) {
       // self.performSegueWithIdentifier("PegBoardSegue", sender: self)
    }
    
    
    
    @IBAction func eightPuzzlePressed(_ sender: UIButton) {
        
        // self.performSegueWithIdentifier("EightPuzzleSegue", sender: self)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesBegan")
        
        for touch: AnyObject in touches {
            
            let touchLocation = touch.location(in: self.view)
            //TicTacToe.layer.presentationLayer()!.hitTest(touchLocation)?.zPosition
            var count = 0
            
            if EightPuzzle.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if PegBoard.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if ConnectFour.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if TicTacToe.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if count > 1 { return } // don't allow overlap
           
            if EightPuzzle.layer.presentation()?.hitTest(touchLocation) != nil
            {
                print("NEW **Eight Puzzle while moving***")
                self.performSegue(withIdentifier: "EightPuzzleSegue", sender: self)
              //  print("layer = \(String(describing: EightPuzzle.layer.presentation()!.hitTest(touchLocation)?.zPosition))")
                
            }
            
            else if PegBoard.layer.presentation()?.hitTest(touchLocation) != nil
            {
                print("NEW **Peg Board while moving***")
                self.performSegue(withIdentifier: "PegBoardSegue", sender: self)
              //  print("layer = \(PegBoard.layer.presentation()!.hitTest(touchLocation)?.zPosition)")

            }
            
            else if ConnectFour.layer.presentation()?.hitTest(touchLocation) != nil
            {
                print("NEW **Connect 4 while moving***")
                self.performSegue(withIdentifier: "ConnectFourSegue", sender: self)
             //   print("layer = \(ConnectFour.layer.presentation()!.hitTest(touchLocation)?.zPosition)")
                
            }
            
            else if TicTacToe.layer.presentation()?.hitTest(touchLocation) != nil
            {
                print("NEW **HIT TIC TAC while moving***")
                self.performSegue(withIdentifier: "TicTacToeSegue", sender: self)
               // print("layer = \(TicTacToe.layer.presentation()!.hitTest(touchLocation)?.zPosition)")
                
            }
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let TicTacLabel = UILabel(frame: CGRect(x: 30, y: 25, width: 95, height: 40))
        TicTacLabel.text = "Tic Tac Toe"
        TicTacLabel.textAlignment = NSTextAlignment.center
        TicTacLabel.textColor = .black
        TicTacToe.layer.zPosition = 1
        TicTacToe.addSubview(TicTacLabel)
        
        let EightLabel = UILabel(frame: CGRect(x: 25, y: 35, width: 95, height: 40))
        EightLabel.text = "8 Puzzle"
        EightLabel.textAlignment = NSTextAlignment.center
        EightLabel.textColor = .black
        EightPuzzle.layer.zPosition = 1
        EightPuzzle.addSubview(EightLabel)
        
        let Connect4Label = UILabel(frame: CGRect(x: 40, y: 30, width: 95, height: 40))
        Connect4Label.text = "Connect 4"
        Connect4Label.textAlignment = NSTextAlignment.center
        Connect4Label.textColor = .black
        ConnectFour.layer.zPosition = 1
        ConnectFour.addSubview(Connect4Label)
        
        let PegLabel = UILabel(frame: CGRect(x: 25, y: 40, width: 95, height: 40))
        PegLabel.text = "Peg Board"
        PegLabel.textAlignment = NSTextAlignment.center
        PegLabel.textColor = .black
        PegBoard.layer.zPosition = 1
        PegBoard.addSubview(PegLabel)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {

         animateTicTacToe(self.TicTacToe.frame.origin.x, newOriginY: self.TicTacToe.frame.origin.y)
         animatePegBoard(self.PegBoard.frame.origin.x, newOriginY: self.PegBoard.frame.origin.y)
         animateEightPuzzle(self.EightPuzzle.frame.origin.x, newOriginY: self.EightPuzzle.frame.origin.y)
         animateConnectFour(self.ConnectFour.frame.origin.x, newOriginY: self.ConnectFour.frame.origin.y)

    }

    
    func animateTicTacToe(_ newOriginX: CGFloat, newOriginY: CGFloat)
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
        
        let randX = CGFloat(Int(arc4random_uniform(UInt32(width))))
        let randY = CGFloat(Int(arc4random_uniform(UInt32(height))))
        let randTime = Double((Int(arc4random_uniform(20))) + 2)
        
        UIView.animate(withDuration: randTime, delay: 0, options: [UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.beginFromCurrentState ], animations: {
            self.TicTacToe.frame = CGRect(x: randX, y: randY, width: self.TicTacToe.frame.size.width, height: self.TicTacToe.frame.size.height)
            }, completion: { (Bool) in self.animateTicTacToe(randX, newOriginY: randY)
        })
    }
    
    
    func animatePegBoard(_ newOriginX: CGFloat, newOriginY: CGFloat)
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

        
        let randX = CGFloat(Int(arc4random_uniform(UInt32(width))))
        let randY = CGFloat(Int(arc4random_uniform(UInt32(height))))
        let randTime = Double((Int(arc4random_uniform(10))) + 4)
        
       // let newPegHeight = origPegHeight + CGFloat(random() % 30)
       // let newPegWidth = origPegWidth + CGFloat(random() % 30)
        
        //self.PegBoard.transform = CGAffineTransformIdentity
       // self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //  self.PegBoard.transform = CGAffineTransformMakeScale(self.randomBetween(1.0, secondNum: 2.0), self.randomBetween(1.0, secondNum: 2.0))

        
        UIView.animate(withDuration: randTime, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.PegBoard.frame = CGRect(x: randX, y: randY, width: self.PegBoard.frame.size.width, height: self.PegBoard.frame.size.height)
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
    
    func randomBetween(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    func animateEightPuzzle(_ newOriginX: CGFloat, newOriginY: CGFloat)
    {
        let randX = CGFloat(Int(arc4random_uniform(UInt32(width))))
        let randY = CGFloat(Int(arc4random_uniform(UInt32(height))))
        let randTime = Double((Int(arc4random_uniform(5))) + 10)
        
        UIView.animate(withDuration: randTime, delay: 0, options:  [UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.beginFromCurrentState], animations: {
            self.EightPuzzle.frame = CGRect(x: randX, y: randY, width: self.EightPuzzle.frame.size.width, height: self.EightPuzzle.frame.size.height)
            }, completion: { (Bool) in self.animateEightPuzzle(randX, newOriginY: randY)
        })
    }
    
    
    func animateConnectFour(_ newOriginX: CGFloat, newOriginY: CGFloat)
    {
        let randX = CGFloat(Int(arc4random_uniform(UInt32(width))))
        let randY = CGFloat(Int(arc4random_uniform(UInt32(height))))
        let randTime = Double((Int(arc4random_uniform(5))) + 6)
        
        UIView.animate(withDuration: randTime, delay: 0, options:  [UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.beginFromCurrentState], animations: {
            self.ConnectFour.frame = CGRect(x: randX, y: randY, width: self.ConnectFour.frame.size.width, height: self.ConnectFour.frame.size.height)
            }, completion: { (Bool) in self.animateConnectFour(randX, newOriginY: randY)
        })
    }




}
