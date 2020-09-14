//
//  ViewController.swift
//  Molky
//
//  Created by Valentin on 06/09/2020.
//  Copyright © 2020 Valentin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let playerManager2 = GameManager.shared
    var playerPlayingNumber:Int = 0

    @IBOutlet weak var Ui_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Ui_tableview.dataSource=self
        ScoreStackView.isHidden = false

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerManager2.getHowManyPlayer()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = Ui_tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let TitleLabel = cell.textLabel{
            TitleLabel.text = String( playerManager2.getPlayerName(playerNumber: indexPath.row))
        }
        if let detailLabel = cell.detailTextLabel{
            detailLabel.text = String( playerManager2.getPlayerScore(playerNumber: indexPath.row))
        }
        return cell 
    }
    
    @IBOutlet weak var ScoreFieldOutlet: UITextField!
    
    @IBOutlet weak var NameLabel: UILabel!
            
    @IBOutlet weak var ScoreStackView: UIStackView!
    
    @IBAction func OkButtonPressed(_ sender: Any) {
        ScoreFieldOutlet.resignFirstResponder()
        if let score:Int = Int(ScoreFieldOutlet.text ?? "0") {
              if score <= 12{
               playerManager2.newscore(playerNumber: playerPlayingNumber, newScore: score)
               if playerManager2.getPlayerGameOn(playerNumber: playerPlayingNumber) == false{
                   ScoreStackView.isHidden = true
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
        NameLabel.text = playerManager2.getPlayerName(playerNumber: playerPlayingNumber)
    }
}

