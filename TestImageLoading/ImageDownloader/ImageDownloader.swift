import Foundation
import UIKit

extension UIImageView {
    func loadImage(by url: String?, quality: ImageDownloader.ImageQuality = .low) {
        guard let url = url else {
            return
        }

        ImageDownloader.shared.downloadImage(url: url, imageView: self, quality: quality) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

class ImageDownloader {
    static let shared = ImageDownloader()

    enum ImageQuality: Int {
        case veryLow = 240
        case low = 480
        case medium = 1024
        case hight = 2048
        case original
    }
    
    typealias DownloadCompleation = (url: URL, compl: ((UIImage?) -> ())?)
    var storageType: ImageCache.StorageType = .cache {
        didSet {
            storage.storageType = storageType
        }
    }
    private lazy var storage: ImageCache = {
        return ImageCache(storageType: storageType)
    }()

    private var setImageView: ThreadSafeDictionary<UIImageView, DownloadCompleation?> = ThreadSafeDictionary(dict: [:])
    private var downloadingNetUrls: ThreadSafeSet<URL> = ThreadSafeSet()

    
    let mainQueue = DispatchQueue(label: "ImageDownloader queue", qos: .userInteractive, attributes: .concurrent)
    
    func downloadImage(url: String, imageView: UIImageView, quality: ImageQuality = .medium, compleation: @escaping (UIImage?) -> ()) {
        imageView.image = nil
        mainQueue.async { [unowned self] in
            guard let url = URL(string: url) else { return }
            self.setImageView[imageView] = (url, compleation)
            if let cache = self.storage.getStoredImage(by: url), let compl = self.setImageView[imageView] {
                if compl?.url == url {
                    compl?.compl?(cache)
                    self.setImageView[imageView] = nil
                    self.clearingSet()
                }
            } else {
                if self.downloadingNetUrls.contains(url) {
                    return
                }
                self.downloadingNetUrls.insert(url)
                Net.shared.loadData(urlReq: url) { data in
                    defer {
                        self.setImageView[imageView] = nil
                        self.downloadingNetUrls.remove(url)
                        self.clearingSet()
                    }
                    guard let data = data else { return }
                    if let originalImage = UIImage(data: data), let image = originalImage.resizedImage(for:  quality == .original ? 1 : min(1, CGFloat(quality.rawValue) / max(originalImage.size.height, originalImage.size.width))) {
                        if let compl = self.setImageView[imageView] {
                            if compl?.url == url {
                                self.storage.storeImage(imageData: image, by: url)
                                compl?.compl?(image)
                            }
                        }
                        self.setImageView.filter({ $0.value?.url == url }).forEach({
                            $0.value?.compl?(image)
                            self.setImageView[$0.key] = nil
                        })
                    }
                }
            }
        }
    }
    
    func clearingSet() {
        setImageView.removeValuу(whereCompl: { $1 == nil })
    }
}


extension UIImage {
    func resizedImage(for scale: CGFloat, imageResizer: ImageResizer = CoreGraphicsResizer()) -> UIImage? {
        if scale == 1 { return self }
        let image = imageResizer.resize(self, scale: scale)
        return image
    }
}


