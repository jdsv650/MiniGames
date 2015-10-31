//
//  Player.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class Player
{
    var firstName : String
    var color : Board.Slot
    
    init(colorChosen : Board.Slot)
    {
        firstName = ""
        color = colorChosen
    }
    
}