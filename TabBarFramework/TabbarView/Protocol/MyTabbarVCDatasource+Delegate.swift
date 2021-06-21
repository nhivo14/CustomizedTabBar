//
//  MyTabbarVCDatasource+Delegate.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/18/21.
//

import UIKit

public protocol MyTabbarVCDatasource: class {
    func tabBarControllerViewControllers() -> [UIViewController]
    func tabBarItems() -> [UITabBarItem]
    func tabBarBackgroundColor() -> CGColor
    func tabBarHeight() -> CGFloat
    func tabBarSelectedColor() -> CGColor
}

public protocol MyTabbarVCDelegate: class {
    func didSelectItemAt(index: Int)
}
