//
//  MyTabbarVC.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/17/21.
//

import UIKit

// framework nên để từ khóa là open để các lớp con khi kế thừa có thể overide được
open class MyTabbarVC: UITabBarController {
    /// The object that acts as the data source of the myTabBar
    public weak var myTabbarVCDatasource: MyTabbarVCDatasource? {
        didSet{
            loadTabBar()
        }
    }
    /// The object that acts as the delegate of the myTabBar
    public weak var myTabbarVCDelegate: MyTabbarVCDelegate?
    
    var customTabBar: CustomTabbar!
    
    let defaultSelection = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Create and load customized tab bar
    func loadTabBar() {
        guard let dataSource = myTabbarVCDatasource else { return }
        let myTBItems: [UITabBarItem] = dataSource.tabBarItems()
        setupCustomTabMenu(myTBItems, dataSource.tabBarControllerViewControllers(), completion: { viewControllers in
            self.viewControllers = viewControllers
        })
        /// Set default selected index for the first item
        selectedIndex = defaultSelection
    }
    
    /// Handle customized tab bar
    /// - Parameters:
    ///   - menuItems: list of UITabBarItem
    ///   - vc: list of UIViewController
    ///   - completion:
    func setupCustomTabMenu(_ menuItems: [UITabBarItem], _ vc: [UIViewController], completion: @escaping ([UIViewController]) -> Void) {
        guard let dataSource = myTabbarVCDatasource else { return }
        let frame = tabBar.bounds
        var controllers = [UIViewController]()
        // Hide default system tab bar
        tabBar.isHidden = true
        // create customized tab bar
        customTabBar = CustomTabbar(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.selectedColor = dataSource.tabBarSelectedColor()
        customTabBar.activateTab(tab: defaultSelection)
        customTabBar.itemTapped = changeTab(tab:)
        view.addSubview(customTabBar)
        // Auto layout for customzied tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: dataSource.tabBarHeight()),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add viewcontrollers
        controllers = vc
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
        myTabbarVCDelegate?.didSelectItemAt(index: tab)
    }
    
    open override func viewDidLayoutSubviews() {
        guard let customTabbar = customTabBar else { return }
        customTabbar.activateTabAgain()
    }
}

