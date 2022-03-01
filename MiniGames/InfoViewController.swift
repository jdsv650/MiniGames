//
//  InfoViewController.swift
//  MiniGames
//
//  Created by James on 1/15/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit
import StoreKit

class InfoViewController: UIViewController, SKStoreProductViewControllerDelegate {


    @IBOutlet var mainView: UIView!
    @IBOutlet weak var RateIV: UIImageView!
    @IBOutlet weak var ShareIV: UIImageView!

    var height: CGFloat!
    var width: CGFloat!
    
    @objc var storeVC: SKStoreProductViewController!
    
    var origRateWidth: CGFloat!
    var origRateHeight: CGFloat!
    var origShareWidth: CGFloat!
    var origShareHeight: CGFloat!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesBegan")
        
        for touch: AnyObject in touches {
            
            let touchLocation = touch.location(in: self.view)

            var count = 0
            
            if RateIV.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if ShareIV.layer.presentation()?.hitTest(touchLocation) != nil { count += 1 }
            
            if count > 1 { return } // don't allow overlap
            
            if RateIV.layer.presentation()?.hitTest(touchLocation) != nil
            {
                ratePressed()
            }
                
            else if ShareIV.layer.presentation()?.hitTest(touchLocation) != nil
            {
                sharePressed()
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: (UIImage (named: "BubblesBackground.png"))!)
        
        origRateWidth = self.RateIV.frame.size.width
        origRateHeight = self.RateIV.frame.size.height
        
        origShareWidth = self.ShareIV.frame.size.width
        origShareHeight = self.ShareIV.frame.size.height
        
        height = self.mainView.frame.height
        width = self.mainView.frame.width
        
        let rateLabel = UILabel(frame: CGRect(x: 30, y: 25, width: 95, height: 40))
        rateLabel.text = "Rate App"
        rateLabel.textAlignment = NSTextAlignment.center
        RateIV.layer.zPosition = 1
        RateIV.addSubview(rateLabel)
        
        let shareLabel = UILabel(frame: CGRect(x: 25, y: 35, width: 95, height: 40))
        shareLabel.text = "Share App"
        shareLabel.textAlignment = NSTextAlignment.center
        ShareIV.layer.zPosition = 1
        ShareIV.addSubview(shareLabel)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        animateRate(self.RateIV.frame.origin.x, newOriginY: self.RateIV.frame.origin.y)
        animateShare(self.ShareIV.frame.origin.x, newOriginY: self.ShareIV.frame.origin.y)
    }
    
    
    func animateRate(_ newOriginX: CGFloat, newOriginY: CGFloat)
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
            self.RateIV.frame = CGRect(x: randX, y: randY, width: self.RateIV.frame.size.width, height: self.RateIV.frame.size.height)
        }, completion: { (Bool) in self.animateRate(randX, newOriginY: randY)
        })
    }
    
    
    func animateShare(_ newOriginX: CGFloat, newOriginY: CGFloat)
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
            self.ShareIV.frame = CGRect(x: randX, y: randY, width: self.ShareIV.frame.size.width, height: self.ShareIV.frame.size.height)
            //  self.PegBoard.transform = CGAffineTransformMakeTranslation(randX, randY)
            //self.PegBoard.transform = CGAffineTransformIdentity
            //self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion:
            { (Bool) in
                // self.PegBoard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                // self.PegBoard.transform = CGAffineTransformIdentity
                
                self.animateShare(randX, newOriginY: randY)
        }
        )
    }
    
    func randomBetween(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func sharePressed()
    {

        let theMessage = "Try the Mini Games iOS app."
        
        let theURL = NSURL(string: "https://itunes.apple.com/us/app/mini-game-pack/id1059197278?mt=8")
        
        let itemsToShare :[Any] = [theMessage, theURL!]
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.print]
        
        self.present(activityVC, animated: true, completion: nil)

    }
    
    func ratePressed()
    {
        storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        
        let productParams = [ SKStoreProductParameterITunesItemIdentifier : "627908713" ]   // id for all my apps
        
        storeVC.loadProduct(withParameters: productParams) { (result, error) in
            
            if result == true
            {
                self.present(self.storeVC, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "App info not found", message: "Please try again later", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
