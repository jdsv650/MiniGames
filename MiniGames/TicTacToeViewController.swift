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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BubblesBackground.png")!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SlingshotSegue"
        {
            //let nextVC = segue.destinationViewController as! TicSlingshotViewController
        }
        else
        {
            let nextVC = segue.destination as! TicTacToeGameViewController
        
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

    

}
