//
//  TabBarPage.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/06/20.
//

import Foundation

enum TabBarPage: String, CaseIterable {
    case REst, active
    
    init?(index: Int) {
        switch index {
        case 0: self = .REst
        case 1: self = .active
        default: return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .REst: return 0
        case .active: return 1
        }
    }
    
    func tabIconName() -> String {
        return self.rawValue
    }
}
