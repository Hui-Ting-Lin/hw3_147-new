//
//  homePage.swift
//  hw3_147
//
//  Created by User11 on 2020/10/27.
//

import SwiftUI

struct homePage: View {
    @State private var brightnessAmount: Double = 0
    @State private var widthAmount: CGFloat = UIScreen.main.bounds.size.width/1.5
    @State private var xAmount: CGFloat = UIScreen.main.bounds.size.width/2
    @State private var yAmount: CGFloat = UIScreen.main.bounds.size.width/2
    @State private var selectedColor = Color.white
    @State private var selectedIndex = 0
    @State private var isJB = false
    @State private var selectDate = Date()
    @State private var price = ""
    @State private var isPresented = false
    @State private var showAlert = false
    @State private var backGround = "抱枕"
    
    
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -6, to: Date())!
    var year: Int{
        Calendar.current.component(.year, from: selectDate)
    }
    var images = ["花花豬", "崇拜豬", "跳舞豬", "難過豬", "Peter"]
    var background = ["抱枕", "馬克杯", "T-shirt"]
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                ImageView(isJB: isJB, selectedColor: selectedColor, widthAmount: widthAmount, brightnessAmount: brightnessAmount, xAmount: xAmount, yAmount: yAmount, selectedIndex: selectedIndex, backGround: backGround, year: year)
                
                NavigationView{
                    Form{
                        HStack{
                            Toggle("我要用JB照", isOn: $isJB)
                        }
                        DisclosureGroup("選擇商品"){
                            VStack(alignment: .leading) {
                                ForEach(background.indices) { (index) in
                                    Text(background[index])
                                        .onTapGesture{
                                            backGround = background[index]
                                        }
                                }
                            }
                        }
                        
                        if isJB{
                            DatePicker("選擇JB時期", selection: $selectDate, in: startDate...today,
                                       displayedComponents: .date)
                        }
                        else{
                            
                            Picker(selection: $selectedIndex, label: Text("選擇圖案")) {
                                ForEach(images.indices) { (index) in
                                    Text(images[index])
                                }
                            }
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                           
                        }
                        
                        HStack{
                            Text("大小")
                            Slider(value: $widthAmount, in: 0...UIScreen.main.bounds.size.width){
                                Text("")
                            }
                            
                        }
                        HStack{
                            Text("亮度")
                            Slider(value: $brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small),
                                   maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)){
                                Text("")
                            }
                        }
                        HStack{
                            Stepper("左右", onIncrement: {
                                self.xAmount += 30
                            }, onDecrement: {
                                self.xAmount -= 30
                            })
                            
                        
                        }
                        HStack{
                            Stepper("上下", onIncrement: {
                                self.yAmount += 30
                            }, onDecrement: {
                                self.yAmount -= 30
                            })
                        }
                        
                        HStack{
                            Text("顏色")
                            Spacer()
                            ColorPicker("",selection: $selectedColor
                            )
                            .frame(width: 30, height: 30)
                        }
                        Group{
                            HStack{
                                Text("價錢")
                                TextField("選個好價錢賣吧", text: $price)
                                         .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("系統估價"){
                                    price = String(Int.random(in: 1...9)) + String(repeating: "9", count: Int.random(in:1...3))
                                }
                                .foregroundColor(Color(red: 244/255, green: 162/255, blue: 97/255))
                                
                            }
                            
                        }
                        UpButton(isPresented: $isPresented, showAlert: $showAlert, price: price)
                        
                        
                    }
                    
                    .foregroundColor(Color(red: 42/255, green: 157/255, blue: 143/255))
                    
                
                }
                
            }
            
            
            
        }
    }
}

struct homePage_Previews: PreviewProvider {
    static var previews: some View {
        homePage()
    }
}


struct UpButton: View{
    func isNumber(price: String?) -> Bool {
        if Int(price!) != nil{
            return true
        }
        else{
            return false
        }
    }
    
    @Binding var isPresented: Bool
    @Binding var showAlert: Bool
    var price: String
    var money = 0
    var body: some View {
        Button("上架"){
            if isNumber(price:price){
                isPresented = true
            }
            else{
                showAlert = true
            }
        }
        .sheet(isPresented: $isPresented){
            showPictureView()
        }
        .alert(isPresented:$showAlert){()-> Alert in
            return Alert(title: Text("價錢請輸入數字！"))
                
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct ImageView: View {
    var isJB : Bool
    var selectedColor : Color
    var widthAmount : CGFloat
    var brightnessAmount : Double
    var xAmount : CGFloat
    var yAmount : CGFloat
    var selectedIndex : Int

    var backGround:String
    var year: Int
    var images = ["花花豬", "崇拜豬", "跳舞豬", "難過豬", "Peter"]
    var body: some View {
        ZStack{
            Image(backGround)
                .resizable()
                .scaleEffect()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                .clipped()
                .colorMultiply(selectedColor)
            

            Image(isJB ? "JB-\(year)" : images[selectedIndex])
                .resizable()
                .scaleEffect()
                .frame(width: widthAmount, height: widthAmount/4*3)
                .clipped()
                .brightness(brightnessAmount)
                .position(x: xAmount, y: yAmount)

            
        }
    }
}
