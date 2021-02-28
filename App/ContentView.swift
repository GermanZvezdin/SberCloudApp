//
//  ContentView.swift
//  App
//
//  Created by German Zvezdin on 26.02.2021.
//

import SwiftUI

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}


extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}


struct ContentView: View {
    @State var logged = false
    @AppStorage("use_pin") var pin = true
    @AppStorage("pin_status") var pinned = false
    @State var fs = UserDefaults.standard.value(forKey: "first_log") as? Bool ?? true
    var body: some View {
        NavigationView {
            
            if pinned {
                if pin {
                    if logged || fs {
                        mainView()
                    } else {
                        PinCodeView(Lable: "", isCorrect: $logged)
                    }
                } else {
                    mainView()
                }
            } else {
                SignInView()
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

