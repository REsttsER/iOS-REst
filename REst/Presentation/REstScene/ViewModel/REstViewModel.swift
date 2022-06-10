//
//  REstViewModel.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/10.
//

import Foundation
import CoreLocation
import RxRelay
import RxSwift

final class REstViewModel {
    //weak var coordinator: REstCoordinator?
    private let restUseCase: REstUseCase
    
    init(restUseCase: REstUseCase) {
        self.restUseCase = restUseCase
    }
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let startButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        let currentUserLocation = PublishRelay<CLLocationCoordinate2D>()
        let authorizationAlertShouldShow = BehaviorRelay<Bool>(value: false)
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .subscribe({ [weak self] _ in
                self?.restUseCase.checkAuthorization()
                self?.restUseCase.observeUserLocation()
            })
            .disposed(by: disposeBag)
        
        self.restUseCase.authorizationStatus
            .map({ $0 == .disallowed })
            .bind(to: output.authorizationAlertShouldShow)
            .disposed(by: disposeBag)
        
        self.restUseCase.userLocation
            .map({ $0.coordinate })
            .bind(to: output.currentUserLocation)
            .disposed(by: disposeBag)
        
        return output
    }
}
