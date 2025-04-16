//
//  HomeView.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let apiManager = ApiManager()
        _viewModel = StateObject(wrappedValue: HomeViewModel(apiManager: apiManager))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0, content: {
                HomeListView(userData: viewModel.homeData)
                AddButtonView(action:  {
                    viewModel.sendData()
                })
            })
            .background(Color.clear)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.successMessage) { message in
                Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    HomeView()
}
