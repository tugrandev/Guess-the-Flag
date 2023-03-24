//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Tuğran on 22.03.2023.
//

import SwiftUI

struct FlagViews: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}
struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showingResult = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCount = 1
    
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .orange], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                ForEach(0..<9) { number in
                    
                }
                VStack(spacing: 45) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text("\(countries[correctAnswer].uppercased())")
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagViews(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Question:\(questionCount)/8")
                    .foregroundColor(.white)
                    .font(.subheadline.bold())
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
            .alert("\(scoreTitle)", isPresented: $showingScore) {
                Button("Continue", action: askNew)
            } message: {
                Text("Your score is \(userScore)")
            }
            .alert("Game Over!", isPresented: $showingResult) {
                Button("New game", action: newGame)
            } message: {
                Text("Your score was \(userScore)")
            }
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 10
        } else {
            scoreTitle = "Wrong! thats the flag of \(countries[number].uppercased())"
            userScore -= 5
        }
        
        
        if questionCount == 8 {
            showingResult = true
        } else {
            showingScore = true
        }
    }
    
    func askNew() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
        
    }
    
    func newGame() {
        questionCount = 0
        userScore = 0
        askNew()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
