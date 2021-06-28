//
//  MyTabbarVCDatasource+Delegate.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/18/21.
//

import UIKit

public protocol MyTabbarVCDatasource: class {
    /// Returns a list of UIViewController
    func tabBarControllerViewControllers() -> [UIViewController]
    
    /// Returns a list of UITabBarItem (including title, image and tag of every single UITabBarItem)
    func tabBarItems() -> [UITabBarItem]
    
    /// Returns the height of the TabBar
    func tabBarHeight() -> CGFloat
    
    /// Returns the color on the UITabBarItem when it is selected
    func tabBarSelectedColor() -> CGColor
}

public protocol MyTabbarVCDelegate: class {
    /// Tells the delegate the UITabBarItem is selected
    /// - Parameter index: shows the tag of the UITabBarItem
    func didSelectItemAt(index: Int)
}
