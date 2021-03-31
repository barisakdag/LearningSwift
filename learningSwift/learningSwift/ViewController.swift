//
//  ViewController.swift
//
//  Created by Baris Akdag on 2021-03-09.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: MyViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MyViewModel(apiService: ApiServiceJSON())
        //TestAPI
        //self.viewModel = MyViewModel(apiService: TestApiService(testData: [MyModel(userId: 1, id: 1, title: "", body: "")]))

        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.onDataChanged = { [weak self] in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.viewModel.callFuncToGetjsonData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // Filtering the list of jsonplaceholder where id is less or equal to 50
    var displayableCells: [MyModel] {
        return self.viewModel.jsonData.filter { $0.id <= 50 }
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

        let list = self.displayableCells[indexPath.row]
        
        cell!.labelOne.text = "Id: " + String(list.id)
        cell!.labelTwo.text = "UserId: " + String(list.userId)
        cell!.labelThree.text = "Title: \n" + String(list.title)
        cell!.labelFour.text = "Body: \n" + String(list.body)
        
        return cell!
    }
}
