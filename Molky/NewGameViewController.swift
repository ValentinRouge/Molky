//
//  NewGameViewController.swift
//  Molky
//
//  Created by Valentin on 07/09/2020.
//  Copyright © 2020 Valentin. All rights reserved.
//

import Foundation
import UIKit

class NewGameViewControler: UIViewController, UITableViewDataSource{

    let gameManager1 = GameManager.shared
    
    @IBOutlet weak var NameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NewGameButtonTouched(_ sender: Any) {
        if gameManager1.getHowManyPlayer() == 0 {
            let alert = UIAlertController(title: "Erreur", message: "Vous ne pouvez pas lancer une partie avec 0 joueur.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func NewPlayerButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Nom du joueur", message: "Entrez le nom du joueur", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nom du joeur"}
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let name = textField!.text!
            self.gameManager1.createPlayer(givenName: name)
            self.NameTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func relnitButtonTouched(_ sender: Any) {
        gameManager1.DeleteAllPlayer()
        NameTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager1.getHowManyPlayer()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NameTableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        if let TitleLabel = cell.textLabel{
            TitleLabel.text = gameManager1.getPlayerName(playerNumber: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        gameManager1.DeletePlayer(playerNumber: indexPath.row)
        NameTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
