//
//  Computer.swift
//  HW2
//
//  Created by User06 on 2023/4/6.
//

import SwiftUI
import AVFoundation
struct Computer: View {
    var dingPlayer: AVPlayer { AVPlayer.sharedDingPlayer }
    @Binding var showComputer: Bool
    @Binding var style:Bool
    @State  var pits: [Int] = [0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0]
    @State var currentPlayer = 1
    @State var isComputersTurn = false
    @State var sum1 = 0
    @State var sum2 = 0
    @State var tot1 = 0
    @State var tot2 = 0
    @State var endd = false
    @State var sound = false
    @State var mus = false
    @State var set = false
    @State var win = false
    @State var lose = false
    @State var tie = false
    @State var rev = true
    @AppStorage("p1win") var p1win: Int = 0
    @AppStorage("p2win") var p2win: Int = 0
    @AppStorage("ulose") var ulose: Int = 0
    @AppStorage("p1lose") var p1lose: Int = 0
    @AppStorage("p2lose") var p2lose: Int = 0
    @AppStorage("udraw") var udraw: Int = 0
    @AppStorage("p1draw") var p1draw: Int = 0
    @AppStorage("p2draw") var p2draw: Int = 0
    fileprivate func moveStone(idx:Int){
        var stonesToMove = pits[idx]
        pits[idx] = 0
        var currentIndex = idx
        while stonesToMove > 0 {
            if currentIndex > 6 && currentIndex <= 13{
                currentIndex+=1
            }
            else{
                currentIndex-=1
            }
            if currentIndex==14{
                currentIndex=6
            }
            if currentIndex < 0{
                currentIndex = 7
            }
            if currentIndex >= pits.count {
                currentIndex = 0
            }
            if (currentPlayer==1&&currentIndex==0)||(currentPlayer==2&&currentIndex==13){
                continue
            }
            pits[currentIndex] += 1
            stonesToMove -= 1
        }
        if pits[currentIndex]==1{
            if (currentPlayer == 1) && (currentIndex>=7&&currentIndex<=12) && (pits[currentIndex-6] != 0){
                pits[13]=pits[currentIndex]+pits[currentIndex-6]
            }
            if (currentPlayer == 2) && (currentIndex>=1&&currentIndex<=6) && (pits[currentIndex+6] != 0){
                pits[0]=pits[currentIndex]+pits[currentIndex+6]
            }
        }
        for i in 1...6{
            sum1+=pits[6+i]
            sum2+=pits[i]
        }
        if sum1 == 0 || sum2 == 0{
            tot1 = pits[13]+sum1
            tot2 = pits[0]+sum2
            endd.toggle()
            if tot1>tot2{
                win=true
                p1win+=1
                p2lose+=1
            }
            else if tot1 == tot2{
                tie=true
                p1draw+=1
                p2draw+=1
            }
            else{
                lose=true
                p1lose+=1
                p2win+=1
            }
        }
        if (currentIndex != 13 && currentPlayer==1)||(currentIndex != 0 && currentPlayer==2){
            currentPlayer = currentPlayer == 1 ? 2 : 1
        }
    }
    fileprivate func computerMove(){
        let currentIndex = Int.random(in: 1...6)
        moveStone(idx: currentIndex)
    }
    var body: some View {
        ZStack{
            Image(style ? "bg1" : "bg0")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            GeometryReader{geometry in
                VStack(spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                    HStack(alignment: .center, spacing: nil){
                        Text("        ")
                        VStack{
                            Text("\(pits[0])")
                                .font(.system(size: 30))
                            ZStack{
                                RoundedRectangle(cornerRadius: 300)
                                    .stroke(Color(red: 0.0, green: 0.0, blue: 128/255),lineWidth: 3)
                                    .frame(width: 145, height: 290,alignment: .center)
                                ForEach(0..<(pits[0]), id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 300)
                                       .foregroundColor(.clear)
                                       .frame(width: 145, height: 290,alignment: .center)
                                       .overlay(Image(style ? "s1\(Int.random(in: 0...11))" : "s0\(Int.random(in: 0...8))")
                                       .resizable()
                                       .clipShape(Circle())
                                       .scaledToFit()
                                       .frame(width: geometry.size.width/20,height:geometry.size.width/20)
                                       .offset(x:CGFloat.random(in: -floor(geometry.size.width/30)...floor(geometry.size.width/30)), y:CGFloat.random(in: -floor(geometry.size.height/25)...floor(geometry.size.height/25))))
                               }
                            }
                        }
                        ForEach(1..<7){i in
                            VStack{
                                Text("\(pits[i])")
                                    .font(.system(size: 30))
                                ZStack{
                                    Circle()
                                        .stroke((currentPlayer == 2 && pits[i]>0) ? Color.red : Color(red: 0.0, green: 0.0, blue: 128/255),lineWidth: (currentPlayer == 2 && pits[i]>0) ?  5:3)
                                        .frame(width: 145, height: 145, alignment:    .center)
                                        .onTapGesture {
                                            moveStone(idx: i)
                                            if sound && pits[i] > 0{
                                                dingPlayer.playFromStart()
                                            }
                                        }
                                    ForEach(0..<(pits[i]), id: \.self){_ in
                                        Circle()
                                            .foregroundColor(.clear)
                                            .frame(width: 145, height: 145,alignment: .center)
                                            .fullScreenCover(isPresented: $endd, content: {GameResult(show: $showComputer,win:$win,tie:$tie,lose:$lose,tot1:$tot1,tot2:$tot2,rev:$rev,style:$style)})
                                            .overlay(Image(style ? "s1\(Int.random(in: 0...11))" : "s0\(Int.random(in: 0...8))")
                                                        .resizable()
                                                        .clipShape(Circle())
                                                        .scaledToFit()
                                                        .frame(width: geometry.size.width/20,height:geometry.size.width/20)
                                                        .offset(x:CGFloat.random(in: -floor(geometry.size.width/30)...floor(geometry.size.width/30)), y:CGFloat.random(in: -floor(geometry.size.height/25)...floor(geometry.size.height/25)))
                                                        .onTapGesture {
                                                            moveStone(idx: i)
                                                            if sound && pits[i] > 0{
                                                                dingPlayer.playFromStart()
                                                            }
                                                        }
                                            )
                                    }
                                }
                                
                            }
                        }
                        Text("PLAYER2")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                    }
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                        Text("PLAYER1")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                        ForEach(7..<13){i in
                            VStack{
                                ZStack{
                                    Circle()
                                        .stroke((currentPlayer == 1 && pits[i]>0) ? Color.red : Color(red: 0.0, green: 0.0, blue: 128/255),lineWidth: (currentPlayer == 1 && pits[i]>0) ?  5:3)
                                        .frame(width: 145, height: 145, alignment:    .center)
                                        .onTapGesture {
                                            moveStone(idx: i)
                                            if sound && pits[i] > 0{
                                                dingPlayer.playFromStart()
                                            }
                                        }
                                    ForEach(0..<(pits[i]), id: \.self){_ in
                                        Circle()
                                            .foregroundColor(.clear)
                                            .frame(width: 145, height: 145,alignment: .center)
                                            .fullScreenCover(isPresented: $endd, content: {GameResult(show: $showComputer,win:$win,tie:$tie,lose:$lose,tot1:$tot1,tot2:$tot2,rev:$rev,style:$style)})
                                            .overlay(Image(style ? "s1\(Int.random(in: 0...11))" : "s0\(Int.random(in: 0...8))")
                                                        .resizable()
                                                        .clipShape(Circle())
                                                        .scaledToFit()
                                                        .frame(width: geometry.size.width/20,height:geometry.size.width/20)
                                                        .offset(x:CGFloat.random(in: -floor(geometry.size.width/30)...floor(geometry.size.width/30)), y:CGFloat.random(in: -floor(geometry.size.height/25)...floor(geometry.size.height/25)))
                                                        .onTapGesture {
                                                            moveStone(idx: i)
                                                            if sound && pits[i] > 0{
                                                                dingPlayer.playFromStart()
                                                            }
                                                        }
                                            )
                                    }
                                }
                                Text("\(pits[i])")
                                    .font(.system(size: 30))
                            }
                        }
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 300)
                                    .stroke(Color(red: 0.0, green: 0.0, blue: 128/255),lineWidth: 3)
                                    .frame(width: 145, height: 290,alignment: .center)
                                ForEach(0..<(pits[13]), id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 300)
                                        .foregroundColor(.clear)
                                        .frame(width: 145, height: 290,alignment: .center)
                                        .overlay(Image(style ? "s1\(Int.random(in: 0...11))" : "s0\(Int.random(in: 0...8))" )
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width/20,height:geometry.size.width/20)
                                                    .offset(x:CGFloat.random(in: -floor(geometry.size.width/30)...floor(geometry.size.width/30)), y:CGFloat.random(in: -floor(geometry.size.height/25)...floor(geometry.size.height/25)))
                                        )
                                }
                            }
                            Text("\(pits[13])")
                                .font(.system(size: 30))
                        }
                    }
                    HStack{
                        Text("Current Player: \(currentPlayer)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(style ? Color(red: 0.0, green: 0.0, blue: 128/255): .white)
                        Button("Home") {
                            AVPlayer.bgQueuePlayer.pause()
                            showComputer = false
                        }
                        .padding()
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        Button("Setting") {
                            set.toggle()
                        }
                        .sheet(isPresented: $set, content: {setting(set: $set,style: $style,mus:$mus,sound:$sound)})
                        .padding()
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                    }
                    
                }
                .position(x:geometry.size.width/2 ,y:geometry.size.height/2)
                }
        }
        .onChange(of: currentPlayer) { newValue in
                    if newValue == 2 {
                        isComputersTurn = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            computerMove()
                        }
                    } else {
                        isComputersTurn = false
                    }
                }
        }
}

struct Computer_Previews: PreviewProvider {
    static var previews: some View {
        Computer(showComputer:.constant(true),style: .constant(true))
    }
}

