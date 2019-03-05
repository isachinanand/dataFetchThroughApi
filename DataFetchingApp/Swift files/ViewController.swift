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
class SampleData {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var didViewed = false
    var image:UIImage?
    var thumbnail:UIImage?
    var thumbnailURL : String
    init(_ values : [String:Any] )
    {        id = values["id"] as? Int ?? -1
        albumId = values["albumId"] as? Int ?? -1
        title = values["title"] as? String ?? ""
        url = values["url"] as? String ?? ""
        thumbnailURL = values["thumbnailUrl"] as? String ?? ""
    }
    
}
var start = 0
var limit = 10


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var emptyDict : [[String:Any]] = [[String:Any]]()
    var sampleData = [SampleData]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.title.text = sampleData[indexPath.row].title
        cell.tableImage?.image = sampleData[indexPath.row].thumbnail
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "segue", sender: self)
        // below is the code to perform navigation without segue
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DescriptionView") as? DescriptionView
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.title1 = emptyDict[indexPath.row]["title"] as! String
        vc?.albumId1 = emptyDict[indexPath.row]["albumId"] as! Int
        vc?.id1 = emptyDict[indexPath.row]["id"] as! Int
        
        
        
    }
    
    @IBOutlet weak var myView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        performGetRequest()
    }
    func performGetRequest(){
        self.getRequestAPICall(url: "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)")
        start = start+limit
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < sampleData.count{
            self.downloadThumbNail(forObject: sampleData[indexPath.row])
        }
        
        if(indexPath.row == sampleData.count-1){
            print(indexPath.row)
            performGetRequest()
        }
    }
    func getRequestAPICall(url: String)  {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.result.value as? [[String:Any]]{
                    //        your json converted into Dictonary
                    for singleResponse in data{
                        let sample = SampleData(singleResponse)
                        self.sampleData.append(sample)
                    }
                    self.myView.reloadData()
                    
                }
                
        }
        
        
        
        
    }
    func downloadImage(forObject:SampleData){
        if forObject.image == nil{
            Alamofire.request(forObject.url).responseImage(completionHandler: { (response) in
                forObject.image = response.result.value
            })
        }
    }
    func downloadThumbNail(forObject:SampleData){
        if forObject.thumbnail == nil{
            Alamofire.request(forObject.thumbnailURL).responseImage(completionHandler: { (response) in
                forObject.thumbnail = response.result.value
                print("image download for",forObject.id)
                let row = self.sampleData.firstIndex(where: { (obj) -> Bool in
                    return obj.id == forObject.id
                })
                let indexP = IndexPath(row: row ?? 0, section: 0)
                self.myView.reloadRows(at: [indexP], with: .automatic)
            })
        }
    }
    
}
