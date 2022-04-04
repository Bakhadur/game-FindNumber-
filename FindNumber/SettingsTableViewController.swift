//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Бахадур Валиев on 20.02.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var timer: UISwitch!
    @IBOutlet weak var timerIndicator: UILabel!
    
    
    
    @IBAction func changeTimer(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerState = sender.isOn
    }
    
    @IBAction func tappedDefaultSettings(_ sender: UIButton) {
        Settings.shared.resetSettings()
        refresh()
    }
    
    
    func refresh(){
        timer.isOn = Settings.shared.currentSettings.timerState
        timerIndicator.text = "\(Settings.shared.currentSettings.timeForGame) сек"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTime" {
            if let selectTimeVC = segue.destination as? SelectTimeViewController {
                selectTimeVC.data = [20, 30, 40, 50, 60, 70]
            }
        }
    }


}
