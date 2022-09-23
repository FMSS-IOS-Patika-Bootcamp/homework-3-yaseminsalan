//
//  CommentsImageViewModel.swift
//  homework3

import Foundation
//View is notified with the delegate structure.
protocol CommentsImageViewModelViewProtocol:AnyObject{
    //Notifies View
    func didCellItemImageFetch(_ itemsImage:[CommentImageCellViewModel])
    func showEmptyImageView()
    func hideEmptyImageView()
}
class CommentsImageViewModel{
    //ViewModel has to hold the Model, for this we created a model list
    private let model = CommentsImageModel()
    
    weak var viewDelegate:CommentsImageViewModelViewProtocol?
  
    
    init(){
        //We have delegated the model in Model to receive news from Model
        model.delegateImage = self
    }
    
    //Informs us that the ViewController is loaded and we can now pull data from the API and perform operations.
    func didViewLoad(){
        model.fetchData()
    }
    //for the communication of the clicked cells
    func didClickImageItem(at index:Int){
        //TODO
        let selectedItem = model.commentsImage[index]
    }
}

private extension CommentsImageViewModel{
    //we wanted to say that in some cases I will not use it
    @discardableResult
    func makeViewBaseModel(_ commentsImage:[CommentImageCellViewModel]) -> [CommentImageCellViewModel]{
        //we use it to translate the data from the model into the desired structure of the cell
        return commentsImage.map{.init(title:$0.title,url:$0.url)}
    }
}

//MARK:-CommentsImageModelProtocol
extension CommentsImageViewModel:CommentsImageModelProtocol{
    //We'll get word Data's been pulled.
    func didImageDataFetchProcessFinish(_ isSuccess: Bool) {
    
        if isSuccess{
            let commentsImage = model.commentsImage
            let cellImageModels = makeViewBaseModel(commentsImage)
            viewDelegate?.didCellItemImageFetch(cellImageModels)
            viewDelegate?.hideEmptyImageView()
        }
        else{
            viewDelegate?.hideEmptyImageView()
        }

      
        
    }
}
