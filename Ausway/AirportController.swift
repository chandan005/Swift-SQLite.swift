//
//  ViewController.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class AirportController: UIViewController {
    
    // Mark: Properties
    
    
    
    @IBOutlet var passengerButtons: [UIButton]!
    
    var senders = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the color of navigation bar
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        //Set the text color of the navigation bar title
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        // Set the color of other items of navigation bar
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        //Set the corner radius of the buttons
        passengerButtons[0].layer.cornerRadius = 5
        passengerButtons[1].layer.cornerRadius = 5
        passengerButtons[2].layer.cornerRadius = 5
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        self.tabBarController?.title = "Where are you?"
    }
    
    // Mark: Actions
    
    // Show Popover Controller when button clicked
    @IBAction func justArrivedAction(sender: AnyObject) {
        self.senders.tag = 1
       performSegueWithIdentifier("popover", sender: sender)
    }

     // Show Popover Controller when button clicked
    @IBAction func gettingLuggageAction(sender: AnyObject) {
        self.senders.tag = 2
        performSegueWithIdentifier("popover", sender: self)
    }

     // Show Popover Controller when button clicked
    @IBAction func readyToGoAction(sender: AnyObject) {
        self.senders.tag = 3
        performSegueWithIdentifier("popover", sender: self)
    }
    
    // Set the title of back button to "Back" by performing segue and sending data
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let popView = segue.destinationViewController as! PopOverController
        popView.senders = senders
    }
    
    
    
    
}



