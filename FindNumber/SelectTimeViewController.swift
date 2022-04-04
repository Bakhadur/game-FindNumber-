//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by Бахадур Валиев on 20.02.2022.
//

import UIKit

class SelectTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var data: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    


}


extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
