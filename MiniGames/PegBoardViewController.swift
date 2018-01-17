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
    //var isPegSelected = false
    var selectedPegTag:Int? = nil
    
    
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
            Holes[i].setTitleColor(UIColor.black, for: UIControlState.normal)
            
            Holes[i].setTitle("", for: UIControlState.normal)
            let currentHoleStatus = pegBoard.getHoleStatus(Holes[i].tag)
            if currentHoleStatus == PegBoard.Hole.open
            {
                Holes[i].setBackgroundImage(UIImage(named: "blackCircle.png"), for: UIControlState.normal)
            } else if currentHoleStatus == PegBoard.Hole.filled
            {
                Holes[i].setBackgroundImage(UIImage(named: "tee.png"), for: UIControlState.normal)
            }
        }
    }
    
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        //isPegSelected = false
        selectedPegTag = nil
        pegBoard.resetBoard()
        drawBoard()
    }
    
    @IBAction func pegPressed(_ sender: UIButton) {
        
        
        let status = pegBoard.getHoleStatus(sender.tag)
        
        if selectedPegTag == nil   // no peg selected
        {
            // check status
            if status == PegBoard.Hole.filled   // mark it
            {
                sender.setTitle("X", for: UIControlState.normal)
                selectedPegTag = sender.tag
            }
            
        }
        else if let theTag = selectedPegTag   // selected peg
        {
            // if same peg deselect it
            
            if theTag == sender.tag  // deselect peg - same peg
            {
                sender.setTitle("", for: UIControlState.normal)
                selectedPegTag = nil
            }
            else if status == PegBoard.Hole.filled
            {
                print("Slot is full")
                // not sender -- previously selected button
                
                let theButton = self.view.viewWithTag(selectedPegTag!) as? UIButton
                
                if let button = theButton
                {
                    button.setTitle("", for: UIControlState.normal)
                    selectedPegTag = nil
                }
            }
            else if status == PegBoard.Hole.open  // check for valid move
            {
                print("Open check for valid move")
                if pegBoard.checkForValidDiagonalMove(selectedPegTag!, finishTagnumber: sender.tag)
                {
                    let _ = pegBoard.removePeg(selectedPegTag!)
                    let _ = pegBoard.updateHoleStatus(sender.tag, status: PegBoard.Hole.filled)
                    let _ = pegBoard.removeJumpedPeg(selectedPegTag!, finishTagnumber: sender.tag)
                    drawBoard()
                }
                else
                {
                    let theButton = self.view.viewWithTag(selectedPegTag!) as? UIButton
                    
                    if let button = theButton
                    {
                        button.setTitle("", for: UIControlState.normal)
                        selectedPegTag = nil
                    }
                    print("invalid move")
                }
            }
            
        }
        
    }
    
    func getArrayIndexForSelectedTagNum() -> Int?
    {
        //  04,
        //13, 15,
        //22, 24, 26
        // 31, 33, 35, 37
        // 40, 42, 44, 46, 48
        
        if let sel = selectedPegTag
        {
            switch sel {
            case 4:
                return 0
            case 13:
                return 1
            case 15:
                return 2
            case 22:
                return 3
            case 24:
                return 4
            case 26:
                return 5
            case 31:
                return 6
            case 33:
                return 7
            case 35:
                return 8
            case 37:
                return 9
                
            case 40:
                return 10
            case 42:
                return 11
            case 44:
                return 12
            case 46:
                return 13
            case 48:
                return 14
            default:
                return nil
            }
        }
        
       return nil
    }
    
}


