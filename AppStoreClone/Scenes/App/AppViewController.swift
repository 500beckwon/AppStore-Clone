//
//  AppViewController.swift
//  AppStoreClone
//
//  Created by ByungHoon Ann on 2022/05/01.
//

import UIKit
import SnapKit

class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
                let spacingview = UIView()
        spacingview.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        [
        featureSectionView,
         rankingFeatureSectionView,
         exchangeCodeButtonView,
        spacingview
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
    }
}

private extension AppViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "앱"
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
    }
}
