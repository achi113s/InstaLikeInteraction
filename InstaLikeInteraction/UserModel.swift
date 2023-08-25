//
//  UserModel.swift
//  InstaLikeInteraction
//
//  Created by Giorgio Latour on 8/21/23.
//

import SwiftUI

struct UserModel: Identifiable, Equatable {
    let id: UUID = UUID()
    let userName: String
    var profilePicture: String
    
    var likedPosts: Set<UUID> = []
    
    mutating func addPostToLikes(_ postID: UUID) {
        likedPosts.insert(postID)
    }
    
    mutating func removePostFromLikes(_ postID: UUID) {
        likedPosts.remove(postID)
    }
    
    func userHasLikedPost(_ postID: UUID) -> Bool {
        return likedPosts.contains(postID)
    }
}
