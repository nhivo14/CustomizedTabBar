//
//  CustomTabbar.swift
//  CustomizedTabbar
//
//  Created by Nhi on 6/17/21.
//

import UIKit

public class CustomTabbar: UIView {
    /// Tells the delegate the tab bar item is tapped
    public var itemTapped: ((_ tab: Int) -> Void)?
    /// The color on the tab bar item  when it is selected
    public var selectedColor: CGColor!
    
    private var activeItem: Int = 0
    private var stackView = UIStackView()
    
    let borderLayerName = "Active Border"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [UITabBarItem], frame: CGRect) {
        self.init(frame: frame)
        layer.backgroundColor = UIColor.white.cgColor
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        //Create every single tab bar item
        for index in 0 ..< menuItems.count {
            let itemView = createTabItem(item: menuItems[index])
            stackView.addArrangedSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = index
//            NSLayoutConstraint.activate([
//                itemView.heightAnchor.constraint(equalTo: heightAnchor),
//                itemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offsetX),
//                itemView.topAnchor.constraint(equalTo: topAnchor),
//            ])
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// Create a tab bar item
    /// - Parameter item: UITabBarItem
    /// - Returns: UIView
    public func createTabItem(item: UITabBarItem) -> UIView {
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
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 4),
        ])
        
        // Add tap gesture recognizer to handle tap event
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        guard let view = sender.view else { return }
        switchTab(from: activeItem, to: view.tag)
    }
    
    private func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    public func activateTabAgain() {
        switchTab(from: activeItem, to: activeItem)
    }
    
    public func activateTab(tab: Int) {
        let tabToActivate = stackView.arrangedSubviews[tab]
        let borderWidth = tabToActivate.frame.width
        let borderLayer = CALayer()
        borderLayer.backgroundColor = selectedColor
        borderLayer.name = borderLayerName
        borderLayer.frame = CGRect(x: 0, y: 0, width: borderWidth, height: 2)
        
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
    
    private func deactivateTab(tab: Int) {
        let inactiveTab = stackView.arrangedSubviews[tab]
        let layerToRemove = inactiveTab.layer.sublayers?.filter({ $0.name == borderLayerName })
        
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
