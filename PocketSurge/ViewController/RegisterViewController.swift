//
//  RegisterViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 25/06/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterHeading: UILabel!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    
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
    
    
    //MARK:- Initial setup
    func initailSetup(){
        self.RegisterBtn.layer.cornerRadius = 5.0
        self.RegisterBtn.titleLabel?.font = UIFont.getMediumFontWith(size: TITLE_MEDIUM)
        UsernameTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
        EmailTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
        PasswordTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
    }
    
    //MARK:- server
    func register_server(){
        let param = ["mail":EmailTextField.text! , "password":PasswordTextField.text!, "name":UsernameTextField.text! ] as [String : Any]
        APiCall().upload(to: URL(string: URL.register)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            print(response)
            let status = response["success"].stringValue
            let message = response["message"].stringValue
            let data = response["data"]
            let id = data["id"].stringValue
            let name = data["name"].stringValue
            //let mail = data["mail"].stringValue
            //let password = data["password"].stringValue
            
            if status == "200"{
                UserDefaults.standard.setValue(id, forKey: Key.UserDefaults.id)
                UserDefaults.standard.setValue(name, forKey: Key.UserDefaults.name)
                UserDefaults.standard.setValue(true, forKey: Key.UserDefaults.alreadyLogin)
                UserDefaults.standard.synchronize()
                self.dashboard()
            }
            else if status == "201"{
                self.presentAlert(withTitle: "Info", message: message)
            }
        }
    }
    
    //MARK:- Call dashboard page
    func dashboard(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func RegisterBtnOnPressed(_ sender: Any) {
        if EmailTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_EMAIL_ALERT)
        }
        else if UsernameTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_USERNAME_ALERT)
        }
        else if PasswordTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_PWD_ALERT)
        }
        else{
            if ((EmailTextField.text?.isValidEmail) != nil) && PasswordTextField.text?.isEmpty != nil && UsernameTextField.text != nil {
                
                if EmailTextField.text?.isValidEmail == true{
                    if PasswordTextField.text!.count > 5{
                       register_server()
                   }
                   else{
                       self.presentAlert(withTitle: "Password Alert", message: "Please enter your password more than 5 characters")
                   }
                }
                else{
                    self.presentAlert(withTitle: "Email Alert", message: "Please Enter valid email Address")
                }
                
                
                
            }else{
                self.presentAlert(withTitle: "", message: VALID_PWD_EMAIL)
            }
        }
    }
    
    
    @IBAction func LoginBtnOnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
