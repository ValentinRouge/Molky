//
//  NewGameViewController.swift
//  Molky
//
//  Created by Valentin on 07/09/2020.
//  Copyright © 2020 Valentin. All rights reserved.
//

import Foundation
import UIKit

class NewGameViewControler: UIViewController {
    
    let gameManager1 = GameManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NewGameButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Nom du joeur", message: "Entrez le nom du joueur", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nom du joeur"}
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let name = textField!.text!
            self.gameManager1.createPlayer(givenName: name)
            self.performSegue(withIdentifier: "Game", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
}
