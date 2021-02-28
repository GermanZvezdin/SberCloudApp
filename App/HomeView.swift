//
//  HomeView.swift
//  Custom TabView
//
//  Created by Alex on 28.02.2021.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("pin_status") var pinned = false
    @AppStorage("username") var username = ""
    @AppStorage("password") var password = ""
    @AppStorage("X-Subject-Token") var Token = ""
    var body: some View {
        HStack{
        VStack(alignment: .leading){
                Text("Home")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Choose the managment service")
                    .fontWeight(.light)
                    Button(action: {
                        pinned = false
                        Token = ""
                        username = ""
                        password = ""
                    }, label: {
                        Text("Выход")
                    })
            }
            Spacer()
        }
        .padding(30)
        ZStack {
            Button(action: {

            }) {
                Text("")
                    .frame(width: 350, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("DarkChart"))
                    )
            }
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Cloud Eye")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("Resource monitoring and alarm notifications")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
           
        }
        
        ZStack {
            Button(action: {

            }) {
                Text("")
                    .frame(width: 350, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("DarkChart"))
                    )
            }
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Application Operation Management")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("Resource monitoring and alarm notifications")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
           
        }
        
        ZStack {
            Button(action: {

            }) {
                Text("")
                    .frame(width: 350, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("DarkChart"))
                    )
            }
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Cloud Trace Service")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("Resource monitoring and alarm notifications")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
           
        }
        
        ZStack {
            Button(action: {

            }) {
                Text("")
                    .frame(width: 350, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("DarkChart"))
                    )
            }
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Application Performance Management")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("Resource monitoring and alarm notifications")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            
            
           
        } .onAppear {
            UserDefaults.standard.set(false, forKey: "first_log")
        }
        
        
        
        
    }
}
