//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Hanife Mehan on 4.03.2021.
//  Copyright © 2021 Hanife Mehan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*Variables*/
    var score = 0
    var timer = Timer()
    //Counter da timeLabel ın içinde gözükecek
    var counter = 0
    //kennyleri dizide tutacağız
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    /*Views*/
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var kenyy1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"

        //HihgScore Checked
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if storedHighScore == nil{
            
            highScore = 0
            highscoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "HighScore: \(highScore)"
            
        }
        //Kullanıcının tıklamasını aktif hale getiririz
        kenyy1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        
        //Tıklanma özelliği katıldı
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        kenyy1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenyy1 , kenny2 , kenny3 , kenny4 , kenny5 , kenny6 , kenny7, kenny8 , kenny9]
        
        //Timers
        counter = 10
        ///bu gösterimle birlikte counter ı stringe çevirmiş olduk ya da String(counter) yapabiliriz
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)

        //fonksiyonu çağırırız
        hideKenny()

    }
    //kennyleri saklama fonksiyonu
     @objc func hideKenny(){
        
        for kenny in kennyArray{
            
            kenny.isHidden = true
        }
        //rasgele değer oluştururuz random
        //kennyArray.count) bu şekilde yaparsak app çöker çünkü arrayler 0 dan başlar ve 9 dediğinde çöker
        //0 ile 8 arasında ragele sayı alırız
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        //random dan aldığı değere göre kennyleri gösterecek
        kennyArray[random].isHidden = false
    }
    
 

    @objc func increaseScore(){
        
        score += 1
        //değer güncellemesi için bir daha yazdırırız
        scoreLabel.text = "Score \(score)"
        
        
    }
    
    @objc func countDown(){
        
        counter-=1
        timeLabel.text = String(counter)
        
        if counter == 0{
            //timerı durdururuz
            timer.invalidate()
            hideTimer.invalidate()
            
            //Bittikten sonra bütün kennyleri tekrar görünmez hale getirmek için
            for kenny in kennyArray{
                
                kenny.isHidden = true
            }
            
            //High Score
            if self.score > self.highScore{
                
                self.highScore = self.score
                highscoreLabel.text = "HighScore: \(self.highScore)"
                //UserDefaults a kaydederiz
                UserDefaults.standard.set(self.highScore, forKey: "HighScore")
                //viewDidLoad da highscoreyi kontrol etmeliyiz
                
            }
            
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: UIAlertControllerStyle.alert)
            let button = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                //replay function
                //viewController içindeki score olduğunu anlaması için self. şeklinde belirttik
                //score u sıfırladık time ı ise tekrar başa aldık
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            })
            
            alert.addAction(button)
            alert.addAction(replayButton)
            //alert ı bu şekilde gösteririz
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
 

}

