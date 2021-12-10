//
//  AllTeamViewController.swift
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

class AllTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let teams:[String:String] = ["1":"Atlanta Hawks", "2":"Boston Celtics", "4":"Brooklyn Nets", "5": "Charlotte Hornets",
                                    "6": "Chicago Bulls",
                                    "7": "Cleveland Cavaliers",
                                    "8": "Dallas Mavericks",
                                    "9": "Denver Nuggets",
                                    "10": "Detroit Pistons",
                                    "11": "Golden State Warriors",
                                    "14": "Houston Rockets",
                                    "15": "Indiana Pacers",
                                    "16": "LA Clippers",
                                    "17": "Los Angeles Lakers",
                                    "19": "Memphis Grizzlies",
                                    "20": "Miami Heat",
                                    "21": "Milwaukee Bucks",
                                    "22": "Minnesota Timberwolves",
                                    "23": "New Orleans Pelicans",
                                    "24": "New York Knicks",
                                    "25": "Oklahoma City Thunder",
                                    "26": "Orlando Magic",
                                    "27": "Philadelphia 76ers",
                                    "28": "Phoenix Suns",
                                    "29": "Portland Trail Blazers",
                                    "30": "Sacramento Kings",
                                    "31": "San Antonio Spurs",
                                    "38": "Toronto Raptors",
                                    "40": "Utah Jazz",
                                    "41": "Washington Wizards"]
    
    let ids:[String] = ["1", "2", "4", "5",
                        "6","7",
                        "8",
                        "9",
                        "10",
                        "11",
                        "14",
                        "15",
                        "16",
                        "17",
                        "19",
                        "20",
                        "21",
                        "22",
                        "23",
                        "24",
                        "25",
                        "26",
                        "27",
                        "28",
                        "29",
                        "30",
                        "31",
                        "38",
                        "40",
                        "41"]
    
    let teamName:[String] = ["Atlanta Hawks", "Boston Celtics", "Brooklyn Nets", "Charlotte Hornets",
                                    "Chicago Bulls",
                                    "Cleveland Cavaliers",
                                    "Dallas Mavericks",
                                    "Denver Nuggets",
                                    "Detroit Pistons",
                                    "Golden State Warriors",
                                    "Houston Rockets",
                                    "Indiana Pacers",
                                    "LA Clippers",
                                    "Los Angeles Lakers",
                                    "Memphis Grizzlies",
                                    "Miami Heat",
                                    "Milwaukee Bucks",
                                    "Minnesota Timberwolves",
                                    "New Orleans Pelicans",
                                    "New York Knicks",
                                    "Oklahoma City Thunder",
                                    "Orlando Magic",
                                    "Philadelphia 76ers",
                                    "Phoenix Suns",
                                    "Portland Trail Blazers",
                                    "Sacramento Kings",
                                    "San Antonio Spurs",
                                    "Toronto Raptors",
                                    "Utah Jazz",
                                    "Washington Wizards"]
    
    
  
    
    @IBOutlet weak var tblView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    
    
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TeamTableViewCell", owner: self, options: nil)?.first as! TeamTableViewCell
        
//        cell.selectionStyle = .none
        
        
        let key = ids[indexPath.row]
        
        cell.lblTeam.text = teams[key]
        
        
        
        
//        cell.backgroundColor = UIColor(red: 0.37, green: 0.36, blue: 0.90, alpha: 1.00)
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = ids[indexPath.row]
        let teamName = teams[key]
        let teamMeta = TeamMeta()
        teamMeta.teamId = key
        teamMeta.fullName = teamName!
        addTeamInDB(teamMeta)
        _ = navigationController?.popViewController(animated: true)
        
        
        
        
    }
    
    
    func addTeamInDB(_ teamMeta : TeamMeta){
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(teamMeta, update: .modified)
            }
        }catch{
            print("Error in getting values from DB \(error)")
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.delegate = self
        tblView.dataSource = self

        
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
