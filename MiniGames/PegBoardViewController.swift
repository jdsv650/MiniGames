//
//  PegBoardViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class PegBoardViewController: UIViewController {

    @IBOutlet var Holes: [UIButton]!
    
    var pegBoard = PegBoard()
    var isPegSelected = false
    var selectedPegTag = 0
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return  UIInterfaceOrientationMask.LandscapeLeft

    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        drawBoard()
    }
    
    
    func drawBoard()
    {
        for var i=0; i<Holes.count; i++
        {
            Holes[i].setTitle("", forState: UIControlState.Normal)
            let currentHoleStatus = pegBoard.getHoleStatus(Holes[i].tag)
            if currentHoleStatus == PegBoard.Hole.Open
            {
                Holes[i].setBackgroundImage(UIImage(named: "blackCircle.png"), forState: UIControlState.Normal)
            } else if currentHoleStatus == PegBoard.Hole.Filled
            {
                Holes[i].setBackgroundImage(UIImage(named: "tee.png"), forState: UIControlState.Normal)
            }
        }
    }
    
    
    @IBAction func resetPressed(sender: UIButton) {
        
        isPegSelected = false
        pegBoard.resetBoard()
        drawBoard()
    }
    
    
    @IBAction func pegPressed(sender: UIButton) {
        
        let status = pegBoard.getHoleStatus(sender.tag)
        
        // first if we tap same peg deselct it -- don't move this
        if isPegSelected == true && selectedPegTag == sender.tag
        {
            sender.setTitle("", forState: UIControlState.Normal)
            isPegSelected = false
            return
        }
        
        // select a peg not open hole
        if isPegSelected == false && status != PegBoard.Hole.Open
        {
            sender.setTitle("X", forState: UIControlState.Normal)
            
            isPegSelected = true
            selectedPegTag = sender.tag
        }
        
        // try to move to filled hole
        if isPegSelected == true && status == PegBoard.Hole.Filled
        {
            print("Slot not empty")
            isPegSelected = false
            
        }
        
        // try to move to filled hole
        if isPegSelected == true && status == PegBoard.Hole.Open
        {
            print("Open check for valid move")
            if pegBoard.checkForValidDiagonalMove(selectedPegTag, finishTagnumber: sender.tag)
            {
                pegBoard.removePeg(selectedPegTag)
                pegBoard.updateHoleStatus(sender.tag, status: PegBoard.Hole.Filled)
                pegBoard.removeJumpedPeg(selectedPegTag, finishTagnumber: sender.tag)
                isPegSelected = false
                drawBoard()
            }
            else
            {
                print("invalid move")
            }
            
        }
        
        
    }
    
}


