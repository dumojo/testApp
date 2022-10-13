//
//  FeedViewController.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//


import UIKit

class FeedViewController: UIViewController {
    
    private var photos = [Gallery]()
    private var page = 1
    private var search = false
    private var searchText = ""
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = PhotoCollectionView()
    }

    private func view() -> PhotoCollectionView {
       return self.view as! PhotoCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NetworkManager.shared.getPhotos(page: 1) { model, status in
            if status == .success{
                self.photos = model ?? []
            }
            DispatchQueue.main.async {
                self.view().collectionView.reloadData()
            }
        }
    }
    
    private func configureView() {
        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == photos.count - 1 {
            page += 1
            if search{
                NetworkManager.shared.searchPhotos(query: searchText, page: page) { model, status in
                    
                    if status == .success{
                        for photo in model!.results{
                            self.photos.append(photo)
                        }
                        DispatchQueue.main.async {
                            self.view().collectionView.reloadData()
                        }
                    }
                }
            }else{
                NetworkManager.shared.getPhotos(page: page) { model, status in
                    if status == .success{
                        for photo in model!{
                            self.photos.append(photo)
                        }
                        DispatchQueue.main.async {
                            self.view().collectionView.reloadData()
                        }
                    }
                }
            }
        }
        let photoURLString = photos[indexPath.row].urls.small
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(urlString: photoURLString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailPhoto = photos[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view().frame.width / 3), height: (view().frame.width / 3))
    }

}

extension FeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search = true
        page = 1
        searchText = searchBar.text ?? ""
        NetworkManager.shared.searchPhotos(query: searchBar.text ?? "", page: 1) { model, status in
            
            if status == .success{
                self.photos = model?.results ?? []
                self.view().startingLabels.isHidden = true
            }
            DispatchQueue.main.async {
                self.view().collectionView.reloadData()
            }
        }
     }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        search = false
        NetworkManager.shared.getPhotos(page: 1) { model, status in
            if status == .success{
                self.photos = model ?? []
            }
            DispatchQueue.main.async {
                self.view().collectionView.reloadData()
            }
        }
    }
}



