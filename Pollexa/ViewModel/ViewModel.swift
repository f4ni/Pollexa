//
//  ViewModel.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import Foundation
import UIKit

protocol ViewModelDelegate: AnyObject {
    func updateList()
}

final class ViewModel {
    
    private let postProvider = PostProvider.shared
    weak var delegate: ViewModelDelegate?
    var posts: [Post]?
    var postConents: [PostCellContent]? {
        getPostCellConents()
    }
}

extension ViewModel {
    
    func getPostCount() -> Int {
        postConents?.count ?? 0
    }
    
    func retrievePosts() {
        postProvider.fetchAll { [weak self] result in
            switch result {
            case .success(let posts):
                print(posts)
                self?.posts = posts
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            self?.delegate?.updateList()
        }
    }
        
    private func getPostCellConents() -> [PostCellContent] {
        posts?.map({
            post in
            let (options, totalVote) = getOptionViewContent(post: post)
            return PostCellContent(
                id: post.id ?? UUID().uuidString,
                userImage: post.user?.image ?? UIImage.placeHolder,
                userName: post.user?.username ?? "",
                pollContent: post.content ?? "",
                pollOptionsContent: options, 
                isVoted: post.options?.contains(where: {($0.selected)}) ?? false,
                createDate: post.createdAt?.timeAgoDisplay ?? "",
                totalVote: "\(totalVote) Total Vote\(totalVote > 1 ? "s" : "")"
            )
        }) ?? []
    }
    
    func getOptionViewContent(post: Post) -> ([OptionViewContent], Int) {
        var totalVote = 0
        let options: [OptionViewContent] = post.options?.map({
            option in
            totalVote = post.options?.reduce(0, { ($0 + $1.voteCount ) }) ?? 1
            return OptionViewContent(
                id: option.id,
                image: option.image,
                rate:  Int(Float(option.voteCount)/Float(totalVote) * 100),
                voteState: option.selected
            )
        }) ?? []
        return (options, totalVote)
    }
    
    func updatePoll(postId: String, optionId: String) {
        guard let postIdxToUpdate = posts?.firstIndex(where: {$0.id == postId}),
              var post = posts?[postIdxToUpdate],
              let selectedOption = post.options?.first(where: { $0.id == optionId }),
              !(post.options?.contains(where: {$0.selected}) ?? false)
        else { return }
        
        let options = post.options?.map({ option in
            var option = option
            option.selected = option.id == selectedOption.id
            option.voteCount += option.selected ? 1 : 0
            return option
        })
        post.options = options
        posts?.remove(at: postIdxToUpdate)
        posts?.insert(post, at: postIdxToUpdate)
        delegate?.updateList()
    }
}
