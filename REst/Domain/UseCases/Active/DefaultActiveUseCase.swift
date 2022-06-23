
//
//  DefaultActiveUseCase.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/22.
//

import Foundation
import RxRelay
import RxSwift

final class DefaultActiveUseCase: ActiveUseCase {
    private let activeRepository: ActiveRepository
    private let disposeBag = DisposeBag()
    var activeList: PublishSubject<ActiveList> = PublishSubject()
    var didLoadActive: PublishSubject<Bool> = PublishSubject()
    
    
    init(activeRepository: ActiveRepository) {
        self.activeRepository = activeRepository
    }
    
    func fetchActiveList() {
        self.activeRepository.fetchActiveList()
            .subscribe(onNext: { [weak self] active in
                self?.activeList.onNext(active)
            })
            .disposed(by: disposeBag)
    }    
}
