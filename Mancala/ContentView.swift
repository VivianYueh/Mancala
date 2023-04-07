//
//  ContentView.swift
//  HW2
//
//  Created by User06 on 2023/3/22.
//
import SwiftUI
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension:
        "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()

    func playFromStart() {
        seek(to: .zero)
        play()
    }
    
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    static func setupBgMusic() {
        guard let url = Bundle.main.url(forResource: "bgm",
        withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    static func setupBgMusic1() {
        guard let url = Bundle.main.url(forResource: "bgm1",
        withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    static func setupBgMusic2() {
        guard let url = Bundle.main.url(forResource: "bgm2",
        withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
}
struct ContentView: View {
    @State var showMain = false
    @State var showComputer = false
    @State var showrule = false
    @State var computer = false
    @State var human = false
    @State var style = false
    @State var sta = false
    @AppStorage("uwin") var uwin: Int = 0
    @AppStorage("p2win") var p2win: Int = 0
    @AppStorage("ulose") var ulose: Int = 0
    @AppStorage("p2lose") var p2lose: Int = 0
    @AppStorage("udraw") var udraw: Int = 0
    @AppStorage("p2draw") var p2draw: Int = 0
    var body: some View {
        ZStack{
            Image("封面")
                .resizable()
                .ignoresSafeArea()
                .onAppear(){
                    AVPlayer.setupBgMusic()
                    AVPlayer.bgQueuePlayer.play()
                }
            GeometryReader{geometry in
                VStack{
                    Text("Mancala")
                        .font(.system(size: 200, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 1.0, green: 0.843, blue: 0.0))
                    HStack{
                        Button("VS. Computer") {
                            showComputer = true
                            computer.toggle()
                            AVPlayer.setupBgMusic()
                            AVPlayer.bgQueuePlayer.pause()
                        }
                        .font(.system(size: 30))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showComputer) {
                            Computer(showComputer: $showComputer,style:$style)
                        }
                        Button("VS. Human") {
                            showMain = true
                            human.toggle()
                            AVPlayer.setupBgMusic()
                            AVPlayer.bgQueuePlayer.pause()
                        }
                        .font(.system(size: 30))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showMain) {
                            Main(showMain: $showMain,style:$style)
                        }
                    }
                    HStack{
                        Button("Statistics") {
                            sta.toggle()
                        }
                        .font(.system(size: 30))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .sheet(isPresented: $sta, content: {statistic(sta:$sta)})
                        Button("How to Play") {
                            showrule = true
                        }
                        .font(.system(size: 30))
                        .frame(width: geometry.size.width/6.9,height: geometry.size.height/17)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showrule) {
                            rule(showrule: $showrule)
                        }
                    }
                }
                .padding(EdgeInsets(top: geometry.size.height/3, leading: geometry.size.width/4, bottom: 0, trailing: 0))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

