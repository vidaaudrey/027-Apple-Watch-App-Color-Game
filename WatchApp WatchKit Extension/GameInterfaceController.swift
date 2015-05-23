//
//  GameInterfaceController.swift
//  WatchApp
//
//  Created by Audrey Li on 5/22/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import WatchKit
import Foundation

struct WKConfig {
    static let UserDefaultScoreName = "scores"
    static let TableRowType = "TableRowController"
    static let ScoreControllerName = "SettingsInterfaceController"
    static let SettingControllerName = "SettingsInterfaceController"
}

class GameInterfaceController: WKInterfaceController {

    @IBOutlet weak var resultLabel: WKInterfaceLabel!
    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var targetColorBtn: WKInterfaceButton!
    @IBOutlet weak var targetColorLabel: WKInterfaceLabel!
    @IBOutlet weak var color1: WKInterfaceButton!
    @IBOutlet weak var color2: WKInterfaceButton!
    @IBOutlet weak var color3: WKInterfaceButton!
    @IBOutlet weak var color4: WKInterfaceButton!
    @IBOutlet weak var correctLabel: WKInterfaceLabel!
    @IBOutlet weak var playAgainBtn: WKInterfaceButton!
    @IBOutlet weak var allMyScoresBtn: WKInterfaceButton!
    
    
    var timeToPlay:NSTimeInterval = 10
    var countdown = NSTimer()
    var score = 0
    var correctAnswer = 0
    
    @IBAction func scoreMenuPressed() {
        pushControllerWithName(WKConfig.ScoreControllerName, context: nil)
    }
    @IBAction func settingMenuPressed() {
        pushControllerWithName(WKConfig.SettingControllerName, context: timeToPlay)
    }
    @IBAction func stopMenuPressed() {
        countdown.invalidate()
        popController()
    }

 
    @IBAction func playAgainBtnPressed() {
        gameSetup()
        startGame()
    }
    
    @IBAction func color1Pressed() {
        answerPicked(0)
    }
    @IBAction func color2Pressed() {
        answerPicked(1)
    }
    @IBAction func color3Pressed() {
        answerPicked(2)
    }
    @IBAction func color4Pressed() {
        answerPicked(3)
    }
    
    func answerPicked(choice: Int){
        if choice == correctAnswer {
            correctLabel.setText("Correct!")
            score++
        } else {
            correctLabel.setText("Wrong!")
        }
        println("score \(score)")
        generateQuestion()
    }
    
    let colorBtns = ["color1", "color2", "color3", "colr4"]
    func generateQuestion(){
        
        correctAnswer = Int(arc4random_uniform(4))
        let ranColor1 = getRandomColor()
        let ranColor2 = getRandomColor()
        let ranColor3 = getRandomColor()
        let ranColor4 = getRandomColor()
        color1.setBackgroundColor(ranColor1)
        color2.setBackgroundColor(ranColor2)
        color3.setBackgroundColor(ranColor3)
        color4.setBackgroundColor(ranColor4)
        println("set correct answer\(correctAnswer)")
        switch correctAnswer {
        case 0:
            targetColorBtn.setBackgroundColor(ranColor1)
        case 1:
            targetColorBtn.setBackgroundColor(ranColor2)
        case 2:
            targetColorBtn.setBackgroundColor(ranColor3)
        default:
            targetColorBtn.setBackgroundColor(ranColor4)
            
        }
    }
    
    
    func startGame(){
        timer.setDate(NSDate(timeIntervalSinceNow: timeToPlay))
        timer.start()
        countdown = NSTimer.scheduledTimerWithTimeInterval(timeToPlay, target: self, selector: "gameComplete", userInfo: nil, repeats: false)
        
        generateQuestion()
    }
    
    func gameComplete(){
        gameSetup(isStart: false)
    }

    
    func gameSetup(isStart:Bool = true){
        resultLabel.setHidden(isStart)
        playAgainBtn.setHidden(isStart)
        allMyScoresBtn.setHidden(isStart)
        
        timer.setHidden(!isStart)
        targetColorLabel.setHidden(!isStart)
        targetColorBtn.setHidden(!isStart)
        color1.setHidden(!isStart)
        color2.setHidden(!isStart)
        color3.setHidden(!isStart)
        color4.setHidden(!isStart)
    
        correctLabel.setText("")
        correctLabel.setHidden(!isStart)
        
        // store the score in the user default
        resultLabel.setText("Your score:\(score)")
        if !isStart {
            var newScores:[String] = []
            if let oldScores = NSUserDefaults.standardUserDefaults().valueForKey(WKConfig.UserDefaultScoreName) as? [String] {
                newScores = oldScores
            }
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let dateStr = dateFormatter.stringFromDate(NSDate())
                
            newScores.append("\(dateStr) - \(score)" )
            NSUserDefaults.standardUserDefaults().setObject(newScores, forKey: WKConfig.UserDefaultScoreName)
    }
        
        score = 0
        
    }
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let timeToPlay = context as? NSTimeInterval {
            self.timeToPlay = timeToPlay
        }
        
        gameSetup()
        startGame()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
