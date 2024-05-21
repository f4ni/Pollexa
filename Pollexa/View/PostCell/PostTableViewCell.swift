//
//  PostTableViewCell.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func optionSelected(optionIdx: Int, postId: String)
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var pollContentLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var createDateLabel: UILabel!
    
    var selectedIdx: Int?
    weak var delegate: PostTableViewCellDelegate?
    var postId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ post: Post) {
        self.userNameLabel.text = post.user?.username ?? ""
        self.userImageView.image = post.user?.image
        self.pollContentLabel.text = post.content ?? ""
        self.firstImageView.image = post.options?.first?.image
        self.firstButton.tag = 0
        self.secondImageView.image = post.options?.last?.image
        self.secondButton.tag = 1
        self.createDateLabel.text = post.createdAt ?? ""
        self.postId = post.id
        self.selectedIdx = post.options?.firstIndex(where: {$0.selected})
        setSelectedButtonImage(with: selectedIdx)
        
    }
    
    @IBAction func firsButtonSelected(_ sender: UIButton) {
        switchSelection(sender.tag)
    }
    
    @IBAction func secondButtonSelected(_ sender: UIButton) {
        switchSelection(sender.tag)
    }
    
    func switchSelection(_ selectedIdx: Int? = nil) {
        guard let selectedIdx,
              let postId,
              selectedIdx != self.selectedIdx else { return }
        
        self.selectedIdx = selectedIdx
        setSelectedButtonImage(with: selectedIdx, animated: true)
        delegate?.optionSelected(optionIdx: selectedIdx, postId: postId)
    }
    
    func setSelectedButtonImage(with selectedIdx: Int?, animated: Bool = false) {
        guard let selectedIdx,
           let selection = Selection(rawValue: selectedIdx)
        else {
            resetCell()
            return
        }
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.accent, .white])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(
            systemName: "hand.thumbsup.circle.fill",
            withConfiguration: colorConfig.applying(sizeConfig)
        )
        
        self.firstButton.setImage(
            selection == .first ? image : nil,
            animated: animated,
            color: .accent
        )
        
        self.secondButton.setImage(
            selection == .second ? image : nil,
            animated: animated,
            color: .accent
        )
    }
    
    override func prepareForReuse() {
        resetCell()
    }
    
    func resetCell() {
        self.firstButton.setImage(nil, for: .normal)
        self.secondButton.setImage(nil, for: .normal)
    }
}

enum Selection: Int {
    case first = 0
    case second
}
