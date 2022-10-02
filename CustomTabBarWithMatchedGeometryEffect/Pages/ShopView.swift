//
//  ShopView.swift
//  ForPeople
//
//  Created by Evgeniy Safin on 03.10.2022.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        ZStack {
            Text("Shop")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.parent.ignoresSafeArea())
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
