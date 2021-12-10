//
//  GameViewController.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import UIKit

import RealmSwift
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllGame.count
    }
    
    @IBOutlet weak var tblView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("GameTableViewCell", owner: self, options: nil)?.first as! GameTableViewCell
        
        cell.hTeamlbl.text = arrAllGame[indexPath.row].hTeam
        cell.vTeamlbl.text = arrAllGame[indexPath.row].vTeam
        cell.hTeamScorelbl.text = arrAllGame[indexPath.row].hTeamScore
        cell.vTeamScorelbl.text = arrAllGame[indexPath.row].vTeamScore
        cell.timelbl.text = arrAllGame[indexPath.row].time
        
        
        return cell
    }
    
    
    
    var teamId: String?
    
    var arrAllGame : [GameInfo] = [GameInfo]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        getGameInfo(teamId!)
        // Do any additional setup after loading the view.
    }
    
    
    func getGameInfo(_ teamId: String) -> Promise<GameInfo>{
        return Promise<GameInfo> { seal -> Void in
            let url = gameInfoURL + teamId
            let headers: HTTPHeaders = [
                "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
                "x-rapidapi-key": "9a33c20aabmshce606e8b286b1c4p100c92jsna5c1c2f4ef30"
            ]
            
            SwiftSpinner.show("Fetching data...")
            
            AF.request(url, headers: headers).responseJSON { response in
                
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                
                
                let gameInfo = GameInfo()
                
                
                
                var games = JSON(JSON(response.data!).dictionary!["api"]!["games"]).array!
                games = Array(games.suffix(150))
                games.reverse()
                

                for i in 0 ... games.count - 1 {
                    
                    let gameInfo = GameInfo()
                    
                    if games[i]["statusGame"].stringValue == "Finished" {
                        var time = self.transformTime(games[i]["startTimeUTC"].stringValue)
                        
                        
                        gameInfo.time = time
                        gameInfo.vTeam = games[i]["vTeam"]["fullName"].stringValue
                        gameInfo.hTeam = games[i]["hTeam"]["fullName"].stringValue
                        gameInfo.vTeamScore = games[i]["vTeam"]["score"]["points"].stringValue
                        gameInfo.hTeamScore = games[i]["hTeam"]["score"]["points"].stringValue
                        
                        self.arrAllGame.append(gameInfo)
                        
                    }
                        
                   
                    
                        
                    
                    
                }
                
                
                
                
                
                self.tblView.reloadData()
                
                SwiftSpinner.hide()
                
                seal.fulfill(gameInfo)
                
            }
        }
    }
    
    
    func transformTime(_ localTime : String) -> String{
    //        2021-10-29T16:34:00-07:00
        
        let endIndex = localTime.firstIndex(of: "T")!
        return String(localTime[...endIndex].dropLast())
        
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
