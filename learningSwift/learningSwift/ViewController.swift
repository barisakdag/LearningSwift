//
//  ViewController.swift
//
//  Created by Baris Akdag on 2021-03-09.
//

import Foundation
import UIKit

struct JsonPlaceHolder: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var listOfJsonPosts = [JsonPlaceHolder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url) {
            data, _, error in
            // Check for errors
            if error == nil, data != nil {
                // Parse the data
                let decoder = JSONDecoder()
                do {
                    let jsonObject = try decoder.decode([JsonPlaceHolder].self,
                                                        from: data!)
                    
                    // Adding the data to a list
                    self.listOfJsonPosts.append(contentsOf: jsonObject)
                    
                    // ReloadData
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    // For each item in the list, if the ID is  below or equal to 50 - Print it out
                    for item in self.listOfJsonPosts {
                        if item.id <= 50 {
                            // print(item)
                            print(item.userId)
                            print(item.id)
                            print(item.title)
                            print(item.body)
                        }
                    }
                    
                } catch {
                    print("Error in json parsing")
                }
            }
        }
        
        datatask.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // Filtering the list of jsonplaceholder where id is less or equal to 50
    var displayableCells: [JsonPlaceHolder] {
        return self.listOfJsonPosts.filter { $0.id <= 50 }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400 // Height of cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayableCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JsonViewCellTableViewCell
        // guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JsonViewCellTableViewCell else{
        //    return UITableViewCell()
        // }
        
        let list = self.displayableCells[indexPath.row]
        
        cell!.labelOne.text = "Id: " + String(list.id)
        cell!.labelTwo.text = "UserId: " + String(list.userId)
        cell!.labelThree.text = "Title: \n" + String(list.title)
        cell!.labelFour.text = "Body: \n" + String(list.body)
        
        return cell!
    }
}
