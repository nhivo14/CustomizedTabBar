//
//  MyTabbarVCDatasource+Delegate.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/18/21.
//

import UIKit

// Vì khi đóng gói thành framework, ở ngoài nhìn vào chỉ thấy được protocol
// Nên viết comment code cho từng function protocol, để phân biệt
public protocol MyTabbarVCDatasource: class {
    /// Ví dụ: func này làm gì đó
    /// Return: màng gì đó để làm gì đó
    func tabBarControllerViewControllers() -> [UIViewController]
    func tabBarItems() -> [UITabBarItem]
    func tabBarBackgroundColor() -> CGColor
    func tabBarHeight() -> CGFloat
    func tabBarSelectedColor() -> CGColor
}

public protocol MyTabbarVCDelegate: class {
    /// Ví dụ: function này để làm gì đó
    /// - Parameter index: param này truyền vào để làm gì đó, ý nghĩa như thế nào
    func didSelectItemAt(index: Int)
}
