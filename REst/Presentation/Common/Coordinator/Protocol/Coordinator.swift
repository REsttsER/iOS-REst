//
//  Coordinator.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/10.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set}
    var type: CoordinatorType { get }
    func start()
    func finish()
    func findCoordinator(type: CoordinatorType) -> Coordinator?
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func findCoordinator(type: CoordinatorType) -> Coordinator? {
        var stack: [Coordinator] = [self]
        
        while !stack.isEmpty {
            let currentCoordinator = stack.removeLast()
            if currentCoordinator.type == type {
                return currentCoordinator
            }
            currentCoordinator.childCoordinators.forEach({ child in
                stack.append(child)
            })
        }
        return nil
    }
}
