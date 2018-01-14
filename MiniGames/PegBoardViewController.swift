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
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return  UIInterfaceOrientationMask.landscapeLeft

    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return UIInterfaceOrientation.landscapeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        drawBoard()
    }
    
    
    func drawBoard()
    {
        for i in 0 ..< Holes.count
        {
            Holes[i].setTitle("", for: UIControlState())
            let currentHoleStatus = pegBoard.getHoleStatus(Holes[i].tag)
            if currentHoleStatus == PegBoard.Hole.open
            {
                Holes[i].setBackgroundImage(UIImage(named: "blackCircle.png"), for: UIControlState())
            } else if currentHoleStatus == PegBoard.Hole.filled
            {
                Holes[i].setBackgroundImage(UIImage(named: "tee.png"), for: UIControlState())
            }
        }
    }
    
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        isPegSelected = false
        pegBoard.resetBoard()
        drawBoard()
    }
    
    
    @IBAction func pegPressed(_ sender: UIButton) {
        
        let status = pegBoard.getHoleStatus(sender.tag)
        
        // first if we tap same peg deselct it -- don't move this
        if isPegSelected == true && selectedPegTag == sender.tag
        {
            sender.setTitle("", for: UIControlState())
            isPegSelected = false
            return
        }
        
        // select a peg not open hole
        if isPegSelected == false && status != PegBoard.Hole.open
        {
            sender.setTitle("X", for: UIControlState())
            
            isPegSelected = true
            selectedPegTag = sender.tag
        }
        
        // try to move to filled hole
        if isPegSelected == true && status == PegBoard.Hole.filled
        {
            print("Slot not empty")
            isPegSelected = false
            
        }
        
        // try to move to filled hole
        if isPegSelected == true && status == PegBoard.Hole.open
        {
            print("Open check for valid move")
            if pegBoard.checkForValidDiagonalMove(selectedPegTag, finishTagnumber: sender.tag)
            {
                let _ = pegBoard.removePeg(selectedPegTag)
                let _ = pegBoard.updateHoleStatus(sender.tag, status: PegBoard.Hole.filled)
                let _ = pegBoard.removeJumpedPeg(selectedPegTag, finishTagnumber: sender.tag)
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


