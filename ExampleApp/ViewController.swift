//
//  ViewController.swift
//  ExampleApp
//
//  Created by NhiVHY on 6/21/21.
//

import UIKit
import TabBarFramework

class ViewController: UIViewController {
    let tabbar = MyTabbarVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tabbar.view)
        tabbar.myTabbarVCDatasource = self
        tabbar.myTabbarVCDelegate = self
    }
}

// MARK: MyTabbarVCDatasource
extension ViewController: MyTabbarVCDatasource {
    func tabBarControllerViewControllers() -> [UIViewController] {
        return [ViewControllerOne(),
                ViewControllerTwo(),
                ViewControllerThree(),
                ViewControllerFour()]
    }
    
    func tabBarItems() -> [UITabBarItem] {
        return [UITabBarItem.init(title: "One", image: UIImage(systemName: "person"), tag: 0),
                UITabBarItem.init(title: "Two", image: UIImage(systemName: "pencil.and.outline"), tag: 1),
                UITabBarItem.init(title: "Three", image: UIImage(systemName: "square.and.arrow.up"), tag: 2),
                UITabBarItem.init(title: "Four", image: UIImage(systemName: "folder"), tag: 3)]
    }
    
    func tabBarHeight() -> CGFloat {
        return 100
    }
    
    func tabBarSelectedColor() -> CGColor {
        return UIColor.red.cgColor
    }
}

// MARK: MyTabbarVCDelegate
extension ViewController: MyTabbarVCDelegate {
    func didSelectItemAt(index: Int) {
        
    }
}
