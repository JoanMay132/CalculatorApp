import SwiftUI

struct NewGame: View {
    var question: (Int, Int)
    var nextQuestion: () -> Void
    var answer: Int
    var possibleAnswers: [Int]
    @State private var scoreTitle: String = ""
    @State private var showingScore: Bool = false
    @State private var selectedAnswer: Int? = nil
    @State private var score: Int = 0
    @State private var gameOver: Bool = false
    @State private var animals : [String] = ["chick", "bear", "buffalo", "chicken"]
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .yellow], center: .bottom, startRadius: 110, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                
                Text("Calculator Game")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .font(.system(size: 500))
                    
                if !gameOver {
                    Image(animals.randomElement()!)
                }else {
                    Spacer()
                    Image("chick")
                    Text("Looseer!")
                        .background(.red)
                        .padding()
                        .foregroundStyle(.white)
                        .font(.title)
                    Spacer()
                    Spacer()
                }
                
                Text("\(question.0) * \(question.1)")
                    .font(.largeTitle)
                    .padding()
                
                ForEach(possibleAnswers, id: \.self) { possibleAnswer in
                    Button(action: {
                        numberTapped(possibleAnswer)
                    }) {
                        Text("\(possibleAnswer)")
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .rotation3DEffect(.degrees(selectedAnswer == possibleAnswer && selectedAnswer == answer ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: selectedAnswer)
                }
                Spacer()
                Text("Score: \(score)")
                    .font(.title.weight(.semibold))
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                // Botón de alerta dependiendo del estado del juego
                Button(gameOver ? "Restart" : "Continue", action: askQuestion)
                
            } message: {
                Text("Your score is: \(score)")
            }
        }
    }
    
    func askQuestion() {
        if gameOver {
            score = 0
            gameOver = false
        }
        // Aquí podrías llamar a nextQuestion() para generar una nueva pregunta
        selectedAnswer = nil
        nextQuestion()
    }

    func numberTapped(_ number: Int) {
        
        if number == answer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! The correct answer is \(answer)."
            gameOver = true
        }
        selectedAnswer = number
        showingScore = true
    }
}

struct ContentView: View {
    @State private var question: (Int, Int) = (1, 1)
    @State private var isSettingsPresented = false
    @State private var selectedNumber: Int = 1
    @State private var answer: Int = 0
    @State private var possibleAnswers: [Int] = []

    var body: some View {
        
         
        NavigationView {
            ZStack {
                RadialGradient(colors: [.yellow, .blue], center: .bottom, startRadius: 600, endRadius: 800)
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome to Edutainment")
                        .font(.title.weight(.bold))
                    Image("chick")
                    
                        .font(.title)
                        .padding()
                    
                    NavigationLink(destination: NewGame(question: question, nextQuestion: generateQuestion, answer: answer, possibleAnswers: possibleAnswers)) {
                        Text("Play New Game")
                            .newGameButton()
                    }
                    .onAppear(perform: generateQuestion) // Generar pregunta cuando aparece la vista
                    
                    Button(action: {
                        isSettingsPresented.toggle()
                    }) {
                        Text("Open Settings")
                            .settingsButton()
                    }
                    .sheet(isPresented: $isSettingsPresented) {
                        settingsView(isPresented: $isSettingsPresented, selectedNumber: $selectedNumber, onChange: generateQuestion)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
            }
        }
    }
    func generateQuestion() {
        // Selecciona una multiplicación aleatoria entre 1 y 10
        let multiplier = Int.random(in: 1...10)
        question = (selectedNumber, multiplier)

        // Respuesta correcta
        answer = (selectedNumber * multiplier)

        // Almacena respuestas aleatorias
        possibleAnswers = [answer]
        while possibleAnswers.count < 4 {
            let possibleAnswer = Int.random(in: answer...100)
            if !possibleAnswers.contains(possibleAnswer) {
                possibleAnswers.append(possibleAnswer)
            }
        }
        possibleAnswers.shuffle()
    }
}

#Preview {
    ContentView()
}
