import UIKit


class Net {
    static var shared = Net()
    private let session: URLSession
    
    init() {
        let sessionConf = URLSessionConfiguration.default
        sessionConf.urlCache = URLCache(memoryCapacity: 200 * 1048576, diskCapacity: 200 * 1048576, diskPath: "image")
        
        sessionConf.requestCachePolicy = .useProtocolCachePolicy
        sessionConf.timeoutIntervalForRequest = 30
        sessionConf.timeoutIntervalForResource = 300
        sessionConf.waitsForConnectivity = true
        session = URLSession(configuration: sessionConf)
    }
    
    
    func loadData(urlReq: URL, compleation: @escaping (Data?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.session.dataTask(with: urlReq) { data, retsponse, error in
                guard let data = data else {
                    return
                }

                compleation(data)
            }.resume()
        }
    }
    
}
