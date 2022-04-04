
import Foundation

enum StatusGame {
    case start
    case win
    case loss
}

class Game {
 
    let cells: Int?
    var newNumbers: [Int]
    var isNewRecord = false
    var status: StatusGame{
        didSet{
            if status == .win {
                stopTimer()
                let newRecord = timeForGame - timelineGame
                let record = UserDefaults.standard.integer(forKey: KeyUserDefaults.recordGame)
                if newRecord < record || record == 0 {
                    UserDefaults.standard.setValue(newRecord, forKey: KeyUserDefaults.recordGame)
                    isNewRecord = true
                }
            }
            checkStatus()
        }
    }
    private let timeForGame: Int
    private let checkStatus: () -> ()
    private var timelineGame: Int{
        didSet{
            getSecond(timelineGame)
            if timelineGame == 0 {
                status = .loss
                stopTimer()
            }
        }
    }
    private var timer: Timer?
    private let getSecond: (Int)-> ()
    
    
    func initialFilling() -> [Int]{
         getSecond(timelineGame)
        return newNumbers
    }
    
    func getGameIndicator() -> String {
           // let randomElement = newNumbers.randomElement() ?? 0
                if newNumbers.count > 0{
                    newNumbers = newNumbers.shuffled()
                return String(newNumbers.removeLast())
                } else {
                    status = .win
                    return ""
                }
        }
    
    func newGame(){
        status = .start
        isNewRecord = false
        newNumbers = Array(1...99).shuffled()
        newNumbers.removeLast(99 - (cells ?? 0))
        timelineGame = timeForGame
        if !(timer?.isValid ?? false) {
            startTimer()
        }
        UserDefaults.standard.setValue(0, forKey: KeyUserDefaults.recordGame)
    }
   
    func stopTimer(){
        timer?.invalidate()
    }
    
    private func startTimer() {
        if Settings.shared.currentSettings.timerState {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
          self?.timelineGame -= 1
        }
        )}
    }
        
    init(cells: Int, checkStatus: @escaping () -> (), getSecond: @escaping (Int) -> ()) {
        status = .start
        self.cells = cells
        timeForGame = Settings.shared.currentSettings.timeForGame
        timelineGame = timeForGame
        newNumbers = Array(1...99).shuffled()
        newNumbers.removeLast(99 - cells)
        self.getSecond = getSecond
        self.checkStatus = checkStatus
        startTimer()
    }
       
    }

extension Int{
    
    func showTimer() -> String {
    
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}
