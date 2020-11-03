//
//  showPictureView.swift
//  hw3_147
//
//  Created by User11 on 2020/10/27.
//

import SwiftUI
import AVFoundation

struct showPictureView: View {
    @State private var isPlay = false
    let player = AVPlayer(url:Bundle.main.url(forResource: "music", withExtension: "mp4")!)
    let time = String(Float.random(in: 0...3))
    

    func message() -> String {
            return "恭喜！！！此商品在" + time + "秒內被秒殺完畢！！"
        }
    var body: some View {
        VStack{
            Image("soldout")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                .clipped()
            Text(message())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Toggle("來點慶祝音樂", isOn: $isPlay)
                            .onChange(of: isPlay, perform: { value in
                                
                                if value {
                                    player.play()
                                } else {
                                    player.pause()
                                }
                            })
                .padding()
        }
        
        
    
            
    }
}

struct showPictureView_Previews: PreviewProvider {
    static var previews: some View {
        showPictureView()
    }
}
