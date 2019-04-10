//
//  MainCellTableViewCell.swift
//  EcoBike
//
//  Created by Julio Banda on 4/8/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import UIKit

class MainCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bikes: UILabel!
    @IBOutlet weak var slots: UILabel!
    
    @IBOutlet weak var address: UILabel!

    var viewModel: BikesTableViewModel? {
        didSet {
            configure(with: self.viewModel!)
        }
    }
    
    func configure(with viewModel: BikesTableViewModel) {
        self.bikes.text = viewModel.bikes
        self.slots.text = viewModel.slots
        
        self.address.text = viewModel.address
    }

}
