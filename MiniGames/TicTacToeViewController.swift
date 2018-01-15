//
//  TicTacToeViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var TicTacToeSingle: UIImageView!
    @IBOutlet weak var TicTacToeTwo: UIImageView!
    @IBOutlet weak var TicTacToeTwoSlingshot: UIImageView!
    
    var height: CGFloat!
    var width: CGFloat!
    
    var origSingleTicTacToeWidth: CGFloat!
    var origSingleTicTacToeHeight: CGFloat!
    var origTwoTicTacToeWidth: CGFloat!
    var origTwoTicTacToeHeight: CGFloat!
    var origTwoSlingshotTicTacToeWidth: CGFloat!
    var origTwoSlingshotTicTacToeHeight: CGFloat!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesBegan")
        
        for touch: AnyObject in touches {
            
            let touchLocation = touch.location(in: self.view)
            var count = 0
            
            if TicTacToeSingle.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if TicTacToeTwo.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if TicTacToeTwoSlingshot.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if count > 1 { return } // don't allow overlap
            
            if TicTacToeSingle.layer.presentation()?.hitTest(touchLocation) != nil
            {
                self.performSegue(withIdentifier: "TXOSegue", sender: self)
            }
                
            else if TicTacToeTwo.layer.presentation()?.hitTest(touchLocation) != nil
            {
                self.performSegue(withIdentifier: "TXOTwoSegue", sender: self)
                
            }
                
            else if TicTacToeTwoSlingshot.layer.presentation()?.hitTest(touchLocation) != nil
            {
                self.performSegue(withIdentifier: "TXOSlingshotSegue", sender: self)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: (UIImage (named: "BubblesBackground.png"))!)
        
        origSingleTicTacToeWidth = self.TicTacToeSingle.frame.size.width
        origSingleTicTacToeHeight = self.TicTacToeSingle.frame.size.height
        
        origTwoTicTacToeWidth = self.TicTacToeTwo.frame.size.width
        origTwoTicTacToeHeight = self.TicTacToeTwo.frame.size.height
        
        origTwoSlingshotTicTacToeWidth = self.TicTacToeTwoSlingshot.frame.size.width
        origTwoSlingshotTicTacToeHeight = self.TicTacToeTwoSlingshot.frame.size.height
        
        height = self.mainView.frame.height
        width = self.mainView.frame.width
        
        let TicTacLabel = UILabel(frame: CGRect(x: 30, y: 25, width: 95, height: 40))
        TicTacLabel.text = "1 Player"
        TicTacLabel.textAlignment = NSTextAlignment.center
        TicTacToeSingle.layer.zPosition = 1
        TicTacToeSingle.addSubview(TicTacLabel)
        
        let TicTacTwo = UILabel(frame: CGRect(x: 25, y: 35, width: 95, height: 40))
        TicTacTwo.text = "2 Player"
        TicTacTwo.textAlignment = NSTextAlignment.center
        TicTacTwo.layer.zPosition = 1
        TicTacToeTwo.addSubview(TicTacTwo)
        
        let Slingshot2Label = UILabel(frame: CGRect(x: 40, y: 30, width: 120, height: 40))
        Slingshot2Label.text = "2P Slingshot"
        Slingshot2Label.textAlignment = NSTextAlignment.center
        Slingshot2Label.layer.zPosition = 1
        TicTacToeTwoSlingshot.addSubview(Slingshot2Label)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        animateTicTacToeSingle(self.TicTacToeSingle.frame.origin.x, newOriginY: self.TicTacToeSingle.frame.origin.y)
        animateTicTacToeTwo(self.TicTacToeTwo.frame.origin.x, newOriginY: self.TicTacToeTwo.frame.origin.y)
        animateTicTacToeTwoSlingshot(self.TicTacToeTwoSlingshot.frame.origin.x, newOriginY: self.TicTacToeTwoSlingshot.frame.origin.y)
    }
    
    
    func animateTicTacToeSingle(_ newOriginX: CGFloat, newOriginY: CGFloat)
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
        
        UIView.animate(withDuration: randTime, delay: 0, options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.beginFromCurrentState ], animations: {
            self.TicTacToeSingle.frame = CGRect(x: randX, y: randY, width: self.TicTacToeSingle.frame.size.width, height: self.TicTacToeSingle.frame.size.height)
        }, completion: { (Bool) in self.animateTicTacToeSingle(randX, newOriginY: randY)
        })
    }
    
    
    func animateTicTacToeTwo(_ newOriginX: CGFloat, newOriginY: CGFloat)
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
        
        
        UIView.animate(withDuration: randTime, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.TicTacToeTwo.frame = CGRect(x: randX, y: randY, width: self.TicTacToeTwo.frame.size.width, height: self.TicTacToeTwo.frame.size.height)
            //  self.PegBoard.transform = CGAffineTransformMakeTranslation(randX, randY)
            //self.PegBoard.transform = CGAffineTransformIdentity
            //self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion:
            { (Bool) in
                // self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                // self.PegBoard.transform = CGAffineTransformIdentity
                
                self.animateTicTacToeTwo(randX, newOriginY: randY)
        }
        )
    }
    
    func randomBetween(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    func animateTicTacToeTwoSlingshot(_ newOriginX: CGFloat, newOriginY: CGFloat)
    {
        let randX = CGFloat(Int(arc4random_uniform(UInt32(width))))
        let randY = CGFloat(Int(arc4random_uniform(UInt32(height))))
        let randTime = Double((Int(arc4random_uniform(5))) + 10)
        
        UIView.animate(withDuration: randTime, delay: 0, options:  [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.beginFromCurrentState], animations: {
            self.TicTacToeTwoSlingshot.frame = CGRect(x: randX, y: randY, width: self.TicTacToeTwoSlingshot.frame.size.width, height: self.TicTacToeTwoSlingshot.frame.size.height)
        }, completion: { (Bool) in self.animateTicTacToeTwoSlingshot(randX, newOriginY: randY)
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TXOSegue"
        {
            let nextVC = segue.destination as! TicTacToeGameViewController
            nextVC.isVersusComp = true
        }
        else if segue.identifier == "TXOTwoSegue"
        {
            let nextVC = segue.destination as! TicTacToeGameViewController
            nextVC.isVersusComp = false
        }
    }

}
