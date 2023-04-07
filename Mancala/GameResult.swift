//
//  GameResult.swift
//  HW2
//
//  Created by User06 on 2023/4/7.
//

import SwiftUI

struct GameResult: View {
    @Binding var show:Bool
    @Binding var win:Bool
    @Binding var tie:Bool
    @Binding var lose:Bool
    @Binding var tot1:Int
    @Binding var tot2:Int
    @Binding var rev:Bool
    @Binding var style:Bool
    @State var replay = false
    @State var home = false
    var body: some View {
        ZStack{
            GeometryReader{geometry in
                Image("封面")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack{
                    if win {
                        Text("You Win!")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 240/255, green: 204/255, blue: 1.0))
                            .padding()
                    }
                    if tie {
                        Text("Draw!")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 240/255, green: 204/255, blue: 1.0))
                            .padding()
                    }
                    if lose {
                        Text("You Lose!")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 240/255, green: 204/255, blue: 1.0))
                            .padding()
                    }
                    HStack{
                        HStack{
                            Text("You:")
                            Text("\(tot1)")
                        }
                        .frame(width: 180,height: 40)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .padding()
                        .background(Color(red: 240/255, green: 204/255, blue: 1.0))
                        .cornerRadius(10)
                        .padding()
                        HStack{
                            Text(rev ? "    Computer:" : "  Player 2:")
                            Text("\(tot2)")
                        }
                        .frame(width: 180,height: 40)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .padding()
                        .background(Color(red: 240/255, green: 204/255, blue: 1.0))
                        .cornerRadius(10)
                        .padding()
                    }
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                    .padding()
                    HStack{
                        Button("Play Again"){
                            replay.toggle()
                        }
                        .fullScreenCover(isPresented: $replay, content: {
                            if !rev {
                                Main(showMain: $show,style:$style)
                            }
                            else{
                                Computer(showComputer: $show, style: $style)
                            }
                        })
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding()
                        .background(Color(red: 240/255, green: 204/255, blue: 1.0))
                        .cornerRadius(40)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(red: 240/255, green: 204/255, blue: 1.0))
                         )
                        Button("Home"){
                            home.toggle()
                        }
                        .fullScreenCover(isPresented: $home, content: {
                            ContentView()
                        })
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding()
                        .background(Color(red: 240/255, green: 204/255, blue: 1.0))
                        .cornerRadius(40)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(red: 240/255, green: 204/255, blue: 1.0))
                         )
                    }
                }.position(x: geometry.size.width/2, y: geometry.size.height/2)
            }
        }
    }
}

struct GameResult_Previews: PreviewProvider {
    static var previews: some View {
        GameResult(show: .constant(true), win: .constant(true), tie: .constant(true), lose: .constant(true),tot1:.constant(0),tot2:.constant(0),rev:.constant(true),style: .constant(true))
    }
}

