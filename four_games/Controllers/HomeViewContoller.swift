//
//  HomeViewContoller.swift
//  HomeViewContoller
//
//  Created by Slom on 18/08/2021.
//

import UIKit
import MessageUI
import AVFoundation
import LinkPresentation





class HomeViewContoller: UIViewController , MFMailComposeViewControllerDelegate   {
  
    @IBOutlet weak var Resume: UIButton!
    @IBOutlet weak var NewGamebutton: UIButton!
    @IBOutlet weak var IQ_Result: UIButton!
    @IBOutlet weak var ContactUs: UIButton!
    @IBOutlet weak var Share:UIImageView?
//    @IBOutlet weak var noadsimage:UIImageView?
//    @IBOutlet weak var noadsbutton:UIImageView?
    var clickplayer = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shareaction))
        
       
//        if !UserDefaults.standard.bool(forKey: "ADS_REMOVED"){
//            let Noadsgesture = UITapGestureRecognizer(target: self, action: #selector(didtapbuy))
//
//            Noadsgesture.numberOfTapsRequired = 1
//            noadsimage?.isUserInteractionEnabled = true
//            noadsimage?.addGestureRecognizer(Noadsgesture)
//    }
        
//            noadsimage?.isHidden = true
//            noadsimage?.isUserInteractionEnabled = false
//            noadsbutton?.isHidden = true
//
        
           
            
            
        
       
        // Add Tap Gesture Recognizer
     
            // Configure Tap Gesture Recognizer
            tapGestureRecognizer.numberOfTapsRequired = 1

            // Add Tap Gesture Recognizer
        Share?.isUserInteractionEnabled = true
        Share?.addGestureRecognizer(tapGestureRecognizer)
        let soundclick = Bundle.main.path(
            forResource: "click",
            ofType: "wav")
        do {
            clickplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundclick!))

             }
        catch {
            // Handle error
        }
        self.view.backgroundColor =  UIColor.black.withAlphaComponent(0.0)
        NewGamebutton?.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        Resume?.addTarget(self, action: #selector(self.resumedismess), for: .touchUpInside)
        IQ_Result?.addTarget(self, action: #selector(self.IQShow), for: .touchUpInside)
        ContactUs?.addTarget(self, action: #selector(self.sendEmail), for: .touchUpInside)

    }
    @objc func sendEmail(_ sender: Any) {
                clickplayer.play()
                let recipientEmail = "a.alsbr@gmail.com"
                let subject = "About IQ Game"
               
                
                // Show default mail composer
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([recipientEmail])
                    mail.setSubject(subject)
                    
                    
                    present(mail, animated: true)

            }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
               controller.dismiss(animated: true)
           }
    
    @objc  func resumedismess(_ sender: Any ){
        clickplayer.play()
        GameViewController.ispussed = true
        self.dismiss(animated: true, completion: nil)
        

    }
    @objc  func IQShow(_ sender: Any ){
        clickplayer.play()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      
        let home = storyBoard.instantiateViewController(withIdentifier: "IQResultViewController")as! IQResultViewController
        home.modalPresentationStyle = UIModalPresentationStyle.currentContext
       
        self.present(home, animated: false, completion: nil)
        

    }
   
  
    @objc func dismiss(_ sender: Any) {
        clickplayer.play()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyBoard.instantiateViewController(withIdentifier: "GameViewController")as! GameViewController
        
        
        home.timer?.invalidate()
        home.timer = nil
        home.score = 0
        home.seconds = 60
        
        home.updateTimeLabel()
        home.updateScoreLabel()
        home.updateNumberLabel()
        
        
     
        
        home.modalPresentationStyle = .fullScreen

        self.present(home, animated: false, completion: nil)
    }
    
    
    @objc func shareaction(recognizer:UIGestureRecognizer!)
        {
                clickplayer.play()
               let messages = "Test Your IQ in 1 minute, This is the fastest way to know your IQ.Just add 1 to 4 Digits to know your IQ.What are you waiting for ?!DOWNLOAD Now!"
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
    
    
//    @objc func didtapbuy(recognizer:UIGestureRecognizer!){
//        clickplayer.play()
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let home = storyBoard.instantiateViewController(withIdentifier: "PurchaseView")as! PurchaseViewController
//        home.modalPresentationStyle = UIModalPresentationStyle.currentContext
//
//        self.present(home, animated: false, completion: nil)
//
//
//    }
    
    
 
    

    
    
    
    
    

    



}
