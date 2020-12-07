//
//  NetworkManager.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation

//MARK: - Network protocol
protocol NetworkManagment {
    
    func searchGitRepository(search model: SearchRequest,
                             success: @escaping(SearchResponse) -> Void,
                             failure: @escaping(String) -> Void)
    
}






//MARK: - Class
class NetworkManager {
    
    /// - Parameters
    private let networking: Networking
    private let errors = LocalError.self
    
    init(networking: Networking) {
        self.networking = networking
    }
    
}





//MARK: - By protocol NetworkManagment
extension NetworkManager: NetworkManagment {
    
    func searchGitRepository(search model: SearchRequest,
                             success: @escaping(SearchResponse) -> Void,
                             failure: @escaping(String) -> Void) {
        
        let request = RequestModel(method: .search, params: model.parameters, request: .get)
        networking.getRequest(request: request) { (data, error) in
            
            self.decode(received: data, in: "searchGitRepository") { (response: SearchResponse) in
                success(response)
            } failure: { (localizedDescription) in
                failure(localizedDescription)
            }
        }
    }
    
}






//MARK: - Private Methods
private extension NetworkManager {
    
    
    /// - `decode` received data in defined method with further transition of it
    func decode<T>(received data: Data?, in method: String,
                   success: @escaping(T) -> Void,
                   failure: @escaping(String) -> Void) where T: Decodable {
        do {
            guard let data = data else {
                failure(LocalError.connectionLost.localizedDescription)
                return
            }
            
            if let localizedDescription = self.errorHandler(from: data) {
                failure(localizedDescription)
            }else{
                let response = try JSONDecoder().decode(T.self, from: data)
                success(response)
            }
        }catch{
            debugPrint("ERROR: NetworkManager: \(method)", error.localizedDescription)
            failure(LocalError.unknown.localizedDescription)
        }
    }
    
    /// - Handle all `errors` if receiving them
    func errorHandler(from data: Data) -> String? {
        do {
            let error = try JSONDecoder().decode(GitError.self, from: data)
            var localizedDescription = error.message
            
            if let errors = error.errors {
                localizedDescription += "\nDescription:"
                for (key, value) in errors {
                    localizedDescription += "\n\(key): \(value)"
                }
            }
            return localizedDescription
            
        } catch {
            debugPrint("CODE 200")
            return nil
        }
    }
    
}
