//
//  DefaultActiveCoordinator.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/21.
//

import UIKit

final class DefaultActiveCoordinator: ActiveCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var activeViewController: ActiveListViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .active
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.activeViewController = ActiveListViewController()
    }
    
    func start() {
        self.activeViewController.activeViewModel = ActiveViewModel(
            coordinator: self,
            activeUseCase: DefaultActiveUseCase(activeRepository: DefaultActiveRepository())
        )
        self.navigationController.pushViewController(self.activeViewController, animated: true)
    }
}

extension DefaultActiveCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators
            .filter { $0.type != childCoordinator.type }
    }
}
