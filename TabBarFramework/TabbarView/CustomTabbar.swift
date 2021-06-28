//
//  CustomTabbar.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/17/21.
//

import UIKit

class CustomTabbar: UIView {
    // khi viết framwork, đối với những biến public nên có comment để biết biết đó dùng như thế nào,
    // tương tự với function cũng vậy
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    var selectedColor: CGColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [UITabBarItem], frame: CGRect) {
        self.init(frame: frame)
        layer.backgroundColor = UIColor.white.cgColor
        // Create every single tab bar item
        for index in 0 ..< menuItems.count {
            let itemWidth = frame.width / CGFloat(menuItems.count)
            let offsetX = itemWidth * CGFloat(index)
            
            let itemView = createTabItem(item: menuItems[index])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = index
            addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offsetX),
                itemView.topAnchor.constraint(equalTo: topAnchor),
            ])
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// Create a tab bar item
    /// - Parameter item: UITabBarItem
    /// - Returns: UIView
    func createTabItem(item: UITabBarItem) -> UIView {
        let tabBarItem = UIView()
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        let itemTitleLabel = UILabel()
        itemTitleLabel.text = item.title
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        
        let itemImageView = UIImageView()
        itemImageView.image = item.image
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.addSubview(itemImageView)
        
        // Auto layout for item
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 25),
            itemImageView.widthAnchor.constraint(equalToConstant: 25),
            itemImageView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemImageView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: 35),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 4),
        ])
        
        // Add tap gesture recognizer to handle tap event
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        // không nên force unwrap các biến optional, mà nên dùng if let hoặc guard let
        switchTab(from: activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        let tabToActivate = subviews[tab]
        let borderWidth = tabToActivate.frame.width - 20
        let borderLayer = CALayer()
        borderLayer.backgroundColor = selectedColor
        // với những name kiểu này nên define ra constant
        // và nên có 1 chỗ để lưu những constant đó
        // -> sửa tương tự cho các class khác
        borderLayer.name = "Active Border"
        borderLayer.frame = CGRect(x: 10, y: 0, width: borderWidth, height: 2)
        
        // nếu được thì cho ở ngoài có thể chỉnh sửa ui trạng thái active/ deactive của tabbar càng tốt
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.curveEaseIn, .allowUserInteraction]) {
                tabToActivate.layer.addSublayer(borderLayer)
                tabToActivate.setNeedsLayout()
                tabToActivate.layoutIfNeeded()
            } completion: { _ in
                self.itemTapped?(tab)
                self.activeItem = tab
            }
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func deactivateTab(tab: Int) {
        let inactiveTab = subviews[tab]
        let layerToRemove = inactiveTab.layer.sublayers?.filter({ $0.name == "Active Border" })
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction]) {
                layerToRemove?.forEach({ $0.removeFromSuperlayer() })
                inactiveTab.setNeedsLayout()
                inactiveTab.layoutIfNeeded()
            } completion: { _ in
                
            }
        }
    }
}
