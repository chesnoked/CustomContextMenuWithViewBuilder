//
//  ProfileView.swift
//  ForPeople
//
//  Created by Evgeniy Safin on 03.10.2022.
//

import SwiftUI

struct ProfileView: View {
    // color theme changer
    @State private var myColorTheme: MyColorTheme = MyColorTheme()
    @State private var parentColor: Color = Color.palette.parent
    @State private var childColor: Color = Color.palette.child
    // context menu
    @State private var showContextMenu: Bool = false
    private let contextMenuSize: CGSize = CGSize(width: 100, height: 100)
    var body: some View {
        ZStack {
            // context menu
            GeometryReader { proxy in
                self.contextMenu
                    .position(
                        x: proxy.frame(in: CoordinateSpace.local).maxX - contextMenuSize.width / 2,
                        y: proxy.frame(in: CoordinateSpace.local).minY + contextMenuSize.height / 2)
            }
            .zIndex(2)
            .padding(.trailing)
            .padding([.trailing, .top])
            .padding([.trailing, .top])
            VStack(spacing: 0) {
                // nav bar
                self.navBar
                    .padding(.horizontal)
                    .padding([.horizontal, .vertical])
                
                Spacer()
            }
            Text("Profile")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.parent.ignoresSafeArea())
    }
    
    // MARK: NavBar
    private var navBar: some View {
        HStack(spacing: 0) {
            // left control button
            self.leftControlButton
                .frame(width: 24, height: 24)
            Spacer()
            // right control button
            self.rightControlButton
                .frame(width: 24, height: 24)
        }
    }
    
    // MARK: Left control button
    private var leftControlButton: some View {
        Button(action: {
            withAnimation(.linear) {
                // show about this app
            }
        }, label: {
            Image(systemName: "info")
                .foregroundColor(Color.palette.child)
        })
    }
    
    // MARK: Right control button
    private var rightControlButton: some View {
        Button(action: {
            withAnimation(.linear) {
                self.showContextMenu.toggle()
            }
        }, label: {
            Image(systemName: "gearshape")
                .foregroundColor(Color.palette.child)
        })
    }
    
    // MARK: Context menu
    @ViewBuilder private var contextMenu: some View {
        if self.showContextMenu {
            // items
            VStack(spacing: 0) {
                // item1: color theme changer
                ContextMenuItem { colorThemeChanger }
//                CustomDivider()
                // item2: set to default color theme
                ContextMenuItem { Button(action: { myColorTheme.defaultColorTheme() }, label: { Image(systemName: "moon.fill") }) }
//                CustomDivider()
                // item 3: :-)
                ContextMenuItem { Button(action: {}, label: { Image(systemName: "bolt.horizontal.fill") }) }
            }
            .frame(width: contextMenuSize.width, height: contextMenuSize.height)
            .background(Color.palette.parent.cornerRadius(12))
            // strokes
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        LinearGradient(
                            gradient: .init(colors: [
                                Color.palette.child,
                                .clear,
                                Color.palette.child
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                        ,
                        lineWidth: 1.5
                    )
            )
            // shadow
            .shadow(color: Color.palette.child, radius: 1.5, x: 0, y: 0)
        }
    }
    
    // MARK: Color theme changer
    private var colorThemeChanger: some View {
        HStack(spacing: 10) {
            // parent color picker
            ColorPicker(selection: $parentColor, supportsOpacity: true, label: { })
                .onChange(of: parentColor) { newParentColor in
                    myColorTheme.saveColor(color: newParentColor, forKey: "parent_color")
                }
            // child color picker
            ColorPicker(selection: $childColor, supportsOpacity: true, label: { })
                .onChange(of: childColor) { newChildColor in
                    myColorTheme.saveColor(color: newChildColor, forKey: "child_color")
                }
        }
        .labelsHidden()
    }
}

// context menu one item
struct ContextMenuItem<Content:View>:View {
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    let content: Content
    var body: some View {
        HStack(spacing: 0) {
            content
        }
        .foregroundColor(Color.palette.child)
        .padding(.vertical, 5)
    }
}

// custom divider
struct CustomDivider: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(height: 1)
            .foregroundColor(Color.palette.child)
            .opacity(0.66)
            .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
