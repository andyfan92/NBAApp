//
//  GameInfo.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import Foundation

import RealmSwift

class GameInfo : Object {
    @objc dynamic var time: String  = ""
    @objc dynamic var vTeam : String = ""
    @objc dynamic var hTeam : String = ""
    @objc dynamic var vTeamScore : String = ""
    @objc dynamic var hTeamScore : String = ""
    @objc dynamic var gameId : String = ""
   
    
    
    override static func primaryKey() -> String? {
        return "gameId"
    }
    
}
