//
//  DescriptionView.swift
//  DataFetchingApp
//
//  Created by Himanshu on 02/03/19.
//  Copyright © 2019 craterzone. All rights reserved.
//

import UIKit

class DescriptionView: UIViewController {
    
    @IBOutlet weak var dispcriptionImage: UIImageView!
    
    @IBOutlet weak var albumIdDisp: UILabel!
    
    @IBOutlet weak var idDisp: UILabel!
    
    @IBOutlet weak var titleDisp: UILabel!
    var title1 = ""
    var albumId1 = 0
    var id1 = 0
    var image1:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleDisp.text = title1
        albumIdDisp.text = String(albumId1)
        idDisp.text = String(id1)
        dispcriptionImage?.image = image1
        //self.dispcriptionImage.image = dispcriptionImage.image
        // Do any additional setup after loading the view.
    }
    

    

}
