//
//  PhotoCell.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import UIKit
import Nuke

class PhotoCell: UICollectionViewCell {

    static let reuseId = "PhotoCell"
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
    }
    
   required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    func configure(urlString: String) {
        Nuke.loadImage(with: URL(string: urlString)!, into: photoImageView)
    }
}


