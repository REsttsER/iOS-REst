//
//  DefaultREstUseCase.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/10.
//

import Foundation
import CoreLocation
import RxSwift

final class DefaultREstUserCase: REstUseCase {
    var authorizationStatus = BehaviorSubject<LocationAuthorizationStatus?>(value: nil)
    var userLocation = PublishSubject<CLLocation>()
    private let locationService: LocationService
    private let disposeBag = DisposeBag()
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    func checkAuthorization() {
        self.locationService.observeUpdatedAuthorization()
            .subscribe(onNext: { [weak self] status in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    self?.authorizationStatus.onNext(.allowed)
                    self?.locationService.start()
                case .notDetermined:
                    self?.authorizationStatus.onNext(.notDetermined)
                    self?.locationService.requestAuthorization()
                case .denied, .restricted:
                    self?.authorizationStatus.onNext(.disallowed)
                @unknown default:
                    self?.authorizationStatus.onNext(nil)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func observeUserLocation() {
        return self.locationService.observeUpdatedLocation()
            .compactMap({ $0.last })
            .subscribe(onNext: { [weak self] location in
                self?.userLocation.onNext(location)
            })
            .disposed(by: self.disposeBag)
    }
    
    func stopUpdatingLocation() {
        self.locationService.stop()
    }
}
