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

/**
lỗi coding convention
indentation của code chưa đúng
nên chia extension ra, và có comment cho mỗi extension
 ví dụ:

 // MARK: MyTabbarVCDelegate
 extension ViewController: MyTabbarVCDelegate {
    // code những func của MyTabbarVCDelegate
 }
 
 // MARK: MyTabbarVCDatasource
 extension ViewController: MyTabbarVCDatasource {
    // code những function của MyTabbarVCDatasource
 }
 */
extension ViewController: MyTabbarVCDelegate, MyTabbarVCDatasource {
        func didSelectItemAt(index: Int) {
            
        }
    // lỗi coding convention
    
        func tabBarControllerViewControllers() -> [UIViewController] {
            return [ViewControllerOne(), ViewControllerTwo(), ViewControllerThree(),
                    ViewControllerFour()]    }
    // lỗi coding convention
    
        func tabBarItems() -> [UITabBarItem] {
            return [UITabBarItem.init(title: "One", image: UIImage(systemName: "person"), tag: 0),UITabBarItem.init(title: "Two", image: UIImage(systemName: "pencil.and.outline"), tag: 1), UITabBarItem.init(title: "Three", image: UIImage(systemName: "square.and.arrow.up"), tag: 2), UITabBarItem.init(title: "Four", image: UIImage(systemName: "folder"), tag: 3) ]    }
    // lỗi coding convention
    // nên viết xuống hàng nếu dòng dài quá
    // space giữa các dấu ngoặc ") } ]" chưa đúng
    
        func tabBarBackgroundColor() -> CGColor {
            return UIColor.white.cgColor
        }
    
        func tabBarHeight() -> CGFloat {
        // lỗi coding convenstion
        return 60
        }
    
        func tabBarSelectedColor() -> CGColor {
            return UIColor.red.cgColor
        }
}

