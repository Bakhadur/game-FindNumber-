//
//  Setings.swift
//  FindNumber
//
//  Created by Бахадур Валиев on 24.02.2022.
//

import Foundation

struct SettingGame:Codable {
    var timerState: Bool
    var timeForGame: Int
}

enum KeyUserDefaults {
    static let settingGame = "settingGame"
    static let recordGame = "recordGame"
}

class Settings{
    static var shared = Settings()
    private let defaultSettings = SettingGame(timerState: true, timeForGame: 30)
    var currentSettings: SettingGame{
        get{
            if let data = UserDefaults.standard.object(forKey: KeyUserDefaults.settingGame) as? Data {
                return try! PropertyListDecoder().decode(SettingGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings){
                    UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingGame)
                }
                return defaultSettings
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue){
                UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingGame)
            }
        }
    }
    
    func resetSettings(){
        currentSettings = defaultSettings
    }
}
