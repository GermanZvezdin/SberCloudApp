//
//  SignUpView.swift
//  App
//
//  Created by German Zvezdin on 26.02.2021.
//

import SwiftUI

struct SignUpView : View {
    
    @State var user = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @Binding var show : Bool
    @State var fs = UserDefaults.standard.value(forKey: "first_log") as? Bool ?? false
    
    var body : some View{
        
        VStack{
            Image("Text")
                .resizable()
                .frame(width: 778/2.5, height: 110/2.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Имя пользователя").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Введите имя пользователя", text: $user)
                        
                        if user != ""{
                            
                            Image("check").foregroundColor(Color.init(.label))
                        }
                        
                    }
                    
                    Divider()
                    
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    
                    Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    SecureField("Введите пароль", text: $pass)
                    
                    Divider()
                }
                
            }.padding(.horizontal, 6)
            
            Button(action: {
                
                                
            }) {
                
                Text("Регистрация").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                
                
            }.background(Color.init(#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1)))
                .clipShape(Capsule())
                .padding(.top, 45)
            
        }.padding()
            .alert(isPresented: $alert) {
                
                Alert(title: Text("Ошибка"), message: Text(self.message), dismissButton: .default(Text("Ok")))
        } .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(show: .constant(true))
    }
}
