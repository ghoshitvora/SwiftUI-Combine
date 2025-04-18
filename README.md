# SwiftUI-Combine

## Overview
This project integrates SwiftUI with Combine for efficient asynchronous network requests using an API Manager and follows the MVVM architecture.

## Usage

## GET Request example

        guard let url = URL(string: ApiURLS.getUsers) else {
            print("Invalid URL")
            return
        }
        
        let apiRequest = ApiRequest(withUrl: url, httpMethods: .GET)
        
        apiManager.apiRequest(apiRequest, responseType: [HomeModel].self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.errorMessage = AlertMessage(title: "Error", message: "\(error.message ?? "Something Went Wrong!")")
                }
            }, receiveValue: { [weak self] _ in
            })
            .store(in: &cancellables)

## Post Request example 

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
        
        apiManager.apiRequest(apiRequest, responseType: HomeModel.self)
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.errorMessage = AlertMessage(title: "Error", message: "\(error.message ?? "Something Went Wrong!")")
                }
            }, receiveValue: { [weak self] _ in
                self?.successMessage = AlertMessage(title: "Success", message: "User registered successfully!")
            })
            .store(in: &cancellables)


## License
This project is licensed under the MIT License - see the LICENSE file for details.
