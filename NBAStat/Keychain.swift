//
//  Keychain.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import Foundation
import KeychainSwift

class Keychain{
    var _key = KeychainSwift()
    
    var key : KeychainSwift {
        get{
            return _key
        }
        set {
            _key = newValue
        }
    }
}
