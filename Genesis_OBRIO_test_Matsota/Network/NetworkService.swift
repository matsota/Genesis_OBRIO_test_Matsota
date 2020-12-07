//
//  NetworkService.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation

//MARK: - Networking protocol
protocol Networking {
    
    func getRequest(request model: RequestModel,
                    completion: @escaping (Data?, LocalError?) -> Void)
    
}









//MARK: - Class
class NetworkService {
    
    /// - Parameters
    private let errors = LocalError.self
    
}









//MARK: - By Networking protocol
extension NetworkService: Networking {
    
    func getRequest(request model: RequestModel,
                    completion: @escaping (Data?, LocalError?) -> Void) {
        
        guard let request = request(request: model) else {return completion(nil, errors.badRequest)}
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            self.log(data: data, response: response as? HTTPURLResponse, error: error)
            switch error {
            case .some(let error):
                debugPrint("ERROR: NetworkService: getRequest:", error.localizedDescription)
                completion(nil, self.errors.unknown)
                    
            case .none:
                completion(data, nil)
            }
        }.resume()
    }
    
}








//MARK: - Private Methods
private extension NetworkService {
    
    /// -  Create `request`
    func request(request model: RequestModel) -> URLRequest? {
        var components = URLComponents()
        
        components.scheme = API.scheme.rawValue
        components.host = API.host.rawValue
        components.path = model.method.rawValue

        var queryItems = [URLQueryItem]()
        if let parameter = model.params {
            for (key, value) in parameter {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        components.queryItems = queryItems
        guard let url = components.url else {return nil }
        var request = URLRequest(url: url)
        request.httpMethod = model.request.rawValue
        return request
    }
    
}
