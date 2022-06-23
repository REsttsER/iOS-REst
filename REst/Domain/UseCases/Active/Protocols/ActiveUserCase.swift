//
//  ActiveUserCase.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/22.
//

import Foundation
import RxSwift

protocol ActiveUseCase {
    typealias ActiveList = [Active]
    var activeList: PublishSubject<ActiveList> { get set }
    var didLoadActive: PublishSubject<Bool> { get set }
    func fetchActiveList()
}
