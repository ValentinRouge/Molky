//
//  GameManager.swift
//  Molky
//
//  Created by Valentin on 06/09/2020.
//  Copyright © 2020 Valentin. All rights reserved.
//

import Foundation

struct player {
    var _score = 0
    var numberof0 = 0
    var _isGameOn = true
    let name:String
    var resonOfEndGame:Int? // 0 = 3x0; 1= gagné
    
    init(nameIs:String) {
        name = nameIs
    }
}

class GameManager{
    private static var s_instance:GameManager? = nil
    public static var shared:GameManager{
        if s_instance == nil {
            s_instance = GameManager()
        }
        return s_instance!
    }
    
    private init() {
        if let List = UserDefaults.standard.array(forKey: Key) as? [String]{
            if List.count != 0 {
                for n in 0...(List.count-1){
                    createPlayer(givenName: List[n])
                }
            }
        }
    }
    
    private var playerList:[player] = []
    private let Key = "Players"
    
    func createPlayer(givenName:String) {
        playerList.append(player.init(nameIs: givenName))
        save()
    }
    
    func getPlayerScore(playerNumber n:Int) -> Int {
        return playerList[n]._score
    }
    
    func getPlayerGameOn(playerNumber n:Int) -> Bool {
        return playerList[n]._isGameOn
    }
    
    func getPlayerName(playerNumber n:Int) -> String {
        return playerList[n].name
    }
    
    func getHowManyPlayer() -> Int {
        return playerList.count
    }
    
    func getPlayerResonOfEndGame(playerNumber n:Int) -> Int?{
        return playerList[n].resonOfEndGame
    }
    
    func newscore(playerNumber n:Int, newScore:Int) {
        if newScore != 0{
            playerList[n]._score = playerList[n]._score + newScore
            playerList[n].numberof0 = 0
            haswin(n: n)
        } else {
            playerList[n].numberof0 = playerList[n].numberof0 + 1
            if playerList[n].numberof0 == 3 {
                returnback(n: n)
            }
        }
    }
    
    func relnitScore() {
        for n in 0...(getHowManyPlayer()-1){
            playerList[n]._score = 0
            playerList[n]._isGameOn = true
            playerList[n].numberof0 = 0
            playerList[n].resonOfEndGame = nil
        }
    }
    
    func DeletePlayer(playerNumber n:Int) {
        playerList.remove(at: n)
        save()
    }
    
    func DeleteAllPlayer() {
        playerList = []
        save()
    }
    private func haswin (n:Int) {
        if playerList[n]._score == 50{
            playerList[n]._isGameOn = false
            playerList[n].resonOfEndGame = 1
        } else if playerList[n]._score > 50 {
            playerList[n]._score = 25
        }
    }
    
    private func returnback(n:Int) {
        if playerList[n]._score > 25{
            playerList[n]._score = 25
            playerList[n].numberof0 = 0
        } else if playerList[n]._score > 0 {
            playerList[n]._score = 0
            playerList[n].numberof0 = 0
        } else if playerList[n]._score == 0{
            playerList[n]._isGameOn = false
            playerList[n].numberof0 = 0
            playerList[n].resonOfEndGame = 0
        }
    }
    
    private func save(){
        var nameList:[String] = []
        if getHowManyPlayer() != 0{
            for n in 0...(getHowManyPlayer()-1){
                nameList.append(playerList[n].name)
            }
        }
        UserDefaults.standard.set(nameList, forKey: Key)
    }
}
