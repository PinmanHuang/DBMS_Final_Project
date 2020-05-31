//
//  SQLDetailDataViewController.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/31.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit

class SQLDetailDataViewController: UIViewController {
    
    var attrs: Array<String>!
    var datas: Array<String>!

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension SQLDetailDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attrs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectTableViewCell else {
            fatalError("Sorry, could not load cell")
        }
        cell.label.text = attrs[indexPath.row]
        cell.dataLabel.text = datas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
