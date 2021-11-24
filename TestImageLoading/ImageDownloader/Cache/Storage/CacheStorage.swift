import UIKit



final class CachStorage: ImageCacheStorage {
    
    private lazy var cache: NSCache<NSURL, NSData> = {
        let cache = NSCache<NSURL, NSData>()
        return cache
    }()
    private let getCacheImage: NSCache<NSURL, UIImage> = NSCache()
    var counter: Int = 0

    
    func getImage(by url: URL) -> UIImage? {
        let url = url as NSURL
        if let cachedData = self.getCacheImage.object(forKey: url) {
            return cachedData
        } else {
            return nil
        }
    }
    
    func saveImage(img: UIImage, by url: URL) {
        let url = url as NSURL
        self.getCacheImage.setObject(img, forKey: url)
    }
    
    
    func getImageData(by url: URL) -> Data? {
        let url = url as NSURL
        if let cachedData = self.cache.object(forKey: url) {
            return cachedData as Data
        } else {
            return nil
        }
    }
    
    func saveImageData(data: Data, by url: URL) {
        let url = url as NSURL
        let data = data as NSData
        self.cache.setObject(data, forKey: url)
    }
    
    
}
