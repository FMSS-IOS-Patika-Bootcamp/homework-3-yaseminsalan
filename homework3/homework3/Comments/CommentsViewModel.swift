//
//  CommentsViewModel.swift
//  homework3
//

//

import Foundation


//We notified the View with the delegate structure
protocol CommentsViewModelViewProtocol:AnyObject{
    //view e haber verir
    func didCellItemFetch(_ items:[CommentCellViewModel])
    func showEmptyView()
    func hideEmptyView()
}
class CommentsViewModel{
    //ViewModel has to keep the Model I, for this we created a model list
    private let model = CommentsModel()
    
    weak var viewDelegate:CommentsViewModelViewProtocol?
  
    
    init(){
        //We have delegated the model in Model to receive news from Model
        model.delegate = self
    }
    
    //Informs us that the ViewController is loaded and we can now pull data from the API and perform operations.
    func didViewLoad(){
        model.fetchData()
    }
    //for the communication of the clicked cells
    func didClickItem(at index:Int){
        //TODO
        let selectedItem = model.comments[index]
    }
}

private extension CommentsViewModel{
    //we wanted to say that in some cases I will not use it
    @discardableResult
    func makeViewBaseModel(_ comments:[CommentCellViewModel]) -> [CommentCellViewModel]{
        //we use it to translate the data from the model into the desired structure of the cell
        return comments.map{.init(title:$0.title,body:$0.body)}
    }
}

//MARK:-CommentsModelProtocol
extension CommentsViewModel:CommentsModelProtocol{
    //We'll get word Data's been pulled.
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
    
        if isSuccess{
            let comments = model.comments
            let cellModels = makeViewBaseModel(comments)
            viewDelegate?.didCellItemFetch(cellModels)
            viewDelegate?.hideEmptyView()
        }
        else{
            viewDelegate?.showEmptyView()
        }


        //TODO:
        

      
        
    }
}
