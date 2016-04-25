//
//  TaxiTableController.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class TaxiTableController: UITableViewController, UINavigationControllerDelegate {
    
    // Stores data from previous array
    var taxiArray: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Taxi Services"
        navigationController?.delegate = self
        
        
        do {
            self.taxiArray = try TaxiDataHelper.findByAvailability()
        } catch _{
            print("Error fetching taxi data")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        self.tabBarController?.title = "Taxi Services"
        self.tableView.scrollEnabled = true
    }
    
    // How many sections in the table?
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows in the table?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // The content of the table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("taxicell", forIndexPath: indexPath) as! TaxiTableView
        
        cell.taxiLabel.text = taxiArray[indexPath.row]
        cell.subtitleLabel.text = "Set destination"
        
        
        return cell
        
    }
    
    
}
