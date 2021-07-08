//
//  BillsTrackerViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit

class BillsTrackerViewController: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var NoBillsImage: UIImageView!
    @IBOutlet weak var AddBillsLbl: UILabel!
    
    //MARK:- Month array
    var Jan = [String]()
    var Feb = [String]()
    var Mar = [String]()
    var Apr = [String]()
    var May = [String]()
    var Jun = [String]()
    var Jul = [String]()
    var Aug = [String]()
    var Sep = [String]()
    var Oct = [String]()
    var Nov = [String]()
    var Dec = [String]()
    var months = [String]()

    //MARK:- Bill title array
    var Jan_title = [String]()
    var Feb_title = [String]()
    var Mar_title = [String]()
    var Apr_title = [String]()
    var May_title = [String]()
    var Jun_title = [String]()
    var Jul_title = [String]()
    var Aug_title = [String]()
    var Sep_title = [String]()
    var Oct_title = [String]()
    var Nov_title = [String]()
    var Dec_title = [String]()

    //MARK:- Date array
    var Jan_Date = [String]()
    var Feb_Date = [String]()
    var Mar_Date = [String]()
    var Apr_Date = [String]()
    var May_Date = [String]()
    var Jun_Date = [String]()
    var Jul_Date = [String]()
    var Aug_Date = [String]()
    var Sep_Date = [String]()
    var Oct_Date = [String]()
    var Nov_Date = [String]()
    var Dec_Date = [String]()
    var get_entries : BillsModel?
    var get_entries_data : [BillsData]?
    var month_billed = ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.3882352941, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        get_bills()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.459893465, green: 0.4559879899, blue: 0.3872475326, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
                    self.TableView.isHidden = true
                    self.NoBillsImage.isHidden = false
                    self.AddBillsLbl.isHidden = false
                }
                else{
                    self.get_entries_data?.forEach({ data in
                        //print(data.date)
                        let olDateFormatter = DateFormatter()
                        olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let oldDate = olDateFormatter.date(from: data.date)
                        let convertDateFormatter = DateFormatter()
                        convertDateFormatter.dateFormat = "MMMM"
                        self.month(month: convertDateFormatter.string(from: oldDate!), amount: data.amount, title_text:data.title, Date:data.date)
                    
                        
                    })
                    
                    self.TableView.isHidden = false
                    self.NoBillsImage.isHidden = true
                    self.AddBillsLbl.isHidden = true
                    //self.TableView.reloadData()
                    self.TableView.delegate = self
                    self.TableView.dataSource = self
                }
        
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_entries?.message ?? "")
            }
        }
    }

    
    
    func month(month:String, amount:String, title_text:String, Date:String){
        if self.month_billed[0] == month.uppercased(){
            Jan.append(amount)
            Jan_title.append(title_text)
            Jan_Date.append(Date)
        }
        if self.month_billed[1] == month.uppercased(){
            Feb.append(amount)
            Feb_title.append(title_text)
            Feb_Date.append(Date)
            
        }
        if self.month_billed[2] == month.uppercased(){
            Mar.append(amount)
            Mar_title.append(title_text)
            Mar_Date.append(Date)
           
        }
        if self.month_billed[3] == month.uppercased(){
            Apr.append(amount)
            Apr_title.append(title_text)
            Apr_Date.append(Date)
            
        }
        if self.month_billed[4] == month.uppercased(){
            May.append(amount)
            May_title.append(title_text)
            May_Date.append(Date)
            
        }
        if self.month_billed[5] == month.uppercased(){
            Jun.append(amount)
            Jun_title.append(title_text)
            Jun_Date.append(Date)
           
        }
        if self.month_billed[6] == month.uppercased(){
            Jul.append(amount)
            Jul_title.append(title_text)
            Jul_Date.append(Date)
        }
        if self.month_billed[7] == month.uppercased(){
            print(title_text)
            Aug.append(amount)
            Aug_title.append(title_text)
            Aug_Date.append(Date)
            
        }
        if self.month_billed[8] == month.uppercased(){
            Sep.append(amount)
            Sep_title.append(title_text)
            Sep_Date.append(Date)
            
        }
        if self.month_billed[9] == month.uppercased(){
            Oct.append(amount)
            Oct_title.append(title_text)
            Oct_Date.append(Date)
           
        }
        if self.month_billed[10] == month.uppercased(){
            Nov.append(amount)
            Nov_title.append(title_text)
            Feb_Date.append(Date)
           
        }
        if self.month_billed[11] == month.uppercased(){
            Dec.append(amount)
            Dec_title.append(title_text)
            Dec_Date.append(Date)
            
        }
        self.TableView.reloadData()
    }
   
}

extension BillsTrackerViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return month_billed.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return Jan.count
        }
        if section == 1{
            return Feb.count
        }
        if section == 2{
            return Mar.count
        }
        if section == 3{
            return Apr.count
        }
        if section == 4{
            return May.count
        }
        if section == 5{
            return Jun.count
        }
        if section == 6{
            return Jul.count
        }
        if section == 7{
            return Aug.count
        }
        if section == 8{
            return Sep.count
        }
        if section == 9{
            return Oct.count
        }
        if section == 10{
            return Nov.count
        }
        if section == 11{
            return Dec.count
        }
        else{
            return 0
        }
       
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = TableView.dequeueReusableCell(withIdentifier: "HeaderMonthTableViewCell") as! HeaderMonthTableViewCell
        cell.HeaderMonthLbl.text = month_billed[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillsTableViewCell", for: indexPath) as! BillsTableViewCell
        if indexPath.section == 0{
            cell.TitleLbl.text = Jan_title[indexPath.row]
            cell.CatLbl.text = Jan_Date[indexPath.row]
            cell.AmountLbl.text = (Jan[indexPath.row]) + "$"
        }
        else if indexPath.section == 1{
            cell.TitleLbl.text = Feb_title[indexPath.row]
            cell.CatLbl.text = Feb_Date[indexPath.row]
            cell.AmountLbl.text = (Feb[indexPath.row]) + "$"
        }
        else if indexPath.section == 2{
            cell.TitleLbl.text = Mar_title[indexPath.row]
            cell.CatLbl.text = Mar_Date[indexPath.row]
            cell.AmountLbl.text = (Mar[indexPath.row]) + "$"
        }
        else if indexPath.section == 3{
            cell.TitleLbl.text = Apr_title[indexPath.row]
            cell.CatLbl.text = Apr_Date[indexPath.row]
            cell.AmountLbl.text = (Apr[indexPath.row]) + "$"
        }
        else if indexPath.section == 4{
            cell.TitleLbl.text = May_title[indexPath.row]
            cell.CatLbl.text = May_Date[indexPath.row]
            cell.AmountLbl.text = (May[indexPath.row]) + "$"
        }
        else if indexPath.section == 5{
            cell.TitleLbl.text = Jun_title[indexPath.row]
            cell.CatLbl.text = Jun_Date[indexPath.row]
            cell.AmountLbl.text = (Jun[indexPath.row]) + "$"
        }
        else if indexPath.section == 6{
            cell.TitleLbl.text = Jul_title[indexPath.row]
            cell.CatLbl.text = Jul_Date[indexPath.row]
            cell.AmountLbl.text = (Jul[indexPath.row]) + "$"
        }
        else if indexPath.section == 7{
            cell.TitleLbl.text = Aug_title[indexPath.row]
            cell.CatLbl.text = Aug_Date[indexPath.row]
            cell.AmountLbl.text = (Aug[indexPath.row]) + "$"
        }
        else if indexPath.section == 8{
            cell.TitleLbl.text = Sep_title[indexPath.row]
            cell.CatLbl.text = Sep_Date[indexPath.row]
            cell.AmountLbl.text = (Sep[indexPath.row]) + "$"
        }
        else if indexPath.section == 9{
            cell.TitleLbl.text = Oct_title[indexPath.row]
            cell.CatLbl.text = Oct_Date[indexPath.row]
            cell.AmountLbl.text = (Oct[indexPath.row]) + "$"
        }
        else if indexPath.section == 10{
            cell.TitleLbl.text = Nov_title[indexPath.row]
            cell.CatLbl.text = Nov_Date[indexPath.row]
            cell.AmountLbl.text = (Nov[indexPath.row]) + "$"
        }
        else if indexPath.section == 11{
            cell.TitleLbl.text = Dec_title[indexPath.row]
            cell.CatLbl.text = Dec_Date[indexPath.row]
            cell.AmountLbl.text = (Dec[indexPath.row]) + "$"
        }
        
        
        return cell
    }
    
    
}


