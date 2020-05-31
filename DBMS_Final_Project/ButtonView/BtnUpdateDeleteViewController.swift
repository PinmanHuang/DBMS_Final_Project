//
//  BtnUpdateDeleteViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/28.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite

class BtnUpdateDeleteViewController: UIViewController {

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
    
    var table_id: Int!  // user select table
    var select_id: Int! // user select data of table_id
    var qTB: Table!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("tableID: \(table_id), selectID: \(select_id)")
        changeField()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnOnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // SQL
    @IBAction func updateBtnOnClick(_ sender: Any) {
        updateTB()
    }
    
    @IBAction func deleteBtnOnClick(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        do {
            if try db!.run(qTB.delete()) > 0 {
                self.view.makeToast("deleted success")
                dismiss(animated: true, completion: nil)
            } else {
                self.view.makeToast("not found")
            }
        } catch {
            self.view.makeToast("delete failed: \(error)")
        }
    }
    
    // SQL
    func updateTB() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        do {
            switch table_id {
            case 0:
                try db?.run(
                    qTB.update(
                        doctorsObject.DocName <- String(field_2.text!),
                        doctorsObject.Room <- String(field_3.text!),
                        doctorsObject.DocPhone <- String(field_4.text!),
                        doctorsObject.DocEmail <- String(field_5.text!),
                        doctorsObject.DivID <- Int64(field_6.text!)!
                ))
                self.view.makeToast("update success")
            case 1:
                try db?.run(
                    qTB.update(
                        divisionsObject.DivName <- String(field_2.text!),
                        divisionsObject.Office <- String(field_3.text!),
                        divisionsObject.HosID <- Int64(field_4.text!)!,
                        divisionsObject.MgrDocID <- Int64(field_5.text!)!
                ))
                self.view.makeToast("update success")
            case 2:
                try db?.run(
                    qTB.update(
                        hospitalsObject.HosName <- String(field_2.text!),
                        hospitalsObject.HosAddr <- String(field_3.text!)
                ))
                self.view.makeToast("update success")
            case 3:
                try db?.run(
                    qTB.update(
                        patientObject.PatName <- String(field_2.text!),
                        patientObject.PatPhone <- String(field_3.text!),
                        patientObject.PatEmail <- String(field_4.text!),
                        patientObject.Address <- String(field_5.text!)
                ))
                self.view.makeToast("update success")
            case 4:
                try db?.run(
                    qTB.update(
                        treatmentsObject.TreType <- String(field_2.text!),
                        treatmentsObject.TreName <- String(field_3.text!),
                        treatmentsObject.Dosage <- Double(field_4.text!)!
                ))
                self.view.makeToast("update success")
            case 5:
                try db?.run(
                    qTB.update(
                        logObject.DocID <- Int64(field_1.text!)!,
                        logObject.PatID <- Int64(field_2.text!)!,
                        logObject.TreID <- Int64(field_3.text!)!,
                        logObject.Timestamp <- String(field_4.text!)
                ))
                self.view.makeToast("update success")
            default:
                print("default")
            }
            
        } catch {
            self.view.makeToast("update failed: \(error)")
        }
    }
    
    // UI
    func changeField() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try? Connection("\(path)/db.sqlite3")
        switch table_id {
        case 0:
            label_1.isHidden = true
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = false
            field_1.isHidden = true
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = false
            label_2.text = "DocName"
            label_3.text = "Room"
            label_4.text = "DocPhone"
            label_5.text = "DocEmail"
            label_6.text = "DivID"
            let TB = doctorsObject.DOCTORS
            let id = doctorsObject.DocID
            qTB = TB.where(id == Int64(select_id))
            for data in try! (db?.prepare(qTB))! {
                field_2.text = data[doctorsObject.DocName]!
                field_3.text = data[doctorsObject.Room]
                field_4.text = data[doctorsObject.DocPhone]
                field_5.text = data[doctorsObject.DocEmail]
                field_6.text = "\(data[doctorsObject.DivID])"
            }
            
        case 1:
            label_1.isHidden = true
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = true
            field_1.isHidden = true
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = true
            label_2.text = "DivName"
            label_3.text = "Office"
            label_4.text = "HosID"
            label_5.text = "MgrDocID"
            let TB = divisionsObject.DIVISIONS
            let id = divisionsObject.DivID
            qTB = TB.where(id == Int64(select_id))
            for data in try! (db?.prepare(qTB))! {
                field_2.text = data[divisionsObject.DivName]!
                field_3.text = data[divisionsObject.Office]
                field_4.text = "\(data[divisionsObject.HosID])"
                field_5.text = "\(data[divisionsObject.MgrDocID])"
            }
        case 2:
            label_1.isHidden = true
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = true
            label_5.isHidden = true
            label_6.isHidden = true
            field_1.isHidden = true
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = true
            field_5.isHidden = true
            field_6.isHidden = true
            label_2.text = "HosName"
            label_3.text = "HosAddr"
            let TB = hospitalsObject.HOSPITALS
            let id = hospitalsObject.HosID
            qTB = TB.where(id == Int64(select_id))
            for data in try! (db?.prepare(qTB))! {
                field_2.text = data[hospitalsObject.HosName]!
                field_3.text = data[hospitalsObject.HosAddr]
            }
        case 3:
            label_1.isHidden = true
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = false
            label_6.isHidden = true
            field_1.isHidden = true
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = false
            field_6.isHidden = true
            label_2.text = "PatName"
            label_3.text = "PatPhone"
            label_4.text = "PatEmail"
            label_5.text = "Address"
            let TB = patientObject.PATIENT
            let id = patientObject.PatID
            qTB = TB.where(id == Int64(select_id))
            for data in try! (db?.prepare(qTB))! {
                field_2.text = data[patientObject.PatName]!
                field_3.text = data[patientObject.PatPhone]
                field_4.text = data[patientObject.PatEmail]
                field_5.text = data[patientObject.Address]
            }
        case 4:
            label_1.isHidden = true
            label_2.isHidden = false
            label_3.isHidden = false
            label_4.isHidden = false
            label_5.isHidden = true
            label_6.isHidden = true
            field_1.isHidden = true
            field_2.isHidden = false
            field_3.isHidden = false
            field_4.isHidden = false
            field_5.isHidden = true
            field_6.isHidden = true
            label_2.text = "TreType"
            label_3.text = "TreName"
            label_4.text = "Dosage"
            let TB = treatmentsObject.TREATMENTS
            let id = treatmentsObject.TreID
            qTB = TB.where(id == Int64(select_id))
            for data in try! (db?.prepare(qTB))! {
                field_2.text = data[treatmentsObject.TreType]!
                field_3.text = data[treatmentsObject.TreName]
                field_4.text = "\(data[treatmentsObject.Dosage])"
            }
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
