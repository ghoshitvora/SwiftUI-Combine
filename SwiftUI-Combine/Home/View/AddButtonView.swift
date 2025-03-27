//
//  AddButtonView.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import SwiftUI

struct AddButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("SEND DATA")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .fontWeight(.heavy)
        }
        .padding(20)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AddButtonView(action: {})
}
