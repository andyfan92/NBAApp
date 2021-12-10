//
//  ViewController.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import UIKit
import Firebase
import SwiftSpinner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
            let keychain = Keychain().key
            
            if keychain.get("uid") != nil {
                performSegue(withIdentifier: "loggedInSegue", sender: self)
            }
    }

    
    
    
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        
                let  email = txtUsername.text;
                let password = txtPassword.text
                
                if email?.count == 0 || email?.isValidEmail == false  {
                    lblStatus.text = " Please enter a valid Email"
                    return
                }

                if password?.count ??  0 < 5 {
                    lblStatus.text = "Please enter a valid password"
                    return
                }
                
                SwiftSpinner.show("Logging in...")
                Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
                    SwiftSpinner.hide(nil)
                    
                    guard let self = self else { return }
                    
                    if error != nil {
                        self.lblStatus.text =  error?.localizedDescription
                        return
                    }
                    let uid = Auth.auth().currentUser?.uid
                    self.txtPassword.text = ""
                    Keychain().key.set(uid!, forKey: "uid" )
                    
                    self.performSegue(withIdentifier: "loggedInSegue", sender: self)

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

extension String{
    var isValidEmail : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
