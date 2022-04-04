//
//  GameViewController.swift
//  FindNumber
//
//  Created by Бахадур Валиев on 05.02.2022.
//

import UIKit

class GameViewController: UIViewController {

    // TODO: Rename
    // FIXME: Rename2
    // MARK: - Разделитель
    //#warning("ПРЕДУПРЕЖДЕНИЕ")
    //#error("ОШИБКА")
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet weak var gameIndicator: UILabel!
    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    lazy var game = Game(cells: numberButton.count, checkStatus: checkStatus) { [weak self] secondGame in
        guard let self = self else {return}
        self.timer.text = secondGame.showTimer()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        game.stopTimer()
    }
    
    @IBAction func tappedNumber(_ sender: UIButton) {
        if sender.currentTitle == gameIndicator.text && game.status == .start {
            sender.isEnabled = false
            sender.alpha = 0
            gameIndicator.text = game.getGameIndicator()
        } else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = .red
            } completion: { (_) in
                  sender.backgroundColor = .white
            }

        }
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        initializingTheGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializingTheGame()
    }

    /**
     функция проверяет статусы игры
     - parameter x: у функции нет параметров
     - returns: ничего Ne vozvrashaet
     
     #Описание
     Просто описание а здесь ссылка [Ссылка на сайт гугла](https://google.com)
     */
    func checkStatus() {
        switch game.status {
        case .loss:
            gameStatus.text = "Game over"
            gameStatus.textColor = .red
            showAlertActionSheet()
        case .start:
            gameStatus.text = "Game on"
            gameStatus.textColor = .black
        case .win:
            gameStatus.text = "The win"
            gameStatus.textColor = .green
            if game.isNewRecord {
                showAlert()
            } else {
                showAlertActionSheet()
            }
            
        }   
    }
    
    func initializingTheGame(){
        let numbers = game.initialFilling()
        for (index, ship) in numbers.enumerated() {
            numberButton[index].setTitle(String(ship), for: UIControl.State.normal)
            numberButton[index].isEnabled = true
            numberButton[index].alpha = 1
        }
        gameIndicator.text = game.getGameIndicator()
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд!", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func showAlertActionSheet() {
        let alert = UIAlertController(title: "Что вы хотите сделать?", message: nil, preferredStyle: .actionSheet)
        let newGameAction =  UIAlertAction.init(title: "Начать новую игру", style: .default) { [weak self](_) in
            self?.game.newGame()
            self?.initializingTheGame()
        }
        let showRecordAction = UIAlertAction.init(title: "Посмотреть рекорд", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        let menuAction =  UIAlertAction.init(title: "Перейти в меню", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecordAction)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = gameStatus
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
