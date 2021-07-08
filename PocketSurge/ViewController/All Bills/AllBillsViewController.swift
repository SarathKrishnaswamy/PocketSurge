//
//  AllBillsViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit

class AllBillsViewController: UIViewController {

    //MARK:- Connection outlet
    @IBOutlet weak var PlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoBillsImage: UIImageView!
    @IBOutlet weak var AddBillsLbl: UILabel!
    
    //MARK:- Server Model
    var get_entries : BillsModel?
    var get_entries_data : [BillsData]?
    var get_category : CategoryModel?
    var get_category_data : [CategoryData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.231372549, green: 0.5529411765, blue: 0.5019607843, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tableView.tableFooterView = UIView()
        PlusBtn.layer.cornerRadius = PlusBtn.frame.width/2
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.231372549, green: 0.5529411765, blue: 0.5019607843, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        get_bills()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    //MARK:- Bills from server
    func get_bills(){
        let user_id = UserDefaults.standard.value(forKey: Key.UserDefaults.id) ?? ""
        let param = ["user_id":user_id]
        APiCall().upload(to: URL(string: URL.all_entries)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            print(response)
            self.get_entries = BillsModel(response)
            self.get_entries_data = self.get_entries?.bills_data
            if self.get_entries?.status == "200"{
                if self.get_entries_data?.count == 0{
                    self.tableView.isHidden = true
                    self.NoBillsImage.isHidden = false
                    self.AddBillsLbl.isHidden = false
                }
                else{
                    self.tableView.isHidden = false
                    self.NoBillsImage.isHidden = true
                    self.AddBillsLbl.isHidden = true
                    self.get_from_server()
                    
                }
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_entries?.message ?? "")
            }
        }
    }
    
    //MARK:- Get category
    func get_from_server(){
        let param = ["":""]
        APiCall().callAPi(strURL: URL.all_categories, methodType: "GET", postDictionary: param) { bool, response, int in
            //print(response)
            self.get_category = CategoryModel(response)
            if self.get_category?.status == "200"{
                self.get_category_data = self.get_category?.Category_Data
                self.tableView.reloadData()
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_category?.message ?? "")
            }
        }
    }
    
    //MARK:- Delete values
    func delete_value(entry_id : String){
        let param = ["entry_id": entry_id]
        APiCall().upload(to: URL(string: URL.delete_entry)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            print(response)
            let success = response["success"].stringValue
            let message = response["message"].stringValue
            if success == "200"{
                
                    self.tableView.isHidden = false
                    self.NoBillsImage.isHidden = true
                    self.AddBillsLbl.isHidden = true
                    self.get_bills()
                
            }
            else{
                self.presentAlert(withTitle: "Info", message: message)
            }
        }
    }

    
    //MARK:- Add bills Btn Connection
    @IBAction func AddBillsBtnOnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddBillsViewController") as! AddBillsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK:- TableView Delegate & Datasource
extension AllBillsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return get_entries_data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillsTableViewCell", for: indexPath) as! BillsTableViewCell
        let category_id :Int? = Int((self.get_entries_data?[indexPath.row].category_id)!)
        let category_name = self.get_category_data?[category_id!-1].category
        cell.TitleLbl.text = self.get_entries_data?[indexPath.row].title
        cell.CatLbl.text = category_name
        cell.AmountLbl.text = (get_entries_data?[indexPath.row].amount)! + "$"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                let entry_id = (self.get_entries_data?[indexPath.row].id)
                self.delete_value(entry_id: entry_id!)
                
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
        }

        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    
}


