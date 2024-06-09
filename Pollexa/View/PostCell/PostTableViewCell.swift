//
//  PostTableViewCell.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func optionSelected(optionId: String, postId: String)
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var pollContentLabel: UILabel!
    @IBOutlet weak var firstOptionView: PollOptionView!
    @IBOutlet weak var secondOptionView: PollOptionView!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var totalVoteCountLabel: UILabel!
    
    var selectedIdx: Int?
    weak var delegate: PostTableViewCellDelegate?
    var postId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ content: PostCellContent) {
        self.postId = content.id
        self.userNameLabel.text = content.userName
        self.userImageView.image = content.userImage
        self.pollContentLabel.text = content.pollContent
        self.createDateLabel.text = content.createDate
        self.totalVoteCountLabel.text = content.totalVote
        
        if let firsOption = content.pollOptionsContent.first {
            self.firstOptionView.set(
                content: firsOption,
                delegate: self,
                voteEnabled: !content.isVoted
            )
        }
        if let secondOption = content.pollOptionsContent.last {
            self.secondOptionView.set(
                content: secondOption,
                delegate: self,
                voteEnabled: !content.isVoted
            )
        }
    }
}

extension PostTableViewCell: PollOptionViewDelegate {
    func buttonAction(optionId: String) {
        guard let postId else { return }
        delegate?.optionSelected(optionId: optionId, postId: postId)
    }
}
