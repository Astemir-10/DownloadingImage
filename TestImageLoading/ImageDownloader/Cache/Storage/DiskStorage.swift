import UIKit



final class DiskStorage: ImageCacheStorage {
    
    lazy var dir: URL = {
        let temp = FileManager.default.temporaryDirectory.appendingPathComponent("img_soul")
        return temp
    }()
    
    func getImage(by url: URL) -> UIImage? {
        if let imgData = getSavedImage(named: url.lastPathComponent) {
            let image = UIImage(data: imgData)
            return image
        }
        return nil
    }
    
    func saveImage(img: UIImage, by url: URL) {
        let data = img.jpegData(compressionQuality: 1)
        saveImage(imageData: data, name: url.lastPathComponent)
    }
    
    func getImageData(by url: URL) -> Data? {
        let imageData = getSavedImage(named: url.lastPathComponent)
        return imageData
    }
    
    func saveImageData(data: Data, by url: URL) {
        self.saveImage(imageData: data, name: url.lastPathComponent)
    }
    
    @discardableResult
    private func saveImage(imageData: Data?, name: String) -> Bool {
        guard let data = imageData else {
            return false
        }
        
        do {

            try data.write(to: dir.appendingPathComponent(name))
            return true
        } catch {
            return false
        }
    }
    
    func getSavedImage(named: String) -> Data? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named))
        return data
    }
    
    init() {
        try? FileManager.default.removeItem(at: FileManager.default.temporaryDirectory.appendingPathComponent("img_soul"))
    }
    
}
