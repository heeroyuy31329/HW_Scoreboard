//
//  ViewController.swift
//  HW_Scoreboard
//
//  Created by 姜宗暐 on 2021/7/29.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UI
    @IBOutlet weak var scoreL: UIButton!
    @IBOutlet weak var winL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var serveL: UILabel!
    
    @IBOutlet weak var scoreR: UIButton!
    @IBOutlet weak var winR: UILabel!
    @IBOutlet weak var nameR: UILabel!
    @IBOutlet weak var serveR: UILabel!
    
    // MARK: 變數
    var stepList = [Step]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立第一步
        makeFirstStep()

        showStep()
    }

    // MARK: Action
    @IBAction func addScoreL(_ sender: Any) {
    
    }
    
    @IBAction func addScoreR(_ sender: Any) {
    
    }
    
    @IBAction func rewind(_ sender: Any) {
    
    }
    
    @IBAction func changeSide(_ sender: Any) {
    
    }
    
    @IBAction func reset(_ sender: Any) {

    }
    
    // MARK: Function
    func makeFirstStep() {
        let playerL = Player()
        playerL.name = "123"
        playerL.win = 0
        playerL.score = 0
        playerL.serve = true
        playerL.color = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
        
        let playerR = Player()
        playerR.name = "456"
        playerR.win = 0
        playerR.score = 0
        playerR.serve = false
        playerR.color = UIColor(red: 0.454, green: 0.612, blue: 0.294, alpha: 1)
        
        let step = Step()
        step.playerL = playerL
        step.playerR = playerR
        
        // 加入第一步
        stepList.append(step)
    }
    
    func showStep() {
        let step = stepList.last
        
        scoreL.titleLabel?.text = "\(step!.playerL!.score)"
        winL.text = "\(step!.playerL!.win)"
        nameL.text = step!.playerL!.name
        serveL.isHidden = !step!.playerL!.serve
        
        scoreR.titleLabel?.text = "\(step!.playerR!.score)"
        winR.text = "\(step!.playerR!.win)"
        nameR.text = step!.playerR!.name
        serveR.isHidden = !step!.playerR!.serve
        
        view.backgroundColor = step!.playerL!.serve ? step!.playerL!.color : step!.playerR!.color
    }
}

