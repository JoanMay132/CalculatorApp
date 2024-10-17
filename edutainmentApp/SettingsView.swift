import SwiftUI

struct settingsView: View {
    @Binding var isPresented: Bool
    @Binding var selectedNumber: Int
    var onChange: () -> Void
    @State private var rotationAngle : Double = 0
    var body: some View {
        VStack {
            Spacer()
            Text("Settings")
                .font(.title)
            Image("dog")
                .rotationEffect(.degrees(rotationAngle))
                .animation(.default, value: rotationAngle)
            Spacer()
            Text("Select a number to multiply")
                Picker("Select a number", selection: $selectedNumber) {
                    ForEach(1..<11) { number in
                        Text("\(number)").tag(number)
                    }
                }
                
                .pickerStyle(.palette)
                .onChange(of: selectedNumber) { oldValue, newValue in
                    rotationAngle += 360
                    onChange()
                }
            
            Spacer()
        
            Button(action: {
                isPresented = false
                
                onChange() // Llama a la función para generar una nueva pregunta
            }) {
                Text("Close settings")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // Prototipo de vista para ver la apariencia
        settingsView(isPresented: .constant(true), selectedNumber: .constant(1), onChange: {})
    }
}
