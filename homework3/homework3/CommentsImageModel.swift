//
//  CommentsImageModel.swift
//  homework3


import Foundation

//Protocol was used to transfer the data from the API to the viewModel
protocol CommentsImageModelProtocol:AnyObject{
    func didImageDataFetchProcessFinish(_ isSuccess:Bool)
}

class CommentsImageModel{
    //Notifies ViewModel
    weak var delegateImage:CommentsImageModelProtocol?
    var commentsImage:[CommentImageCellViewModel] = []
    func fetchData(){
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/photos") else {
            //false is returned if the url does not exist or is the wrong url
            delegateImage?.didImageDataFetchProcessFinish(false)
            return
        }
            var request:URLRequest = .init(url: url)
        // We set GET method as http method
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){[weak self]
            data,response,error in
            //is checked for errors
            guard  error == nil else{
                //no data was received because an error was received, therefore false is returned
                self?.delegateImage?.didImageDataFetchProcessFinish(false)
                return
            }
            
            guard let data = data else{
                //Even if there is no error, data may not have arrived, false is returned because there is no data
                self?.delegateImage?.didImageDataFetchProcessFinish(false)
                return
            }
            
            //data arrived without any problems
            do{
                
                //we can convert the incoming data to the class we want
                let jsonDecoder = JSONDecoder()
                //we said convert the data here to the "CommentCellViewModel" array type
                self?.commentsImage = try  jsonDecoder.decode([CommentImageCellViewModel].self, from: data)
                //We notify ViewModel (everything is done, successfully received the data)
                
                print("deneme collection")
                self?.delegateImage?.didImageDataFetchProcessFinish(true)
            }catch{
                self?.delegateImage?.didImageDataFetchProcessFinish(false)
                print("JSON Serialization")
            }
            
        }
        task.resume()

    }
}
