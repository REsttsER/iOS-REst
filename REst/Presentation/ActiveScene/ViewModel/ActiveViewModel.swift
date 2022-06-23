//
//  ActiveViewModel.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import Foundation
import RxSwift
import RxRelay

final class ActiveViewModel {
    private let activeUseCase: ActiveUseCase
    weak var coordinator: ActiveCoordinator?
    var activeList: [Active]?
    private(set) var initialLoad = true
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
        var didLoadData = PublishRelay<Bool>()
    }
    
    init(coordinator: ActiveCoordinator, activeUseCase: ActiveUseCase) {
        self.coordinator = coordinator
        self.activeUseCase = activeUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.viewWillAppearEvent
            .subscribe(onNext: { [weak self] in
                self?.activeUseCase.fetchActiveList()
            })
            .disposed(by: disposeBag)
        
        self.activeUseCase.activeList
            .subscribe(onNext: { [weak self] active in
                self?.activeList = active
            })
            .disposed(by: disposeBag)
        
        self.activeUseCase.didLoadActive
            .filter { $0 }
            .subscribe(onNext: { _ in
                output.didLoadData.accept(true)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
