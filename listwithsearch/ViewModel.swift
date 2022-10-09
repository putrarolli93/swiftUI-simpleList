//
//  ViewModel.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var list =  [ListData]()
    @Published var listLoadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init( dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getList()
    }
    
    func getList() {
        dataManager.fetchChats()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.list = dataResponse.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        listLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
