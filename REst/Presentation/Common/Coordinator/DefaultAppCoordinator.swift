//
//  DefaultAppCoordinator.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import UIKit

final class DefaultAppCoordinator: AppCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showTabBarFlow()
    }
    
    func showLoginFlow() {
        
    }
    
    func showTabBarFlow() {
        let tabBarCoordinator = DefaultTabBarCoordinator(self.navigationController)
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
        
        self.navigationController.view.backgroundColor = .systemBackground
        self.navigationController.viewControllers.removeAll()
        
        switch childCoordinator.type {
        case .tab:
            self.showLoginFlow()
        default:
            break
        }
    }
}
