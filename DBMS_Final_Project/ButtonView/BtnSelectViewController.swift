//
//  BtnSelectViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/25.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite
import DropDown

class BtnSelectViewController: UIViewController {

    @IBOutlet var selectView: UIView!
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var whereLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var selectTB = 0                        // 選擇的 Tabel
    let whereID = ["DocID", "DivID", "HosID", "PatID", "TreID", "DocID"]
    var TB: Table!
    var datas = Dictionary<Int, String>()   // SQL Select 的所有資料
    var dataLen = 0                         // SQL Select 的資料長度
    var select_id = 0                       // 點選的資料 id
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectData()
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = selectView
        dropDown.dataSource = ["DOCTORS", "DIVISIONS", "HOSPITALS", "PATIENT", "TREATMENTS", "LOG"]
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectBtn.setTitle(item, for: .normal)
            self.whereLabel.text = "WHERE \(self.whereID[index])=1"
            self.selectTB = index
            self.selectData()
        }
    }
    
    @IBAction func whereSwitch(_ sender: UISwitch!) {
        if sender.isOn {
            print("isOn")
        } else {
            print("ifOff")
        }
    }
    
    func selectData() {
        // initial
        dataLen = 0
        datas = [:]
        
        // select table
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        switch selectTB {
        case 0:
            TB = doctorsObject.DOCTORS
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[Int(data[doctorsObject.DocID])] = "\(data[doctorsObject.DocID]), \(data[doctorsObject.DocEmail]), \(data[doctorsObject.DocName]!)"
                print("id: \(data[doctorsObject.DocID]), email: \(data[doctorsObject.DocEmail]), name: \(data[doctorsObject.DocName]!)")
            }
        case 1:
            TB = divisionsObject.DIVISIONS
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[Int(data[divisionsObject.DivID])] = "\(data[divisionsObject.DivID]), \(data[divisionsObject.DivName]!)"
                print("id: \(data[divisionsObject.DivID]), name: \(data[divisionsObject.DivName]!), office: \(data[divisionsObject.Office]!), hos_id: \(data[divisionsObject.HosID]), mgr_doc: \(data[divisionsObject.MgrDocID])")
            }
        case 2:
            TB = hospitalsObject.HOSPITALS
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[Int(data[hospitalsObject.HosID])] = "\(data[hospitalsObject.HosID]), \(data[hospitalsObject.HosName]!)"
                print("id: \(data[hospitalsObject.HosID]), name: \(data[hospitalsObject.HosName]!), address: \(data[hospitalsObject.HosAddr]!)")
            }
        case 3:
            TB = patientObject.PATIENT
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[Int(data[patientObject.PatID])] = "\(data[patientObject.PatID]), \(data[patientObject.PatName]!)"
                print("id: \(data[patientObject.PatID]), name: \(data[patientObject.PatName]!), email: \(data[patientObject.PatEmail])")
            }
        case 4:
            TB = treatmentsObject.TREATMENTS
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[Int(data[treatmentsObject.TreID])] = "\(data[treatmentsObject.TreID]), \(data[treatmentsObject.TreName])"
                print("id: \(data[treatmentsObject.TreID]), name: \(data[treatmentsObject.TreName]), dosage: \(data[treatmentsObject.Dosage])")
            }
        case 5:
            TB = logObject.LOG
            for data in try! (db?.prepare(TB))! {
                dataLen += 1
                datas[dataLen] = "\(data[logObject.DocID]), \(data[logObject.PatID]), \(data[logObject.TreID])"
                print("doc_id: \(data[logObject.DocID]), pat_id: \(data[logObject.PatID]), tre_id: \(data[logObject.TreID])")
            }
        default:
            print("default")
        }
        tableView.reloadData()
        
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select" {
            if let view = segue.destination as? BtnUpdateDeleteViewController {
                view.table_id = selectTB
                view.select_id = select_id
            }
        }
    }

}

extension BtnSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLen
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectTableViewCell else {
            fatalError("Sorry, could not load cell")
        }
        cell.label.text = Array(datas)[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        select_id = Array(datas)[indexPath.row].key
        if selectTB != 5 {
            self.performSegue(withIdentifier: "select", sender: Any?.self)
        }
    }
}
