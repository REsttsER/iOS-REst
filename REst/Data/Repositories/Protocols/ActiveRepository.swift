//
//  ActiveRepository.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/22.
//

import Foundation
import RxSwift

protocol ActiveRepository {
    func fetchActiveList() -> Observable<[Active]>
}
