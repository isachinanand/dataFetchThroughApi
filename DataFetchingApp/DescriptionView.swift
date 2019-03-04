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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     titleDisp.text = title1
        self.dispcriptionImage.image = dispcriptionImage.image
        // Do any additional setup after loading the view.
    }
    

    

}
