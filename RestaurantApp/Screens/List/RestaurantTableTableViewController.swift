//
//  RestaurantTableTableViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class RestaurantTableTableViewController: UITableViewController {
    
    // Properties
    var vieModels = [RestaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vieModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell

        // Create teh viewModel
        let vm = vieModels[indexPath.row]
        
        // Configure the viewModel
        cell.configure(with: vm)

        return cell
    }

}
