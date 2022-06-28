//
//  Database.swift
//  Workout Record
//
//  Created by Ono Makoto on 15/6/2022.
//

import Foundation
import SQLite

let FILE_NAME = "record.db"



class Database {
    
    var db: Connection
    let main = Table("main")
    let id = Expression<Int64>("id")
    let type_name = Expression<String>("type_name")
    let weight = Expression<String>("weight")
    let set_index = Expression<Int>("set_index")
    let date = Expression<String>("date")
    let rep_count = Expression<Int>("rep_count")
    
    func formatDate() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let formatted_today = dateFormatter.string(from: today)
        return formatted_today
    }

    init() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(FILE_NAME).path
        print(filePath)
        db = try! Connection(filePath)
        do {
            /*try db.execute("""
                BEGIN TRANSACTION;
                CREATE TABLE main (
                    id INTEGER PRIMARY KEY NOT NULL,
                    type_name TEXT NOT NULL,
                    set_count INTEGER NOT NULL,
                    date TEXT NOT NULL
                );
                CREATE TABLE rep_count (
                    type_id INTEGER NOT NULL,
                    rep_id INTEGER PRIMARY KEY NOT NULL,
                    rep_count INTEGER NOT NULL,
                    FOREIGN KEY (type_id) REFERENCES main(id)
                );
                COMMIT TRANSACTION;
                """
            )*/
            try db.run(main.create{t in
                t.column(Expression<Int64>("id"), primaryKey: true)
                t.column(Expression<String>("type_name"))
                t.column(Expression<String>("weight"))
                t.column(Expression<Int>("set_index"))
                t.column(Expression<String>("date"))
                t.column(Expression<Int>("rep_count"))
            })
        } catch {
            print("error while creating tables")
        }
    }
    
    func findByDate(selectedDate: String) -> [[Data]] {
        var results = [Data]()
        var types_set = Set<String>()
        var set_array = [Data]()
        var items = [[Data]]()
        
        //var selectedDate: String = formatDate()
        
        guard let data = try? db.prepare(main.filter(date == selectedDate)) else {
            return [results]
        }
        for row in data {
            results.append(
                Data(
                    id: row[self.id],
                    type_name: row[self.type_name],
                    weight: row[self.weight],
                    set_index: row[self.set_index],
                    date: row[self.date],
                    rep_count: row[self.rep_count]
                )
            )
        }
        for row in results {
            types_set.insert(row.type_name)
        }
        
        for i in 0..<types_set.count {
            for row in results {
                if row.type_name == Array(types_set)[i] {
                    set_array.append(row)
                }
            }
            items.append(set_array)
            set_array = []
        }
        return items
    }
    
    func add(typeState: String, weight_str: String, set_i: Int, numState: Int) -> () {
        do {
            print(typeState, weight_str, set_i, numState)
            try db.run(main.insert(type_name <- typeState, weight <- weight_str, set_index <- set_i, date <- formatDate(), rep_count <- numState)
            )
            print("sucessfully inserted", typeState)
        } catch {
            print("failed to insert data")
        }
    }
    
    func delete(idToDelete: Int64) -> () {
        do {
            let rowToDelete = main.filter(id == idToDelete)
            try db.run(rowToDelete.delete())
        } catch {
            print("failed to delete \(id)")
        }
    }
}

class Data {
    let id: Int64
    let type_name: String
    let set_index: Int
    let weight: String
    let date: String
    let rep_count: Int
    init(id: Int64, type_name: String, weight: String, set_index: Int, date: String, rep_count: Int) {
        self.id = id
        self.type_name = type_name
        self.weight = weight
        self.set_index = set_index
        self.date = date
        self.rep_count = rep_count
    }
}
