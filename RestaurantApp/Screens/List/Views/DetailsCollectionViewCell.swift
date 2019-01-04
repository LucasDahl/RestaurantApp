//
//  DetailsCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 1/4/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    // Properties
    let imageView = UIImageView()
    
    // Override init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // Call the setUp method
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Func setup
    func setUp() {
        
        // Add the imageview to the contentvire
        contentView.addSubview(imageView)
        
        // setup the image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        // Set the constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            ])
        
    }
    
}
