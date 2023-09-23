//
//  DBHelper.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 24/09/23.
//

import Foundation
import SQLite3

class DBHelper {
    
    static let shared = DBHelper()
    
    private init() {
        dataBase = openDatabase()
        createTable()
    }
    var dataBase: OpaquePointer?
    let dataBasePath: String = "myDb.Sqlite"
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dataBasePath)
        var dataBase: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &dataBase) != SQLITE_OK
        {
            debugPrint("error opening database")
            return nil
        }
        else
        {
            debugPrint("Successfully opened connection to database at \(dataBasePath)")
            return dataBase
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS location(latitude TEXT, longitude TEXT, placeName TEXT, timeStamp TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dataBase, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                debugPrint("location table created.")
            } else {
                debugPrint("location table could not be created.")
            }
        } else {
            debugPrint("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(latitude: Double, longitude: Double, placeName: String, timeStamp: String)
    {
        let insertStatementString = "INSERT INTO location (latitude, longitude, placeName, timeStamp) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dataBase, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(insertStatement, 1, latitude)
            sqlite3_bind_double(insertStatement, 2, longitude)
            sqlite3_bind_text(insertStatement, 3, (placeName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (timeStamp as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                debugPrint("Successfully inserted row.")
            } else {
                debugPrint("Could not insert row.")
            }
        } else {
            debugPrint("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [HomeDataModel] {
        let queryStatementString = "SELECT * FROM location;"
        var queryStatement: OpaquePointer? = nil
        var psns : [HomeDataModel] = []
        if sqlite3_prepare_v2(dataBase, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let latitude = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let longitude = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let placeName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let timeStamp = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                psns.append(HomeDataModel(latitude: latitude, longitude: longitude, placeName: placeName, timeStamp: timeStamp))
                debugPrint("Query Result:")
                debugPrint("\(placeName) | \(latitude) | \(longitude) | \(timeStamp)")
            }
        } else {
            debugPrint("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
}
