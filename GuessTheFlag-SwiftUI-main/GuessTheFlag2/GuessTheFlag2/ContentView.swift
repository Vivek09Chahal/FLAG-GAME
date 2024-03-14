//
//  ContentView.swift
//  GuessTheFlag2
//

import SwiftUI

//View Composition
struct FlagImage: View {
    var imageName: String
    var body: some View{
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
        
    }
}

// Custom Modifier
struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.white)
        
    }
}

extension View{
    func titleStyle() -> some View{
        modifier(Title())
    }
}

struct ContentView: View {
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State var score = 0
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.cyan,.yellow]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            //                        RadialGradient(stops: [
            //                            .init(color: Color(red: 0.1, green: 0.45, blue: 0.45), location: 0.3),
            //                            .init(color: Color(red: 0.66, green: 0.15, blue: 0.26), location: 0.3)
            //                        ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag").titleStyle()
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                            //                            Image(countries[number])
                            //                                .renderingMode(.original)
                            //                                .clipShape(Capsule())
                            //                                .shadow(radius: 10)
                        }
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle,isPresented: $showingScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else {
            scoreTitle = "Incorrect"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
