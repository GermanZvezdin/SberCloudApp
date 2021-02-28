//
//  PinCodeView.swift
//  App
//
//  Created by German Zvezdin on 27.02.2021.
//


import SwiftUI
import LocalAuthentication

struct PinCodeView: View {
    @State var Lable: String
    @State var pin: String = ""
    @State var useBiometric = false
    @State var pinlen = 0
    @Binding var isCorrect: Bool
    @State var showAlert = false
    var body: some View {
        VStack{
            Image("Text")
                .resizable()
                .frame(width: 778/2.5, height: 110/2.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 80)
            
            HStack(spacing:15){
                Circle()
                    .frame(width: 10,height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.init(pin.count >= 1 ?#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1):#colorLiteral(red: 0.2059755325, green: 0.2463819385, blue: 0.2839548886, alpha: 1)))
                Circle()
                    .frame(width: 10,height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.init(pin.count >= 2 ?#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1):#colorLiteral(red: 0.2059755325, green: 0.2463819385, blue: 0.2839548886, alpha: 1)))
                Circle()
                    .frame(width: 10,height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.init(pin.count >= 3 ?#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1):#colorLiteral(red: 0.2059755325, green: 0.2463819385, blue: 0.2839548886, alpha: 1)))
                Circle()
                    .frame(width: 10,height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.init(pin.count >= 4 ?#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1):#colorLiteral(red: 0.2059755325, green: 0.2463819385, blue: 0.2839548886, alpha: 1)))
            }.padding(.bottom, 30)
            
            KeyPad(string: $pin, showAlert: $showAlert, Biometric: $useBiometric, isCorrect: $isCorrect)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Ошибка"), message: Text("Неверный пин-код"), dismissButton: .default(Text("Ок")))
                }
            Spacer()
           
        }
    }
}


struct KeyPadButton: View {
    var key: String
    var body: some View {
        Button(action: { self.action(self.key) }) {
            if key != "22" && key != "⌫" {
                Text(key)
                    .font(.system(size: 40))
                    .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .padding(20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            } else if key == "⌫"{
                Text(key)
                    .font(.system(size: 40))
                    .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .padding(.trailing, 37)
                    .padding(.leading, 25)
            } else {
                Image("face")
                    .padding(.trailing, 15)
                    .padding(.leading, 35)
            }
                
        }
    }

    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }

    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct KeyPadRow: View {
    var keys: [String]

    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}


func authenticate(_ completion:@escaping (_ flag: Bool)->Void) {
    let context = LAContext()
    var error: NSError?
    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "We need to unlock your data."

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    } else {
        // no biometrics
    }

}


struct KeyPad: View {
    @Binding var string: String
    @AppStorage("pin") var corpin: String = "0000"
    @Binding var showAlert: Bool
    @Binding var Biometric: Bool
    @Binding var isCorrect: Bool
    @State var scanner = LAContext()
    @AppStorage("pin_status") var pinned = false
    var body: some View {
        VStack(spacing: 0){
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: ["22", "0", "⌫"])
        }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }

    private func keyWasPressed(_ key: String) {
       print(string)
        if key ==  "⌫"{
            if !string.isEmpty{
                string.removeLast()
            }
        } else if key == "22" {
            authenticate() {
                (res) in
                if res {
                    isCorrect = true
                } else {
                    showAlert = true
                }
            }
        } else {
            string += key
        }
        if string.count == 4 {
            if string == corpin {
                isCorrect = true
            } else {
                showAlert = true
                string = ""
            }
        }
    }
}


struct PinCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeView(Lable: "Hello", isCorrect: .constant(true))
    }
}
