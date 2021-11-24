import UIKit

protocol ImageCacheStorage {
    func getImage(by url: URL) -> UIImage?
    func saveImage(img: UIImage, by url: URL)
    
    func getImageData(by url: URL) -> Data?
    func saveImageData(data: Data, by url: URL)
}
