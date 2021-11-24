import Foundation
import UIKit


class MemoryStorage: ImageCacheStorage {    
    private var _memory: [URL: UIImage] = [:]
    private var _memoryData: [URL: Data] = [:]


    func getImage(by url: URL) -> UIImage? {
        let image = _memory[url]
        return image
    }
    
    func saveImage(img: UIImage, by url: URL) {
        _memory[url] = img
    }
    
    func getImageData(by url: URL) -> Data? {
        let image = _memoryData[url]
        return image
    }
    
    func saveImageData(data: Data, by url: URL) {
        _memoryData[url] = data
    }
}
