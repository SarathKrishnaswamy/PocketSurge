//
//  DashboardViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK:- Connection outlet
    @IBOutlet weak var IntervalLbl: UILabel!
    @IBOutlet weak var UsernameLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var AllBillsView: UIView!
    @IBOutlet weak var BudgetBillsView: UIView!
    @IBOutlet weak var BillsTrackerView: UIView!
    @IBOutlet weak var PacheckCalculatorView: UIView!
    @IBOutlet weak var BgView: UIView!
    
    //MARK:- set variable
    var timer : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
        initialsetup()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = false
    }
    
    //MARK:- Initial Setup
    func initialsetup(){
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12 : IntervalLbl.text = "Happy Morning"
        case 12 : IntervalLbl.text = "Happy Noon"
        case 13..<17 : IntervalLbl.text = "Happy Afternoon"
        case 17..<22 : IntervalLbl.text = "Happy Evening"
        default: IntervalLbl.text = "Happy Night"
        }
        AllBillsView.layer.cornerRadius = 5.0
        BudgetBillsView.layer.cornerRadius = 5.0
        BillsTrackerView.layer.cornerRadius = 5.0
        PacheckCalculatorView.layer.cornerRadius = 5.0
        BgView.layer.cornerRadius = 50.0
        BgView.layer.masksToBounds = true
        //Set timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(time), userInfo: nil, repeats: true)
    }
    
    //MARK:- Get current time
    @objc func time(){
        // get the current date and time
        let currentDateTime = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        // get the date time String from the date object
        formatter.string(from: currentDateTime)
        self.TimeLbl.text = formatter.string(from: currentDateTime)
    }
    
    //MARK:- All bills Page
    func allbills(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AllBillsViewController") as! AllBillsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- Budget breakdown page
    func budgetbreakdown(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "BudgetBreakDownViewController") as! BudgetBreakDownViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Bills tracker page
    func BillsTracker(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "BillsTrackerViewController") as! BillsTrackerViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- pay check page
    func paycheck(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "PayCheckViewController") as! PayCheckViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK:- All bills Btn Connection
    @IBAction func AllBillsBtnOnPressed(_ sender: Any) {
        allbills()
    }
    
    //MARK:-Budget breakdown Btn Connection
    @IBAction func BudgetBreakDownBtnOnPressed(_ sender: Any) {
        budgetbreakdown()
    }
    
    //MARK:-Bills Tracker Btn Connection
    @IBAction func BillsBreakDownOnPressed(_ sender: Any) {
        BillsTracker()
    }
    
    //MARK:-Pay check Btn Connection
    @IBAction func PaycheckBtnOnPressed(_ sender: Any) {
        paycheck()
    }
}
