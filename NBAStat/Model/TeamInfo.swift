//
//  TeamInfo.swift
//  NBAStat
//
//  Created by fan on 12/8/21.
//

import Foundation


import RealmSwift

class TeamInfo : Object {
    @objc dynamic var nickName: String  = ""
    @objc dynamic var city : String = ""
    @objc dynamic  var fullName : String = ""
    @objc dynamic var teamId : String = ""
    @objc dynamic var logo : String = ""
    @objc dynamic var shortName: String  = ""
    @objc dynamic var confName: String  = ""
    @objc dynamic var divName: String  = ""

    
    override static func primaryKey() -> String? {
        return "teamId"
    }
    
}
