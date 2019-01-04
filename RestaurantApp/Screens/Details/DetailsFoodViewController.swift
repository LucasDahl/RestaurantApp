//
//  DetailsFoodViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsFoodViewController: UIViewController {
    
    @IBOutlet weak var detailsFoodView: DetailsFoodView!
    
    var viewModel: DetailsViewModel? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the cell class
        detailsFoodView.collectionView?.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        // Delegates and datasource
        detailsFoodView.collectionView?.delegate = self
        detailsFoodView.collectionView?.dataSource = self
        
    }
    
    func updateView() {
        
        if let viewModel = viewModel {
            
            // Set the labels
            detailsFoodView.priceLabel?.text = viewModel.price
            detailsFoodView.hoursLabel?.text = viewModel.isOpen
            detailsFoodView.locationLabel?.text = viewModel.phoneNumber
            detailsFoodView.ratingsLabel?.text = viewModel.rating
            
            // reload the collectionView
            detailsFoodView.collectionView?.reloadData()
            
        }
        
    }

   
} // End class

//=========================================
// MARK: - Delegates and datasource methods
//=========================================

extension DetailsFoodViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // If no images are avaliable use 0
        return viewModel?.imageUrls.count ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailsCollectionViewCell
        
        // Check if an image was sent rom the api
        if let url = viewModel?.imageUrls[indexPath.item] {
            
            // set the cell's image
            cell.imageView.af_setImage(withURL: url)
            
        }
        
        // Return the cell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
}
