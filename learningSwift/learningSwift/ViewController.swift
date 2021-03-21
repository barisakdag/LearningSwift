//
//  ViewController.swift
//
//  Created by Baris Akdag on 2021-03-09.
//

import UIKit
import Foundation

struct JsonPlaceHolder: Codable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
}

class ViewController: UIViewController {

   @IBOutlet var tableView: UITableView!
    
    var listOfJsonPosts = [JsonPlaceHolder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        //var listOfJsonPosts = [JsonPlaceHolder]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        guard url != nil else {
            print("Error creating url object")
            return
        }
        
        let session =  URLSession.shared

        let datatask = session.dataTask(with: url!){
                    (data,response,error) in
                        //Check for errors
                    if error  == nil && data != nil{
                        //Parse the data
                        let decoder = JSONDecoder()
                        do{
                            let jsonObject =  try decoder.decode([JsonPlaceHolder].self
                                       , from: data!)

                            
                            //Adding the data to a list
                            self.listOfJsonPosts.append(contentsOf: jsonObject)
                            
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }

                            // For each item in the list, if the ID is  below or equal to 50 - Print it out
                            for item in self.listOfJsonPosts{
                                if item.id <= 50 {
                                    //print(item)
                                    print(item.userId)
                                    print(item.id)
                                    print(item.title)
                                    print(item.body)
                                }
                            }
                            
                        }catch{
                            print("Error in json parsing")
                        }
                    }
                    
                }
        
                datatask.resume()

}

}



extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400 //Height of cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfJsonPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JsonViewCellTableViewCell else{
            return UITableViewCell()
        }
        let list = self.listOfJsonPosts[indexPath.row]
        
        
        // add to list if list.id <=50
        // else set empty cellrows
        if list.id <= 50 {
            cell.labelOne?.text = "Id: " + String(list.id)
            cell.labelTwo?.text = "UserId: " + String(list.userId)
            cell.labelThree?.text = "Title: \n" + String(list.title)
            cell.labelFour?.text = "Body: \n" + String(list.body)
        }else{
            cell.labelOne?.text = ""
            cell.labelTwo?.text = ""
            cell.labelThree?.text = ""
            cell.labelFour?.text = ""
        }
        return cell
    }
    
}
