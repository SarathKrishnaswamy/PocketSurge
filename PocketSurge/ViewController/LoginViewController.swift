//
//  ViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 25/06/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LoginHeading: UILabel!
    @IBOutlet weak var Loginbtn: UIButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initailSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initailSetup(){
        self.Loginbtn.layer.cornerRadius = 5.0
        self.Loginbtn.titleLabel?.font = UIFont.getMediumFontWith(size: TITLE_MEDIUM)
        EmailTextField.font = UIFont.getMediumFontWith(size: TEXT_SMALL)
        PasswordTextField.font = UIFont.getMediumFontWith(size: TEXT_SMALL)

    }
    
    func dashboard(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func RegisterBtnOnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func LoginBtnOnPressed(_ sender: Any) {
        
        if EmailTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_EMAIL_ALERT)
        }
        else if PasswordTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_PWD_ALERT)
        }
        else{
            if ((EmailTextField.text?.isValidEmail) != nil) && PasswordTextField.text?.isEmpty != nil{
                dashboard()
                
            }else{
                self.presentAlert(withTitle: "", message: VALID_PWD_EMAIL)
            }
        }
        
    }
    
    
}

