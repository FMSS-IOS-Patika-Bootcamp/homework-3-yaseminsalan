//
//  CommentsImageViewController.swift
//  homework3

import UIKit
import Kingfisher
class CommentsImageViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewImageModel = CommentsImageViewModel()
    private var itemsImage:[CommentImageCellViewModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewImageModel.viewDelegate = self
        viewImageModel.didViewLoad()
        // Do any additional setup after loading the view.
    }
    

  

}
private extension CommentsImageViewController{
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
     
    }
    
    
}
extension CommentsImageViewController:CommentsImageViewModelViewProtocol{
    func didCellItemImageFetch(_ itemsImage: [CommentImageCellViewModel]) {
        //TODO
        self.itemsImage = itemsImage
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showEmptyImageView() {
        //TODO
    }
    
    func hideEmptyImageView() {
        //TODO
        
       
    }
    
    
}
extension CommentsImageViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewImageModel.didClickImageItem(at:indexPath.row)
    }
    
}
extension CommentsImageViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentsImageCell", for: indexPath) as! CommentsImageCollectionViewCell
     
        let url = URL.init(string: itemsImage[indexPath.row].url!)
        cell.commentImage.kf.setImage(with: url)
        return cell
    }
    
    
}
extension CommentsImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
           let screenWidth = screenSize.width
           return CGSize(width: (screenWidth/5)-1, height: (screenWidth/3)-4);
    }
    
  /* func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }*/
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
}

