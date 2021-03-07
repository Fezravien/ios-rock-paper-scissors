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
enum GameConditionNumbers: Int {
    case endGame = 0
    case initValue = -1
}
enum GameConditionStrings: String {
    case userTurn = "User"
    case computerTurn = "Computer"
    case endGamePresent = "게임 종료"
}
enum JudgeOfUserAtRockscissorsPaper: Int {
    case userSelectWinRockScissors = 1
    case userSelectWinScissors = -2
    case userSelectLoseScissorsRock = -1
    case userSelectLosePaper = 2
    case userSelectDraw = 0
}

// MARK: - RockScissorsPaperGame Class

class RockScissorsPaperGame {
    var userInput: Hand = .initHand
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
    
    func createRandomNumber() -> Hand {
        let rock1Scissors2Paper3 = Hand.allCases.map { $0 }[Int.random(in: 1...3)]
        return rock1Scissors2Paper3
    }
    
    // MARK: - User input valid check
    
    func userTyping() throws -> Hand {
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
    
    func judgeGames(userNumber userState: Hand, computerNumber computerState: Hand) throws -> GameConditionStrings {
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
                return .userTurn
            } else if computerWinStatus.contains(decisionStatus) {
                printJudge(gameResult: .lose)
                return .computerTurn
            }
        }
        throw GameRestart.unknown
    }
    
    // MARK: - Error
    
    func printError() {
        print("잘못된 입력입니다. 다시 시도해주세요.")
    }
    func finishGame() {
        print(GameConditionStrings.endGamePresent.rawValue)
    }
    func printJudge(gameResult: GameResult) {
        print(gameResult.rawValue)
    }
    
    // MARK: - RockScissorsPaper Print
    
    func gameMenuPresent() {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
    }
}

// MARK: - MukChiPaGame Class

class MukChiPaGame: RockScissorsPaperGame {
    var mukChiPaTurn: GameConditionStrings
    init(mukChiPaTurn: GameConditionStrings) {
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
                let judgeString = try judgeGames(userNumber: userInput, computerNumber: computerNumber)
                guard judgeString != .endGamePresent else {
                    print(judgeString)
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
    
    override func judgeGames(userNumber userState: Hand, computerNumber computerState: Hand) throws -> GameConditionStrings {
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
                mukChiPaTurn = .userTurn
                throw GameRestart.beginAgain
            } else if computerWinStatus.contains(decisionStatus) {
                mukChiPaTurn = .computerTurn
                throw GameRestart.beginAgain
            }
        }
        throw GameRestart.unknown
    }
    
    // MARK: - MukChiPa Print
    
    override func gameMenuPresent() {
        print("[\(mukChiPaTurn) 턴] 묵(1), 찌(2), 빠(3)! <종료: 0>", terminator: " : ")
    }
    func turnCheckPresent() {
        print("\(mukChiPaTurn)의 턴입니다")
    }
    
}

// MARK: - RockScissorsPaperGame instance && Start point

RockScissorsPaperGame().startGame()
