//
//  HomeViewModel.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Variable(s)
    
    @Published var homeData: [HomeModel] = []
    @Published var errorMessage: AlertMessage?
    @Published var successMessage: AlertMessage?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Api Method(s)
    
    func fetchData() {
        guard let url = URL(string: ApiURLS.getUsers) else {
            print("Invalid URL")
            return
        }
        
        let apiRequest = ApiRequest(withUrl: url, httpMethods: .GET)
        
        ApiManager.shared.apiRequest(apiRequest, responseType: [HomeModel].self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.errorMessage = AlertMessage(title: "Error", message: "\(error.message ?? "Something Went Wrong!")")
                }
            }, receiveValue: { [weak self] homeModel in
                self?.homeData = homeModel
            })
            .store(in: &cancellables)
    }
    
    func sendData() {
        guard let url = URL(string: ApiURLS.registerUsers) else {
            print("Invalid URL")
            return
        }
        
        let userData: [String: Any] = ["FirstName": "Johnson", "Email": "johnson3@gmail.com", "PhoneNumber": "568939-6410", "Vehicle": "Test1", "JobTitle": "Chief Mobility Liaison"]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) else {
                print("Failed to encode JSON")
                return
        }
        
        let apiRequest = ApiRequest(withUrl: url, httpMethods: .POST, requestBody: jsonData)
        
        ApiManager.shared.apiRequest(apiRequest, responseType: HomeModel.self)
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.errorMessage = AlertMessage(title: "Error", message: "\(error.message ?? "Something Went Wrong!")")
                }
            }, receiveValue: { [weak self] _ in
                self?.successMessage = AlertMessage(title: "Success", message: "User registered successfully!")
            })
            .store(in: &cancellables)
    }
}
