//
//  ViewController.swift
//  DBMS_Final_Project
//
//  Created by Huang Joyce on 2020/5/4.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite
import SideMenu

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // UI
        self.view.addBackground()
        
        // Side Menu
        setupSideMenu()
        
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
    
    // MARK: Side Menu
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "MenuNavigationController") as? SideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
    }
    
    // MARK: Button On Click

    @IBAction func createBtnOnClick(_ sender: Any) {
        // Create Table
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        doctorsTB(db: db!)
        divisionsTB(db: db!)
        hospitalsTB(db: db!)
        patientTB(db: db!)
        treatmentsTB(db: db!)
        logTB(db: db!)
                
    }
    
    @IBAction func insertBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        do {
            let rowid = try db?.run(
                doctorsObject.DOCTORS.insert(
                    doctorsObject.DocEmail <- "doctor1@gmail.com",
                    doctorsObject.DocName <- "doctor1",
                    doctorsObject.Room <- "C100",
                    doctorsObject.DocPhone <- "0999999999",
                    doctorsObject.DivID <- 0
            ))
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
        
        let TB = doctorsObject.DOCTORS
        for data in try! (db?.prepare(TB))! {
            print("id: \(data[doctorsObject.DocID]), email: \(data[doctorsObject.DocEmail]), name: \(data[doctorsObject.DocName])")
                       // id: 1, email: alice@mac.com, name: Optional("Alice")
        }
    }
    
    // Table
    func doctorsTB(db: Connection) {
        
        try! db.run(doctorsObject.DOCTORS.create(ifNotExists: true) { t in
            t.column(doctorsObject.DocID, primaryKey: true)
            t.column(doctorsObject.DocName)
            t.column(doctorsObject.Room)
            t.column(doctorsObject.DocPhone)
            t.column(doctorsObject.DocEmail, unique: true)
            t.column(doctorsObject.DivID)
        })
    }
    
    func divisionsTB(db: Connection) {
        
        try! db.run(divisionsObject.DIVISIONS.create(ifNotExists: true) { t in
            t.column(divisionsObject.DivID, primaryKey: true)
            t.column(divisionsObject.DivName)
            t.column(divisionsObject.Office)
            t.column(divisionsObject.HosID)
            t.column(divisionsObject.MgrDocID)
        })
    }
    
    func hospitalsTB(db: Connection) {
        
        try! db.run(hospitalsObject.HOSPITALS.create(ifNotExists: true) { t in
            t.column(hospitalsObject.HosID, primaryKey: true)
            t.column(hospitalsObject.HosName)
            t.column(hospitalsObject.HosAddr)
        })
    }
    
    func patientTB(db: Connection) {
        
        try! db.run(patientObject.PATIENT.create(ifNotExists: true) { t in
            t.column(patientObject.PatID, primaryKey: true)
            t.column(patientObject.PatName)
            t.column(patientObject.PatPhone)
            t.column(patientObject.PatEmail)
            t.column(patientObject.Address)
        })
    }
    
    func treatmentsTB(db: Connection) {
        
        try! db.run(treatmentsObject.TREATMENTS.create(ifNotExists: true) { t in
            t.column(treatmentsObject.TreID, primaryKey: true)
            t.column(treatmentsObject.TreType)
            t.column(treatmentsObject.TreName)
            t.column(treatmentsObject.Dosage, defaultValue: 0.0)
        })
    }
    
    func logTB(db: Connection) {
        
        try! db.run(logObject.LOG.create(ifNotExists: true) { t in
            t.column(logObject.DocID)
            t.column(logObject.PatID)
            t.column(logObject.TreID)
            t.column(logObject.Timestamp)
        })
    }
}

extension ViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
