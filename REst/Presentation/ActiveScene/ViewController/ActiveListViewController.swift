//
//  ActiveViewController.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import UIKit
import RxSwift
import SnapKit

enum ActiveTableViewValue: CGFloat {
    case tableViewCellHeight = 80
    
    func value() -> CGFloat {
        return self.rawValue
    }
}

final class ActiveListViewController: UIViewController {
    var activeViewModel: ActiveViewModel?
    private let disposeBag = DisposeBag()
    
    lazy var activeTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(ActiveTableViewCell.self, forCellReuseIdentifier: ActiveTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ActiveListViewController {
    func configureUI() {
        self.view.addSubview(self.activeTableView)
        self.activeTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let input = ActiveViewModel.Input(
            viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }
        )
        
        let output = self.activeViewModel?.transform(from: input, disposeBag: self.disposeBag)
        
        output?.didLoadData
            .asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .drive(onNext: { [weak self] _ in
                self?.activeTableView.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
}

extension ActiveListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ActiveTableViewValue.tableViewCellHeight.value()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.checkAtiveCount()
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActiveTableViewCell.identifier,
            for: indexPath) as? ActiveTableViewCell else { return UITableViewCell() }
        return cell
    }
}
