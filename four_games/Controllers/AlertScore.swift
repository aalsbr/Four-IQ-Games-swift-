//
//  AlertScore.swift
//  AlertScore
//
//  Created by Slom on 18/08/2021.
//

import UIKit
import GoogleMobileAds


class AlertScore: UIViewController {
   
  
   
    var scoredata = 0


      @IBOutlet weak var cancelBtn: UIButton!
     @IBOutlet weak var share: UIButton!
      @IBOutlet weak var messageHolder: UILabel!
      @IBOutlet weak var test: UILabel!
      @IBOutlet weak var imageHolder: UIImageView!
      
          
        var iqnumber = 0
        
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
       
        self.view.backgroundColor =  UIColor.black.withAlphaComponent(0.0)
        cancelBtn?.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        share?.addTarget(self, action: #selector(self.sharecall), for: .touchUpInside)

        if scoredata < 7 {
            iqnumber = 80+Int.random(in: 0..<20)
            
        }
        else if scoredata <= 15 {
            iqnumber = 100+Int.random(in: 0..<15)
        
        }
        else if scoredata <=  24 {
            iqnumber = 120+Int.random(in: 0..<10)
               }
        else if scoredata > 24 {
            iqnumber = 135+Int.random(in: 0..<10)
           
         }
        messageHolder.text = "\(iqnumber)"
        
        
  
      
        
      
    }
 

    @objc func dismiss(_ sender: Any) {
     
        self.dismiss(animated: true, completion: nil)

    }
    @objc func sharecall(_ sender: Any)
    {
            
           let messages = "My IQ is : \(iqnumber)    ,  Test Your IQ in 1 minute, This is the fastest way to know your IQ.Just add 1 to 4 Digits to know your IQ.What are you waiting for ?!DOWNLOAD Now!"
        if let name = URL(string: "https://apps.apple.com/us/app/id1585149983"), !name.absoluteString.isEmpty {
            let objectsToShare = [messages, name] as [Any]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
            return
          // show alert for not available
        }
//
    }
     
        
       

    
  
    
 
    

  
}

