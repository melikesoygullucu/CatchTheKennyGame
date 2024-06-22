//
//  ViewController.swift
//  CatchKenny
//
//  Created by Melike Soygüllücü on 20.06.2024.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highscore = 0
    var kennyArray = [UIImageView]()
    
 
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 10
        timerLabel.text = "\(counter)"
        scoreLabel.text = "Score: \(score)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(newScore)"
        }
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        
        kennyArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
    }

    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func timerFunction() {
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if self.highscore < self.score {
                self.highscore = self.score
                highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            alertDialog()
            
        }
    }
    
    @objc func alertDialog() {
        let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
        let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        let ReplayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.counter = 10
            self.timerLabel.text = "\(self.counter)"
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
        }
        alert.addAction(OKButton)
        alert.addAction(ReplayButton)
        self.present(alert, animated: true)
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

}

