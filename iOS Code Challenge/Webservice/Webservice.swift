//
//  Webservice.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 30/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import Foundation


protocol Webservice {
    func fetchProfile(completion: @escaping(Bool, ProfileModel) -> Void)
    func updateProfile(withData profileData: ProfileModel, completion: @escaping(ProfileModel) -> Void)
    func changePass(withParams params: [String: Any], completion: @escaping(Bool, [String: Any]?) -> Void)
}

class MockApiClient: Webservice {
    private static let delay = 0.25
    private static let fileManager = FileManager.default
    private static var subURL: URL?
    
    
    func fetchProfile(completion: @escaping (Bool, ProfileModel) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + MockApiClient.delay) {
            let filePath = "Profile"
            
            MockApiClient.loadJsonDataFromFile(filePath) { data in
                if let json = data {
                    do {
                        let estimate = try JSONDecoder().decode(ProfileModel.self, from: json)
                        completion(true, estimate)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            }
        }
    }
    
    
    private static func loadJsonDataFromFile(_ mainPath: String, completion: (Data?) -> Void) {
        if let mainFileURL = Bundle.main.url(forResource: mainPath, withExtension: "json") {
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                subURL = documentDirectory.appendingPathComponent("Profile.json")
                
                if (fileManager.fileExists(atPath: subURL!.path) && mainPath == "Profile"){
                    let jsonData = try Data(contentsOf: subURL!)
                    completion(jsonData as Data)
                }else{
                    let jsonData = try Data(contentsOf: mainFileURL)
                    completion(jsonData as Data)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    
    func updateProfile(withData profileData: ProfileModel, completion: @escaping (ProfileModel) -> Void) {
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(profileData)
            try jsonData.write(to: MockApiClient.subURL!)
            completion(profileData)
        } catch _ as NSError {
            fatalError("Couldn't save data into \(MockApiClient.subURL!)")
        }
        
    }
    
    func changePass(withParams params: [String: Any], completion: @escaping(Bool, [String: Any]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + MockApiClient.delay) {
            let filePath = "ChangePass"
            MockApiClient.loadJsonDataFromFile(filePath) { data in
                if let json = data {
                    do {
                        if let response = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                            completion(true, response)
                        }
                    } catch _ as NSError {
                        completion(false, nil)
                    }
                }
            }
        }
    }
    
}
