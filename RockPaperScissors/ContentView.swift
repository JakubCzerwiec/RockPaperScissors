//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mój Maczek on 04/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["icloud.fill", "doc", "scissors"]
    @State private var move = "Paper"
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let loosingMoves = ["Scissors", "Rock", "Paper"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    var computerMove: String {
        return shouldWin ? loosingMoves[computerChoice] : winningMoves[computerChoice]
    }
    
    @State private var gamesPlayed = 0
    @State private var endGame = false
    var endGameAlert = "Game Over"
    
    var body: some View {
        VStack {
            Section("Pleyers Score") {
                Text("Your score is: \(score)")
            }
            Section("Hall 9000 chooses:") {
                Text("\(computerMove)")
            }
            Section("You should:") {
                Text(shouldWin ? "Win" : "Loose")
            }
            Section("What is your answer?") {
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            play(number)
                            shouldWin.toggle()
                            gamesPlayed += 1
                            checkEnd()
                        } label: {
                            Image(systemName: moves[number])
                        }
                        .padding()
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                    }
                }
            }
            Button("reset") {
                restartGame()
            }
            .alert(endGameAlert, isPresented: $endGame) {
                Button("New Game", action: restartGame)
            } message: {
                Text("Final score is: \(score)")
            }
            
            
        }
    }

    func play (_ number: Int) {
        if number == computerChoice && shouldWin {
            score += 1
            computerChoice = Int.random(in: 0...2)
        } else if number != computerChoice && shouldWin {
            score -= 1
            computerChoice = Int.random(in: 0...2)
        }
        
        if number == computerChoice && !shouldWin {
            score += 1
            computerChoice = Int.random(in: 0...2)
        } else if number != computerChoice && !shouldWin {
            score -= 1
            computerChoice = Int.random(in: 0...2)
        }
    }
    
    func checkEnd() {
        if gamesPlayed > 9 {
            endGame = true
        }
    }
    
    func restartGame() {
        score = 0
        computerChoice = Int.random(in: 0...2)
        gamesPlayed = 0
    }
}

#Preview {
    ContentView()
}
