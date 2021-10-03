//
//  IQResultViewController.swift
//  IQResultViewController
//
//  Created by Slom on 02/09/2021.
//

import UIKit

class IQResultViewController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.black.withAlphaComponent(0.0)
        cancelBtn?.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
       
    }
    
    
    
    
    @objc func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
