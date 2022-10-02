//
//  CustomTabBarWithMatchedGeometryEffect.swift
//  ForPeople
//
//  Created by Evgeniy Safin on 03.10.2022.
//

import SwiftUI

enum TabItems: String, CaseIterable {
    case home = "house.fill"
    case shop = "list.bullet"
    case cart = "cart.fill"
    case profile = "person.crop.circle.fill"
}

struct MyAppMainView: View {
    @Namespace private var tabBarNameSpace
    @State private var selectedItem: TabItems = .home
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // show pages
                self.showPages
                Spacer(minLength: 30)
                // tab bar
                self.tabBar
                    .padding(.bottom)
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.parent.ignoresSafeArea())
    }
    
    // MARK: Show pages {
    @ViewBuilder private var showPages: some View {
        switch self.selectedItem {
        case .home:
            HomeView()
        case .shop:
            ShopView()
        case .cart:
            CartView()
        case .profile:
            ProfileView()
        }
    }
    
    // MARK: TabBar
    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(TabItems.allCases, id: \.self) { tabItem in
                ZStack {
                    if self.selectedItem == tabItem {
                        Rectangle()
                            .fill(Color.palette.parent)
                            .matchedGeometryEffect(id: "tabs", in: self.tabBarNameSpace)
                    }
                    Image(systemName: tabItem.rawValue)
                        .foregroundColor(self.selectedItem == tabItem ? Color.palette.child : Color.palette.parent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation(.linear) {
                        self.selectedItem = tabItem
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: 37)
        .background(Color.palette.child.cornerRadius(30))
    }
}

struct CustomTabBarWithMatchedGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        MyAppMainView()
    }
}
