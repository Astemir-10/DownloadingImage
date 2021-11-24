import UIKit

class ImageIOResizer: ImageResizer {
    func resize(_ image: UIImage, scale: CGFloat) -> UIImage? {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        return resize(image: image, with: size)
    }
    
    func resize(_ image: UIImage, size: CGSize) -> UIImage? {
        return resize(image: image, with: size)
    }
    
    private func resize(image: UIImage, with size: CGSize) -> UIImage? {
        guard let imageData = image.pngData() else { return nil }
        
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
        ]
        let a = CGImageSourceCreateWithData(imageData as CFData, nil)
        guard let image = CGImageSourceCreateThumbnailAtIndex(a!, 0, options as CFDictionary)  else { return nil }
        return UIImage(cgImage: image)
    }
}
