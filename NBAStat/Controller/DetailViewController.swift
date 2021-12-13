//
//  DetailViewController.swift
//  NBAStat
//
//  Created by fan on 12/8/21.
//

import UIKit


import RealmSwift
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var arrAllTeam : [TeamInfo] = [TeamInfo]()
    
    var team:[String:String] = [:]
    
    
    @IBAction func playerBtn(_ sender: Any) {
        performSegue(withIdentifier: "playerSegue", sender: self)
    }
    
    @IBAction func gameBtn(_ sender: Any) {
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "playerSegue" {
                let playerVC = segue.destination as! PlayerViewController
                playerVC.teamId = strLabel
            }
        
            if segue.identifier == "gameSegue" {
                let gameVC = segue.destination as! GameViewController
                gameVC.teamId = strLabel
            }
            
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TeamDetailTableViewCell", owner: self, options: nil)?.first as! TeamDetailTableViewCell


        let key = [String](team.keys)[indexPath.row]
        let val = team[key]!
        cell.lblTitle.text = key
        cell.lblInfo.text = val
        
        if key == "TeamId" {
            imgView.image = UIImage(named: String(val))
        }
        
        return cell
    }
    
    func loadCurrentConditions(){
            
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Read all the values from realm DB and fill up the arrCityInfo
        // for each city info het the city key and make a NW call to current NBAStat condition
        // wait for all the promises to be fulfilled
        // Once all the promises are fulfilled fill the arrCurrentNBAStat array
        // call for reload of tableView
        
        do{
            let realm = try Realm()
            let teams = realm.objects(TeamInfo.self)
            self.arrAllTeam = Array(teams)
            if self.arrAllTeam.count == 0 {
                getTeamInfo()
            }
            
       }catch{
           print("Error in reading Database \(error)")
       }
            
            
            
    }
    
    var strLabel: String?

    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        guard let strLabel = strLabel else {
            return
        }
        
        loadCurrentConditions()
        
        if arrAllTeam.count == 0 {
            return
        }
        
        for i in 0 ... arrAllTeam.count - 1 {
            if arrAllTeam[i].teamId == strLabel {
                let teamInfo = arrAllTeam[i]
                team["TeamId"] = teamInfo.teamId
                team["FullName"] = teamInfo.fullName
                team["NickName"] = teamInfo.nickName
                team["City"] = teamInfo.city
                team["Logo"] = teamInfo.logo
                team["ShortName"] = teamInfo.shortName
                team["ConfName"] = teamInfo.confName
                team["DivName"] = teamInfo.divName
            }
        }
        
        
        
        self.tblView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func addTeamInDB(_ teamInfo : TeamInfo){
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(teamInfo, update: .modified)
            }
        }catch{
            print("Error in getting values from DB \(error)")
        }
    }
    
    
    func getTeamInfo() -> Promise<TeamInfo>{
        return Promise<TeamInfo> { seal -> Void in
            let url = teamInfoURL
            let headers: HTTPHeaders = [
                "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
                "x-rapidapi-key": "9a33c20aabmshce606e8b286b1c4p100c92jsna5c1c2f4ef30"
            ]
            
            
            
            AF.request(url, headers: headers).responseJSON { response in
                
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                let teamInfo = TeamInfo()
                
                let teams = JSON(JSON(response.data!).dictionary!["api"]!["teams"]).array!
                
                
                for i in 0 ... teams.count - 1 {
                    if teams[i]["nbaFranchise"] == "1" {
                        let teamInfo = TeamInfo()
                        if teams[i]["teamId"] == "37" {
                            continue
                        }
                        teamInfo.city = teams[i]["city"].stringValue
                        teamInfo.nickName = teams[i]["nickname"].stringValue
                        teamInfo.fullName = teams[i]["fullName"].stringValue
                        teamInfo.shortName = teams[i]["shortName"].stringValue
                        teamInfo.logo = teams[i]["logo"].stringValue
                        teamInfo.teamId = teams[i]["teamId"].stringValue
                        teamInfo.divName = teams[i]["leagues"]["standard"]["divName"].stringValue
                        teamInfo.confName = teams[i]["leagues"]["standard"]["confName"].stringValue
                        self.addTeamInDB(teamInfo)
                        self.arrAllTeam.append(teamInfo)
                    }
                }
                
                
                for i in 0 ... self.arrAllTeam.count - 1 {
                    if self.arrAllTeam[i].teamId == self.strLabel {
                        let teamInfo = self.arrAllTeam[i]
                        self.team["TeamId"] = teamInfo.teamId
                        self.team["FullName"] = teamInfo.fullName
                        self.team["NickName"] = teamInfo.nickName
                        self.team["City"] = teamInfo.city
                        self.team["Logo"] = teamInfo.logo
                        self.team["ShortName"] = teamInfo.shortName
                        self.team["ConfName"] = teamInfo.confName
                        self.team["DivName"] = teamInfo.divName
                    }
                }
                
                
                
                self.tblView.reloadData()
                
                seal.fulfill(teamInfo)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
