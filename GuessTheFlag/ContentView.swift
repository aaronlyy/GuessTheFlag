//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aaron Levi Can on 30.09.24.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var scoreMessage = ""
    
    var body: some View {
        
        // add zstack to add a background gradient
        ZStack {
            // custom radial background with 2 stops and custom colors
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            

            VStack {
                
                Spacer()
                
                Text("GUESS THE FLAG 👻")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                
                VStack(spacing: 15) { // spacing is like gap in css
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary) // change text color
                            .font(.subheadline.weight(.heavy)) // change text font and weight
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number) // action as trailing closure
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule) // add style to image
                                .shadow(radius: 5) // add shadow to image
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Your score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) { // add alert to the whole view
            Button("Continue", action: askQuestion) // view to show in the alert
        } message: { // message to show in the alert
            Text(scoreMessage)
        }
    }
    
    // some extra functions
    func flagTapped(_ number: Int) -> Void {
        if number == correctAnswer {
            scoreTitle = "Right!"
            score += 1
            scoreMessage = "Your score is \(score)"
        }
        else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[correctAnswer])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
