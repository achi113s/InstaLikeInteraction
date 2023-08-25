//
//  ContentView.swift
//  InstaLikeInteraction
//
//  Created by Giorgio Latour on 8/21/23.
//

import SwiftUI

struct ContentView: View {
    var post: PostModel = PostModel(imageName: "choonsik")
    @State var user: UserModel = UserModel(userName: "choonsik", profilePicture: "choonsikProfilePic")
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.white)
            PostView(post: post, user: $user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
