//
//  PlayerInfo.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import Foundation


import RealmSwift

class PlayerInfo : Object {
    @objc dynamic var firstName: String  = ""
    @objc dynamic var lastName : String = ""
    @objc dynamic var teamId : String = ""
    @objc dynamic var yearsPro : String = ""
    @objc dynamic var collegeName : String = ""
    @objc dynamic var country: String  = ""
    @objc dynamic var playerId: String  = ""
    @objc dynamic var dateOfBirth: String  = ""
    @objc dynamic var affiliation: String  = ""
    @objc dynamic var startNba: String  = ""
    @objc dynamic var heightInMeters: String  = ""
    @objc dynamic var weightInKilograms: String  = ""
    
    
    override static func primaryKey() -> String? {
        return "playerId"
    }
    
}
