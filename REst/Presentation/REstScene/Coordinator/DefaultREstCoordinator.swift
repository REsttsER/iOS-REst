//
//  DefaultREstCoordinator.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import UIKit

final class DefaultREstCoordinator: REstCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var restViewController: REstViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .REst
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.restViewController = REstViewController()
    }
    
    func start() {
        self.restViewController.viewModel = REstViewModel(
            coordinator: self,
            restUseCase: DefaultREstUseCase(locationService: DefaultLocationService())
        )
        self.navigationController.pushViewController(self.restViewController, animated: true)
    }
}

extension DefaultREstCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}

