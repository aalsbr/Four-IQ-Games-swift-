//
//  GameViewController.swift
//  four_games
//
//  Created by Slom on 08/08/2021.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GoogleMobileAds



class GameViewController: UIViewController {
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var settings:UIImageView?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    var score = 0
    var timer:Timer?
    var seconds = 60
    var audioPlayer = AVAudioPlayer()
    var clickplayer = AVAudioPlayer()
    static var ispussed = false
    
    private  var fullscreenAd : GADInterstitialAd?
    struct constanst {
        static let scoreAd = "ca-app-pub-1939925225975999/6537399986"
    }
    
    private let  banner: GADBannerView = {
        let banner = GADBannerView()
      banner.adUnitID = "ca-app-pub-1939925225975999/8749588212"
        banner.load(GADRequest())
        
        return banner
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // IF USER BUY NO ADS IN PURCHASE !
      
//        if !UserDefaults.standard.bool(forKey: "ADS_REMOVED"){
//
//        }
        banner.rootViewController = self
        view.addSubview(banner)
        creatad()
          
        
    
        
        let soundFileURL = Bundle.main.path(
            forResource: "game1",
            ofType: "wav")
        let soundclick = Bundle.main.path(
            forResource: "click",
            ofType: "wav")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonAction))

            // Configure Tap Gesture Recognizer
            tapGestureRecognizer.numberOfTapsRequired = 1

            // Add Tap Gesture Recognizer
        settings?.isUserInteractionEnabled = true
        settings?.addGestureRecognizer(tapGestureRecognizer)
        
        

    

 
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundFileURL!))
            clickplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundclick!))

             }
        
        
        
        catch {
            // Handle error
        }
       
        
        inputField?.becomeFirstResponder()
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
        
    }
    
  
  
    
    func updateScoreLabel() {
        scoreLabel?.text = String(score)
    }
    func updateNumberLabel() {
        numberLabel?.text = String.randomNumber(length: 4)
    }
    @IBAction func inputFieldDidChange()
    {
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else {
            return
        }
        guard inputText.count == 4 else {
            return
        }
        var isCorrect = true
        for n in 0..<4
        {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            if input == 0 {
                input = 10
            }
            if input != number + 1 {
                isCorrect = false
                break
            }
        }
        if isCorrect {
            score += 1
            audioPlayer.play()
            
        }
        else if score > 0{
            score -= 1
        }
        
      
    
        
        updateNumberLabel()
        updateScoreLabel()
        inputField?.text = ""
     
        
      
    
        if GameViewController.ispussed && timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds == 0 {
                    self.showad()
                }
                if self.seconds <= 60 {
                    self.updateTimeLabel()
                    self.seconds -= 1
                }
            }
        }
        else if timer == nil{
         timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
             if self.seconds == 0 {
                 self.showad()
             }
             if self.seconds <= 60 {
                 
                 self.updateTimeLabel()
                 self.seconds -= 1
             }
         }
         }
        
     
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        banner.frame = CGRect(x: 0 ,
                              y: view.safeAreaInsets.top,
                              width: view.frame.size.width,
                              height: 50).integral
        
    }
    
    
    func updateTimeLabel() {
        
        let min = (seconds / 60) % 60
        let sec = seconds % 60
        
        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    func finishGame()
    {
        
        timer?.invalidate()
        timer = nil
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        let alert = storyBoard.instantiateViewController(withIdentifier: "Alertscore")as! AlertScore
        alert.scoredata = score
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
     
             self.present(alert, animated: true, completion: nil)
     
        GameViewController.ispussed = false
        score = 0
        seconds = 60
        updateTimeLabel()
        updateScoreLabel()
        updateNumberLabel()
        
    }
    
   @objc func buttonAction(recognizer:UIGestureRecognizer!)
       {
           clickplayer.play()
           updateNumberLabel()
           GameViewController.ispussed = false
           timer?.invalidate()
           timer = nil
           

           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         
           
           let home = storyBoard.instantiateViewController(withIdentifier: "HomeViewContoller")as! HomeViewContoller
          
           home.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
          
           self.present(home, animated: true, completion: nil)
          

//
       }
    private func showad (){
        if fullscreenAd != nil{
           fullscreenAd!.present(fromRootViewController: self)
         }
        else{
            finishGame()
        }
    }
    
    private func creatad(){
     
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:constanst.scoreAd,
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if  error != nil {
                        
                              return
                            }
                            fullscreenAd = ad
                            fullscreenAd?.fullScreenContentDelegate = self

                          }
        )
  
    }
    


    
}
extension GameViewController : GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
         finishGame()
          creatad()
        
    }
}

