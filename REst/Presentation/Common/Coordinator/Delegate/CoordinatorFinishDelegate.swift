//
//  CoordinatorFinishDelegate.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import UIKit

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
