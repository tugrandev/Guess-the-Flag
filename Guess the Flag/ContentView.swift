//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Tuğran on 22.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .orange], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack(spacing: 50) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                        .font(.largeTitle.weight(.heavy))
                    Text("\(countries[correctAnswer].uppercased())")
                        .foregroundColor(.black)
                        .font(.largeTitle.weight(.bold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                    }
                }
                
            }
        }
        .alert("\(scoreTitle)", isPresented: $showingScore) {
            Button("Continue", action: askNew)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askNew() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
