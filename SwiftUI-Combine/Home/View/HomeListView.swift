//
//  HomeListView.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import SwiftUI

struct HomeListView: View {
    let userData: [HomeModel]
    
    var body: some View {
        List(userData, id: \.id) {item in
            ListDataView(userItem: item)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
}

#Preview {
    HomeListView(userData: [])
}
