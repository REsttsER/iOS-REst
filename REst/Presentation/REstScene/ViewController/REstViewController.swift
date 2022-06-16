//
//  REstViewController.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/18.
//

import CoreLocation
import UIKit
import MapKit

import SnapKit
import RxSwift
import RxCocoa

class REstViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel = REstViewModel(restUseCase: DefaultREstUseCase(locationService: DefaultLocationService()))
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        map.isZoomEnabled = true
        return map
    }()
    
    private lazy var restButton: UIButton = {
        let button = UIButton()
        button.setTitle("휴식", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.alpha = 0.4
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var jogButton: UIButton = {
        let button = UIButton()
        button.setTitle("조깅", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.alpha = 0.4
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        return button
    }()

    private lazy var runButton: UIButton = {
        let button = UIButton()
        button.setTitle("러닝", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.alpha = 0.4
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

private extension REstViewController {
    func configureUI() {
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        self.view.addSubview(self.restButton)
        self.restButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
        self.view.addSubview(self.jogButton)
        self.jogButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
        self.view.addSubview(self.runButton)
        self.runButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(100)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
    }
    
    func bindViewModel() {
        let output = self.viewModel.transform(
            input: REstViewModel.Input(
                viewDidLoadEvent: Observable.just(()).asObservable(),
                startButtonDidTapEvent: self.restButton.rx.tap.asObservable()
            ),
            disposeBag: self.disposeBag)
        
        output.authorizationAlertShouldShow
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] shouldShowAlert in
                if shouldShowAlert { self?.setAuthAlertAction() }
            })
            .disposed(by: disposeBag)
        
        output.currentUserLocation
            .asDriver(onErrorJustReturn: self.mapView.userLocation.coordinate)
            .drive(onNext: { [weak self] userLocation in
                self?.updateCurrentLocation(latitude: userLocation.latitude, longtitue: userLocation.longitude, delta: 0.005)
            })
            .disposed(by: self.disposeBag)
    }
    
    func updateCurrentLocation(latitude: CLLocationDegrees, longtitue: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longtitue)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        self.mapView.setRegion(locationRegion, animated: true)
    }
    
    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(
            title: "위치정보 권한 요청",
            message: "달리기를 기록하기 위해서 위치정보 권한이 필요해요!",
            preferredStyle: .alert)
        
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(
            title: "네 허용하겠습니다",
            style: .default,
            handler: { _ in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
        )
        authAlertController.addAction(getAuthAction)
        self.present(authAlertController, animated: true, completion: nil)
    }
}
