//
//  BudgetBreakDownViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit
import Charts

class BudgetBreakDownViewController: UIViewController,ChartViewDelegate {
    //MARK:- Connection outlet
    
    @IBOutlet weak var Piechart: PieChartView!
    @IBOutlet weak var TableView: UITableView!
   
    //MARK:- Server Model
    var get_entries : BillsModel?
    var get_entries_data : [BillsData]?
    var get_category : CategoryModel?
    var get_category_data : [CategoryData]?
    
    
    var bill_amount_1 = [Float]()
    var internet_sum_value = Float()
    
    var bill_amount_2 = [Float]()
    var food_sum_value = Float()
    
    var bill_amount_3 = [Float]()
    var gadgets_sum_value = Float()
    
    var bill_amount_4 = [Float]()
    var transport_sum_value = Float()
    
    var bill_amount_5 = [Float]()
    var renewals_sum_value = Float()
    
    var total_value = Float()
    
    var sample_value = [1.75555]
    
    var category = [String]()
    //MARK:- variable
   
    //var category = ["Accommodation","Entertainment","Groceries","Restaurants","Transport"]
    var category_image = [UIImage(systemName: "globe"),UIImage(named: "food"),UIImage(systemName: "ipad"),UIImage(systemName: "bus"),UIImage(named: "renewals")]
    //var entries : [PieChartDataEntry] = NSArray() as! [PieChartDataEntry]
    var cat_colors: [UIColor] = []
    var category_color = [#colorLiteral(red: 0.2050859332, green: 0.5914066434, blue: 0.9727563262, alpha: 1), #colorLiteral(red: 0.2392156863, green: 0.5450980392, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.516361177, green: 0.5748247504, blue: 0.3790351152, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) ]
    var category_price = ["0$","0$","0$","0$","0$"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2050859332, green: 0.5914066434, blue: 0.9727563262, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        get_from_server()
       
        Piechart.delegate = self
        self.TableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.5921568627, blue: 0.9725490196, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK:- Get category
    func get_from_server(){
        let param = ["":""]
        APiCall().callAPi(strURL: URL.all_categories, methodType: "GET", postDictionary: param) { bool, response, int in
            //print(response)
            self.get_category = CategoryModel(response)
            if self.get_category?.status == "200"{
                self.get_category_data = self.get_category?.Category_Data
                self.get_bills()
                self.get_category_data?.forEach({ data in
                    self.category.append(data.category)
                })
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_category?.message ?? "")
            }
        }
    }
    
    //MARK:- Bills from server
    func get_bills(){
        let user_id = UserDefaults.standard.value(forKey: Key.UserDefaults.id) ?? ""
        let param = ["user_id":user_id]
        APiCall().upload(to: URL(string: URL.all_entries)!, params: param, imageData: nil, filename: "", documentData: nil) { bool, response in
            //print(response)
            self.get_entries = BillsModel(response)
            self.get_entries_data = self.get_entries?.bills_data
            if self.get_entries?.status == "200"{
                
                if self.get_entries_data?.count == 0{
                    self.TableView.isHidden = true
                }
                else{
                    self.TableView.reloadData()
                    self.TableView.delegate = self
                    self.TableView.dataSource = self
                    self.get_entries_data?.forEach({ bills in
                        //print(bills.category_id)
                        
                        if bills.category_id == "1"{
                            //print(bills.amount)
                            self.bill_amount_1.append(Float(bills.amount)!)
                            print(self.bill_amount_1)
                            let sum = self.bill_amount_1.reduce(0, +)
                            self.internet_sum_value = sum
                        }
                        
                        if bills.category_id == "2"{
                            //print(bills.amount)
                            self.bill_amount_2.append(Float(bills.amount)!)
                            print(self.bill_amount_2)
                            let sum = self.bill_amount_2.reduce(0, +)
                            self.food_sum_value = sum
                        }
                        
                        
                        
                        if bills.category_id == "3"{
                            //print(bills.amount)
                            self.bill_amount_3.append(Float(bills.amount)!)
                            print(self.bill_amount_3)
                            let sum = self.bill_amount_3.reduce(0, +)
                            self.gadgets_sum_value = sum
                        }
                        
                        if bills.category_id == "4"{
                            //print(bills.amount)
                            self.bill_amount_4.append(Float(bills.amount)!)
                            print(self.bill_amount_4)
                            let sum = self.bill_amount_4.reduce(0, +)
                            self.transport_sum_value = sum
                        }
                        
                        if bills.category_id == "5"{
                            //print(bills.amount)
                            self.bill_amount_5.append(Float(bills.amount)!)
                            print(self.bill_amount_5)
                            let sum = self.bill_amount_5.reduce(0, +)
                            self.renewals_sum_value = sum
                        }
                        
                        self.total_value =  self.internet_sum_value +  self.food_sum_value +  self.gadgets_sum_value +  self.transport_sum_value +  self.renewals_sum_value
                        print(self.total_value)
                        
                        let value_1 = Double(self.internet_sum_value/self.total_value)*100
                        //self.entries.append(PieChartDataEntry(value:  value_1))
                        
                        let value_2 = Double(self.food_sum_value/self.total_value)*100
                        print(Double(value_2))
                        //self.entries.append(PieChartDataEntry(value:  value_2))
                        
                        let value_3 = Double(self.gadgets_sum_value/self.total_value)*100
                        print(Double(value_3))
                        //self.entries.append(PieChartDataEntry(value:  value_3))
                        
                        let value_4 = Double(self.transport_sum_value/self.total_value)*100
                        print(Double(value_4))
                        //self.entries.append(PieChartDataEntry(value:  value_4))
                        
                        let value_5 = Double(self.renewals_sum_value/self.total_value)*100
                        print(Double(value_5))
                        //self.entries.append(PieChartDataEntry(value:  value_5))
                        self.setDataCount(value_1: value_1, value_2: value_2, value_3: value_3, value_4: value_4, value_5: value_5)
                        
                        
                        
                    })
                    
                }
                
               
            
            }
            else{
                self.presentAlert(withTitle: "Info", message: self.get_entries?.message ?? "")
            }
        }
    }
    
    // MARK: - Models
       fileprivate static let alpha: CGFloat = 0.5
       let colors = [
           UIColor.yellow.withAlphaComponent(alpha),
           UIColor.green.withAlphaComponent(alpha),
           UIColor.purple.withAlphaComponent(alpha),
           UIColor.cyan.withAlphaComponent(alpha),
           UIColor.darkGray.withAlphaComponent(alpha),
           UIColor.red.withAlphaComponent(alpha),
           UIColor.magenta.withAlphaComponent(alpha),
           UIColor.orange.withAlphaComponent(alpha),
           UIColor.brown.withAlphaComponent(alpha),
           UIColor.lightGray.withAlphaComponent(alpha),
           UIColor.gray.withAlphaComponent(alpha),
       ]
       fileprivate var currentColorIndex = 0

    func setDataCount(value_1:Double, value_2:Double, value_3:Double, value_4:Double, value_5:Double) {
        let entry1 = PieChartDataEntry(value: value_1, label: "")
        let entry2 = PieChartDataEntry(value: value_2, label: "")
        let entry3 = PieChartDataEntry(value: value_3, label: "")
        let entry4 = PieChartDataEntry(value: value_4, label: "")
        let entry5 = PieChartDataEntry(value: value_5, label: "")
        
        
        let set = PieChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5], label: "")
        print(set)
        set.drawIconsEnabled = false
    
        set.sliceSpace = 2
        set.yValuePosition = .insideSlice
        
       
        cat_colors.append(colors[5])
        cat_colors.append(colors[1])
        cat_colors.append(colors[2])
        cat_colors.append(colors[3])
        cat_colors.append(colors[4])
           

        set.colors = cat_colors
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.zeroSymbol = ""
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(UIFont.getLightFontWith(size: 11.0))
        data.setValueTextColor(.black)
        Piechart.noDataText = ""
       // Piechart.holeRadiusPercent = 0
        //Piechart.holeRadiusPercent = 0.10
        Piechart.data = data
        Piechart.legend.enabled = false
        Piechart.highlightValues(nil)
    }

    
   }


   extension CGFloat {
       static func random() -> CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
       }
   }

   extension UIColor {
       static func randomColor() -> UIColor {
           return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
       }

}

extension BudgetBreakDownViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return get_category_data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
       
        if indexPath.row == 0{
            cell.PriceLbl.text = String(Float(internet_sum_value)) + "$"
            cell.ThumbnailImage.tintColor = cat_colors[0]
        }
        if indexPath.row == 1{
            cell.PriceLbl.text = String(Float(food_sum_value)) + "$"
            cell.ThumbnailImage.tintColor = cat_colors[1]
        }
        if indexPath.row == 2{
            cell.PriceLbl.text = String(Float(gadgets_sum_value)) + "$"
            cell.ThumbnailImage.tintColor = cat_colors[2]
        }
        if indexPath.row == 3{
            cell.PriceLbl.text = String(Float(transport_sum_value)) + "$"
            cell.ThumbnailImage.tintColor = cat_colors[3]
        }
        if indexPath.row == 4{
            cell.PriceLbl.text = String(Float(renewals_sum_value)) + "$"
            cell.ThumbnailImage.tintColor = cat_colors[4]
        }
        
        cell.CategoryLbl.text = get_category_data?[indexPath.row].category
        cell.ThumbnailImage.image = category_image[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
