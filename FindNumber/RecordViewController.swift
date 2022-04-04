//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Бахадур Валиев on 03.03.2022.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var record: UILabel!
    
    @IBAction func closeVC(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        record.text = String(UserDefaults.standard.integer(forKey: KeyUserDefaults.recordGame))
    }
    


}
