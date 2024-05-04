//
//  ContentView.swift
//  Auto Create
//
//  Created by Gianmarco Lugaresi on 09/02/24.
//

import SwiftUI


struct HomeView: View {
    @State private var isClicked = 0
    
    var body: some View {
            
            VStack{
                if isClicked == 0 {
                    
                    VStack{
                        HStack{
                            Text("AutoCreate")
                                .fontWeight(.bold)
                                .padding(10)
                                .font(.title)
                            Text("© Giamma")
                                .padding(10)
                        }
                        .background(Color.orange)
                        .cornerRadius(8)
                        .padding(.top,-2)
                        
                    }
                    .foregroundColor(.white)
                    .frame(width:300,height: 70)
                    
                    VStack{
                        
                        HStack{
                            Text("• Progetto:")
                            
                            
                                .padding(.top,-20)
                                .fontWeight(.bold)
                            Button("HTML"){
                                withAnimation{
                                    isClicked = 1
                                }
                            }
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .buttonStyle(.borderless)
                            .foregroundColor(.black)
                            
                            .padding(.top,-20)
                        }
                        Spacer()
                        HStack{
                            Text("• Progetto:")
                            
                            
                                .padding(.top,-40)
                                .fontWeight(.bold)
                            Button("Python"){
                                withAnimation{
                                    isClicked = 2
                                }
                            }
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .buttonStyle(.borderless)
                            .foregroundColor(.black)
                            
                            .padding(.top,-50)
                        }
                        Spacer()
                        HStack{
                            Text("• Progetto:")
                            
                            
                                .padding(.top,-50)
                                .fontWeight(.bold)
                            Button("SwiftUI"){
                                withAnimation{
                                    isClicked = 3
                                }
                            }
                            .padding(11)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .buttonStyle(.borderless)
                            .foregroundColor(.black)
                            .padding(.top,-60)
                        }
                        
                    }
                    .frame(width: 180,height:160)
                    .padding(50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                else if isClicked == 1 {
                    HTML()
                        .transition(.opacity)
                }
                else if isClicked == 2{
                    Python()
                        .transition(.opacity)
                }
                else if isClicked == 3 {
                    Swift_UI()
                        .transition(.opacity)
                }
            }
            .padding(50)
            .frame(width:300, height: 350)
            .background(Color.white)
            .environment(\.colorScheme, .light)
            .cornerRadius(10)
        }
    }

struct ConditionalViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeView()
                
        }
    }
}

    
