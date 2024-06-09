//
//  PostCellContent.swift
//  Pollexa
//
//  Created by Furkan icoz on 8.06.2024.
//

import UIKit

struct PostCellContent {
    let id: String
    let userImage: UIImage
    let userName: String
    let pollContent: String
    let pollOptionsContent: [OptionViewContent]
    let isVoted: Bool
    let createDate: String
    let totalVote: String
}
