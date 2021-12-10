//
//  PlayerViewController.swift
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

class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllPlayer.count
    }
    
    @IBOutlet weak var tblView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PlayerTableViewCell", owner: self, options: nil)?.first as! PlayerTableViewCell
        let playerInfo = arrAllPlayer[indexPath.row]
        cell.affiliationlbl.text = "Affiliation: " + playerInfo.affiliation
        cell.collegeNamelbl.text = "College: " + playerInfo.collegeName
        cell.fullNamelbl.text = "Name: " + playerInfo.firstName + " " + playerInfo.lastName
        cell.yearsProlbl.text = "Year: " + playerInfo.yearsPro
        cell.heightlbl.text = "Height: " + playerInfo.heightInMeters
        cell.weightlbl.text = "Weight: " + playerInfo.weightInKilograms
        
//        cell.selectionStyle = .none
//        cell.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
        



        
        return cell
    }
    
    
    
    var teamId: String?
    
    var arrAllPlayer : [PlayerInfo] = [PlayerInfo]()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        getPlayerInfo(teamId!)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getPlayerInfo(_ teamId: String) -> Promise<PlayerInfo>{
        
        SwiftSpinner.show("Fetching data...")
        return Promise<PlayerInfo> { seal -> Void in
            let url = payerInfoURL + teamId
            let headers: HTTPHeaders = [
                "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
                "x-rapidapi-key": "9a33c20aabmshce606e8b286b1c4p100c92jsna5c1c2f4ef30"
            ]
            
            
            
            AF.request(url, headers: headers).responseJSON { response in
                
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                
                let playerInfo = PlayerInfo()
                
                
                
                let players = JSON(JSON(response.data!).dictionary!["api"]!["players"]).array!


                for i in 0 ... players.count - 1 {
                    
                    let playerInfo = PlayerInfo()
                        
                    playerInfo.teamId = players[i]["teamId"].stringValue
                    playerInfo.playerId = players[i]["playerId"].stringValue
                    playerInfo.affiliation = players[i]["affiliation"].stringValue
                    playerInfo.country = players[i]["country"].stringValue
                    playerInfo.firstName = players[i]["firstName"].stringValue
                    playerInfo.lastName = players[i]["lastName"].stringValue
                    playerInfo.collegeName = players[i]["collegeName"].stringValue
                    playerInfo.heightInMeters = players[i]["heightInMeters"].stringValue
                    playerInfo.startNba = players[i]["startNba"].stringValue
                    playerInfo.weightInKilograms = players[i]["weightInKilograms"].stringValue
                    playerInfo.dateOfBirth = players[i]["dateOfBirth"].stringValue
                    playerInfo.yearsPro = players[i]["yearsPro"].stringValue
                        
                    self.arrAllPlayer.append(playerInfo)
                    
                }
                
                print(self.arrAllPlayer)
                
                self.tblView.reloadData()
                
                SwiftSpinner.hide()
                
                seal.fulfill(playerInfo)
                
            }
        }
    }
    

}
