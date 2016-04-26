//
//  DataHelper.swift
//  Ausway
//
//  Created by Chandan Singh on 19/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SQLite

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item: T) throws -> Int64
    static func delete(item: T) throws -> Void
    static func findAll() throws -> [T]?
}

protocol TaxiDataHelperProtocol {
    associatedtype P
    static func findAll() throws -> [P]?
    static func findByAvailability() throws -> [String]?
}

protocol SkybusDataHelperProtocol {
    associatedtype S
    static func findAll() throws -> [String]?
}


class DomesticDataHelper: DataHelperProtocol{
    static let TABLE_NAME = "Domestic"
    
    static let table = Table(TABLE_NAME)
    static let domestic_id = Expression<Int64>("domestic_id")
    static let timestamp = Expression<String>("timestamp")
    
    typealias T = Domestic
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(domestic_id, primaryKey: true)
                t.column(timestamp)
                })
            
        } catch _ {
            // Error throw if table already exists
        }
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.timestamp != nil) {
            let insert = table.insert(timestamp <- item.timestamp!)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.domestic_id {
            let query = table.filter(domestic_id == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(domestic_id == id)
        
        let items = try DB.prepare(query)
        for item in  items {
            return Domestic(domestic_id: item[domestic_id] , timestamp: item[timestamp])
        }
        
        
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Domestic(domestic_id: item[domestic_id], timestamp: item[timestamp]))
        }
        
        return retArray
        
    }
    
}

class InternationalDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "International"
    
    static let table = Table(TABLE_NAME)
    static let international_id = Expression<Int64>("international_id")
    static let timestamp = Expression<String>("timestamp")
    
    typealias T = International
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(international_id, primaryKey: true)
                t.column(timestamp)
                })
            
        } catch _ {
            // Error throw if table already exists
        }
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.timestamp != nil) {
            let insert = table.insert(timestamp <- item.timestamp!)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.international_id {
            let query = table.filter(international_id == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(international_id == id)
        
        let items = try DB.prepare(query)
        for item in  items {
            return International(international_id: item[international_id] , timestamp: item[timestamp])
        }
        
        
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(International(international_id: item[international_id], timestamp: item[timestamp]))
        }
        
        return retArray
    }
    
}

class TaxiDataHelper: TaxiDataHelperProtocol {
    static let TABLE_NAME = "Taxi"
    
    static let table = Table(TABLE_NAME)
    static let taxi_id = Expression<Int64>("taxi_id")
    static let taxi_number = Expression<String>("taxi_number")
    static let taxi_available = Expression<String>("taxi_available")
    
    typealias P = Taxi
    
    static func findAll() throws -> [P]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var taxiArray = [P]()
        let items = try DB.prepare(table)
        for item in items {
            taxiArray.append(Taxi(taxi_id: item[taxi_id], taxi_number: item[taxi_number], taxi_available: item[taxi_available]))
        }
        return taxiArray
    }
    
    static func findByAvailability() throws -> [String]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var taxiArray = [String]()
        let query = table.select(taxi_number).filter(taxi_available == "1")
        
        let items = try DB.prepare(query)
        
        for item in items {
            taxiArray.append(item.get(taxi_number))
        }
        
        return taxiArray
    }
}

class Terminal1DataHelper: SkybusDataHelperProtocol {
    static let TABLE_NAME = "T1_Skybus"
    
    
    static let table = Table(TABLE_NAME)
    static let t1_skybus_id = Expression<Int64>("t1_skybus_id")
    static let t1_skybus_time = Expression<String>("t1_skybus_time")
    
    typealias S = T1_Skybus
    
    static func findAll() throws -> [String]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var t1Array = [String]()
        let query = table.select(t1_skybus_time)
        let items = try DB.prepare(query)
        for item in items {
            t1Array.append(item.get(t1_skybus_time))
        }
        return t1Array
    }
    
    
    static func returnDate() throws -> [String]?{
        let currentDate = NSDate()
        var arr = [String]()
        do {
            arr = try findAll()!
        } catch _ {
            
        }
        
        var strings = [String]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        var dates = [NSDate]()
        for are in arr {
            var some = dateFormatter.stringFromDate(NSDate())
            print(some)
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: are)
            let newDate = dateFormatter.dateFromString(some)
            let order = NSCalendar.currentCalendar().compareDate(currentDate, toDate: newDate!, toUnitGranularity: .Minute)
            switch order {
            case .OrderedAscending:
                dates.append(newDate!)
            default:
                break
            }
        }
        for time in dates {
            dateFormatter.dateFormat = "HH:mm"
            let strFromDates = dateFormatter.stringFromDate(time)
            strings.append(strFromDates)
        }
        
        return strings
    }
    
    
   
}


class Terminal3DataHelper: SkybusDataHelperProtocol {
    static let TABLE_NAME = "T3_Skybus"
    
    static let table = Table(TABLE_NAME)
    static let t3_skybus_id = Expression<Int64>("t3_skybus_id")
    static let t3_skybus_time = Expression<String>("t3_skybus_time")
    
    typealias S = T3_Skybus
    
    static func findAll() throws -> [String]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var t3Array = [String]()
        let query = table.select(t3_skybus_time)
        let items = try DB.prepare(query)
        for item in items {
            t3Array.append(item.get(t3_skybus_time))
        }
        return t3Array
    }
    
    
    static func returnDate() throws -> [String]?{
        let currentDate = NSDate()
        var arr = [String]()
        do {
            arr = try findAll()!
        } catch _ {
            
        }
        
        var strings = [String]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        var dates = [NSDate]()
        for are in arr {
            var some = dateFormatter.stringFromDate(NSDate())
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: are)
            let newDate = dateFormatter.dateFromString(some)
            let order = NSCalendar.currentCalendar().compareDate(currentDate, toDate: newDate!, toUnitGranularity: .Minute)
            switch order {
            case .OrderedAscending:
                dates.append(newDate!)
            default:
                break
            }
        }
        for ass in dates {
            dateFormatter.dateFormat = "HH:mm"
            let somes = dateFormatter.stringFromDate(ass)
            strings.append(somes)
        }
        
        return strings
    }
    

}


class Terminal4DataHelper: SkybusDataHelperProtocol {
    static let TABLE_NAME = "T4_Skybus"
    
    static let table = Table(TABLE_NAME)
    static let t4_skybus_id = Expression<Int64>("t4_skybus_id")
    static let t4_skybus_time = Expression<String>("t4_skybus_time")
    
    typealias S = T4_Skybus
    
    static func findAll() throws -> [String]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var t4Array = [String]()
        let query = table.select(t4_skybus_time)
        let items = try DB.prepare(query)
        for item in items {
            t4Array.append(item.get(t4_skybus_time))
        }
        return t4Array
    }
    
    
    static func returnDate() throws -> [String]?{
        let currentDate = NSDate()
        var arr = [String]()
        do {
            arr = try findAll()!
        } catch _ {
            
        }
        
        var strings = [String]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        var dates = [NSDate]()
        for are in arr {
            var some = dateFormatter.stringFromDate(NSDate())
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: are)
            let newDate = dateFormatter.dateFromString(some)
            let order = NSCalendar.currentCalendar().compareDate(currentDate, toDate: newDate!, toUnitGranularity: .Minute)
            switch order {
            case .OrderedAscending:
                dates.append(newDate!)
            default:
                break
            }
        }
        for ass in dates {
            dateFormatter.dateFormat = "HH:mm"
            let somes = dateFormatter.stringFromDate(ass)
            strings.append(somes)
        }
        
        return strings
    }
    
   
}



