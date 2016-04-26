//
//  SkybusTableController.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class SkybusTableController: UITableViewController, UINavigationControllerDelegate {
    
    // Stores data from previous array
    /*var timeTableArray: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Skybus Services"
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        self.tabBarController?.title = "Skybus Services"
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tables", forIndexPath: indexPath) as! SkybusTableView
        
        cell.mainLabel?.text = timeTableArray[indexPath.row]
        cell.subtitleLabel.text = "Express to Souther Cross Station in 20 Mins"
        //cell.textLabel?.text = timeTableArray[indexPath.row]
        //cell.detailTextLabel?.text = "Express service to Southern Cross Station"
        
        return cell
        
    }
    
    // Removes all the data from array upon clicking back button
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? PopOverController {
            //controller.arr.removeAll()
            controller.passengerType.selectedSegmentIndex = -1
            controller.t1t2t3.selectedSegmentIndex = -1
        }
    }*/
    
}
