//
//  BtnInsertViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/25.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite
import DropDown

class BtnInsertViewController: UIViewController {
    var selectIndex = 0     // select TB id
    
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var selectView: UIView!
    
    @IBOutlet var label_1: UILabel!
    @IBOutlet var label_2: UILabel!
    @IBOutlet var label_3: UILabel!
    @IBOutlet var label_4: UILabel!
    @IBOutlet var label_5: UILabel!
    @IBOutlet var label_6: UILabel!
    @IBOutlet var field_1: UITextField!
    @IBOutlet var field_2: UITextField!
    @IBOutlet var field_3: UITextField!
    @IBOutlet var field_4: UITextField!
    @IBOutlet var field_5: UITextField!
    @IBOutlet var field_6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectBtnOnClick(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = selectView
        dropDown.dataSource = ["DOCTORS", "DIVISIONS", "HOSPITALS", "PATIENT", "TREATMENTS", "LOG"]
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectBtn.setTitle(item, for: .normal)
            self.selectIndex = index
            self.changeField()
        }
    }
    
    @IBAction func addBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        do {
            switch selectIndex {
            case 0:
                let rowid = try db?.run(
                    doctorsObject.DOCTORS.insert(
                        doctorsObject.DocID <- Int64(field_1.text!)!,
                        doctorsObject.DocName <- String(field_2.text!),
                        doctorsObject.Room <- String(field_3.text!),
                        doctorsObject.Salary <- Int64(field_4.text!)!,
                        doctorsObject.DocEmail <- String(field_5.text!),
                        doctorsObject.DivID <- Int64(field_6.text!)!
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            case 1:
                let rowid = try db?.run(
                    divisionsObject.DIVISIONS.insert(
                        divisionsObject.DivID <- Int64(field_1.text!)!,
                        divisionsObject.DivName <- String(field_2.text!),
                        divisionsObject.Office <- String(field_3.text!),
                        divisionsObject.HosID <- Int64(field_4.text!)!,
                        divisionsObject.MgrDocID <- Int64(field_5.text!)!
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            case 2:
                let rowid = try db?.run(
                    hospitalsObject.HOSPITALS.insert(
                        hospitalsObject.HosID <- Int64(field_1.text!)!,
                        hospitalsObject.HosName <- String(field_2.text!),
                        hospitalsObject.HosAddr <- String(field_3.text!)
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            case 3:
                let rowid = try db?.run(
                    patientObject.PATIENT.insert(
                        patientObject.PatID <- Int64(field_1.text!)!,
                        patientObject.PatName <- String(field_2.text!),
                        patientObject.PatPhone <- String(field_3.text!),
                        patientObject.PatEmail <- String(field_4.text!),
                        patientObject.Address <- String(field_5.text!)
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            case 4:
                let rowid = try db?.run(
                    treatmentsObject.TREATMENTS.insert(
                        treatmentsObject.TreID <- Int64(field_1.text!)!,
                        treatmentsObject.TreType <- String(field_2.text!),
                        treatmentsObject.TreName <- String(field_3.text!),
                        treatmentsObject.Dosage <- Double(field_4.text!)!
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            case 5:
                let rowid = try db?.run(
                    logObject.LOG.insert(
                        logObject.DocID <- Int64(field_1.text!)!,
                        logObject.PatID <- Int64(field_2.text!)!,
                        logObject.TreID <- Int64(field_3.text!)!,
                        logObject.Timestamp <- String(field_4.text!)
                ))
                self.view.makeToast("inserted id: \(rowid!)")
            default:
                print("default")
            }
            
        } catch {
            self.view.makeToast("insertion failed: \(error)")
        }
    }
    
    func changeField() {
        switch selectIndex {
        case 0:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = false
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = false
            label_1.text = "DocID"
            label_2.text = "DocName"
            label_3.text = "Room"
            label_4.text = "Salary"
            label_5.text = "DocEmail"
            label_6.text = "DivID"
        case 1:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = true
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = true
            label_1.text = "DivID"
            label_2.text = "DivName"
            label_3.text = "Office"
            label_4.text = "HosID"
            label_5.text = "MgrDocID"
        case 2:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = true
            label_5.isHidden = true
            label_6.isHidden = true
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = true
            field_5.isHidden = true
            field_6.isHidden = true
            label_1.text = "HosID"
            label_2.text = "HosName"
            label_3.text = "HosAddr"
        case 3:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = true
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = true
            label_1.text = "PatID"
            label_2.text = "PatName"
            label_3.text = "PatPhone"
            label_4.text = "PatEmail"
            label_5.text = "Address"
        case 4:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = true
            label_6.isHidden = true
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = true
            field_6.isHidden = true
            label_1.text = "TreID"
            label_2.text = "TreType"
            label_3.text = "TreName"
            label_4.text = "Dosage"
        case 5:
            label_1.isHidden = false
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = true
            label_6.isHidden = true
            field_1.isHidden = false
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = true
            field_6.isHidden = true
            label_1.text = "DocID"
            label_2.text = "PatID"
            label_3.text = "TreID"
            label_4.text = "Timestamp"
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
