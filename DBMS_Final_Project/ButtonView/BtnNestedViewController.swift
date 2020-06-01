//
//  BtnNestedViewController.swift
//  DBMS_Final_Project
//
//  Created by Huang Joyce on 2020/6/1.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import DropDown
import SQLite

class BtnNestedViewController: UIViewController {
    
    var divisionDatas = [""]
    var doctorDatas = [""]
    
    // User Select Data
    var divisionIndex = 0
    var doctorIndex = 0
    
    // SQL Request Data
    var stmtLen = 0
    var attrs = Array<String>()
    var datas = Array<Array<String>>()

    @IBOutlet weak var divisionBtn: UIButton!     // division name
    @IBOutlet weak var divisionView: UIView!
    @IBOutlet weak var doctorBtn: UIButton! // doctor name
    @IBOutlet weak var doctorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectDoctors()
        selectDivisions()
    }
    
    @IBAction func divisionBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = divisionView
        dropDown.dataSource = divisionDatas
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.divisionBtn.setTitle(item, for: .normal)
            self.divisionIndex = index
        }
    }
    
    @IBAction func doctorBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = doctorView
        dropDown.dataSource = doctorDatas
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.doctorBtn.setTitle(item, for: .normal)
            self.doctorIndex = index
        }
    }
    @IBAction func inSendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let sql_query = "SELECT DocName, Room, DocEmail FROM DOCTORS WHERE DivID IN (SELECT DivID FROM DIVISIONS WHERE DivName='\(divisionDatas[divisionIndex])')"
        print("===query str: \(sql_query)")
        stmtLen = 0
        attrs = []
        datas = []
        let stmt = try! (db?.prepare(sql_query))!
        for row in stmt {
            for (index, name) in stmt.columnNames.enumerated() {
                if attrs.count != row.count {
                    attrs.append(name)
                }
                if datas.count < stmtLen+1 {
                    datas.append([])
                }
                datas[stmtLen].append("\(row[index]!)")
                print ("\(name):\(row[index]!)")
            }
            stmtLen += 1
        }
        self.view.makeToast("sql success")
        self.performSegue(withIdentifier: "select", sender: Any?.self)
    }
    
    @IBAction func notinSendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let sql_query = "SELECT PatName, PatPhone, PatEmail, Address FROM PATIENT WHERE PatID NOT IN (SELECT PatID FROM LOG WHERE DocID IN (SELECT DocID FROM DOCTORS WHERE DocName='\(doctorDatas[doctorIndex])'))"
        print("===query str: \(sql_query)")
        stmtLen = 0
        attrs = []
        datas = []
        let stmt = try! (db?.prepare(sql_query))!
        for row in stmt {
            for (index, name) in stmt.columnNames.enumerated() {
                if attrs.count != row.count {
                    attrs.append(name)
                }
                if datas.count < stmtLen+1 {
                    datas.append([])
                }
                datas[stmtLen].append("\(row[index]!)")
                print ("\(name):\(row[index]!)")
            }
            stmtLen += 1
        }
        self.view.makeToast("sql success")
        self.performSegue(withIdentifier: "select", sender: Any?.self)
    }
    
    @IBAction func existsSendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let sql_query = "SELECT DocName, Room, DocEmail FROM DOCTORS WHERE EXISTS(SELECT * FROM LOG WHERE DOCTORS.DocID=LOG.DocID)"
        print("===query str: \(sql_query)")
        stmtLen = 0
        attrs = []
        datas = []
        let stmt = try! (db?.prepare(sql_query))!
        for row in stmt {
            for (index, name) in stmt.columnNames.enumerated() {
                if attrs.count != row.count {
                    attrs.append(name)
                }
                if datas.count < stmtLen+1 {
                    datas.append([])
                }
                datas[stmtLen].append("\(row[index]!)")
                print ("\(name):\(row[index]!)")
            }
            stmtLen += 1
        }
        self.view.makeToast("sql success")
        self.performSegue(withIdentifier: "select", sender: Any?.self)
    }
    
    @IBAction func notexistsSendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let sql_query = "SELECT DocName, Room, DocEmail FROM DOCTORS WHERE NOT EXISTS(SELECT * FROM LOG WHERE DOCTORS.DocID=LOG.DocID)"
        print("===query str: \(sql_query)")
        stmtLen = 0
        attrs = []
        datas = []
        let stmt = try! (db?.prepare(sql_query))!
        for row in stmt {
            for (index, name) in stmt.columnNames.enumerated() {
                if attrs.count != row.count {
                    attrs.append(name)
                }
                if datas.count < stmtLen+1 {
                    datas.append([])
                }
                datas[stmtLen].append("\(row[index]!)")
                print ("\(name):\(row[index]!)")
            }
            stmtLen += 1
        }
        self.view.makeToast("sql success")
        self.performSegue(withIdentifier: "select", sender: Any?.self)
    }
    
    // SQL
    func selectDoctors() {
        doctorDatas = []
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        let TB = doctorsObject.DOCTORS
        for data in try! (db?.prepare(TB))! {
            doctorDatas.append(data[doctorsObject.DocName]!)
        }
        doctorBtn.setTitle(doctorDatas[0], for: .normal)
    }
    
    func selectDivisions() {
        divisionDatas = []
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        let TB = divisionsObject.DIVISIONS
        for data in try! (db?.prepare(TB))! {
            divisionDatas.append(data[divisionsObject.DivName]!)
        }
        divisionBtn.setTitle(divisionDatas[0], for: .normal)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select" {
            if let view = segue.destination as? SQLAllDataViewController {
                view.attrs = attrs
                view.datas = datas
                view.stmtLen = stmtLen
            }
        }
    }

}
