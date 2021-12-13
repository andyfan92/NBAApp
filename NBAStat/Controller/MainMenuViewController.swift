//
//  SecondViewController.swift
//  NBAStat
//
//  Created by fan on 12/10/21.
//

import UIKit

import Firebase
import SwiftSpinner

import RealmSwift
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit


class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            Keychain().key.clear()
            self.navigationController?.popViewController(animated: true)
            
        }catch{
            print(error.localizedDescription)
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
