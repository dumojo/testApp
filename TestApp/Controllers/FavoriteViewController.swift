//
//  FavoriteViewController.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UITableViewController {
    
    
    private let heigthForRow: CGFloat = 100
    var favoritePhotos = [FavoritePhoto]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoritePhotos()
        configureView()
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.getFavoritePhotos()
            self.tableView.reloadData()
        }
    }
    private func configureView() {
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
        tableView.backgroundColor = .secondarySystemBackground
    }
    func getFavoritePhotos() {
        let photoFetch: NSFetchRequest<FavoritePhoto> = FavoritePhoto.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(photoFetch)
            favoritePhotos = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}

extension FavoriteViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heigthForRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseId, for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        cell.configureCell(with: favoritePhotos[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(self.favoritePhotos[indexPath.row])
            self.favoritePhotos.remove(at: indexPath.row)
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NetworkManager.shared.getPhoto(id: favoritePhotos[indexPath.row].photoID) { photo, status in
            let detailVC = DetailViewController()
            if status == .success{
                detailVC.detailPhoto = photo
            }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

