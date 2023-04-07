//
//  rule.swift
//  HW2
//
//  Created by User06 on 2023/3/29.
//

import SwiftUI

struct rule: View {
    @Binding var showrule: Bool
    @State var st = 0
    @State  var r: [Int] = [0,0,1,1,1,1,2,4,4]
    var body: some View {
        let Arr = ["遊戲目標是讓靠近自己這排的右邊大洞裝滿愈多的寶石，遊戲結束時將比較雙方大洞的寶石數量。","一開始每人有 24 顆寶石，一個小洞裝 4 顆。","輪到玩家的回合時，玩家可移動自己某個小洞的寶石。(大洞的寶石無法移動，大洞的寶石數量代表分數）","玩家移動的最後一顆寶石落在自己的大洞時，可以再次移動自己小洞的寶石。","寶石移動時不可落在對手的大洞，若遇到對手的大洞，請視而不見跳過。","玩家移動的最後一顆寶石落在自己空的小洞，而且此洞的對面也有寶石時，兩個洞的寶石將被收到玩家的大洞，開心地進補大量分數。","當某一邊的小洞沒有寶石時遊戲結束，此時畫面上小洞的寶石也會成為分數，它們將全部移動到大洞。","大洞裡寶石較多的玩家獲勝。"]
        ZStack{
            Image("封面")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            VStack{
                Image("r\(r[st])")
                    .resizable()
                    .frame(width: 900, height: 500, alignment: .center)
                HStack{
                    Button{
                        st-=1
                        if st == -1{
                            st=7
                        }
                    }label:{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    .padding(5)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                    Spacer()
                    Text(Arr[st])
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .truncationMode(.head)
                    Spacer()
                    Button{
                        st+=1
                        if st == 8{
                            st=0
                        }
                    }label:{
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    .padding(5)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                }
                .padding(5)
                .frame(width: 900, height: 100)
                .lineLimit(2)
                .background(Color.black)
                .cornerRadius(10)
                ProgressView(value: Double(st+1),total:8)
                    .accentColor(.white)
                    .background(Color.clear)
                Button("HOME") {
                    showrule = false
                    st=0
                }
                .padding(5)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
            }
        }
    }
}

struct rule_Previews: PreviewProvider {
    static var previews: some View {
        rule(showrule: .constant(true))
    }
}

