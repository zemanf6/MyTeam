//
//  DetailViewController.swift
//  myTeamCode
//
//  Created by praxe on 28.05.19.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import SnapKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setTableView()
        setDetails()
        setValues()
    }
    func setValues() {
        setFaceOffs()
        setFaceOffText()
        setAttendace()
        setProgressAttendace()
        setPenaltiesAway()
        setPpGoalsAway()
        setPkGoalsAway()
        setPenaltiesHome()
        setPpGoalsHome()
        setPkGoalsHome()
        setPenaltiesText()
        setPpGoalsText()
        setPkGoalsText()
        setAttendanceText()
        setLine1()
        setLine2()
        setLine3()
    }
    var attendance: UILabel = UILabel()
    var progressAttendance: UIProgressView = UIProgressView()
    
    var penaltyAway: UILabel = UILabel()
    var ppGoalsAway: UILabel = UILabel()
    var pkGoalsAway: UILabel = UILabel()
    
    var penaltyHome: UILabel = UILabel()
    var ppGoalsHome: UILabel = UILabel()
    var pkGoalsHome: UILabel = UILabel()
    
    var attendanceText: UILabel = UILabel()
    var faceoffsText: UILabel = UILabel()
    var penaltiesText: UILabel = UILabel()
    var ppGoalsText: UILabel = UILabel()
    var pkGoalsText: UILabel = UILabel()
    
    var faceoffAway: MBCircularProgressBarView = MBCircularProgressBarView()
    var faceoffHome: MBCircularProgressBarView = MBCircularProgressBarView()
    
    
    var line1: UIView = UIView()
    var line2: UIView = UIView()
    var line3: UIView = UIView()
    
    var match: Match!
    
    
    var tableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeadCell
        cell.match = match
        cell.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        cell.selectionStyle = .none
        return cell
    }
    
    func setTableView() {
        tableView.register(HeadCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 120.0
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        self.title = "Match"
        tableView.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(190)
        }
    }
    func setDetails() {
        self.tableView.rowHeight = 120.0
        attendance.text = match?.attendance
        progressAttendance.transform = progressAttendance.transform.scaledBy(x: 1, y: 10)
        progressAttendance.progress = Float(match.attendance)! / Float(match.maxAttendance)!
        penaltyAway.text = match.awayTeam?.penalties
        ppGoalsAway.text = match.awayTeam?.ppGoals
        pkGoalsAway.text = match.awayTeam?.pkGoals
        
        penaltyHome.text = match.homeTeam?.penalties
        ppGoalsHome.text = match.homeTeam?.ppGoals
        pkGoalsHome.text = match.homeTeam?.pkGoals
        
        faceoffsText.text = "FACEOFFS"
        attendanceText.text = "ATTENDANCE"
        penaltiesText.text = "PENALTIES"
        ppGoalsText.text = "POWER-PLAY GOALS"
        pkGoalsText.text = "PENALTY-KILLING GOALS"
    }
    func setFaceOffs() {
        self.view.addSubview(faceoffAway)
        self.view.addSubview(faceoffHome)
        
        faceoffHome.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        faceoffHome.fontColor = UIColor.white
        faceoffHome.progressColor = UIColor(red: 213.0/255.0, green: 189.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        faceoffHome.progressStrokeColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        faceoffHome.valueFontSize = 35.0
        faceoffHome.valueFontName = "HelveticaNeue-Bold"
        faceoffHome.unitFontName = "HelveticaNeue-Bold"
        faceoffHome.unitFontSize = 25.0
        faceoffHome.emptyLineStrokeColor = UIColor(red: 43.0/255.0, green: 47.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        faceoffHome.progressLineWidth = 10
        
        faceoffAway.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        faceoffAway.fontColor = UIColor.white
        faceoffAway.progressColor = UIColor(red: 213.0/255.0, green: 189.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        faceoffAway.progressStrokeColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        faceoffAway.valueFontSize = 35.0
        faceoffAway.valueFontName = "HelveticaNeue-Bold"
        faceoffAway.unitFontName = "HelveticaNeue-Bold"
        faceoffAway.unitFontSize = 25.0
        faceoffAway.emptyLineStrokeColor = UIColor(red: 43.0/255.0, green: 47.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        faceoffAway.progressLineWidth = 10
        
        faceoffHome.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(280)
            
            
            make.width.equalTo(115)
            make.height.equalTo(115)
        }
        faceoffAway.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(280)
            make.width.equalTo(115)
            make.height.equalTo(115)
        }
        let awayNumbers = (match?.awayTeam?.faceOffs)?.components(separatedBy: "/")//20 40
        let homeNumbers = (match?.homeTeam?.faceOffs)?.components(separatedBy: "/")//20 40
        
        guard let awayN = NumberFormatter().number(from: awayNumbers?[0] ?? "") else {return}
        guard let homeN = NumberFormatter().number(from: homeNumbers?[0] ?? "") else {return}
        guard let max = NumberFormatter().number(from: awayNumbers?[1] ?? "") else {return}
        
        var awayPer: Double = 0
        var homePer: Double = 0
        if max == 0 {
            
        }
        else {
            awayPer = Double(truncating: awayN) / (Double(truncating: max) / 100)
            homePer = Double(truncating: homeN) / (Double(truncating: max) / 100)
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.faceoffAway.value = CGFloat(awayPer)
                self.faceoffHome.value = CGFloat(homePer)
            }, completion: nil)
            
            
            
        }
        faceoffHome.maxValue = 100
        faceoffAway.maxValue = 100
    }
    func setFaceOffText() {
        view.addSubview(faceoffsText)
        faceoffsText.textColor = UIColor.white
        faceoffsText.font = UIFont(name: "HelveticaNeue", size: 19.0)
        faceoffsText.snp.makeConstraints { (make) in
             make.centerX.equalToSuperview()
             make.top.equalToSuperview().offset(330)
        }
    }
    func setAttendace() {
        self.view.addSubview(attendance)
        attendance.textColor = UIColor.white
        attendance.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        attendance.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-300)
        }
    }
    func setAttendanceText() {
        self.view.addSubview(attendanceText)
        attendanceText.textColor = UIColor.white
        attendanceText.font = UIFont(name: "HelveticaNeue", size: 17.0)
        attendanceText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(attendance.snp.bottom).offset(-65)
        }
    }
    func setProgressAttendace() {
        self.view.addSubview(progressAttendance)
        progressAttendance.trackTintColor = UIColor(red: 42.0/255.0, green: 46.0/255.0, blue: 127.0/255.0, alpha: 1.0)
        progressAttendance.progressTintColor = UIColor(red: 213.0/255.0, green: 189.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        progressAttendance.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-250)
        }
    }
    func setPenaltiesAway() {
        self.view.addSubview(penaltyAway)
        penaltyAway.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        penaltyAway.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-160)
            make.right.equalToSuperview().offset(-25)
        }
    }
    func setPenaltiesText() {
        self.view.addSubview(penaltiesText)
        penaltiesText.textColor = UIColor.white
        penaltiesText.font = UIFont(name: "HelveticaNeue", size: 19.0)
        penaltiesText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-160)
        }
    }
    func setPpGoalsAway() {
        self.view.addSubview(ppGoalsAway)
        ppGoalsAway.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        ppGoalsAway.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-100)
            make.right.equalToSuperview().offset(-25)
        }
    }
    func setPpGoalsText() {
        self.view.addSubview(ppGoalsText)
        ppGoalsText.textColor = UIColor.white
        ppGoalsText.font = UIFont(name: "HelveticaNeue", size: 19.0)
        ppGoalsText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    func setPkGoalsAway() {
        self.view.addSubview(pkGoalsAway)
        pkGoalsAway.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        pkGoalsAway.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-25)
        }
    }
    func setPkGoalsText() {
        self.view.addSubview(pkGoalsText)
        pkGoalsText.textColor = UIColor.white
        pkGoalsText.font = UIFont(name: "HelveticaNeue", size: 19.0)
        pkGoalsText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    func setPenaltiesHome() {
        self.view.addSubview(penaltyHome)
        penaltyHome.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        penaltyHome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-160)
            make.left.equalToSuperview().offset(25)
        }
    }
    func setPpGoalsHome() {
        self.view.addSubview(ppGoalsHome)
        ppGoalsHome.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        ppGoalsHome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-100)
            make.left.equalToSuperview().offset(25)
        }
    }
    func setPkGoalsHome() {
        self.view.addSubview(pkGoalsHome)
        pkGoalsHome.textColor = UIColor(red: 250.0/255.0, green: 231.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        pkGoalsHome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview().offset(25)
        }
    }
    func setLine1() {
        self.view.addSubview(line1)
        line1.backgroundColor = UIColor(red: 102.0/255.0, green: 105.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        line1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    func setLine2() {
        self.view.addSubview(line2)
        line2.backgroundColor = UIColor(red: 102.0/255.0, green: 105.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        line2.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-140)
        }
    }
    func setLine3() {
        self.view.addSubview(line3)
        line3.backgroundColor = UIColor(red: 102.0/255.0, green: 105.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        line3.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
    }
}
