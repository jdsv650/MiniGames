//
//  MainNavigationController.swift
//  MiniGames
//
//  Created by James on 1/17/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, UINavigationControllerDelegate {

    override open var shouldAutorotate: Bool
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.shouldAutorotate
        }
        else
        {
            return true
        }
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.preferredInterfaceOrientationForPresentation
        }
        else
        {
            return .portrait
        }
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.supportedInterfaceOrientations
        }
        else
        {
            return .allButUpsideDown
        }
    }

}

/**
extension UINavigationController
{
    
    override open var shouldAutorotate: Bool
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.shouldAutorotate
        }
        else
        {
            return false
        }
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.preferredInterfaceOrientationForPresentation
        }
        else
        {
            return .portrait
        }
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if let lastVC = self.viewControllers.last
        {
            return lastVC.supportedInterfaceOrientations
        }
        else
        {
            return .allButUpsideDown
        }
    }
 ****/
