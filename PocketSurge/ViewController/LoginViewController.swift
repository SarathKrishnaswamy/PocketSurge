//
//  ViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 25/06/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    //MARK:- Connection Outlet
    @IBOutlet weak var LoginHeading: UILabel!
    @IBOutlet weak var Loginbtn: UIButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide navigation bar
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
        self.Loginbtn.layer.cornerRadius = 5.0
        self.Loginbtn.titleLabel?.font = UIFont.getMediumFontWith(size: TITLE_MEDIUM)
        EmailTextField.font = UIFont.getMediumFontWith(size: TEXT_SMALL)
        PasswordTextField.font = UIFont.getMediumFontWith(size: TEXT_SMALL)

    }
    
    func login_server(){
        let param = ["mail":EmailTextField.text! , "password":PasswordTextField.text! ] as [String : Any]
        let headers: HTTPHeaders = ["Content-Type": "text/html; charset=utf-8"]
        AF.request(URL.login, method: .post, parameters: param, encoding:JSONEncoding.default, headers:headers).validate().responseJSON(completionHandler: {
            respones in
            print(URL.login)
            print(param)
            switch respones.result {
            case .success( let value):
                
                let json  = value
                print(json)
                break;
                
            case .failure(let error):
                debugPrint(error)
            }
        })
            
                                                                                                                                        
                                                                
       
    }
    
    
    func postAction() {
        let param = ["mail":EmailTextField.text! , "password":PasswordTextField.text!]
        APiCall().upload(to: URL(string: URL.login)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            //print(response)
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
            
           /* print(status)
            print(message)
            print(id)
            print(name)
            print(mail)
            print(password)*/
        }
    }
    
    //MARK:- Call dashboard page
    func dashboard(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    //MARK:- Register button connection
    @IBAction func RegisterBtnOnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Login button connection
    @IBAction func LoginBtnOnPressed(_ sender: Any) {
        
        if EmailTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_EMAIL_ALERT)
        }
        else if PasswordTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_PWD_ALERT)
        }
        else{
            if ((EmailTextField.text?.isValidEmail) != nil) && PasswordTextField.text?.isEmpty != nil{
                postAction()
            }else{
                self.presentAlert(withTitle: "", message: VALID_PWD_EMAIL)
            }
        }
        
    }
    
    
}

