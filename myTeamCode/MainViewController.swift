//
//  MainViewController.swift
//  myTeamCode
//
//  Created by praxe on 28.05.19.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView = UITableView()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        setTableView()
        loadData()
    }
    
    var matches: [Match] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeadCell
        cell.match = matches[indexPath.row]
        cell.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
    func loadData() {
        request("http://vps1.hczlin.cz/api/v1/games").responseJSON { (response)  in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseDatas = responseValue["data"] as! [[String: Any]]? {
                    self.prepareData(dict: responseDatas)
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func prepareData(dict: [[String: Any]] ) {
        for i in dict {
            let match: Match = Match(dict: i)
            matches.append(match)
        }
        matches.reverse()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = DetailViewController()
        let selectedRow = matches[indexPath.row]
        newViewController.match = selectedRow
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func setTableView() {
        self.tableView.rowHeight = 120.0
        tableView.allowsSelection = true
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 232.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        self.title = "Matches"
        tableView.backgroundColor = UIColor(red: 59.0/255.0, green: 63.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.bounces = false
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0) //88
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
        }
        tableView.register(HeadCell.classForCoder(), forCellReuseIdentifier: "cell")
    }

    

}
