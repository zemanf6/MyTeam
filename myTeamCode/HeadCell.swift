//
//  HeadCell.swift
//  myTeamCode
//
//  Created by praxe on 28.05.19.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SnapKit

class HeadCell: UITableViewCell {
    var match: Match? {
        didSet {
            updateView()
        }
    }
    var round: UILabel = UILabel()
    var date: UILabel = UILabel()
    var score: UILabel = UILabel()
    
    var shortcutAway: UILabel = UILabel()
    var shortcutHome: UILabel = UILabel()
    
    var imageHome: UIImageView = UIImageView()
    var ImageAway: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func prepareData() {
        prepareDateLabel()
        prepareRoundLabel()
        prepareScoreLabel()
        prepareShortcutHome()
        prepareShortcutAway()
        prepareImageAway()
        prepareImageHome()
    }
    func prepareDateLabel() {
        self.addSubview(date)
        date.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
        date.textColor = UIColor(red: 213.0/255.0, green: 189.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        date.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(45)
            
        }
    }
    func prepareRoundLabel() {
        self.addSubview(round)
        round.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
        round.textColor = UIColor.white
        round.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(17)
        }
    }
    func prepareScoreLabel() {
        self.addSubview(score)
        score.textColor = UIColor.white
        score.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
        score.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    func prepareShortcutHome() {
        self.addSubview(shortcutHome)
        shortcutHome.textColor = UIColor.white
        shortcutHome.font = UIFont(name: "HelveticaNeue", size: 19)
        shortcutHome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(30)
        }
    }
    func prepareShortcutAway() {
        self.addSubview(shortcutAway)
        shortcutAway.font = UIFont(name: "HelveticaNeue", size: 19)
        shortcutAway.textColor = UIColor.white
        shortcutAway.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-30)
        }
    }
    let size = CGSize(width: 60.0, height: 60.0)
    
    func prepareImageHome() {
        self.addSubview(imageHome)
        imageHome.snp.makeConstraints { (make) in
            make.width.height.equalTo(size)
            make.left.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-45)
        }
    }
    func prepareImageAway() {
        self.addSubview(ImageAway)
        ImageAway.snp.makeConstraints { (make) in
            make.width.height.equalTo(size)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-45)
        }
        
    }
    func updateView() {
        round.text = match?.round
        date.text = match?.date
        score.text = match?.score
        shortcutHome.text = match?.homeTeam?.shortcut
        shortcutAway.text = match?.awayTeam?.shortcut
        
        
        
        request(match?.awayTeam?.logo ?? "").responseImage { (response) in
            print(response)
            if let image = response.result.value {
                let ScaledImg = image.af_imageAspectScaled(toFit: self.size)
                DispatchQueue.main.async {
                    self.ImageAway.image = ScaledImg
                }
            }
        }
        
        request(match?.homeTeam?.logo ?? "").responseImage { (response) in
            print(response)
            if let image = response.result.value {
                let scaledImg = image.af_imageAspectScaled(toFit: self.size)
                DispatchQueue.main.async {
                    self.imageHome.image = scaledImg
                }
            }
        }
    }
}
