//
//  PollOptionView.swift
//  Pollexa
//
//  Created by furkan icoz on 8.06.2024.
//

import UIKit

protocol PollOptionViewDelegate: AnyObject {
    func buttonAction(optionId: String)
}

@IBDesignable
class PollOptionView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: PollOptionViewDelegate?
    var id: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        loadView()
    }
}

extension PollOptionView {
    
    func set(content: OptionViewContent, delegate: PollOptionViewDelegate, voteEnabled: Bool) {
        id = content.id
        imageView.image = content.image
        rateLabel.text = "\(content.rate) %"
        button.setImage(
            (content.voteState ?? false) ? UIImage.thumbCircleFill : nil,
            animated: false,
            color: .accent
        )
        self.delegate = delegate
        
        rateLabel.isHidden = !(content.voteState ?? false)
        button.isEnabled = voteEnabled
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let id else { return }

        self.button.setImage(
            UIImage.thumbCircleFill,
            animated: true,
            color: .accent
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.buttonAction(optionId: id)
        }
    }
}
