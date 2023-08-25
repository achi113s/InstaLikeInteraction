//
//  Post.swift
//  InstaLikeInteraction
//
//  Created by Giorgio Latour on 8/21/23.
//

import SwiftUI

struct PostView: View {
    var post: PostModel
    @Binding var user: UserModel
    
    @State private var hearts: [Heart] = []
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 15) {
                    Image(user.profilePicture)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(style: .init(lineWidth: 1))
                                .foregroundColor(Color(white: 0.93))
                        }
                    
                    Text("\(user.userName)")
                        .font(.system(.body, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        print("Follow")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 40)
                                .foregroundColor(Color(white: 0.93, opacity: 1.0))
                            Text("Follow")
                                .font(.system(.body, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    
                    Image(systemName: "ellipsis")
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                
                Image(post.imageName)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture(count: 2, coordinateSpace: .global) { tapLocation in
                        let heart = Heart(x: tapLocation.x, y: tapLocation.y)
                        withAnimation(.easeInOut(duration: 0.2)) {
                            user.addPostToLikes(post.id)
                            
                            hearts.append(
                                heart
                            )
                        }
                        
                        withAnimation(.easeInOut.delay(0.6)) {
                            hearts.removeAll(where: { $0.id == heart.id })
                        }
                    }
                
                HStack(spacing: 15) {
                    Image(systemName: user.userHasLikedPost(post.id) ? "heart.fill" : "heart")
                        .font(.system(size: 25))
                        .foregroundColor(user.userHasLikedPost(post.id) ? .red : .black)
                        .onTapGesture {
                            withAnimation {
                                if user.userHasLikedPost(post.id) {
                                    user.removePostFromLikes(post.id)
                                } else {
                                    user.addPostToLikes(post.id)
                                }
                            }
                        }
                    
                    Image(systemName: "bubble.right")
                        .font(.system(size: 25))
                    
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                    
                    Spacer()
                    
                    Image(systemName: "bookmark")
                        .font(.system(size: 25))
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15))
            }
            
            GeometryReader { geo in
                ForEach(hearts, id: \.id) { heart in
                    heart
                        .position(x: heart.x, y: heart.y - (heart.size.height * 1.8))
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: .opacity,
                                removal: .offset(
                                    x: heart.x < (geo.size.width / 2) ?
                                        (geo.size.width / 2) - heart.x :
                                        -(heart.x - (geo.size.width / 2)),
                                    y: -(geo.size.height / 2 + 300)
                                )
                            )
                        )
                        .zIndex(1)
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static let post = PostModel(imageName: "choonsik")
    static let user = UserModel(userName: "choonsik", profilePicture: "choonsikProfilePic")
    static var previews: some View {
        StatefulPreviewWrapper(user) { value in
            PostView(post: post, user: value)
        }
    }
}

struct Rotated: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: Double.random(in: 1.0...360.0)))
    }
}
