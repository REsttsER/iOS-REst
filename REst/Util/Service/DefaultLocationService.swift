//
//  DefaultLocationService.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/13.
//

import Foundation
import CoreLocation
import RxRelay
import RxSwift

final class DefaultLocationService: NSObject, LocationService {
    var locationManager: CLLocationManager?
    var disposeBag: DisposeBag = DisposeBag()
    var authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.distanceFilter = CLLocationDistance(3)
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    func start() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stop() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func requestAuthorization() {
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func observeUpdatedAuthorization() -> Observable<CLAuthorizationStatus> {
        return self.authorizationStatus.asObservable()
    }
    
    func observeUpdatedLocation() -> Observable<[CLLocation]> {
        return PublishRelay<[CLLocation]>.create({emitter in
            self.rx.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
                .compactMap({ $0.last as? [CLLocation] })
                .subscribe(onNext: { location in
                    emitter.onNext(location)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
}

extension DefaultLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus.accept(status)
    }
}
