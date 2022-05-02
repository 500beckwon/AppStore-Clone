//
//  FeatureSectionView.swift
//  AppStoreClone
//
//  Created by ByungHoon Ann on 2022/05/01.
//

import Foundation
import UIKit

final class FeatureSectionView: UIView {
    private var featureLust = [Feature]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cview.isPagingEnabled = true
        cview.backgroundColor = .systemBackground
        cview.dataSource = self
        cview.delegate = self
        cview.showsHorizontalScrollIndicator = false
        cview.register(FeatureCollectionCell.self, forCellWithReuseIdentifier: "FeatureCollectionCell")
        return cview
    }()
    
    private let sepratorView = SepratorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        fetchData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featureLust.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionCell", for: indexPath) as? FeatureCollectionCell else { return UICollectionViewCell() }
        cell.setup(feature: featureLust[indexPath.item])
        return cell
    }
    
    
}

extension FeatureSectionView: UICollectionViewDelegate {
    
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
}

private extension FeatureSectionView {
    func setupViews() {
        [
            collectionView, sepratorView
        ].forEach {
            addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(snp.width)
        }
        
        sepratorView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
        }
    }
}

private extension FeatureSectionView {
    func fetchData() {
    guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
    do {
        let data = try Data(contentsOf: url)
        let result = try PropertyListDecoder().decode([Feature].self, from: data)
        self.featureLust = result
    } catch {
        print(error.localizedDescription)
    }
    }
}
