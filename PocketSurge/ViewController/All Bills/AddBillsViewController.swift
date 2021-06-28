//
//  AddBillsViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 29/06/21.
//

import UIKit

struct bills {
    static var Bill_title = [String]()
    static var Bill_category = [String]()
    static var Bill_amount = [String]()
    
}


class AddBillsViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var CategoryTextField: UITextField!
    var PickerView = UIPickerView()
    
    var category = ["Accommodation","Entertainment","Groceries","Restaurants","Transport"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.PickerView.isHidden = true
        self.TitleTextField.delegate = self
        self.AmountTextField.delegate = self
        self.CategoryTextField.delegate = self
        createPickerView()
        dismissPickerView()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if CategoryTextField.isFirstResponder{
            self.PickerView.isHidden = false
        }
    }
    

    @IBAction func DoneBtnOnPressed(_ sender: Any) {
       
        if TitleTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_TITLE)
        }
        else if CategoryTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_CATEGORY)
        }
        else if AmountTextField.text! == ""{
            self.presentAlert(withTitle: "", message: VALID_AMOUNT)
        }
        else{
            if ((TitleTextField.text?.isValidEmail) != nil) && CategoryTextField.text?.isEmpty != nil && AmountTextField.text?.isEmpty != nil {
                bills.Bill_title.append(TitleTextField.text!)
                bills.Bill_category.append(CategoryTextField.text!)
                bills.Bill_amount.append(AmountTextField.text!)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                
            }
        }
    }
    
    func createPickerView() {
        self.PickerView.delegate = self
        CategoryTextField.inputView = PickerView
        self.PickerView.reloadAllComponents()
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        CategoryTextField.inputAccessoryView = toolBar
        
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CategoryTextField.text = self.category[row]
        self.view.endEditing(true)
       
    }
    

}
