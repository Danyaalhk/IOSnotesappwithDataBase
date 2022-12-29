//
//  APIfunctions.swift
//  Note-app
//
//  Created by Danyaal Kashif on 12/27/22.
//

import Foundation
import Alamofire
//MRK: - Custom Notes Struct
struct Note: Decodable{
    var title: String
    var date: String
    var _id: String
    var note: String
}


//MARK: - Functions That Interact With Custom API
class APIFunctions{
    //sets custom data delegate
    var delegate: DataDelegate?
    //creates an instance of class so other files can interact with the class
    static let functions = APIFunctions()
    //Fetches Notes from MongoDB
    func fetchNotes(){
        AF.request("http://192.168.254.125:8081/fetch").response { response in
            
            print("response data: ")
            print(response.data!)
            //Converts JSOn response imto UTF8 string format
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func AddNote(date: String, title: String, note: String){
        
        AF.request("http://192.168.254.125:8081/create", method: .post, encoding: URLEncoding.httpBody, headers:["title":title, "date": date, "note": note]).responseJSON{
            response in
            print(response)
            
        }
        
    }
    
    func updateNote(date:String, title: String, note: String, id: String){
        AF.request("http://192.168.254.125:8081/update", method: .post, encoding: URLEncoding.httpBody, headers:["title":title, "date": date, "note": note, "id": id]).responseJSON{
            response in
            print(response)
        }
        
    }
    
    func deleteNote(id: String){
        AF.request("http://192.168.254.125:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers:["id": id]).responseJSON{
            response in
            print(response)
        }
    }
    
    
    
    
}
