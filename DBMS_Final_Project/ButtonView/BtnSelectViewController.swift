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
    
    var selectTB = 0
    let whereID = ["DocID", "DivID", "HosID", "PatID", "TreID", "DocID"]
    var TB: Table!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        print(selectTB)
        switch selectTB {
        case 0:
            TB = doctorsObject.DOCTORS
            for data in try! (db?.prepare(TB))! {
                print("id: \(data[doctorsObject.DocID]), email: \(data[doctorsObject.DocEmail]), name: \(data[doctorsObject.DocName]!)")
            }
        case 1:
            TB = divisionsObject.DIVISIONS
            for data in try! (db?.prepare(TB))! {
                print("id: \(data[divisionsObject.DivID]), name: \(data[divisionsObject.DivName]!), office: \(data[divisionsObject.Office]!), hos_id: \(data[divisionsObject.HosID]), mgr_doc: \(data[divisionsObject.MgrDocID])")
            }
        case 2:
            TB = hospitalsObject.HOSPITALS
            for data in try! (db?.prepare(TB))! {
                print("id: \(data[hospitalsObject.HosID]), name: \(data[hospitalsObject.HosName]!), address: \(data[hospitalsObject.HosAddr]!)")
            }
        case 3:
            TB = patientObject.PATIENT
            for data in try! (db?.prepare(TB))! {
                print("id: \(data[patientObject.PatID]), name: \(data[patientObject.PatName]!), email: \(data[patientObject.PatEmail])")
            }
        case 4:
            TB = treatmentsObject.TREATMENTS
            for data in try! (db?.prepare(TB))! {
                print("id: \(data[treatmentsObject.TreID]), name: \(data[treatmentsObject.TreName]), dosage: \(data[treatmentsObject.Dosage])")
            }
        case 5:
            TB = logObject.LOG
            for data in try! (db?.prepare(TB))! {
                print("doc_id: \(data[logObject.DocID]), pat_id: \(data[logObject.PatID]), tre_id: \(data[logObject.TreID])")
            }
        default:
            print("default")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BtnSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
