//
//  ViewController.swift
//  DBMS_Final_Project
//
//  Created by Huang Joyce on 2020/5/4.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create Table
//        let path = NSSearchPathForDirectoriesInDomains(
//            .documentDirectory, .userDomainMask, true
//        ).first!
//        let db = try? Connection("\(path)/db.sqlite3")
//
//        let users = Table("users")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//        let email = Expression<String>("email")
//
//        try! db?.run(users.create{ t in
//            t.column(id, primaryKey: true)
//            t.column(name)
//            t.column(email, unique: true)
//        })
    }

    @IBAction func insertBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        let users = Table("users")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
        do {
            let rowid = try db?.run(users.insert(email <- "alice2@mac.com", name <- "alice2"))
            print("inserted id: \(rowid)")
        } catch {
            print("insertion failed: \(error)")
        }
        
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        let users = Table("users")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
        for user in try! (db?.prepare(users))! {
             print("id: \(user[id]), email: \(user[email]), name: \(user[name])")
                       // id: 1, email: alice@mac.com, name: Optional("Alice")
        }
    }
}

