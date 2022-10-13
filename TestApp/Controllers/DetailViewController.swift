//
//  DetailViewController.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import UIKit
import CoreData
import Nuke

class DetailViewController: UIViewController {
    
    var detailPhoto: Gallery?
    var favoritePhotos = [FavoritePhoto]()
    
    init() {
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func view() -> DetailView {
       return self.view as! DetailView
    }

    override func loadView() {
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getFavoritePhotos()
        print(detailPhoto)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoritePhotos()
        isFavoritePhoto()
        view().isFavoritePhoto()
    }
    
    private func configureView() {
        let view = DetailView(frame: .zero, detailPhoto: detailPhoto)
        view.button.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
        self.view = view
    }
    
    private func configure() {
        isFavoritePhoto()
        setupImage()
    }
    
    private func setupImage() {
        Nuke.loadImage(with: URL(string: detailPhoto?.urls.small ?? "")!, into: view().imageView)
        
    }
    
    @objc func addPhotoButtonClicked(sender: UIButton!) {
        if view().favoritePhoto{
            configureAlert(title: "Done", message: "Removed for favorite")
            for favoritePhoto in favoritePhotos {
                if favoritePhoto.photoID == detailPhoto?.id{
                    if let index = favoritePhotos.firstIndex(of: favoritePhoto) {
                        
                        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(self.favoritePhotos[index])
                        favoritePhotos.remove(at: index)
                        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
                        view().favoritePhoto = false
                        getFavoritePhotos()
                    }
                }
            }
        }else{
            save(id: detailPhoto?.id ?? "", url: detailPhoto?.urls.small ?? "", name: detailPhoto?.user.name ?? "", location: detailPhoto?.user.location ?? "")
            configureAlert(title: "Success", message: "Add to favorite")
            view().favoritePhoto = true
            getFavoritePhotos()
        }
    }
    
    private func configureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func isFavoritePhoto() {
        guard let photo = detailPhoto else {return}
        view().favoritePhoto = false
        for favoritePhoto in favoritePhotos {
            if favoritePhoto.photoID == photo.id {
                view().favoritePhoto = true
            }
        }
    }
    func save(id: String, url: String, name: String, location: String) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let favoritePhoto = FavoritePhoto(context: managedContext)
      
        favoritePhoto.setValue(id, forKey: #keyPath(FavoritePhoto.photoID))
        favoritePhoto.setValue(url, forKey: #keyPath(FavoritePhoto.url))
        favoritePhoto.setValue(name, forKey: #keyPath(FavoritePhoto.name))
        favoritePhoto.setValue(location, forKey: #keyPath(FavoritePhoto.location))
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
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



