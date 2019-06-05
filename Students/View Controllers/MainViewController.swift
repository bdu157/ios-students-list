//
//  MainViewController.swift
//  Students
//
//  Created by Dongwoo Pae on 6/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let studentController = StudendController()
    private var studentTableViewController: StudentTableViewController! {
        didSet {
            self.updateDataSource()
        }
    }
    
    
    private var students: [Student] = [] {
        didSet {
             self.updateDataSource()
        }
    }
    
    @IBOutlet weak var sortSelector: UISegmentedControl!
    @IBOutlet weak var filterSelector: UISegmentedControl!
    
    //  MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.studentController.loadFromPersistentStore { (students, error) in
            if let error = error {
                print("There was an error loading students \(error)")
                return
            }
            DispatchQueue.main.async {
                self.students = students ?? []
                }
            }
        }
    // MARK: IBAction
    
    @IBAction func sort(_ sender: UISegmentedControl) {
        self.updateDataSource()
    }
    
    @IBAction func filter(_ sender: UISegmentedControl) {
        self.updateDataSource()
    }
    
    private func updateDataSource() {
        var sortedAndFilteredStudents: [Student]
        
        switch self.filterSelector.selectedSegmentIndex {
        case 1:  // filter for iOS
            sortedAndFilteredStudents = self.students.filter {$0.course == "iOS"}
          //  ({(student)-> Bool in
          //      return student.course == "iOS"})
        case 2:
            sortedAndFilteredStudents = self.students.filter {$0.course == "Web"}
        case 3:
            sortedAndFilteredStudents = self.students.filter {$0.course == "UX"}
        default:
            sortedAndFilteredStudents = self.students
        }
        
        if self.sortSelector.selectedSegmentIndex == 0 {
//            sortedAndFilteredStudents = self.students.sorted(by: { (student1, student2) -> Bool in
//                student1.firstName < student2.firstName
//            })
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {$0.firstName < $1.firstName}
        } else {
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {$0.lastName < $1.lastName}
        }
        
        self.studentTableViewController.students = sortedAndFilteredStudents
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "StudentTableEmbedSegue" {
            self.studentTableViewController = segue.destination as? StudentTableViewController
        }
    }

}
