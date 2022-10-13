//
//  FavoriteTableViewCell.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import UIKit
import Nuke

class FavoriteTableViewCell: UITableViewCell {

    static let reuseId = "Cell"
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    private let userLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    private func configureView() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        layoutPhoto()
        layoutLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutPhoto() {
        contentView.addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    private func layoutLabel() {
       
        contentView.addSubview(userLabel)
        userLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 25).isActive = true
        contentView.addSubview(userLocation)
        userLocation.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10).isActive = true
        userLocation.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 25).isActive = true
        
    }
    
    func configureCell(with photo: FavoritePhoto?) {
        self.userLabel.text = ("\(photo?.name ?? "Unknown")")
        self.userLocation.text = ("\(photo?.location ?? "Unknown")")
        Nuke.loadImage(with: URL(string: photo?.url ?? "")!, into: photoImageView)
    }
}

