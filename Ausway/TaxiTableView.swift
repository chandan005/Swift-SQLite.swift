//
//  TaxiTableView.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
class TaxiTableView: UITableViewCell {
    
    

    @IBOutlet weak var taxiImage: UIImageView!
    
    @IBOutlet weak var taxiLabel: UILabel!


    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated:animated)
    }
}

