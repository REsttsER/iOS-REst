//
//  TabBarCoordinator.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import UIKit

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}
