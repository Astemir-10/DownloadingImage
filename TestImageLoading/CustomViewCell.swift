import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    var index: IndexPath!
    var isDisplay = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        print(myImageView.image?.size)
//        myImageView.image = nil
        
    }
    
    func setIamge(url: String) {
        

        
//        myImageView.kf.setImage(with: URL(string: url)) { result in
////            print("COMPLEATION \(self.index)")
//////            print(try! result.get().cacheType)
//        }
        
//        myImageView.loadIamgeF(url: url)
        myImageView.loadImage(by: url)
//        ImageDownloader.shared.images(iv: myImageView)
    }
}




