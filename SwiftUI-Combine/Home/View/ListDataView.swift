//
//  ListDataView.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import SwiftUI

struct ListDataView: View {
    
    let userItem: HomeModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(userItem?.FirstName ?? "")")
                .font(.headline)
            Text("Email: \(userItem?.Email ?? "")")
        }
    }
}

#Preview {
    ListDataView(userItem: nil)
}
