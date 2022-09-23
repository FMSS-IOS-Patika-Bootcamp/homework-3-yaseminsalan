//
//  CommentsEntity.swift
//  homework3


import Foundation
//called decodable so that it can be decoded on the data side
struct CommentCellViewModel:Decodable{
    var userId:Int?
    var id:Int?
    var title:String?
    var body:String?
   
}

struct CommentImageCellViewModel:Decodable{
    var albumId:Int?
    var id:Int?
    var title:String?
    var url:String?
    var thumbnailUrl:String?
   
}

