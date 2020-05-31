//
//  TBObjectModel.swift
//  DBMS_Final_Project
//
//  Created by Huang Joyce on 2020/5/8.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import Foundation
import SQLite

class doctorsObject {
    
    static let DOCTORS = Table("DOCTORS")
    static let DocID = Expression<Int64>("DocID")
    static let DocName = Expression<String?>("DocName")
    static let Room = Expression<String>("Room")
    static let Salary = Expression<Int64>("Salary")
    static let DocEmail = Expression<String>("DocEmail")
    static let DivID = Expression<Int64>("DivID")
    
}

class divisionsObject {
    
    static let DIVISIONS = Table("DIVISIONS")
    static let DivID = Expression<Int64>("DivID")
    static let DivName = Expression<String?>("DivName")
    static let Office = Expression<String?>("Office")
    static let HosID = Expression<Int64>("HosID")
    static let MgrDocID = Expression<Int64>("MgrDocID")
    
}

class hospitalsObject {
    
    static let HOSPITALS = Table("HOSPITALS")
    static let HosID = Expression<Int64>("HosID")
    static let HosName = Expression<String?>("HosName")
    static let HosAddr = Expression<String?>("HosAddr")
    
}

class patientObject {
    
    static let PATIENT = Table("PATIENT")
    static let PatID = Expression<Int64>("PatID")
    static let PatName = Expression<String?>("PatName")
    static let PatPhone = Expression<String>("PatPhone")
    static let PatEmail = Expression<String>("PatEmail")
    static let Address = Expression<String>("Address")
    
}

class treatmentsObject {
    
    static let TREATMENTS = Table("TREATMENTS")
    static let TreID = Expression<Int64>("TreID")
    static let TreType = Expression<String?>("TreType")
    static let TreName = Expression<String>("TreName")
    static let Dosage = Expression<Double>("Dosage")
    
}

class logObject {
    
    static let LOG = Table("LOG")
//    static let LogID = Expression<Int64>("LogID")
    static let DocID = Expression<Int64>("DocID")
    static let PatID = Expression<Int64>("PatID")
    static let TreID = Expression<Int64>("TreID")
    static let Timestamp = Expression<String>("Timestamp")
    
}
