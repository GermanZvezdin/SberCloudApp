//
//  LoginView.swift
//  App
//
//  Created by German Zvezdin on 26.02.2021.
//

import SwiftUI

struct SignInView : View {
    
    @State var user = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    @AppStorage("pin_status") var pinned = false
    @AppStorage("username") var username = ""
    @AppStorage("password") var password = ""
    @AppStorage("X-Subject-Token") var Token = ""
    @ObservedObject var MetaData: MetricsData = MetricsData()
    var body : some View{
        VStack {
            VStack{
                
                Image("Text")
                    .resizable()
                    .frame(width: 778/2.5, height: 110/2.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 30)
                
                    
                
                // поля ввода
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        
                        Text("Имя полльзователя").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        HStack{
                            
                            TextField("Введите ваше имя пользователя", text: $user)
                            
                            if user != ""{
                                
                                Image("check").foregroundColor(Color.init(.label))
                            }
                            
                        }
                        
                        Divider()
                        
                    }.padding(.bottom, 15)
                    
                    VStack(alignment: .leading){
                        
                        Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        SecureField("Введите ваш пароль", text: $pass)
                        
                        Divider()
                    }
                    
                }.padding(.horizontal, 6)
                
                Button(action: {
                    SberCloudApiPostData(login: user, pass: pass) {
                        (res, flag) in
                            if !flag {
                                self.message = "Неверный логин или пароль"
                                self.alert.toggle()
                            } else {
                                Token = res
                                username = user
                                password = pass
                                pinned = true
                            }
                    }
                    
                    
                }) {
                    
                    Text("Вход").foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).frame(width: UIScreen.main.bounds.width - 120).padding()
                    
                    
                }.background(Color.init(#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1)))
                    .clipShape(Capsule())
                    .padding(.top, 30)
                
                
            }.padding()
                .alert(isPresented: $alert) {
                    
                    Alert(title: Text("Ошибка"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            }
            VStack{
                
                Text("(или)").foregroundColor(Color.gray.opacity(0.5)).padding(.top,30)
                
                
                HStack(spacing: 8){
                    
                    Text("Новый пользователь ?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Регистрация")
                        
                    }.foregroundColor(Color.init(#colorLiteral(red: 0.02112478018, green: 0.9086515903, blue: 0.5908379555, alpha: 1)))
                    
                }.padding(.top, 25)
                
            }.sheet(isPresented: $show) {
                
                SignUpView(show: self.$show)
            }
        } .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
