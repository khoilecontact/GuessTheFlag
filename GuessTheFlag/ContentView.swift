//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by KhoiLe on 15/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "US", "UK"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 10
    @State private var notifyResult = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            
            VStack(spacing: 50) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(contries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.contries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 7) {
                    let score = String(self.userScore)
                    Text("Your score is")
                    Text(score)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(notifyResult), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    //functions
    func flagTapped(_ number: Int) {
        if number==correctAnswer {
            scoreTitle="Correct"
            notifyResult = "Correct! That is the flag of \(contries[correctAnswer])"
            userScore+=1
        } else {
            scoreTitle="Wrong"
            notifyResult = "Wrong! That is the flag of \(contries[number])"
            userScore-=1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
