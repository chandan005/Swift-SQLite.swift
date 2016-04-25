//
//  PassengerDataModel.swift
//  Ausway
//
//  Created by Chandan Singh on 19/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation


typealias Domestic = (
    domestic_id: Int64?,
    timestamp: String?
)

typealias International = (
    international_id: Int64?,
    timestamp: String?
)

typealias Taxi = (
    taxi_id: Int64?,
    taxi_number: String?,
    taxi_available: String?
)

typealias T1_Skybus = (
    t1_skybus_id: Int64?,
    t1_skybus_time: String?
)

typealias T3_Skybus = (
    t3_skybus_id: Int64?,
    t3_skybus_time: String?
)

typealias T4_Skybus = (
    t4_skybus_id: Int64?,
    t4_skybus_time: String?
)

