import UIKit
import CoreImage


class CoreImageResizer: ImageResizer {
    private let sharedContext = CIContext(options: [.useSoftwareRenderer : false])

    func resize(_ image: UIImage, scale: CGFloat) -> UIImage? {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        return resize(image: image, with: size)
    }
    
    func resize(_ image: UIImage, size: CGSize) -> UIImage? {
        resize(image: image, with: size)
    }
    
    
    private func resize(image: UIImage, with size: CGSize) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        let ciImage = CIImage(cgImage: cgImage)
        
        let scale = min(size.width / image.size.width, size.height / image.size.height)
        
        let filter = CIFilter(name: "CILanczosScaleTransform")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(scale, forKey: kCIInputScaleKey)
        filter?.setValue(1, forKey: kCIInputAspectRatioKey)
        
        guard let outputCIImage = filter?.outputImage,
              let outputCGImage = sharedContext.createCGImage(outputCIImage,
                                                              from: outputCIImage.extent) else { return nil }
        return UIImage(cgImage: outputCGImage)
    }
}
