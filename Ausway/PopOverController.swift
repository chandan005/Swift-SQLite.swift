//
//  PopOverController.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import SQLite

class PopOverController: UIViewController {
    
    // Mark: Properties
    
    // Path for the database with name and type
    let path = NSBundle.mainBundle().pathForResource("mainDB", ofType: "db")
    // Defining constant for "T1" Table
    let terminal1 = Table("T1")
    // Constant for "T2" table
    let terminal2 = Table("T2")
    // Constant for "T3" table
    let terminal3 = Table("T3")
    // constant for table columns
    let id = Expression<Int64>("skybus_id")
    let timetable = Expression<String?>("skybus_timetable")
    // stores query
    var query: QueryType!
    // stores query data
    var arr = [String]()
    
    var time = [String]()
    
    var senders: UIButton!
    
    

    // Outlet for done button
    @IBOutlet weak var done: UIButton!
    
    // Outlet for terminal segment buttons
    @IBOutlet weak var t1t2t3: UISegmentedControl!
    
    @IBOutlet weak var passengerType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preferences"
        done.layer.borderColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
        done.layer.borderWidth = 1
        done.layer.cornerRadius = 5
        
        // Database
        let dataStore = SQLiteDataStore.sharedInstance
        do {
            try dataStore.createTables()
            passengerSelected(nil)
            setTaxi()
        } catch _ {}
        
        
        
    }
    
    
    
    //Mark: Actions
    
    // Show data based on the selected segment
    @IBAction func terminalChanged(sender: UISegmentedControl) {
        switch t1t2t3.selectedSegmentIndex {
        case 0:
            do {
                try self.arr = Terminal1DataHelper.returnDate()!
            } catch _ {}
            switch self.senders.tag {
            case 1:
                self.arr.removeFirst(4)
            case 2:
                self.arr.removeFirst(2)
            case 3:
                self.arr.removeFirst(1)
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            performSegueWithIdentifier("scheduledservice", sender: self)
      
        case 1:
            do {
                try self.arr = Terminal3DataHelper.returnDate()!
            } catch _ {}
            switch self.senders.tag {
            case 1:
                self.arr.removeFirst(4)
            case 2:
                self.arr.removeFirst(2)
            case 3:
                self.arr.removeFirst(1)
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            performSegueWithIdentifier("scheduledservice", sender: self)
      
        case 2:
            do {
                try self.arr = Terminal4DataHelper.returnDate()!
            } catch _ {}
            switch self.senders.tag {
            case 1:
                self.arr.removeFirst(4)
            case 2:
                self.arr.removeFirst(2)
            case 3:
                self.arr.removeFirst(1)
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            performSegueWithIdentifier("scheduledservice", sender: self)
           
        default:
            break
        }
    }
    
    
    
    @IBAction func doneAction(sender: AnyObject) {
        //var dateInString = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
       
        
    }
    
    // Passes data to next controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let barViewControllers = segue.destinationViewController as! UITabBarController
        //let nav = barViewControllers.viewControllers![0] as! UINavigationController
        //let destinationViewController = nav.viewControllers[1] as! TimeTableViewController
        let destinationViewController = barViewControllers.viewControllers![0] as! TimeTableViewController
        destinationViewController.timeTableArray = arr
        destinationViewController.departureMins = time
    }
    
    func setTaxi(){
        do {
            _ = try TaxiDataHelper.findByAvailability()
        } catch _{
            
        }
    }
    
    
    
    @IBAction func passengerSelected(sender: UISegmentedControl? = nil) {
        switch passengerType.selectedSegmentIndex {
        case 0:
            do {
                _ = try DomesticDataHelper.insert(
                    Domestic(
                        domestic_id: 0,
                        timestamp: NSDate().stringFromDate()
                        
                    ))
            } catch _{
                print("Error Writing to Database")
            }
            
        case 1:
            do {
                _ = try InternationalDataHelper.insert(
                    International(
                        international_id: 0,
                        timestamp: NSDate().stringFromDate()
                        
                    ))
            } catch _ {
                print("Error Writing to Database")
            }
            
        default:
            break
        }
    }
    

    
    // Creates DB
    /*func createDB(){
        if t1t2t3.titleForSegmentAtIndex(t1t2t3.selectedSegmentIndex) == "Terminal 1"{
            self.query = self.terminal1.select(timetable)
            performQuery(query)
        }
        else if t1t2t3.titleForSegmentAtIndex(t1t2t3.selectedSegmentIndex) == "Terminal 2"{
            self.query = self.terminal2.select(timetable)
            performQuery(query)
        
        }
        else if t1t2t3.titleForSegmentAtIndex(t1t2t3.selectedSegmentIndex) == "Terminal 3" {
            self.query = self.terminal3.select(timetable)
            performQuery(query)
        
        }
    }

    // Query to return data
    func performQuery(query: QueryType) {
        do {
            let db = try Connection(self.path!, readonly: true)
            do {
                for data in try db.prepare(query){
                    self.arr.append(data.get(timetable)!)
                }
            } catch {
                print("Error Fetching data")
            }
        } catch {
            print("Error Connecting to database")
        }
    }
    
    func returnDate(arr: [String]){
        let currentDate = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        //var pls = [NSDate]()
        for are in arr {
            var some = dateFormatter.stringFromDate(NSDate())
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: are)
            let newDate = dateFormatter.dateFromString(some)
            let order = NSCalendar.currentCalendar().compareDate(currentDate, toDate: newDate!, toUnitGranularity: .Minute)
            switch order {
            case .OrderedAscending:
                self.dates.append(newDate!)
            default:
                break
            }
        }
        for ass in self.dates {
            dateFormatter.dateFormat = "HH:mm"
            let somes = dateFormatter.stringFromDate(ass)
            self.arr.append(somes)
        }
        
    }*/
}

// Extension to convert dates to string and vice versa
extension NSDate{
    func dateFromString(date: String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.locale = NSLocale.currentLocale()
        let dates = formatter.dateFromString(date)
        return dates!
    }
    
    func stringFromDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.locale = NSLocale.currentLocale()
        let dateString = formatter.stringFromDate(self)
        return dateString
    }
    
    func timeInterval(dates: [String]) -> [String] {
        var intes = [String]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        for date in dates {
            var some = dateFormatter.stringFromDate(NSDate())
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: date)
            
            let newDates = dateFormatter.dateFromString(some)
            let current = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let dateComponents = calendar.components([.Hour, .Minute],fromDate: current, toDate: newDates!, options: [])
            let hour = dateComponents.hour
            let minutes = dateComponents.minute
            
            let hh = String(hour)
            let mm = String(minutes)
            
            if hh == "0" {
                let toAppend = mm + " mins"
                intes.append(toAppend)
            } else {
                let toAppend = hh + " hour" + " " + mm + " mins"
                intes.append(toAppend)
            }
            
            
            
        }
        return intes
        
    }
}

// Extension to remove elements from array
extension Array where Element: Equatable{
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}


