//
//  Team.swift
//  myTeamCode
//
//  Created by praxe on 28.05.19.
//  Copyright © 2019 Filip. All rights reserved.
//

import Foundation

class Team {
    
    public var logo: String
    public var shortcut: String
    
    public var faceOffs: String
    public var penalties: String
    public var ppGoals: String
    public var pkGoals: String
    
    init(dict: [String: Any]) {
        logo = (dict["logo"] as? [String:Any])?["urlS"] as? String ?? ""
        shortcut = dict["shortcut"] as? String ?? ""
        faceOffs = dict["faceoffs"] as? String ?? ""
        penalties = dict["penalty"] as? String ?? ""
        ppGoals = dict["ppGoals"] as? String ?? ""
        pkGoals = dict["shGoals"] as? String ?? ""
    }
}
