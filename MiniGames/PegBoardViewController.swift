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
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var pegBoard = PegBoard()
    var selectedPegTag:Int? = nil
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return  [UIInterfaceOrientationMask.landscapeLeft, UIInterfaceOrientationMask.landscapeRight]
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BubblesBackground.png")!)
        
        // pushing down on load
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        drawBoard()
    }
    
    
    func drawBoard()
    {
        removeAllHighlightButton()
        
        for i in 0 ..< Holes.count
        {
            Holes[i].setTitleColor(UIColor.black, for: UIControl.State.normal)
            Holes[i].setTitle("", for: UIControl.State.normal)
            
            let currentHoleStatus = pegBoard.getHoleStatus(Holes[i].tag)
            if currentHoleStatus == PegBoard.Hole.open
            {
                Holes[i].setBackgroundImage(UIImage(named: "blackCircle.png"), for: UIControl.State.normal)
            } else if currentHoleStatus == PegBoard.Hole.filled
            {
                Holes[i].setBackgroundImage(UIImage(named: "pin2.png"), for: UIControl.State.normal)
            }
        }
    }
    
    @IBAction func resetPegBoardPressed(_ sender: UIBarButtonItem) {
        
        //isPegSelected = false
        selectedPegTag = nil
        pegBoard.resetBoard()
        drawBoard()
    }
    
    func addHighlightButton(theButton :UIButton)
    {
        theButton.layer.borderWidth = 4
        theButton.layer.borderColor = UIColor.green.cgColor
    }
    
    func removeHighlightButton(theButton :UIButton)
    {
        theButton.layer.borderWidth = 4
        theButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    func removeAllHighlightButton()
    {
        for button in Holes
        {
            button.layer.borderWidth = 4
            button.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
    @IBAction func pegPressed(_ sender: UIButton) {
        
        
        let status = pegBoard.getHoleStatus(sender.tag)
        
        if selectedPegTag == nil   // no peg selected
        {
            // check status
            if status == PegBoard.Hole.filled   // mark it
            {
                //sender.setTitle("X", for: UIControlState.normal)
                addHighlightButton(theButton: sender)
                selectedPegTag = sender.tag
            }
            
        }
        else if let theTag = selectedPegTag   // selected peg
        {
            // if same peg deselect it
            
            if theTag == sender.tag  // deselect peg - same peg
            {
                //sender.setTitle("", for: UIControlState.normal)
                removeHighlightButton(theButton: sender)
                selectedPegTag = nil
            }
            else if status == PegBoard.Hole.filled
            {
                print("Slot is full")
                // not sender -- previously selected button
                
                let theButton = self.view.viewWithTag(selectedPegTag!) as? UIButton
                
                if let button = theButton
                {
                   // button.setTitle("", for: UIControlState.normal)
                    removeHighlightButton(theButton: button)
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
                    selectedPegTag = nil
                }
                else
                {
                    let theButton = self.view.viewWithTag(selectedPegTag!) as? UIButton
                    
                    if let button = theButton
                    {
                        //button.setTitle("", for: UIControlState.normal)
                        removeHighlightButton(theButton: button)
                        selectedPegTag = nil
                    }
                    print("invalid move")
                }
            }
            
        }
        
    }
   
}


