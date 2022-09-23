//
//  CommentsModel.swift
//  homework3


import Foundation

//Protocol was used to transfer the data from the API to the viewModel
protocol CommentsModelProtocol:AnyObject{
    func didDataFetchProcessFinish(_ isSuccess:Bool)
}

class CommentsModel{
    //Notifies ViewModel
    weak var delegate:CommentsModelProtocol?
    var comments:[CommentCellViewModel] = []
    func fetchData(){
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else {
            //false is returned if the url does not exist or is the wrong url
            delegate?.didDataFetchProcessFinish(false)
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
                self?.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            guard let data = data else{
                //Even if there is no error, data may not have arrived, false is returned because there is no data
                self?.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            //data arrived without any problems
            do{
                
                //we can convert the incoming data to the class we want
                let jsonDecoder = JSONDecoder()
                //we said convert the data here to the "CommentCellViewModel" array type
                self?.comments = try  jsonDecoder.decode([CommentCellViewModel].self, from: data)
                //We notify ViewModel (everything is done, successfully received the data)
                self?.delegate?.didDataFetchProcessFinish(true)
            }catch{
                self?.delegate?.didDataFetchProcessFinish(false)
                print("JSON Serialization")
            }
            
        }
        task.resume()

    }
}
