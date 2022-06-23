//
//  LocationService.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/10.
//

import Foundation
import CoreLocation
import RxRelay
import RxSwift

protocol LocationService {
    var authorizationStatus: BehaviorRelay<CLAuthorizationStatus> { get set }
    func start()
    func stop()
    func requestAuthorization()
    func observeUpdatedAuthorization() -> Observable<CLAuthorizationStatus>
    func observeUpdatedLocation() -> Observable<[CLLocation]>
}
