//
//  DeveloperCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 22/04/2023.
//

import SwiftUI

struct DeveloperCard: View {
    var body: some View {
        VStack(spacing: 0) {
            Image.wallpaper
                .resizable()
                .frame(height: 90)
            Color.black.opacity(0.8)
                .overlay {
                    VStack(alignment: .leading) {
                        Image.ape
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.black.opacity(0.8), lineWidth: 2)
                            }
                            .padding(.leading, 18)
                        Text("Kayla's Court")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -20)
                }
        }
        .frame(width: 220, height: 160, alignment: .top)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
        }
    }
}

struct DeveloperCard_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperCard()
    }
}
