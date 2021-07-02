//
//  BudgetBreakDownViewController.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 28/06/21.
//

import UIKit
import PieCharts

class BudgetBreakDownViewController: UIViewController,PieChartDelegate {
    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var TableView: UITableView!
    var category = ["Accommodation","Entertainment","Groceries","Restaurants","Transport"]
    var category_image = [UIImage(systemName: "globe"),UIImage(systemName: "video"),UIImage(systemName: "cart"),UIImage(systemName: "cart.fill"),UIImage(systemName: "bus")]
    var category_color = [#colorLiteral(red: 0.2050859332, green: 0.5914066434, blue: 0.9727563262, alpha: 1), #colorLiteral(red: 0.2392156863, green: 0.5450980392, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.516361177, green: 0.5748247504, blue: 0.3790351152, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) ]
    var category_price = ["0$","0$","0$","0$","0$"]
    var model = [PieSliceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2050859332, green: 0.5914066434, blue: 0.9727563262, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.TableView.tableFooterView = UIView()
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.5921568627, blue: 0.9725490196, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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

    // MARK: - PieChartDelegate
       
       func onSelected(slice: PieSlice, selected: Bool) {
           print("Selected: \(selected), slice: \(slice)")
       }
       fileprivate func createModels() -> [PieSliceModel] {
         model = [
            PieSliceModel(value: 10, color: colors[0]),
            PieSliceModel(value: 10, color: colors[1]),
            PieSliceModel(value: 10, color: colors[2]),
            PieSliceModel(value: 10, color: colors[3]),
            PieSliceModel(value: 10, color: colors[4])
        ]
        self.TableView.reloadData()
        self.TableView.delegate = self
        self.TableView.dataSource = self
           currentColorIndex = model.count
           return model
       }
       

       
       // MARK: - Layers
       
       fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
           
           let textLayerSettings = PiePlainTextLayerSettings()
           textLayerSettings.viewRadius = 75
           textLayerSettings.hideOnOverflow = true
           textLayerSettings.label.font = UIFont.systemFont(ofSize: 10)
           
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           textLayerSettings.label.textGenerator = {slice in
               return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
           }
           let textLayer = PiePlainTextLayer()
           textLayer.settings = textLayerSettings
           return textLayer
       }
       
       fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
           let lineTextLayer = PieLineTextLayer()
           var lineTextLayerSettings = PieLineTextLayerSettings()
           lineTextLayerSettings.lineColor = UIColor.lightGray
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
           lineTextLayerSettings.label.textGenerator = {slice in
               return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
           }
           
           lineTextLayer.settings = lineTextLayerSettings
           return lineTextLayer
       }
       
       @IBAction func onPlusTap(sender: UIButton) {
           let newModel = PieSliceModel(value: 4 * Double(CGFloat.random()), color: colors[currentColorIndex])
           chartView.insertSlice(index: 0, model: newModel)
           currentColorIndex = (currentColorIndex + 1) % colors.count
           if currentColorIndex == 2 {currentColorIndex += 1} // avoid same contiguous color
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
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.CategoryLbl.text = category[indexPath.row]
        cell.ThumbnailImage.image = category_image[indexPath.row]
        cell.ThumbnailImage.tintColor = category_color[indexPath.row]
        cell.PriceLbl.text = category_price[indexPath.row]
        return cell
    }
    
    
}
