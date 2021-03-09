//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//
enum GameRestart: Error {
    case inputValue
    case beginAgain
    case unknown
    case exit
}
enum Hand: Int, CaseIterable {
    case rock = 1
    case scissors = 2
    case paper = 3
    case initHand = 0
}
enum GameResult: String {
    case win = "이겼습니다!"
    case lose = "졌습니다!"
    case draw = "비겼습니다!"
}
enum JudgeOfUserAtRockscissorsPaper: Int {
    case userSelectWinRockScissors = 1
    case userSelectWinScissors = -2
    case userSelectLoseScissorsRock = -1
    case userSelectLosePaper = 2
    case userSelectDraw = 0
}
struct GameCondition {
    static let endGame = 0
    static let initValue = -1
    static let userTurn = "User"
    static let computerTurn = "Computer"
    static let endGamePresent = "게임 종료"
}

// MARK: - RockScissorsPaperGame Class

class RockScissorsPaperGame {
    fileprivate var userInput: Hand = .initHand
    func startGame() {
        for _ in 0...Int.max {
            gameMenuPresent()
            let computerNumber = createRandomNumber()
            do {
                userInput = try userTyping()
            } catch {
                printError()
                continue
            }
            do {
                let judgedGame = try judgeGames(userNumber: userInput, computerNumber: computerNumber)
                MukChiPaGame(mukChiPaTurn: judgedGame).startGame()
            } catch GameRestart.exit {
                break
            } catch GameRestart.beginAgain {
                printJudge(gameResult: .draw)
                continue
            } catch {
            }
            break
        }
    }
    
    // MARK: - Computer Number
    
    fileprivate func createRandomNumber() -> Hand {
        let rock1Scissors2Paper3 = Hand.allCases.map { $0 }[Int.random(in: 1...3)]
        return rock1Scissors2Paper3
    }
    
    // MARK: - User input valid check
    
    fileprivate func userTyping() throws -> Hand {
        var validedInputNumber: Hand = .initHand
        let optionalInput = readLine()
        do {
            validedInputNumber = try isValidInput(needValidInput: optionalInput)
        } catch {
            throw GameRestart.inputValue
        }
        return validedInputNumber
    }
    private func isValidInput(needValidInput userInput: String?) throws -> Hand {
        var valiedNumber: Hand = .initHand
        do {
            valiedNumber = try isCheckedInput(needCheckInput: userInput)
        } catch {
            throw GameRestart.inputValue
        }
        return valiedNumber
    }
    private func isCheckedInput(needCheckInput userInput: String?) throws -> Hand {
        let validNumbers = Hand.allCases.map { $0.rawValue }
        guard let validString = userInput,
              let validedNumber = Int(validString),
              validNumbers.contains(validedNumber),
              let validedHandValue = Hand(rawValue: validedNumber) else {
            
            throw GameRestart.inputValue
        }
        return validedHandValue
    }
    
    // MARK: - Game judge
    
    fileprivate func judgeGames(userNumber userState: Hand, computerNumber computerState: Hand) throws -> String {
        guard let decisionStatus = JudgeOfUserAtRockscissorsPaper(rawValue: userState.rawValue - computerState.rawValue) else {
            throw GameRestart.unknown
        }
        let userWinStatus: [JudgeOfUserAtRockscissorsPaper] = [.userSelectWinRockScissors, .userSelectWinScissors]
        let computerWinStatus: [JudgeOfUserAtRockscissorsPaper] = [.userSelectLoseScissorsRock, .userSelectLosePaper]
        let userComputerDraw: JudgeOfUserAtRockscissorsPaper = .userSelectDraw
        if userState == .initHand {
            finishGame()
            throw GameRestart.exit
        } else if decisionStatus == userComputerDraw {
            printJudge(gameResult: .draw)
            throw GameRestart.beginAgain
        } else {
            if userWinStatus.contains(decisionStatus) {
                printJudge(gameResult: .win)
                return GameCondition.userTurn
            } else if computerWinStatus.contains(decisionStatus) {
                printJudge(gameResult: .lose)
                return GameCondition.computerTurn
            }
        }
        throw GameRestart.unknown
    }
    
    // MARK: - Error
    
    fileprivate func printError() {
        print("잘못된 입력입니다. 다시 시도해주세요.")
    }
    fileprivate func finishGame() {
        print(GameCondition.endGamePresent)
    }
    fileprivate func printJudge(gameResult: GameResult) {
        print(gameResult.rawValue)
    }
    
    // MARK: - RockScissorsPaper Print
    
    fileprivate func gameMenuPresent() {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
    }
}

// MARK: - MukChiPaGame Class

class MukChiPaGame: RockScissorsPaperGame {
    private var mukChiPaTurn: String
    init(mukChiPaTurn: String) {
        self.mukChiPaTurn = mukChiPaTurn
    }
    
    override func startGame() {
        for _ in 0...Int.max {
            gameMenuPresent()
            let computerNumber = createRandomNumber()
            do {
                userInput = try userTyping()
            } catch {
                printError()
                continue
            }
            do {
                let judged = try judgeGames(userNumber: userInput, computerNumber: computerNumber)
                guard judged != GameCondition.endGamePresent else {
                    print(judged)
                    break
                }
                print("\(mukChiPaTurn)의 승리!")
            } catch GameRestart.exit {
                break
                
            } catch GameRestart.beginAgain {
                turnCheckPresent()
                continue
            } catch {
                
            }
            break
        }
    }
    
    // MARK: - Game judge
    
    override func judgeGames(userNumber userState: Hand, computerNumber computerState: Hand) throws -> String {
        guard let decisionStatus = JudgeOfUserAtRockscissorsPaper(rawValue: userState.rawValue - computerState.rawValue) else {
            throw GameRestart.unknown
        }
        let userWinStatus: [JudgeOfUserAtRockscissorsPaper] = [.userSelectWinRockScissors, .userSelectWinScissors]
        let computerWinStatus: [JudgeOfUserAtRockscissorsPaper] = [.userSelectLoseScissorsRock, .userSelectLosePaper]
        let userComputerDraw: JudgeOfUserAtRockscissorsPaper = .userSelectDraw
        if userState == .initHand {
            finishGame()
            throw GameRestart.exit
        } else if decisionStatus == userComputerDraw {
            printJudge(gameResult: .win)
            throw GameRestart.exit
        } else {
            if userWinStatus.contains(decisionStatus) {
                mukChiPaTurn = GameCondition.userTurn
                throw GameRestart.beginAgain
            } else if computerWinStatus.contains(decisionStatus) {
                mukChiPaTurn = GameCondition.computerTurn
                throw GameRestart.beginAgain
            }
        }
        throw GameRestart.unknown
    }
    
    // MARK: - MukChiPa Print
    
    override func gameMenuPresent() {
        print("[\(mukChiPaTurn) 턴] 묵(1), 찌(2), 빠(3)! <종료: 0>", terminator: " : ")
    }
    fileprivate func turnCheckPresent() {
        print("\(mukChiPaTurn)의 턴입니다")
    }
}

// MARK: - RockScissorsPaperGame instance && Start point

RockScissorsPaperGame().startGame()

