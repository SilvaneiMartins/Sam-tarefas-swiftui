//
//  HomeView.swift
//  SamNotes
//
//  Created by Silvanei  Martins on 27/04/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var showColors: Bool = false
    @State var animationButton: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            if isMacOS() {
                Group {
                    SideBar()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.20))
                        .frame(width: 1)
                }
            }
            
            MainContent()
        }// HStack
        #if os(macOS)
        .ignoresSafeArea()
        #endif
        .frame(width: isMacOS() ? getRect().width / 1.7 : nil, height: isMacOS() ? getRect().height - 180 : nil,alignment: .leading)
        .background(Color("BG").ignoresSafeArea())
        #if os(iOS)
        .overlay(SideBar())
        #endif
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func SideBar() -> some View  {
        VStack {
            if isMacOS() {
                Text("Tarefa")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            if isMacOS() {
                AddButton()
                    .zIndex(1)
            }
            
            VStack(spacing: 15) {
                let colors = [Color("Yellow"),Color("Orange"),Color("Purple"), Color("Blue"), Color("Green")]
                
                ForEach(colors, id: \.self) {color in
                        Circle()
                            .fill(color)
                            .frame(width: isMacOS() ? 20 : 25, height: isMacOS() ? 20 : 25)
                }// ForEach
            }// VStack
            .padding(.top, 20)
            .frame(height: showColors ? nil : 0)
            .opacity(showColors ? 1 : 0)
            .zIndex(0)
            
            if !isMacOS() {
                AddButton()
                    .zIndex(1)
            }
        }// VStack
        #if os(macOS)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
        #else
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
        .background(BlurView(style: .systemUltraThinMaterialDark)
            .opacity(showColors ? 1 : 0)
            .ignoresSafeArea())
        #endif
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Pesquisar", text: .constant(""))
            }//HStack
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            .overlay(
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .padding(.horizontal, -25)
                    .frame(height: 1)
                    .offset(y: 6)
                    .opacity(isMacOS() ? 0 : 1),
                
                alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Notas")
                        .font(isMacOS() ? .system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() ? 25 : 15), count: isMacOS() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        ForEach(notes) {note in
                            CardView(note: note)
                        }
                    }
                    .padding(.top, 30)
                }//VSTack
                .padding(.top, isMacOS() ? 45 : 30)
            }//ScroolView
        }// VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 40 : 15)
        .padding(.horizontal, 25)
        
    }
    
    @ViewBuilder
    func CardView(note: Note) -> some View {
        VStack {
            Text(note.note)
                .font(isMacOS() ? .title3 : .body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(note.date, style: .date)
                    .foregroundStyle(.black)
                    .opacity(0.8)
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
            }// HStack
            .padding(.top, 55)
        }// VStack
        .padding()
        .background(note.cardColor)
        .cornerRadius(18)
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showColors.toggle()
                animationButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    animationButton.toggle()
                }
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .scaleEffect(animationButton ? 1.1 : 1)
                .padding(isMacOS() ? 15 : 15)
                .background(Color.black)
                .clipShape(Circle())
        }
        .rotationEffect(.init(degrees: showColors ? 90: 0))
        .scaleEffect(animationButton ? 1.1 : 1)
        .padding(.top, 30)
    }
}

#Preview {
    HomeView()
}

extension View {
    func getRect() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #elseif os(macOS)
        return NSScreen.main?.visibleFrame ?? .zero
        #else
        return .zero
        #endif
    }
    
    func isMacOS() -> Bool {
        #if os(macOS)
        return true
        #else
        return false
        #endif
    }
}

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get {
            return .none
        }
        set {
            super.focusRingType = .none
        }
    }
}
#endif
