//
//  BikesTableViewController.swift
//  EcoBike
//
//  Created by Julio Banda on 4/8/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import UIKit

class BikesTableViewController: UITableViewController {
    
    var viewModels: [BikesTableViewModel]? {
        didSet {
            tableView.insertRows(at: [IndexPath(item: (viewModels!.count - 1) , section: 0)], with: .bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 74
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCellTableViewCell
        
        if let viewModels = viewModels {
            cell.viewModel = viewModels[indexPath.row]
        }
        
        return cell
    }
    
    // MARK - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModels?[indexPath.row] else {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = false
            return
        }
        
        performSegue(withIdentifier: Segues.detail, sender: viewModel)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.detail {
            
            guard let destination = segue.destination as? StationDetailViewController, let viewModel = sender as? BikesTableViewModel else { return }
            destination.viewModel = viewModel
            
        }
    }

}
