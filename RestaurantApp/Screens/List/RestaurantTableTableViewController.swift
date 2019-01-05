//
//  RestaurantTableTableViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

protocol  ListActions: class {
    func didTapCell(_ viewController: UIViewController, viewModel: RestaurantListViewModel)
}

class RestaurantTableTableViewController: UITableViewController {
    
    // Properties
    var viewModels = [RestaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    weak var delegate: ListActions?

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell

        // Create teh viewModel
        let vm = viewModels[indexPath.row]
        
        // Configure the viewModel
        cell.configure(with: vm)

        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the details viewController
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") else { return }
        
        // Push the navigation viewController to the stack.
        navigationController?.pushViewController(detailsViewController, animated: true)
        
        // Notify the appDelegate when it is fired
        let vm = viewModels[indexPath.row]
        delegate?.didTapCell(detailsViewController, viewModel: vm)
        
    }

}
