//
//  SQLiteDatabase.swift
//  Ausway
//
//  Created by Chandan Singh on 16/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: ErrorType {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

class SQLiteDataStore {
    
    // Creates only one instance of throughout the application
    static let sharedInstance = SQLiteDataStore()
    let BBDB: Connection?

    
    private init() {
        var path = "primary.sqlite3"
        
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.stringByAppendingPathComponent("primary.sqlite3")
            print(path)
        }
        
        
        do {
            BBDB = try Connection(path)
        } catch _ {
            BBDB = nil
        }
        
    }
    
    func createTables() throws {
        do {
            try DomesticDataHelper.createTable()
            try InternationalDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
    }
    
}

extension String {
    func stringByAppendingPathComponent(pathComponent: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(pathComponent)
    }
}




