//
//  ContentView.swift
//  IMC
//
//  Created by Nazildo Souza on 01/04/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var peso = ""
    @State private var altura = ""
    @State private var image = 0
    @State private var result = 0.0
    @State private var button = false
    
    let images = ["magreza", "abaixo", "ideal", "sobre", "obesidade"]
    let resultTipo = ["Magreza", "Normal", "Sobrepeso", "Obesidade", "Obesidade Grave"]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: self.colorScheme == .light ? [Color(#colorLiteral(red: 0, green: 0.6715669487, blue: 0.8866384846, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.7019607843, blue: 0.7647058824, alpha: 1))] : [Color(#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.004370007664, green: 0.4360928837, blue: 0.7523878691, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.hiddenKeyboard()
                    }
                
                VStack {
                    Spacer(minLength: geo.size.height / 3.5)
                    Text("Cálculo do IMC")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Descubra o seu índice de massa corporal")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, geo.size.height / 40)
                        .padding(.horizontal, geo.size.width / 20)
                    
                    HStack(spacing: 50) {
                        VStack {
                            Text("Peso (kg)")
                                .foregroundColor(.white)
                            TextField("Ex: 75", text: self.$peso)
                                .foregroundColor(.primary).colorInvert()
                                .padding(.leading, 10)
                                .keyboardType(.decimalPad)
                                .frame(width: geo.size.width / 3, height: geo.size.height / 15)
                                .background(Color.primary).colorInvert()
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 2, y: 2)
                        }
                        VStack {
                            Text("Altura (m)")
                                .foregroundColor(.white)
                            TextField("Ex: 1.75", text: self.$altura)
                                .foregroundColor(.primary).colorInvert()
                                .padding(.leading, 10)
                                .keyboardType(.decimalPad)
                                .frame(width: geo.size.width / 3, height: geo.size.height / 15)
                                .background(Color.primary).colorInvert()
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 2, y: 2)
                        }
                    }
                    .padding(.vertical, geo.size.height / 30)
                    
                    Button(action: {
                        self.calculoImc()
                        self.hiddenKeyboard()
                    }) {
                        Text("Calcular")
                            .font(.headline)
                            .foregroundColor(self.colorScheme == .light ? Color(#colorLiteral(red: 0, green: 0.7019607843, blue: 0.7647058824, alpha: 1)) : Color(#colorLiteral(red: 0.004370007664, green: 0.4360928837, blue: 0.7523878691, alpha: 1)))
                            .padding(.horizontal, geo.size.width / 3.5)
                            .padding(.vertical, geo.size.height / 50)
                            .background(self.colorScheme == .light ? Color(#colorLiteral(red: 1, green: 0.9275085745, blue: 0.5360817619, alpha: 1)) : Color(#colorLiteral(red: 1, green: 0.802802881, blue: 0.5836523955, alpha: 1)))
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.5), radius: 4, x: 2, y: 2)
                        
                    }
                    Text("Seu índice de massa corporal é:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, geo.size.height / 30)
                        .opacity(self.button ? 1 : 0)
                    
                    Text("\(self.result, specifier: "%.1f"):  \(self.resultTipo[self.image])")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, geo.size.height / 50)
                        .opacity(self.button ? 1 : 0)
                    
                    Image(self.images[self.image])
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 5, height: geo.size.height / 3)
                        .padding(.horizontal, 120)
                        .background((Color.primary).colorInvert())
                        .clipShape(Circle())
                        .overlay(Circle().stroke(self.colorScheme == .light ? Color(#colorLiteral(red: 0, green: 0.7019607843, blue: 0.7647058824, alpha: 1)) : Color(#colorLiteral(red: 0.004370007664, green: 0.4360928837, blue: 0.7523878691, alpha: 1)), lineWidth: 4))
                        .shadow(color: Color.primary.opacity(0.4), radius: 10, x: 0, y: 0)
                        .opacity(self.button ? 1 : 0)
                    
                    
                    Spacer(minLength: geo.size.height / 4)
                    
                }
                .frame(width: geo.size.width * 1.3, height: geo.size.height * 1.3)
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
