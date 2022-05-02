//
//  RankingFeatureSectionView.swift
//  AppStoreClone
//
//  Created by ByungHoon Ann on 2022/05/01.
//

import Foundation
import UIKit
import SnapKit

final class RankingFeatureSectionView: UIView {
    private let cellHeight: CGFloat = 30
    
    var rankingList = [RankingFeature]()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "iPhone이 처음이라면"
        label.textColor = .black
        return label
    }()
    
    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cview.isPagingEnabled = true
        cview.backgroundColor = .systemBackground
        cview.dataSource = self
        cview.delegate = self
        cview.showsHorizontalScrollIndicator = false
        cview.register(RankingFeatureCollectionCell.self, forCellWithReuseIdentifier: "RankingFeatureCollectionCell")
        return cview
    }()
    
    private let seperatorView = SepratorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fecthData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rankingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureCollectionCell", for: indexPath) as? RankingFeatureCollectionCell else { return UICollectionViewCell()
        }
        cell.setup(ranking: rankingList[indexPath.item])
        return cell
    }
}

extension RankingFeatureSectionView: UICollectionViewDelegate {
    
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: RankingFeatureCollectionCell.height)
    }
}

private extension RankingFeatureSectionView {
    func setupView() {
        [
            titleLabel,
            showAllAppsButton,
            collectionView,
            seperatorView
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8)
        }
        
        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(RankingFeatureCollectionCell.height * 3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

private extension RankingFeatureSectionView {
    func fecthData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            rankingList = result
        } catch {
            print(error.localizedDescription)
        }
    }
}
