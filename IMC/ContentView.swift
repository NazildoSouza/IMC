//
//  ContentView.swift
//  IMC
//
//  Created by Nazildo Souza on 01/04/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct ContentView: View { 
    @State private var peso = ""
    @State private var altura = ""
    @State private var image = 0
    @State private var result = 0.0
    @State private var button = false
    
    let images = ["magreza", "abaixo", "ideal", "sobre", "obesidade"]
    let resultTipo = ["Magreza", "Normal", "Sobrepeso", "Obesidade", "Obesidade Grave"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Color2"), Color("Color1"), Color("Color2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.hiddenKeyboard()
                }
            
            VStack {
                
                Spacer()
                
                Text("Cálculo do IMC")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Descubra o seu índice de massa corporal")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 50) {
                    VStack {
                        Text("Peso (kg)")
                            .foregroundColor(.white)
                            .padding([.top, .horizontal], 10)
                            .frame(maxWidth: 100)
                        TextField("Ex: 75", text: self.$peso)
                            .padding(.leading, 10)
                            .keyboardType(.decimalPad)
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 20)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 8)
                    }
                    
                    VStack {
                        Text("Altura (m)")
                            .foregroundColor(.white)
                            .padding([.top, .horizontal], 10)
                            .frame(maxWidth: 100)
                        TextField("Ex: 1.75", text: self.$altura)
                            .padding(.leading, 10)
                            .keyboardType(.decimalPad)
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 20)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 8)
                    }
                }
                .padding(.vertical)
                
                Button(action: {
                    self.calculoImc()
                    self.hiddenKeyboard()
                }) {
                    Text("Calcular")
                        .font(.headline)
                        .foregroundColor(Color("ColorName"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color("ColorCalculate"))
                        .cornerRadius(10)
                        .shadow(radius: 8)
                    
                }
                Text("Seu índice de massa corporal é:")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .opacity(self.button ? 1 : 0)
                
                Text("\(self.result, specifier: "%.1f"):  \(self.resultTipo[self.image])")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top)
                    .opacity(self.button ? 1 : 0)
                
                Image(self.images[self.image])
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 3)
                    .padding(.all)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("Color2"), lineWidth: 4))
                    .shadow(radius: 10)
                    .opacity(self.button ? 1 : 0)
                
                
                Spacer()
                
            }
        }
    }
    
    func calculoImc() {
        let peso = Double(self.peso.replacingOccurrences(of: ",", with: ".")) ?? 0
        let altura = Double(self.altura.replacingOccurrences(of: ",", with: ".")) ?? 0
        
        let imc = peso / (altura * altura)
        self.result = imc
        
        switch imc {
            case 0 ..< 18.5:
                self.image = 0
            case 18.5 ..< 25.0:
                self.image = 1
            case 25 ..< 30.0:
                self.image = 2
            case 30 ..< 40.0:
                self.image = 3
            default:
                self.image = 4
        }
        
        if self.peso != "" && self.altura != "" {
            self.button = true
        } else {
            self.button = false
        }
        
    }
    
    func hiddenKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS Max", "iPad (7th generation)"], id: \.self) { device in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: device))
        }
    }
}
