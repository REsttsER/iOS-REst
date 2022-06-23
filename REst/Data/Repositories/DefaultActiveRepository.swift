//
//  DefaultActiveRepository.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/22.
//

import Foundation
import RxSwift

final class DefaultActiveRepository: ActiveRepository {
    var disposeBag: DisposeBag = DisposeBag()
    
    func fetchActiveList() -> Observable<[Active]> {
        return Observable.create() { emitter in
            let restActives:[Active] = [
                Active(i: 1, date: Date()),
                Active(i: 2, date: Date())
            ]
            emitter.onNext(restActives)
            return Disposables.create()
        }
    }
}
