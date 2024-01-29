//
//  SwiftUIView.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

struct HomePageView: View {
    @State private var isMenuOpen = false
    @State private var menuOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var isLanguageSelectionPresented = false

    private let menuWidth: CGFloat = 200.0

    var body: some View {
        NavigationView {
                ZStack {
                    VPNView()
                    GeometryReader { geometry in
                        MenuView(isLanguageSelectionPresented: $isLanguageSelectionPresented)
                        
                            .frame(width: menuWidth)
                            .offset(x: menuOffset)
                            .animation(.linear(duration: 0.3), value: menuOffset)
                            .navigationTitle("Home")
                        //                    }
                        // Кнопка в NavigationBar для открытия меню
                        //                    YourMainContentView()
                            .navigationBarItems(
                                leading: Button(action: {
                                    menuOffset = isMenuOpen ? -geometry.size.width : 0
                                    withAnimation {
                                        isMenuOpen.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                        .foregroundStyle(Color.black)
                                }
                            )
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let _ = print(value)
                                guard isMenuOpen else { return }
//                                menuOffset = max(min(value.translation.width, 0), -menuWidth)
//                                withAnimation(.linear(duration: 0.1)) {

//                                }

//                                withAnimation(.linear(duration: 3)) {
                                    menuOffset = -menuWidth

                                    isMenuOpen.toggle()
                            }
                    )
                }
                .gesture(
                    
                    DragGesture()
                        .onChanged { value in
                            guard isMenuOpen else { return }
                            //                                menuOffset = max(min(value.translation.width, 0), -menuWidth)
                            //                                withAnimation(.linear(duration: 0.1)) {
                            
                            //                                }
                            
                            //                                withAnimation(.linear(duration: 3)) {
                            menuOffset = -menuWidth
                            
                            isMenuOpen.toggle()
                        }
                        
                )
                .gesture(
                    TapGesture().onEnded { value in
                        let _ = print("Тап \(value)")
                        
                    }
                )
                
                
                
            }
        }
                
    }
}

struct YourMainContentView: View {
    var body: some View {
        Text("ABCDE")
    }
}

struct MenuView: View {
    @Binding var isLanguageSelectionPresented: Bool
    @State var isModalPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 25) {
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                
                    Button(action: { isModalPresented.toggle() }) {
                        Text("Change language")
                            .bold()
                            .foregroundColor(.white)
//                            .padding()
                    }
                    .sheet(isPresented: $isModalPresented) {
                        LanguageSelectionView()
                    }
                    
                    Button(action: { }) {
                        Text("Subscription")
                            .bold()
                            .foregroundColor(.white)
//                            .padding()
                    }
                    
                    Button(action: { }) {
                        Text("Referrals")
                            .bold()
                            .foregroundColor(.white)
//                            .padding()
                    }

                Spacer()
                
                // Здесь должна быть другая логика,
                // но, поскольку это тестовое задание,
                // то просто открываем начальный экран.
                NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true)) {
                    Text("Exit")
                        .bold()
                }
                .padding()
                .foregroundColor(.red)
            }
        }
    }
}

struct LanguageSelectionView: View {
    
    private enum Language: String, CaseIterable, Identifiable {
        case eng = "English"
        case deu = "Deuche"
        var id: Self { self }
    }
    
    @State private var selectedLanguage: Language = .eng
    
    var body: some View {
        VStack {
            Text("Choose language")
                .frame(height: 50)
            List {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(Language.allCases) { language in
                        Text(language.rawValue.capitalized)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

