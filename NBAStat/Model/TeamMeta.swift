//
//  TeamMeta.swift
//  NBAStat
//
//  Created by fan on 12/8/21.
//

import Foundation

import RealmSwift


class TeamMeta : Object {
   
    @objc dynamic  var fullName : String = ""
    @objc dynamic var teamId : String = ""
    
    
    override static func primaryKey() -> String? {
        return "teamId"
    }
    
}
