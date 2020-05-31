//
//  SQLAllDataViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/31.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit
import SQLite

class SQLAllDataViewController: UIViewController {
    
    var stmtLen: Int?       // select data result length
    var attrs: Array<String>!
    var datas: Array<Array<String>>!
    var selectDatas = Array<String>()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select" {
            if let view = segue.destination as? SQLDetailDataViewController {
                view.attrs = attrs
                view.datas = selectDatas
            }
        }
    }

}

extension SQLAllDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stmtLen!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectTableViewCell else {
            fatalError("Sorry, could not load cell")
        }
        print("row: \(indexPath.row), data: \(datas[0][0])")
        cell.label.text = attrs[0]+":"
        cell.label_2.text = attrs[1]+":"
        cell.dataLabel.text = datas[indexPath.row][0]
        cell.dataLabel_2.text = datas[indexPath.row][1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDatas = datas[indexPath.row]
        self.performSegue(withIdentifier: "select", sender: Any?.self)
    }
}
