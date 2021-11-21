//
//  PostRow.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let text = post.contents.first(where: { $0.type == .text })?.data.value {
                Text(text)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
            
            if let imageUrl = post.contents
                .first(where: { $0.data.previewImage != nil })?
                .data.previewImage?.data.medium?.url {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
        }
        .padding(.bottom, 12)
    }
}
