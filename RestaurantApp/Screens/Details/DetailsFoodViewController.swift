//
//  DetailsFoodViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {
    
    @IBOutlet weak var detailsFoodView: DetailsFoodView!
    
    var viewModel: DetailsViewModel? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        print(viewModel)
        
        if let viewModel = viewModel {
            
            detailsFoodView.priceLabel?.text = viewModel.price
            detailsFoodView.hoursLabel?.text = viewModel.isOpen
            detailsFoodView.locationLabel?.text = viewModel.phoneNumber
            detailsFoodView.ratingsLabel?.text = viewModel.rating
            
        }
        
    }

   
} // End class
