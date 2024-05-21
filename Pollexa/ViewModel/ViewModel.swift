//
//  ViewModel.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateList()
}

final class ViewModel {
    
    private let postProvider = PostProvider.shared
    
    weak var delegate: ViewModelDelegate?
    
    var posts: [Post]?
    
    func retrievePosts() {
        postProvider.fetchAll { result in
            switch result {
            case .success(let posts):
                print(posts)
                self.set(posts)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            delegate?.updateList()
        }
    }
    
    private func set(_ posts: [Post]) {
        self.posts = posts
    }
    
    func updatePoll(postId: String, optionIdx: Int) {
        if let postIdxToUpdate = posts?.firstIndex(where: {$0.id == postId}),
           var post = posts?[postIdxToUpdate],
           let selectedOption = post.options?[optionIdx]
        {
            let options = post.options?.map({ option in
                var option = option
                option.selected = option.id == selectedOption.id
                
                return option
            })
            post.options = options
            posts?.remove(at: postIdxToUpdate)
            posts?.insert(post, at: postIdxToUpdate)
            delegate?.updateList()
        }
    }
}
