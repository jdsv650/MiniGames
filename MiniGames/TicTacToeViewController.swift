//
//  TicTacToeViewController.swift
//  MiniGames
//
//  Created by James on 10/25/15.
//  Copyright © 2015 James. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nextVC = segue.destinationViewController as! TicTacToeGameViewController
        
        if segue.identifier == "OnePSegue"
        {
            nextVC.isVersusComp = true
        }
        
        if segue.identifier == "TwoPSegue"
        {
            nextVC.isVersusComp = false
        }
    }

    

}
