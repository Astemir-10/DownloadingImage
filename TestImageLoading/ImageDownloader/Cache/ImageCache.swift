import Foundation
import UIKit



final class ImageCache {
    enum StorageType {
        case cache, disk, memory
    }
    
    lazy var storage: ImageCacheStorage = {
        switch storageType {
            
        case .cache:
            return CachStorage()
        case .disk:
            return DiskStorage()
        case .memory:
            return MemoryStorage()
        }
    }()
    var storageType: StorageType
    final func storeImageData(imageData: Data, by url: URL) {
        storage.saveImageData(data: imageData, by: url)
    }
    
    final func getStoredImageData(by url: URL) -> Data? {
        storage.getImageData(by: url)
    }
    
    final func storeImage(imageData: UIImage, by url: URL) {
        self.storage.saveImage(img: imageData, by: url)
    }
    
    final func getStoredImage(by url: URL) -> UIImage? {
        return storage.getImage(by: url)
    }
    
    init(storageType: StorageType) {
        self.storageType = storageType
    }
}
