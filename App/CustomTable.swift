//
//  CustomTable.swift
//  Custom TabView
//
//  Created by Alex on 26.02.2021.
//

import SwiftUI

struct CustomTable: View {
    @Binding var index : Int
    @Binding var PlusButton : Bool
    @StateObject var AData: AddData
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Button(action : {
                            self.index = 0
                        }) {
                            Image("house")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                        .foregroundColor(self.index == 0 ? Color("GreenLine"): Color.black)
                        
                        Text("Home")
                            .foregroundColor(self.index == 0 ? Color.black: Color("DarkChart"))
                            .offset(y: -10)
                    }
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            self.index = 1
                        }) {
                            Image("globe")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                        .foregroundColor(self.index == 1 ? Color("GreenLine"): Color.black)
                        Text("Overview")
                            .foregroundColor(self.index == 1 ? Color.black: Color("DarkChart"))
                            .offset(y: -10)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            self.index = 2
                        }) {
                            Image("MyPanel")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .foregroundColor(self.index == 2 ? Color("GreenLine"): Color.black)
                        Text("My panel")
                            .foregroundColor(self.index == 2 ? Color.black: Color("DarkChart"))
                            .offset(y: -10)
                        
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 45)
                .offset(y: 15)
                .background(Color.white)
                .preferredColorScheme(.light)

            }
            
            if self.index == 2{
                Spacer()
                HStack {
                    Spacer()
                    withAnimation {
                        Button(action: {
                            PlusButton.toggle()
                        }) {
                            Image("Plus")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("GreenLine"))
                                .clipShape(Circle())
                                .offset(x: -10, y: -30)
                                .shadow(color: Color.black.opacity(0.3), radius: 8)
                        }
                        .sheet(isPresented: $PlusButton){
                            AddMetric(AData: AData, isShow: $PlusButton)
                                .environmentObject(MetricsData())

                        }
                        
                    }
                }
            }
            
        }
    }
}


