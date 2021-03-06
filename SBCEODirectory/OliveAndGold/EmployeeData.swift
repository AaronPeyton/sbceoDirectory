//
//  EmployeeStructure.swift
//  SBCEO Directory
//
//  Created by Mobile on 7/18/17.
//  Copyright © 2017 com.4myeecc. All rights reserved.
//

import Foundation
import Firebase

class EmployeeData: NSObject, NSCoding {
    // All pieces of data tied to an employee
    let name: String
    let division: String
    let job: String
    let ext: String
    let email: String
    let reference: DatabaseReference?
    let key: String
    
    let data: [String]
//    [name,job,email,8059644710(which is the direct line or something),then ext]
    
    // Keys tied to each property instead of using literals all over code
    struct PropertyKeys {
        static let nameKey = "name"
        static let divisionKey = "division"
        static let jobKey = "job"
        static let extKey = "ext"
        static let emailKey = "email"
        static let referenceKey = "reference"
        static let keyKey = "key"
    }
    
    // Used for initializing from direct input of all properties
    init(name n: String, division d: String, job j: String, ext ex: String, email e: String, key k: String) {
        name = n
        division = d
        job = j
        ext = ex
        email = e
        reference = nil
        key = k
        
        data = [name, job, email, "8059644710",ext]
    }
    
    // Used for initializing directly from snapshot
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue[PropertyKeys.nameKey] as! String
        division = snapshotValue[PropertyKeys.divisionKey] as! String
        job = snapshotValue[PropertyKeys.jobKey] as! String
        ext = snapshotValue[PropertyKeys.extKey] as! String
        email = snapshotValue[PropertyKeys.emailKey] as! String
        reference = snapshot.ref
        
        data = [name, job, email, "8059644710",ext]
    }
    
    // Used for initializing from dictionary
    init(dictionary: [String: AnyObject], valueKey: String) {
        key = valueKey
        name = dictionary[PropertyKeys.nameKey] as! String
        division = dictionary[PropertyKeys.divisionKey] as! String
        job = dictionary[PropertyKeys.jobKey] as! String
        ext = dictionary[PropertyKeys.extKey] as! String
        email = dictionary[PropertyKeys.emailKey] as! String
        reference = nil
        
        data = [name, job, email, "8059644710", ext]
    }
    
    // Used to pass an EmployeeData object into the firebase database (not actaully used anywhere in current code)
    func toAnyObject() -> Any {
        return [
            PropertyKeys.nameKey: name,
            PropertyKeys.divisionKey: division,
            PropertyKeys.jobKey: job,
            PropertyKeys.extKey: ext,
            PropertyKeys.emailKey: email
        ]
    }
    
    // Required method for any class conforming to NSCoding/NSObject. Used when initializing object from locally stored persistent data
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKeys.nameKey) as! String
        let division = aDecoder.decodeObject(forKey: PropertyKeys.divisionKey) as! String
        let job = aDecoder.decodeObject(forKey: PropertyKeys.jobKey) as! String
        let ext = aDecoder.decodeObject(forKey: PropertyKeys.extKey) as! String
        let email = aDecoder.decodeObject(forKey: PropertyKeys.emailKey) as! String
        let key = aDecoder.decodeObject(forKey: PropertyKeys.keyKey) as! String
        
        self.init(name: name, division: division, job: job, ext: ext, email: email, key: key)
    }
    
    // Required method for any class conforming to NSCoding/NSObject. Used when app closes to encode object into local storage for persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.nameKey)
        aCoder.encode(division, forKey: PropertyKeys.divisionKey)
        aCoder.encode(job, forKey: PropertyKeys.jobKey)
        aCoder.encode(ext, forKey: PropertyKeys.extKey)
        aCoder.encode(email, forKey: PropertyKeys.emailKey)
        aCoder.encode(reference, forKey: PropertyKeys.referenceKey)
        aCoder.encode(key, forKey: PropertyKeys.keyKey)
    }
}
