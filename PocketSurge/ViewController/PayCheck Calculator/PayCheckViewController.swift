//
//  PayCheckViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit

class PayCheckViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var PayRateTextField: UITextField!
    @IBOutlet weak var HourlyWorkedTextField: UITextField!
    @IBOutlet weak var CalculateBtn: UIButton!
    @IBOutlet weak var PaycheckLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5609527826, green: 0.6176843643, blue: 0.6621069312, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        CalculateBtn.layer.cornerRadius = 6.0
        self.PayRateTextField.delegate = self
        self.HourlyWorkedTextField.delegate = self
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5609527826, green: 0.6176843643, blue: 0.6621069312, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    
    
    @IBAction func CalculateBtnOnPressed(_ sender: Any) {
        if PayRateTextField.text == "" && HourlyWorkedTextField.text == ""{
            PaycheckLbl.text = "0.0$"
        }else{
            calculate()
        }
        
    }
    
    func calculate(){
        let a = Float(PayRateTextField.text!)!
        let b = Float(HourlyWorkedTextField.text!)!
        let c = (a) * (b)
        PaycheckLbl.text = String(Double(c)) + "$"
    }
}
