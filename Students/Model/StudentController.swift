//
//  StudentController.swift
//  Students
//
//  Created by Dongwoo Pae on 5/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class StudentController {
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "students", ofType: "json") else {return nil}
        return URL(fileURLWithPath: filePath)
    }
    
    
    //decoding this json file into Student object so it can be used to show UI and others
    
    func loadFromPersistentStore(completion: @escaping ([Student]?, Error?) -> Void) {
        let bgQueue = DispatchQueue(label: "studentQueue", attributes: .concurrent)
        
        bgQueue.async {
            let fm = FileManager.default
            guard let url = self.persistentFileURL,
                fm.fileExists(atPath: url.path) else {return}
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let students = try decoder.decode([Student].self, from: data)
                completion(students, nil)
            } catch {
                print("Error loading student data: \(error)")
                completion(nil, error)
                
            }
        }
    }
}
