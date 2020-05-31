//
//  SQLInputViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/31.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite
import DropDown

class SQLInputViewController: UIViewController {

    var selectIndex = 0                 // select Query id
    var typeIndex = 0                   // select Query Type id
    var typeInit = ["SELECT-FROM-WHERE", "IN", "COUNT"]
    var SQLInit = ["SELECT * FROM DOCTORS WHERE DocName='doctor_1'", "SELECT * FROM DOCTORS IN", "SELECT COUNT(ID) FROM DOCTORS"]
    
    var stmtLen = 0
    var attrs = Array<String>()
    var datas = Array<Array<String>>()
    
    @IBOutlet var selectBtn: UIButton!  // select Query Btn
    @IBOutlet var selectView: UIView!   // Query selections
    @IBOutlet var typeBtn: UIButton!    // select Query Type Btn
    @IBOutlet var typeView: UIView!     // Query Type selections
    @IBOutlet var sqlTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = selectView
        dropDown.dataSource = ["SQL Query", "Nested Query", "Aggregate Query"]
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectBtn.setTitle(item, for: .normal)
            self.typeBtn.setTitle(self.typeInit[index], for: .normal)
            self.sqlTextView.text = self.SQLInit[index]
            self.selectIndex = index
//            self.changeField()
        }
    }
    
    @IBAction func typeBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = typeView
        switch selectIndex {
        case 0:
            dropDown.dataSource = ["SELECT-FROM-WHERE", "DELETE", "INSERT", "UPDATE"]
        case 1:
            dropDown.dataSource = ["IN", "NOT IN", "EXISTS", "NOT EXISTS"]
        case 2:
            dropDown.dataSource = ["COUNT", "SUM", "MAX", "MIN", "AVG" , "HAVING"]
        default:
            print("default")
        }
        
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.typeBtn.setTitle(item, for: .normal)
            self.typeIndex = index
            self.changeField()
        }
    }
    
    @IBAction func sendBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        
        if selectIndex == 0 && (typeIndex == 1 || typeIndex == 2 || typeIndex == 3) {
            do {
                try (db?.run(sqlTextView.text))
                self.view.makeToast("sql success")
            } catch {
                self.view.makeToast("sql failed: \(error)")
            }
        } else {
            stmtLen = 0
            attrs = []
            datas = []
            let stmt = try! (db?.prepare(sqlTextView.text))!
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
    }
    
    // UI
    func changeField() {
        let defaultSQL = [
            ["SELECT * FROM DOCTORS WHERE DocName='Apple'",
             "DELETE FROM DOCTORS WHERE DocName='Apple'",
             "INSERT INTO DOCTORS ('DocName', 'Room', 'DocPhone', 'DocEmail', 'DivID') VALUES ('Apple', 'C111', '0900000111', 'apple@gmail.com', 10)",
             "UPDATE DOCTORS SET 'DocPhone' = '0912345678' WHERE DocName='Apple'"],
            ["1", "2", "3", "4"],
            ["01", "02", "03", "04", "05", "06"]]
        sqlTextView.text = defaultSQL[selectIndex][typeIndex]
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
