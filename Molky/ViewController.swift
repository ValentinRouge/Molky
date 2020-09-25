//
//  ViewController.swift
//  Molky
//
//  Created by Valentin on 06/09/2020.
//  Copyright © 2020 Valentin. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class ResultCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dot1: UIImageView!
    @IBOutlet weak var dot2: UIImageView!
    
}

class ViewController: UIViewController, UITableViewDataSource {

    
    
    let playerManager2 = GameManager.shared
    var playerPlayingNumber:Int = 0

    @IBOutlet weak var Ui_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Ui_tableview.dataSource=self
        ScoreStackView.isHidden = false
        QuestionLabel.isHidden = false
        playerManager2.relnitScore()
        actualiseScreenNewPlayer()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerManager2.getHowManyPlayer()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Ui_tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        if let TitleLabel = cell.NameLabel{
            TitleLabel.text = String( playerManager2.getPlayerName(playerNumber: indexPath.row))
        }
        if let detailLabel = cell.scoreLabel{
            detailLabel.text = String( playerManager2.getPlayerScore(playerNumber: indexPath.row))
        }
        let number0 = playerManager2.getPlayerNumber0(playerNumber: indexPath.row)
        if number0 == 0{
            cell.dot1.isHidden = true
            cell.dot2.isHidden = true
        } else if number0 == 1 {
            cell.dot1.isHidden = false
            cell.dot2.isHidden = true
        }else if number0 == 2 {
            cell.dot1.isHidden = false
            cell.dot2.isHidden = false
        }
        return cell 
    }
    
    @IBOutlet weak var ScoreFieldOutlet: UITextField!
    
    @IBOutlet weak var NameLabel: UILabel!
            
    @IBOutlet weak var ScoreStackView: UIStackView!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBAction func OkButtonPressed(_ sender: Any) {
        ScoreFieldOutlet.resignFirstResponder()
        if let score:Int = Int(ScoreFieldOutlet.text ?? "0") {
              if score <= 12{
               playerManager2.newscore(playerNumber: playerPlayingNumber, newScore: score)
               if playerManager2.getPlayerGameOn(playerNumber: playerPlayingNumber) == false{
                   ScoreStackView.isHidden = true
                   QuestionLabel.isHidden = true
                   if let reason = playerManager2.getPlayerResonOfEndGame(playerNumber: playerPlayingNumber),
                      reason == 1{
                       let alert = UIAlertController(title: "Bravo", message: "Vous avez gagné", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   } else if let reason = playerManager2.getPlayerResonOfEndGame(playerNumber: playerPlayingNumber),
                   reason == 0{
                       let alert = UIAlertController(title: "Vous avez perdu", message: "Vous avez marqué 0 points pendant 3 tous consécutifs. \n Vous ferez mieux la prochaine fois !", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
               }
                playerPlayingNumber = playerPlayingNumber + 1
                if playerPlayingNumber >= playerManager2.getHowManyPlayer(){
                    playerPlayingNumber = 0
                }
                actualiseScreenNewPlayer()
               Ui_tableview.reloadData()
           } else {
               let alert = UIAlertController(title: "Veillez entrer un nombre correct", message: "Au molky un score ne peut être supérieur a 12", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "D'accord", style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
        }
    }
    
    func actualiseScreenNewPlayer(){
        NameLabel.text = "\(playerManager2.getPlayerName(playerNumber: playerPlayingNumber)) joue"
        QuestionLabel.text = "Quel est le score de \(playerManager2.getPlayerName(playerNumber: playerPlayingNumber))?"
    }
}

