//
//  ObjectCell.swift
//  Losty
//
//  Created by Crypto on 7/12/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit

class ObjectCell: UITableViewCell {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBOutlet weak var labelNameOutlet: UILabel!
    
    @IBOutlet weak var labelDateOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configCell (name: String, date: String, image: UIImage?) {
        
        labelNameOutlet.text = name
        labelDateOutlet.text = date
        imageViewOutlet.image = image
    }
    
}
