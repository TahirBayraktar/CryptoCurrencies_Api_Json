//
//  ViewController.swift
//  CryptoCurrencies
//
//  Created by Tahir Bayraktar on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var bnbLabel: UILabel!
    @IBOutlet weak var dogeLabel: UILabel!
    @IBOutlet weak var enjLabel: UILabel!
    @IBOutlet weak var xrpLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
//        Request & Session
        let url = URL(string: "http://api.coinlayer.com/api/live?access_key=a36c847de0ff4f07f2798a61735e655e")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { Data, Response , Error in
            
            if Error != nil {
                let alert = UIAlertController(title: "Error", message: Error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            
                
            }else {
//              Response & Data
                if Data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: Data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
//                        ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                if let btc = rates["BTC"] as? Double{
                                   self.btcLabel.text = "BTC: "+String(format: "%.3f", btc)
                                }
                                if let eth = rates["ETH"] as? Double{
                                    self.ethLabel.text = "ETH: "+String(format: "%.3f", eth)
                                }
                                if let bnb = rates["BNB"] as? Double{
                                    self.bnbLabel.text = "BNB: " + String(format: "%.3f",bnb)
                                }
                                if let doge = rates["DOGE"] as? Double{
                                    self.dogeLabel.text = "DOGE: " + String(format: "%.5f",doge)
                                }
                                if let enj = rates["ENJ"] as? Double{
                                    self.enjLabel.text = "ENJ: " + String(format: "%.4f", enj)
                                }
                                if let xrp = rates["XRP"] as? Double{
                                    self.xrpLabel.text = "XRP: " + String(format:"%.4f",xrp)
                                }
                                if let link = rates["LINK"] as? Double{
                                    self.linkLabel.text = "LINK: " + String(format: "%.4f", link)
                                }
                            }
                        }
                    }catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
    }
}

