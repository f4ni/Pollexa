//
//  HeaderView.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import UIKit

class DiscoverHeader: UIView {
    
    @IBOutlet weak var postCountLabel: UILabel!
    
    init(postCount: Int) {
        super.init(frame: .zero)
        loadView()
        self.postCountLabel.text = "\(postCount) Active Poll"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        loadView()
    }
}
