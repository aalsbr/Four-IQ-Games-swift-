//
//  PurchaseViewController.swift
//  four_games
//
//  Created by Slom on 10/09/2021.
//

import UIKit
import StoreKit

class PurchaseViewController: UIViewController , SKPaymentTransactionObserver , SKProductsRequestDelegate {



    @IBOutlet weak var Buy: UIButton!
    @IBOutlet weak var Restore: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!


    var myproduct : SKProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.black.withAlphaComponent(0.0)
        //button setup
        cancelBtn?.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        Buy?.addTarget(self, action: #selector(self.BuyButton), for: .touchUpInside)
        Restore?.addTarget(self, action: #selector(self.RestoreButton), for: .touchUpInside)

        //add payment
        fetch()

        if UserDefaults.standard.bool(forKey:"ADS_REMOVED"){
            Buy?.isHidden = true
            Restore?.isHidden = true
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 0, y: 0)
            label.textAlignment = .center
            label.textColor = .green
            label.text = "Thanks for buying "
            self.view.addSubview(label)
        }





    }

    //back to setting button
    @objc func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    func fetch(){
        let request = SKProductsRequest(productIdentifiers: ["com.removeads.forever1"])
        request.delegate = self
        request.start()
    }


    @objc func BuyButton(_ sender: Any) {
        guard let myproduct = myproduct else{
            print(" eroor its me againe")
            return
        }
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKPayment(product:myproduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(paymentRequest)
        }


    }


    @objc func RestoreButton(_ sender: Any) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()

    }




    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            myproduct = product
            print("HIII")

            print(product.productIdentifier)
            print(product.priceLocale)
            print(product.localizedTitle)

        }

    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {
            if transaction.transactionState == .purchased ||  transaction.transactionState == .restored {

                UserDefaults.standard.set(true, forKey: "ADS_REMOVED")

                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)

                print(" Transaction sucess")

            }
            else if transaction.transactionState == .failed {
                print(" Transaction faild")
            }
        }

    }





}
