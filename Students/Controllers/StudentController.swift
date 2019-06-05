//
//  StudentController.swift
//  Students
//
//  Created by Dongwoo Pae on 6/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class StudendController {
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "students", ofType: "json") else {return nil}
            return URL(fileURLWithPath: filePath)
    }
    
    func loadFromPersistentStore(completion: @escaping ([Student]?, Error?) -> Void) {
        let backgroundAQueue = DispatchQueue(label: "studentQueue", attributes: .concurrent)
        
        backgroundAQueue.async {
            let fm = FileManager.default
            guard let url = self.persistentFileURL,
                fm.fileExists(atPath: url.path) else {completion(nil, NSError()); return}
            
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
