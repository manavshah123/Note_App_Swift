//
//  ViewController.swift
//  Login_app
//
//  Created by user214343 on 2/4/22.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {

    @IBOutlet weak var buttonlogin: UIButton!
    @IBOutlet weak var usertext: UITextField!
    @IBOutlet weak var userpass: UITextField!
    
    var emailId : String?
    var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func loginButton(_ sender: Any) {
        emailId = usertext.text
        password = userpass.text
        UserDefaults.standard.set(usertext.text, forKey: "Key") //setObject
        if emailId == "email" && password == "1234" {
           guard let vc = storyboard?.instantiateViewController(identifier: "bookViewController") as? BookViewController else {
               print("ViewController not found")
               return
           }
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            print("Incorrect Email ID or Password")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let lastEmail = UserDefaults.standard.string(forKey: "Key")
         usertext.text = lastEmail
    }

}
