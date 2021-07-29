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
        addScore(side: .Left)
    }
    
    @IBAction func addScoreR(_ sender: Any) {
        addScore(side: .Right)
    }
    
    @IBAction func rewind(_ sender: Any) {
        if(stepList.count > 1) {
            stepList.removeLast()
            
            showStep()
        }
    }
    
    @IBAction func changeSide(_ sender: Any) {
        let lastStep = stepList.last
        
        // 兩邊交換
        let step = Step()
        step.playerL = lastStep!.playerR
        step.playerR = lastStep!.playerL
        step.isdeuce = lastStep!.isdeuce
        
        // 加入新的一步
        stepList.append(step)
        
        showStep()
    }
    
    @IBAction func reset(_ sender: Any) {
        stepList.removeAll()
        
        makeFirstStep()
        
        showStep()
    }
    
    @IBAction func setName(_ sender: Any) {
        let alertController = UIAlertController(title: "設定名稱", message: "請輸入雙方名稱", preferredStyle: .alert)
        
        // 設定兩個textField來輸入雙方名字
        alertController.addTextField { textField in
            textField.placeholder = "左側的名字"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "右側的名字"
        }
        
        // 設定按鈕
        let ok = UIAlertAction(title: "OK", style: .default) { alertAction in
            self.addStep()
            
            let step = self.stepList.last
            step?.playerL?.name = alertController.textFields?[0].text ?? ""
            step?.playerR?.name = alertController.textFields?[1].text ?? ""
            
            self.showStep()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Function
    func makeFirstStep() {
        let playerL = Player()
        playerL.name = ""
        playerL.win = 0
        playerL.score = 0
        playerL.serve = true
        playerL.color = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
        
        let playerR = Player()
        playerR.name = ""
        playerR.win = 0
        playerR.score = 0
        playerR.serve = false
        playerR.color = UIColor(red: 0.454, green: 0.612, blue: 0.294, alpha: 1)
        
        let step = Step()
        step.playerL = playerL
        step.playerR = playerR
        step.isdeuce = false
        
        // 加入第一步
        stepList.append(step)
    }
    
    func showStep() {
        let step = stepList.last
        
        scoreL.setTitle("\(step!.playerL!.score)", for: .normal)
        winL.text = "\(step!.playerL!.win)"
        nameL.text = step!.playerL!.name
//        serveL.isHidden = !step!.playerL!.serve
        serveL.text = step!.playerL!.serve ? "Serve" : ""
        
        scoreR.setTitle("\(step!.playerR!.score)", for: .normal)
        winR.text = "\(step!.playerR!.win)"
        nameR.text = step!.playerR!.name
//        serveR.isHidden = !step!.playerR!.serve
        serveR.text = step!.playerR!.serve ? "Serve" : ""
        
        view.backgroundColor = step!.playerL!.serve ? step!.playerL!.color : step!.playerR!.color
    }
    
    func addStep() {
        // 複製前一步
        let lastStep = stepList.last
        
        // 每次增加一個新的step
        let playerL = Player()
        playerL.name = lastStep!.playerL!.name
        playerL.win = lastStep!.playerL!.win
        playerL.score = lastStep!.playerL!.score
        playerL.serve = lastStep!.playerL!.serve
        playerL.color = lastStep!.playerL!.color
        
        let playerR = Player()
        playerR.name = lastStep!.playerR!.name
        playerR.win = lastStep!.playerR!.win
        playerR.score = lastStep!.playerR!.score
        playerR.serve = lastStep!.playerR!.serve
        playerR.color = lastStep!.playerR!.color
        
        let step = Step()
        step.playerL = playerL
        step.playerR = playerR
        step.isdeuce = lastStep!.isdeuce
        
        // 加入新的一步
        stepList.append(step)
    }
    
    func addScore(side: Side) {
        addStep()
        
        let lastStep = stepList.last

        switch side {
        case .Left:
            lastStep!.playerL!.score += 1
        case .Right:
            lastStep!.playerR!.score += 1
        }
                
        checkWin()
        changeBall()
        showStep()
    }
    
    func checkWin() {
        let lastStep = stepList.last
        
        if (lastStep!.isdeuce) {
            // deuces局
            let scoreDif = lastStep!.playerL!.score - lastStep!.playerR!.score
            
            if (scoreDif == 2) {
                // 左方贏一局
                lastStep!.playerL!.win += 1
                lastStep!.playerL!.score = 0
                lastStep!.playerR!.score = 0
                lastStep!.isdeuce = false
            } else if (scoreDif == -2) {
                // 右方贏一局
                lastStep!.playerR!.win += 1
                lastStep!.playerL!.score = 0
                lastStep!.playerR!.score = 0
                lastStep!.isdeuce = false
            }
        } else {
            // 非deuce局
            if (lastStep!.playerL!.score == 11) {
                // 左方贏一局
                lastStep!.playerL!.win += 1
                lastStep!.playerL!.score = 0
                lastStep!.playerR!.score = 0
            } else if (lastStep!.playerR!.score == 11) {
                // 右方贏一局
                lastStep!.playerR!.win += 1
                lastStep!.playerL!.score = 0
                lastStep!.playerR!.score = 0
            } else if (lastStep!.playerL!.score == 10 && lastStep!.playerR!.score == 10){
                // 進入deuce局
                lastStep!.isdeuce = true
            }
        }
    }
    
    func changeBall() {
        let lastStep = stepList.last
        
        if (lastStep!.isdeuce) {
            lastStep!.playerR!.serve = !lastStep!.playerR!.serve
            lastStep!.playerL!.serve = !lastStep!.playerL!.serve
        } else {
            let ballCount = lastStep!.playerL!.score + lastStep!.playerR!.score
            
            // 每兩球換邊
            if (ballCount % 2 == 0) {
                lastStep!.playerR!.serve = !lastStep!.playerR!.serve
                lastStep!.playerL!.serve = !lastStep!.playerL!.serve
            }
        }
    }
}

