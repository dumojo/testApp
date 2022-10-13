//
//  PhotoCollectionView.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//


import UIKit

class PhotoCollectionView: UIView {
    
    let collectionFlowLayout: UICollectionViewFlowLayout
    let collectionView: UICollectionView
    let startingLabels = UILabel()
    
    override init(frame: CGRect) {
        collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionFlowLayout)
        super.init(frame: frame)
        setupCollectionView()
        setupStartingLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStartingLabels() {
        startingLabels.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startingLabels)
        startingLabels.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startingLabels.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.minimumInteritemSpacing = 0
        layoutCollectionView()
    }
    private func layoutCollectionView() {
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
