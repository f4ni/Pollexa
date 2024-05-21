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
    
    func loadView() {
        let view = loadFromNib()
        view.frame = self.bounds
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
