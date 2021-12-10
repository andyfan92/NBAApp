//
//  FavoriteTeamTableViewCell.swift
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
import Firebase
import SwiftSpinner

class FavoriteTeamTableViewController
:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblView: UITableView!
    
    
    @IBAction func logout(_ sender: Any) {
        print("logout")
        do{
            try Auth.auth().signOut()
            Keychain().key.clear()
            
            performSegue(withIdentifier: "logoutSegue", sender: self)
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var arrAllTeam : [TeamInfo] = [TeamInfo]()
    
    var arrMyTeam : [TeamMeta] = [TeamMeta]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyTeam.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tblView.delegate = self
        tblView.dataSource = self
        loadCurrentConditions()
        loadMyFavoriteTeam()
        
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
    
       }catch{
           print("Error in reading Database \(error)")
       }
            
            
            
    }
    
    
    func loadMyFavoriteTeam(){
            
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Read all the values from realm DB and fill up the arrCityInfo
        // for each city info het the city key and make a NW call to current NBAStat condition
        // wait for all the promises to be fulfilled
        // Once all the promises are fulfilled fill the arrCurrentNBAStat array
        // call for reload of tableView
        
        do{
            let realm = try Realm()
            let teams = realm.objects(TeamMeta.self)
            self.arrMyTeam = Array(teams)
            print(self.arrMyTeam)
       }catch{
           print("Error in reading Database \(error)")
       }
            
            
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadMyFavoriteTeam()
        self.tblView.reloadData()
    }
    
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TeamTableViewCell", owner: self, options: nil)?.first as! TeamTableViewCell
        
        
        cell.lblTeam.text = arrMyTeam[indexPath.row].fullName
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblView.cellForRow(at: indexPath)
        tblView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "detailSegue", sender: cell)
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        self.deleteTeamInDB(arrMyTeam[indexPath.row])
        self.arrMyTeam.remove(at: indexPath.row)
        
        
        self.tblView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    
    func deleteTeamInDB(_ teamMeta : TeamMeta){
        do{
            let realm = try Realm()
            try realm.write {
                realm.delete(teamMeta)
            }
        }catch{
            print("Error in getting values from DB \(error)")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! TeamTableViewCell
            print(arrMyTeam[tblView.indexPath(for: cell)!.row].fullName)
            detailVC.strLabel = arrMyTeam[tblView.indexPath(for: cell)!.row].teamId
        }
            
    }
    
    
    
    
    
    
    
    
    
    

}
