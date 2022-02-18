//
//  ViewController.swift
//  BucketListiOSClientSide
//
//  Created by Najla on 12/01/2022.
/*
 Finish the CRUD functionality on your Bucket List application.
 Server: Create the /tasks/update method that will update a particular task
 iOS: Create the update function in your TaskModel and call this to effectively update a task
 Server: Create the /tasks/delete method that will delete a particular task
 iOS: Create the delete function in your Task Model and call this in your "commitEditingStyle" tableView function to effectively delete a task
 */
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate  {

    //outlets:
    @IBOutlet weak var TaskTextField: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var BucketListTV: UITableView!
    //variables:
    var BucketList = [NSDictionary]()
    var updatedId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BucketListTV.dataSource = self
        BucketListTV.delegate = self
        updateData()
    }//end view
    
    func updateData (){
        TaskModel.getAllTasks() {
                           data, response, error in
                           do {
                              
                               self.BucketList.removeAll()
                               guard let data = data else {return}
                               if let tasksResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                                   for task in tasksResult{
                                       self.BucketList.append(task as! NSDictionary)
                                   }
                                   
                                   DispatchQueue.main.async {
                                       self.BucketListTV.reloadData()
                                   }
                               }
                           } catch {
                               print("Something went wrong")
                           }
                       }
    }//end update
    
    @IBAction func AdddButttonClicked(_ sender: Any) {
        guard let text = TaskTextField.text else{return}
           //add new task
            
        if (sender as AnyObject).titleLabel?.text == "add"{
              
              TaskModel.addTaskWithObjective(objective: text) {
                          data, response, error in
                         guard let myData = data else {return}
                         do{
                             let task = try JSONSerialization.jsonObject(with: myData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                             DispatchQueue.main.async {
                                 self.BucketList.append(task)
                                 self.BucketListTV.reloadData()
                             }
                             self.updateData()
                         print("new task added")
                         }catch{
                             
                         }
                         
                         }
                  
                  
                  
              }else{
                  
                  TaskModel.updateTask(id: BucketList[updatedId]["id"] as! String,objective: text) {
                                data, response, error in
                                 guard let myData = data else {return}
                                 do{
                                 let task = try JSONSerialization.jsonObject(with: myData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                 DispatchQueue.main.async {
                                     self.BucketList[self.updatedId] = task
                                     self.BucketListTV.reloadData()
                                 }
                                 self.updateData()
                                 print("task updated")
                                     self.AddButton.setTitle("add", for: .normal)
                                     
                                 }catch{
                                     
                                 }
                             }
                  
              }
              
    }//end AddButtonClicked
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BucketList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
             cell.textLabel?.text = BucketList[indexPath.row]["objective"] as? String
             return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        TaskModel.deleteTask(id: BucketList[indexPath.row]["id"] as! String) {
           data, response, error in
            print("task deleted")
            self.BucketList.remove(at: indexPath.row)
            self.updateData()
        }
  
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        AddButton.setTitle("update", for: .normal)
        TaskTextField.text = BucketList[indexPath.row]["objective"] as? String
        updatedId = indexPath.row
    }
}//end class

