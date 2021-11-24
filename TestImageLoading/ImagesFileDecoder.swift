import Foundation

class ImagesFileDecoder {
    static func images() -> [String] {

        do {
            if let fileUrl = Bundle.main.path(forResource: "images", ofType: "json") {
                let url = URL(fileURLWithPath: fileUrl)
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]]
                var set: Set<String> = []
                json?["images"]?.forEach({ set.insert($0) })
                var arr = [String]()
                set.forEach({arr.append($0)})
                
                set.forEach({
                    print("\"\($0)\",")
                })
                print("\n\n")
                return json?["images"] ?? []
            } else {
                return []
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
}
