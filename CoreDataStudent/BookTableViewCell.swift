//
//  BookTableViewCell.swift
//  CoreDataStudent
//
//  Created by Ducont on 04/01/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var bookTiTle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
