//
//  File.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

struct VPNView: View {
    private enum Country: String, CaseIterable, Identifiable {
        case usa = "США"
        case uk = "Великобритания"
        case germany = "Германия"
        
        var id: String { self.rawValue }
    }
    
    @State private var selectedCountry: Country = .usa
    @State private var isVPNActive = false

    var body: some View {
        VStack {
            Text("Выбрана страна: \(selectedCountry.rawValue)")

            // Выпадающий список с использованием Enum
            Picker("Выберите страну", selection: $selectedCountry) {
                ForEach(Country.allCases, id: \.self) { country in
                    Text(country.rawValue).tag(country)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button(action: {
                toggleVPN()
            }) {
                Text(isVPNActive ? "Остановить VPN" : "Запустить VPN")
                    .padding()
                    .foregroundColor(.white)
                    .background(isVPNActive ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .padding()

            Text(isVPNActive ? "VPN запущен" : "VPN не активен")
                .foregroundColor(isVPNActive ? .green : .red)
                .padding()
        }
        .padding()
        .onAppear {
            // Добавим этот блок кода, чтобы предотвратить автоматическое выбор первого элемента
//            if selectedCountry == nil {
//                selectedCountry = Country.allCases.first
//            }
        }
    }

    func toggleVPN() {
        // Здесь вы можете вставить логику активации/деактивации VPN
        isVPNActive.toggle()
    }
}

struct VPNView_Previews: PreviewProvider {
    static var previews: some View {
        VPNView()
    }
}
