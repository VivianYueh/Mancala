//
//  statistic.swift
//  HW2
//
//  Created by User06 on 2023/4/7.
//

import SwiftUI

struct statistic: View {
    @Binding var sta:Bool
    @AppStorage("uwin") var uwin: Int = 0
    @AppStorage("p2win") var p2win: Int = 0
    @AppStorage("ulose") var ulose: Int = 0
    @AppStorage("p2lose") var p2lose: Int = 0
    @AppStorage("udraw") var udraw: Int = 0
    @AppStorage("p2draw") var p2draw: Int = 0
    var body: some View {
        ZStack{
            Color(red: 0.0, green: 0.0, blue: 128/255)
                .ignoresSafeArea()
            VStack{
                Text("Statistics")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                HStack{
                    Text("Total")
                    Text("Win")
                    Text("Lose")
                    Text("Draw")
                }
                .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -150))
                Text("--------------------------------------------------------")
                HStack{
                    Text("You       ")
                    Text("      \(uwin+ulose+udraw)")
                    Text("      \(uwin)")
                    Text("      \(ulose)")
                    Text("      \(udraw)")
                }
                .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Text("--------------------------------------------------------")
                HStack{
                    Text("Others      ")
                    Text("\(p2win+p2lose+p2draw)")
                    Text("      \(p2win)")
                    Text("      \(p2lose)")
                    Text("      \(p2draw)")
                }
                .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .frame(width: 570,height: 320)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 224/255, green: 204/255, blue: 255/255), Color(red: 122/255, green: 140/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom))
            .overlay(Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(20)
                        .foregroundColor(.white)
                        .onTapGesture {
                            sta.toggle()
                        }, alignment: .topTrailing)
        }
        
    }
}

struct statistic_Previews: PreviewProvider {
    static var previews: some View {
        statistic(sta:.constant(true))
    }
}

