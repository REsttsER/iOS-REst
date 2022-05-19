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

class REstViewController: UIViewController {
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
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

private extension REstViewController {
    func configureUI() {
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.right.left.bottom.equalToSuperview()
        }
        
        self.view.addSubview(self.jogButton)
        self.jogButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
        self.view.addSubview(self.runButton)
        self.runButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
    }
}
