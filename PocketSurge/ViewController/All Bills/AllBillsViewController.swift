//
//  AllBillsViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit

class AllBillsViewController: UIViewController {

    @IBOutlet weak var PlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoBillsImage: UIImageView!
    @IBOutlet weak var AddBillsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.231372549, green: 0.5529411765, blue: 0.5019607843, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tableView.tableFooterView = UIView()
        PlusBtn.layer.cornerRadius = PlusBtn.frame.width/2
        if bills.Bill_title.count == 0{
            self.tableView.isHidden = true
            self.NoBillsImage.isHidden = false
            self.AddBillsLbl.isHidden = false
        }
        else{
            self.tableView.isHidden = false
            self.NoBillsImage.isHidden = true
            self.AddBillsLbl.isHidden = true
            self.tableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.231372549, green: 0.5529411765, blue: 0.5019607843, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        if bills.Bill_title.count == 0{
            self.tableView.isHidden = true
            self.NoBillsImage.isHidden = false
            self.AddBillsLbl.isHidden = false
        }
        else{
            self.tableView.isHidden = false
            self.NoBillsImage.isHidden = true
            self.AddBillsLbl.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }


    @IBAction func AddBillsBtnOnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddBillsViewController") as! AddBillsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension AllBillsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.Bill_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillsTableViewCell", for: indexPath) as! BillsTableViewCell
        cell.TitleLbl.text = bills.Bill_title[indexPath.row]
        cell.CatLbl.text = bills.Bill_category[indexPath.row]
        cell.AmountLbl.text = bills.Bill_amount[indexPath.row] + "$"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                if bills.Bill_title.count > 0{
                    bills.Bill_title.remove(at: indexPath.row)
                    bills.Bill_category.remove(at: indexPath.row)
                    bills.Bill_amount.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
                if bills.Bill_title.count == 0{
                    self.tableView.isHidden = true
                    self.NoBillsImage.isHidden = false
                    self.AddBillsLbl.isHidden = false
                }
                else{
                    self.tableView.isHidden = false
                    self.NoBillsImage.isHidden = true
                    self.AddBillsLbl.isHidden = true
                    self.tableView.reloadData()
                }
                
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
        }

        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    
}


