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
    func initailSetup(){
        self.RegisterBtn.layer.cornerRadius = 5.0
        self.RegisterBtn.titleLabel?.font = UIFont.getMediumFontWith(size: TITLE_MEDIUM)
        UsernameTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
        EmailTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
        PasswordTextField.font =  UIFont.getMediumFontWith(size: TEXT_SMALL)
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
                
            }else{
                self.presentAlert(withTitle: "", message: VALID_PWD_EMAIL)
            }
        }
    }
    
    
    @IBAction func LoginBtnOnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
