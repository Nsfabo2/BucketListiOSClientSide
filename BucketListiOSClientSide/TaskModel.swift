//
//  TaskModel.swift
//  BucketListiOSClientSide
//
//  Created by Najla on 12/01/2022.
//

import Foundation
class TaskModel{
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }//end getAllTasks
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
       if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
       var request = URLRequest(url: urlToReq)
       request.httpMethod = "POST"
       let bodyData = "objective=\(objective)"
       request.httpBody = bodyData.data(using: .utf8)
       let session = URLSession.shared
       let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
      task.resume()
            }
    }//end addTaskWithObjective
    
    static func updateTask(id: String,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
                 if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)") {
                     var request = URLRequest(url: urlToReq)
                     request.httpMethod = "PUT"
                     let bodyData = "objective=\(objective)"
                     request.httpBody = bodyData.data(using: .utf8)
                     request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                     let session = URLSession.shared
                     let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                     task.resume()
                 }
         }//end updateTask
    
    static func deleteTask(id: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)") {
                var request = URLRequest(url: urlToReq)
                request.httpMethod = "DELETE"
                let bodyData = "id=\(id)"
                request.httpBody = bodyData.data(using: .utf8)
               let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }//end deleteTask
    
}//end class
