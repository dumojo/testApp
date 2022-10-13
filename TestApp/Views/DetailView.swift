//
//  DetailView.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//


import UIKit

class DetailView: UIView {
    private let detailPhoto: Gallery?
    
    var imageView = UIImageView()
    private let stackLabels = UIStackView()
    var button = UIButton()
    private let userLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let numOfDownloadsLabel = UILabel()
    var favoritePhoto: Bool = false {
        didSet {
            isFavoritePhoto()
        }
    }
    
    init(frame: CGRect, detailPhoto: Gallery?) {
        self.detailPhoto = detailPhoto
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .systemBackground
        createImageView()
        
        createButtonView()
        createStackLabels()
    }
    
    private func createImageView() {
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width*4/3)
        imageView.contentMode = .scaleAspectFill
        layoutImageView()
        imageView.bringSubviewToFront(button)
    }
    
    private func layoutImageView() {
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    func createStackLabels() {
        self.addSubview(stackLabels)
        createLabels()
        layoutStackLabels()
        setupStackLabels()
    }
    
    private func createLabels() {
        let userString = ("User: \(detailPhoto?.user.name ?? "Unknown")")
        let dateFormatter = ISO8601DateFormatter()
        let isoDate = dateFormatter.date(from:detailPhoto?.created_at ?? "")!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let dateString = ("Create at: \(formatter.string(from: isoDate))")
        let locationString = ("Location: \(detailPhoto?.user.location ?? "Unknown")")
        let numOfDownloadsString = ("Downloads count: \(detailPhoto?.user.total_collections ?? 0)")
        setupLabel(with: userLabel, text: userString)
        setupLabel(with: dateLabel, text: dateString)
        setupLabel(with: locationLabel, text: locationString)
        setupLabel(with: numOfDownloadsLabel, text: numOfDownloadsString)
    }
    
    private func layoutStackLabels() {
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        stackLabels.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        stackLabels.leftAnchor.constraint(equalTo: imageView.leftAnchor,constant: 15).isActive = true
        stackLabels.axis = .vertical
        
    }
    
    private func setupStackLabels() {
        stackLabels.addArrangedSubview(userLabel)
        stackLabels.addArrangedSubview(dateLabel)
        stackLabels.addArrangedSubview(locationLabel)
        stackLabels.addArrangedSubview(numOfDownloadsLabel)
    }
    
    private func setupLabel(with label: UILabel, text: String?) {
        label.text = text
        label.numberOfLines = 0
        label.textColor = .label
    }
    
    private func createButtonView() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.layer.zPosition = 1
        button.setTitleShadowColor(.systemGray5, for: .normal)
        layoutButton()
        isFavoritePhoto()
    }
    
    func isFavoritePhoto() {
        if favoritePhoto {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            button.tintColor = .systemRed
        } else {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.tintColor = .white
        }
    }
    
    private func layoutButton() {
        button.leftAnchor.constraint(equalTo: imageView.leftAnchor,constant: 15).isActive = true
        button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: (-15)).isActive = true
        
    }
}
