import Foundation
import UIKit


protocol ImageResizer {
    func resize(_ image: UIImage, scale: CGFloat) -> UIImage?
    func resize(_ image: UIImage, size: CGSize) -> UIImage?
}
