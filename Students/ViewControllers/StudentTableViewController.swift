//
//  StudentTableViewController.swift
//  Students
//
//  Created by Dongwoo Pae on 5/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    var students: [Student] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let student = self.students[indexPath.row]
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = student.course

        return cell
    }
}
