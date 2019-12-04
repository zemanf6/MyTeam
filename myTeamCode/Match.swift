//
//  Match.swift
//  myTeamCode
//
//  Created by praxe on 28.05.19.
//  Copyright © 2019 Filip. All rights reserved.
//

import Foundation

class Match {
    
    public var typeOfMatch: String
    
    public var score: String
    public var round: String
    public var date: String
    public var time: String
    public var attendance: String
    public var maxAttendance: String
    
    public var homeTeam: Team?
    public var awayTeam: Team?
    
    
    init(dict: [String: Any]) {
        typeOfMatch = dict["type"] as? String ?? ""
        score = dict["score"] as? String ?? ""
        round = dict["roundText"] as? String ?? ""
        date = dict["dateStartText"] as? String ?? ""
        time = dict["timeStartText"] as? String ?? ""
        attendance = dict["attendance"] as? String ?? ""
        maxAttendance = dict["maxAttendance"] as? String ?? ""
        if let hmTeam = dict["homeTeam"] as? [String: Any] {
            homeTeam = Team(dict: hmTeam)
        }
        
        if let awTeam = dict["visitorTeam"] as? [String: Any] {
            awayTeam = Team(dict: awTeam)
        }
        
    }
}
