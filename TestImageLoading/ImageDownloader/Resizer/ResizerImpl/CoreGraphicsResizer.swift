import CoreGraphics
import UIKit

class CoreGraphicsResizer: ImageResizer {
    func resize(_ image: UIImage, scale: CGFloat) -> UIImage? {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        return resize(image: image, with: size)
    }
    
    func resize(_ image: UIImage, size: CGSize) -> UIImage? {
        resize(image: image, with: size)
    }
    
    func resize(image: UIImage, with size: CGSize) -> UIImage? {
        guard let image = image.cgImage else { return nil }
        
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: image.bitsPerComponent,
                                bytesPerRow: 0,
                                space: image.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
                                bitmapInfo: image.bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(image, in: CGRect(origin: .zero, size: size))
        
        guard let scaledImage = context?.makeImage() else { return nil }
        
        return UIImage(cgImage: scaledImage)
    }
}
