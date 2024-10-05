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
        NavigationStack {
            
        
            ZStack {
                LinearGradient(stops: [
                    .init(color: .white, location: 0.48), // zacznie się tu
                    .init(color: .black, location: 0.55), // a skończy tu
                ], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Section("Your score is: \(score)") {
                        
                            
                    }
                        .font(.title)
                    Section("Hall 9000 chooses:") {
                        Text("\(computerMove)")
                            .fontWeight(.bold)
                    }
                        .font(.title)
                    Section("You should:") {
                        Text(shouldWin ? "Win" : "Loose")
                            .fontWeight(.bold)
                    }
                        .font(.title)
                        
                    Spacer()
                    Section("What is your answer?") {
                        HStack {
                            ForEach(0..<3) { number in
                                Button {
                                    play(number)
                                    shouldWin.toggle()
                                    reshuffle()
                                    gamesPlayed += 1
                                    checkEnd()
                                } label: {
                                    Image(systemName: moves[number])
                                }
                                .padding()
                                .fontWeight(.bold)
                                .font(.system(size: 50))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    Spacer()
                    
                    // Restart button
                    Button("Restart") {
                        restartGame()
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                    
                    // Alert after 10 games
                    .alert(endGameAlert, isPresented: $endGame) {
                        Button("New Game", action: restartGame)
                    } message: {
                        Text("Final score is: \(score)")
                    }
                }
            }
            .navigationTitle("Rock - Paper - Scissors")
        }
    }

    // Game logic
    func play (_ number: Int) {
        if number == computerChoice && shouldWin {
            score += 1
        } else if number != computerChoice && shouldWin {
            score -= 1
        }
        
        if number == computerChoice && !shouldWin {
            score += 1
        } else if number != computerChoice && !shouldWin {
            score -= 1
        }
    }
    
    // Drawing computer choice
    func reshuffle() {
        computerChoice = Int.random(in: 0...2)
    }
    
    // Condition to end the game
    func checkEnd() {
        if gamesPlayed > 9 {
            endGame = true
        }
    }
    
    // Restarting game
    func restartGame() {
        score = 0
        computerChoice = Int.random(in: 0...2)
        gamesPlayed = 0
    }
}

#Preview {
    ContentView()
}
