//
//  ViewWithCollection.swift
//  TestImageLoading
//
//  Created by Astemir Shibzuhov on 11/22/21.
//

import UIKit
import Kingfisher

class MyCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.pin(to: self)
        
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPress(_ :))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func longPress(_ g: UILongPressGestureRecognizer) {
        if g.state == .began {
            if let image = imageView.image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
        }
    }
    
    func setImage(url: String) {
//        imageView.kf.setImage(with: URL(string: url))
        imageView.loadImage(by: url)
    }
}


class ViewWithCollection: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let images = ImagesFileDecoder.images()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.register(MyCell.self, forCellWithReuseIdentifier: "Cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCell
        cell.setImage(url: images[indexPath.row])
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 3.2, height: collectionView.frame.height / 5.2)
//    }
}



extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
