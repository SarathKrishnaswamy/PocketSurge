//
//  AddBillsViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 29/06/21.
//

import UIKit

//MARK:- Store the values in struct class
struct bills {
    static var Bill_title = [String]()
    static var Bill_category = [String]()
    static var Bill_amount = [String]()
    
}


class AddBillsViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK:- Connection outlet
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var CategoryTextField: UITextField!
    
    //MARK:- Server Model
    var get_category : CategoryModel?
    var get_category_data : [CategoryData]?
    var category_id : String!
    
    //MARK:- PickerView
    var PickerView = UIPickerView()
    
    //MARK:- Category Array
    var category = ["Accommodation","Entertainment","Groceries","Restaurants","Transport"]
    
    //MARK:- Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.PickerView.isHidden = true
        self.TitleTextField.delegate = self
        self.AmountTextField.delegate = self
        self.CategoryTextField.delegate = self
        createPickerView()
        dismissPickerView()
        get_from_server()
    }
    
    //MARK:- Get category
    func get_from_server(){
        let param = ["":""]
        APiCall().callAPi(strURL: URL.all_categories, methodType: "GET", postDictionary: param) { bool, response, int in
            print(response)
            self.get_category = CategoryModel(response)
            if self.get_category?.status == "200"{
                self.get_category_data = self.get_category?.Category_Data
                self.CategoryTextField.text = self.get_category_data?[0].category
                self.category_id = self.get_category_data?[0].id
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_category?.message ?? "")
            }
        }
    }
    
    //MARK:- Save In Id
    func save_bill_server(){
        let user_id = UserDefaults.standard.value(forKey: Key.UserDefaults.id) ?? ""
        let param = ["title":TitleTextField.text!, "category_id":self.category_id!, "amount":AmountTextField.text! , "user_id":user_id]
        APiCall().upload(to: URL(string: URL.add_entry)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            print(response)
            let success = response["success"].stringValue
            let message = response["message"].stringValue
            if success == "200"{
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.presentAlert(withTitle: "Info", message: message)
            }
        }
    }
    
    //MARK:- BeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if CategoryTextField.isFirstResponder{
            self.PickerView.isHidden = false
        }
    }
    
    //MARK:- Done BtnOn Pressed
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
                save_bill_server()
                
            }
            else{
                
            }
        }
    }
    
    //MARK:- Create Picker
    func createPickerView() {
        self.PickerView.delegate = self
        CategoryTextField.inputView = PickerView
        self.PickerView.reloadAllComponents()
    }
    
    //MARK:- Dismiss Picker
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
    
    //MARK:- Picker Delegate & datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.get_category_data?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.get_category_data?[row].category
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CategoryTextField.text = self.get_category_data?[row].category
        self.category_id = self.get_category_data?[row].id
        self.view.endEditing(true)
       
    }
    

}
