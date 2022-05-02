//
//  TabBarController.swift
//  AppStoreClone
//
//  Created by ByungHoon Ann on 2022/04/30.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var todayViewController: TodayViewController = {
        let v = TodayViewController()
        let tabBarItem = UITabBarItem(title: "투대이",
                                  image: UIImage(systemName: "mail"),
                                  tag: 0)
        v.tabBarItem = tabBarItem
        return v
    }()
    
    private lazy var appViewController: UIViewController = {
        let v = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "앱",
                                      image: UIImage(systemName: "square.stack.3d.up"),
                                      tag: 1)
        v.tabBarItem = tabBarItem
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewControllers = [todayViewController, appViewController]
    }


}

