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
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    let doctordata = [["doctor_1@gmail.com", "doctor_1", "C001", "10001", "1"],
                      ["doctor_2@gmail.com", "doctor_2", "C002", "20002", "2"],
                      ["doctor_3@gmail.com", "doctor_3", "C003", "30003", "3"],
                      ["doctor_4@gmail.com", "doctor_4", "C004", "40004", "4"],
                      ["doctor_5@gmail.com", "doctor_5", "C005", "50005", "5"],
                      ["doctor_6@gmail.com", "doctor_6", "C006", "60006", "6"],
                      ["doctor_7@gmail.com", "doctor_7", "C007", "70007", "7"],
                      ["doctor_8@gmail.com", "doctor_8", "C008", "80008", "8"],
                      ["doctor_9@gmail.com", "doctor_9", "C009", "90009", "9"],
                      ["doctor_10@gmail.com", "doctor_10", "C010", "10010", "10"]]
    let divisiondata = [["General Medicine", "D001", "1", "1"],
                        ["Surgery", "D002", "1", "2"],
                        ["Pediatrics", "D003", "1", "3"],
                        ["Emergency", "D004", "1", "4"],
                        ["Ophthalmology", "D005", "1", "5"],
                        ["Otolaryngology", "D006", "1", "6"],
                        ["Dentistry", "D007", "1", "7"],
                        ["Chest", "D008", "1", "8"],
                        ["Cardiology", "D009", "1", "9"],
                        ["Gastroenterology and Hepatology", "D010", "1", "10"]]
    let hospitaldata = [["Taipei Veterans General Hospital", "No.201, Sec. 2, Shipai Rd., Beitou District, Taipei City, Taiwan"],
                        ["Taichung Veterans General Hospital", "1650 Taiwan Boulevard Sect. 4, Taichung, Taiwan "],
                        ["Taipei Chang-Gung Memorial Hospital", "No. 5, Fuxing St., Guishan Dist., Taoyuan City, Taiwan"],
                        ["Linkou Chang-Gung Memorial Hospital", "No. 5, Fuxing St., Guishan Dist., Taoyuan City, Taiwan"],
                        ["Mackay Memorial Hospital", "No.16, Sec. 4, Zhongshan N. Rd., Shilin Dist., Taipei City, Taiwan"],
                        ["Hsinchu Mackay Memorial Hospital", "No. 690, Sec. 2, Guangfu Rd., East Dist., Hsinchu City, Taiwan"],
                        ["Cathay General Hospital", "No. 280, Sec. 4, Ren’ai Rd., Da’an Dist., Taipei City, Taiwan"],
                        ["Cathay General Hospital Hsinchu Branch", "No. 678, Sec. 2, Zhonghua Rd., East Dist., Hsinchu City, Taiwan"],
                        ["National Taiwan University Hospital", "No. 7, Zhongshan S. Rd., Zhongzheng Dist., Taipei City, Taiwan"],
                        ["National Taiwan University Hospital Hsin-Chu Branch", "No. 25, Ln. 442, Sec. 1, Jingguo Rd., North Dist., Hsinchu City, Taiwan"]]
    let patientdata = [["Anna", "0910000001", "patient_1@gmail.com", "No. 1, Dajia St., Zhongshan Dist., Taipei City, Taiwan"],
                       ["Brian", "0910000002", "patient_2@gmail.com", "No. 2, Dadao Rd., Xinyi Dist., Taipei City, Taiwan"],
                       ["Chris", "0910000003", "patient_3@gmail.com", "No. 3, Danan Rd., Shilin Dist., Taipei City, Taiwan"],
                       ["David", "0910000004", "patient_4@gmail.com", "No. 4, Sanmin Rd., East Dist., Hsinchu City, Taiwan"],
                       ["Eden", "0910000005", "patient_5@gmail.com", "No. 5, Daxue Rd., East Dist., Hsinchu City, Taiwan"],
                       ["Fed", "0910000006", "patient_6@gmail.com", "No. 6, Sec. 2, Wufu Rd., Xiangshan Dist., Hsinchu City, Taiwan"],
                       ["Gary", "0910000007", "patient_7@gmail.com", "No. 7, Gongyuan Rd., Central Dist., Taichung City, Taiwan"],
                       ["Hadi", "0910000008", "patient_8@gmail.com", "No. 8, Daye Rd., Nantun Dist., Taichung City, Taiwan"],
                       ["Ivan", "0910000009", "patient_9@gmail.com", "No. 9, Shixing Rd., Zhubei City, Hsinchu County, Taiwan"],
                       ["Jack", "0910000010", "patient_10@gmail.com", "No. 10, Sec. 1, Liujia 5th Rd., Zhubei City, Hsinchu County, Taiwan"]]
    let treatmentdata = [["1", "Abciximab", "10.0"],
                         ["1", "Batilol", "5.0"],
                         ["1", "Clindamycin", "15.0"],
                         ["1", "Doxycycline", "10.0"],
                         ["1", "Erythromycin", "2.0"],
                         ["1", "Fosfomycin", "2.5"],
                         ["1", "Gentamycin", "3.0"],
                         ["1", "Olanzapine", "4.0"],
                         ["1", "Piperacillin", "15.0"],
                         ["1", "Ribavirin", "20.0"]]
    let logdata = [["1", "1", "1", "2020-05-01T00:00:00.000"],
                   ["1", "1", "2", "2020-05-01T00:00:00.000"],
                   ["1", "1", "3", "2020-05-01T00:00:00.000"],
                   ["1", "1", "4", "2020-05-01T00:00:00.000"],
                   ["2", "2", "5", "2020-05-02T00:00:00.000"],
                   ["2", "2", "6", "2020-05-02T00:00:00.000"],
                   ["2", "2", "7", "2020-05-02T00:00:00.000"],
                   ["3", "3", "8", "2020-05-03T00:00:00.000"],
                   ["3", "3", "9", "2020-05-03T00:00:00.000"],
                   ["3", "3", "10", "2020-05-03T00:00:00.000"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // UI
//        self.view.addBackground()
        
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
    
    @IBAction func loadBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        do {
            for data in doctordata {
                let rowid = try db?.run(
                    doctorsObject.DOCTORS.insert(
                        doctorsObject.DocEmail <- data[0],
                        doctorsObject.DocName <- data[1],
                        doctorsObject.Room <- data[2],
                        doctorsObject.Salary <- Int64(data[3])!,
                        doctorsObject.DivID <- Int64(data[4])!
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            }
            for data in divisiondata {
                let rowid = try db?.run(
                    divisionsObject.DIVISIONS.insert(
                        divisionsObject.DivName <- data[0],
                        divisionsObject.Office <- data[1],
                        divisionsObject.HosID <- Int64(data[2])!,
                        divisionsObject.MgrDocID <- Int64(data[3])!
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            }
            for data in hospitaldata {
                try db?.run(
                    hospitalsObject.HOSPITALS.insert(
                        hospitalsObject.HosName <- data[0],
                        hospitalsObject.HosAddr <- data[1]
                ))
            }
            for data in patientdata {
                try db?.run(
                    patientObject.PATIENT.insert(
                        patientObject.PatName <- data[0],
                        patientObject.PatPhone <- data[1],
                        patientObject.PatEmail <- data[2],
                        patientObject.Address <- data[3]
                ))
            }
            for data in treatmentdata {
                try db?.run(
                    treatmentsObject.TREATMENTS.insert(
                        treatmentsObject.TreType <- data[0],
                        treatmentsObject.TreName <- data[1],
                        treatmentsObject.Dosage <- Double(data[2])!
                ))
            }
            for data in logdata {
                try db?.run(
                    logObject.LOG.insert(
                        logObject.DocID <- Int64(data[0])!,
                        logObject.PatID <- Int64(data[1])!,
                        logObject.TreID <- Int64(data[2])!,
                        logObject.Timestamp <- data[3]
                ))
            }
        } catch  {
            self.view.makeToast("insertion failed: \(error)")
        }
    }
    
    @IBAction func insertBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        do {
//             try db.run(users.insert(email <- "alice@mac.com", name <- "Alice"))
            let rowid = try db?.run(
                doctorsObject.DOCTORS.insert(
                    doctorsObject.DocEmail <- "doctor1@gmail.com",
                    doctorsObject.DocName <- "doctor1",
                    doctorsObject.Room <- "C100",
                    doctorsObject.Salary <- 100,
                    doctorsObject.DivID <- 0
            ))
            self.view.makeToast("inserted id: \(rowid!)")
        } catch {
            self.view.makeToast("insertion failed: \(error)")
        }
        
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let TB = divisionsObject.DIVISIONS
        for data in try! (db?.prepare(TB))! {
            print("id: \(data[divisionsObject.DivID]), email: \(data[divisionsObject.DivName]), name: \(data[divisionsObject.Office])")
                       // id: 1, email: alice@mac.com, name: Optional("Alice")
        }
    }
    
    // Table
    func doctorsTB(db: Connection) {
        
        try! db.run(doctorsObject.DOCTORS.create(ifNotExists: true) { t in
            t.column(doctorsObject.DocID, primaryKey: true)
            t.column(doctorsObject.DocName)
            t.column(doctorsObject.Room)
            t.column(doctorsObject.Salary)
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
            t.primaryKey(logObject.DocID, logObject.PatID, logObject.TreID)
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
