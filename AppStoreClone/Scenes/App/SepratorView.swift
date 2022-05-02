//
//  SepratorView.swift
//  AppStoreClone
//
//  Created by ByungHoon Ann on 2022/05/01.
//

import Foundation
import UIKit
import SnapKit

final class SepratorView: UIView {
    private lazy var separator: UIView = {
       let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
