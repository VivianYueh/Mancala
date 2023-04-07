//
//  setting.swift
//  HW2
//
//  Created by User06 on 2023/4/7.
//

import SwiftUI
import AVFoundation
struct setting: View {
    @Binding var set:Bool
    @Binding var style:Bool
    @Binding var mus:Bool
    @Binding var sound:Bool
    @State var musty = 0
    var body: some View {
        ZStack{
            Color(red: 0.0, green: 0.0, blue: 128/255)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 0){
                Text("Setting")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                    .padding()
                HStack(spacing:0){
                    Text("              Music:")
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                    Text("1")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(musty==1 ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            mus = true
                            musty = 1
                            AVPlayer.bgQueuePlayer.pause()
                            AVPlayer.setupBgMusic1()
                            AVPlayer.bgQueuePlayer.play()
                        }
                    Text("2")
                        .frame(width: 50, height: 30, alignment: .center)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(musty==2 ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            mus = true
                            musty = 2
                            AVPlayer.bgQueuePlayer.pause()
                            AVPlayer.setupBgMusic2()
                            AVPlayer.bgQueuePlayer.play()
                        }
                    Text("Off")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(musty==0 ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            mus = false
                            musty = 0
                            AVPlayer.bgQueuePlayer.pause()
                        }
                }
                HStack(spacing:0){
                    Text("Sound:")
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                    Text("On")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(sound ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            sound=true
                        }
                    Text("Off")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(!sound ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            sound=false
                        }
                }
                HStack(spacing:0){
                    Text("      Style:")
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                    Text("1")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(!style ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            style=false
                        }
                    Text("2")
                        .frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 128/255))
                        .background(style ? Color(red: 208/255, green: 204/255, blue: 255/255) : Color.white )
                        .cornerRadius(30)
                        .padding()
                        .onTapGesture {
                            style=true
                        }
                }
            }.frame(width: 500, height: 300, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 224/255, green: 204/255, blue: 255/255), Color(red: 122/255, green: 140/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom))
            .overlay(Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(20)
                        .foregroundColor(.white)
                        .onTapGesture {
                            set.toggle()
                        }, alignment: .topTrailing)
        }
    }
}

struct setting_Previews: PreviewProvider {
    static var previews: some View {
        setting(set: .constant(true),style: .constant(true),mus:.constant(true),sound:.constant(true))
    }
}

