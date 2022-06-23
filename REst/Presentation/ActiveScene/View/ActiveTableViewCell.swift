//
//  ActiveTableViewCell.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/21.
//

import UIKit
import RxSwift
import SnapKit

class ActiveTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    lazy var activeDateLabel: UILabel = {
        let label = UILabel()
        label.text = "년월일"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    func updateUI(date: String) {
        self.activeDateLabel.text = date
    }
}

private extension ActiveTableViewCell {
    func configureUI() {
        contentView.addSubview(self.activeDateLabel)
        self.activeDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)            
        }
    }
}
