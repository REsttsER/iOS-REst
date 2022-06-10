//
//  REstUseCase.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/10.
//

import Foundation
import CoreLocation
import RxSwift

protocol REstUseCase {
    var authorizationStatus: BehaviorSubject<LocationAuthorizationStatus?> { get set }
    var userLocation: PublishSubject<CLLocation> { get set }
    init(locationService: LocationService)
    func checkAuthorization()
    func observeUserLocation()
    func stopUpdatingLocation()    
}
