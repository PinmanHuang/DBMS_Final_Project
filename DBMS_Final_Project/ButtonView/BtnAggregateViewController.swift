//
//  BtnAggregateViewController.swift
//  DBMS_Final_Project
//
//  Created by Huang Joyce on 2020/6/1.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite
import DropDown

class BtnAggregateViewController: UIViewController {
    
    // 
    var selectDatas = ["DOCTORS", "DIVISIONS", "HOSPITALS", "PATIENT", "TREATMENTS", "LOG"]
    var typeDatas = ["COUNT(*)", "SUM", "MAX", "MIN", "AVG"]
    var havingDatas = ["0", "1", "2", "3"]
    
    // User Select Data
    var selectIndex = 0     // select table index id
    var typeIndex = 0       // type index id
    var groupByIsOn = 0     // group switch is on(1)/off(0)
    var havingIsOn = 0      // having switch is on(1)/off(0)
    var havingIndex = 2     // having count 0~3
    
    // SQL Request Data
    var stmtLen = 0
    var attrs = Array<String>()
    var datas = Array<Array<String>>()

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var havingBtn: UIButton!
    @IBOutlet weak var havingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
//        let dropDown = DropDown()
//        dropDown.anchorView = selectView
//        dropDown.dataSource = selectDatas
//        dropDown.show()
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            self.selectBtn.setTitle(item, for: .normal)
//            self.selectIndex = index
//        }
    }
    
    @IBAction func typeBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = typeView
        dropDown.dataSource = typeDatas
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.typeBtn.setTitle(item, for: .normal)
            self.typeIndex = index
        }
    }
    
    @IBAction func havingBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = havingView
        dropDown.dataSource = havingDatas
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.havingBtn.setTitle(item, for: .normal)
            self.havingIndex = index
        }
    }
    
    @IBAction func groupSwitch(_ sender: UISwitch!) {
        if sender.isOn {
            groupByIsOn = 1
            print("isOn")
        } else {
            groupByIsOn = 0
            print("ifOff")
        }
    }
    
    @IBAction func havingSwitch(_ sender: UISwitch!) {
        if sender.isOn {
            havingIsOn = 1
            print("isOn")
        } else {
            havingIsOn = 0
            print("ifOff")
        }
    }
    
    @IBAction func sendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let sql_query = queryString()
        print("===query str: \(sql_query)")
        stmtLen = 0
        attrs = []
        datas = []
        let stmt = try! (db?.prepare(sql_query))!
        for row in stmt {
            print("===count: \(row.count)")
            for (index, name) in stmt.columnNames.enumerated() {
                if attrs.count != row.count {
                    attrs.append(name)
                }
                if datas.count < stmtLen+1 {
                    print("data: \(datas.count), totla: \(stmtLen)")
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
    
    // MARK: - SQL Query String
    func queryString() -> String {
        var str = "SELECT"
        if groupByIsOn == 1 {
            str += " DivID,"
        }
        if typeIndex == 0 {
            str += " COUNT(*)"
        } else {
            str += " \(typeDatas[typeIndex])(Salary)"
        }
        str += " FROM \(selectDatas[selectIndex])"
        if groupByIsOn == 1 {
            str += " GROUP BY DivID"
        }
        if havingIsOn == 1 {
            str += " HAVING COUNT(*)>"+havingBtn.titleLabel!.text!
        }
        return str
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
