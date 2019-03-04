//
//  ViewController.swift
//  DataFetchingApp
//
//  Created by Himanshu on 02/03/19.
//  Copyright © 2019 craterzone. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
/* class SampleData {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailURL : String
    init(data:[String:Any] )
    {        id = data["id"] as? Int ?? -1
        albumId = data["albumId"] as? Int ?? -1
        title = data["title"] as? String ?? ""
        url = data["url"] as? String ?? ""
        thumbnailURL = data["thumbnailURL"] as? String ?? ""
        
    }
    
} */
var start = 0
var limit = 10

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var emptyDict : [[String:Any]] = [[String:Any]]()
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return emptyDict.count
}




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if (emptyDict.count == 0) { print ("No data") }
        else {
            cell.title.text = emptyDict[indexPath.row]["title"] as! String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBOutlet weak var myView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        myView.delegate = self
        myView.dataSource = self
         self.getRequestAPICall(url: "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)")
        start = start+limit

}
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == emptyDict.count-1){
            print(indexPath.row)
        viewDidLoad()
        }
    }
    func getRequestAPICall(url: String)  {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.result.value as? [[String:Any]]{
                    //        your json converted into Dictonary
                   // print(data)
            self.emptyDict.append(contentsOf: data)
            self.myView.reloadData()
                    
                                    }
                
        }
        
        
        
        
    }


}
