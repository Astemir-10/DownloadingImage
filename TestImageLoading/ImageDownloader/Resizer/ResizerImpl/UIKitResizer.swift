import UIKit


class UIKitResizer: ImageResizer {
    func resize(_ image: UIImage, scale: CGFloat) -> UIImage? {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        return resize(image: image, with: size)
    }
    
    
    func resize(_ image: UIImage, size: CGSize) -> UIImage? {
        return resize(image: image, with: size)
    }
    
    func resize(image: UIImage, with size: CGSize) -> UIImage? {
        let image = UIGraphicsImageRenderer(size: size).image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
