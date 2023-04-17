//
//  ProfileView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 13/04/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var searchWord = ""
    @State private var scrollOffset: CGPoint = .zero
    @State private var headerHeight: CGFloat = 242

    var heightMultiplier: CGFloat {
        let multiplier = 1 - (yOffset / 150)
        if multiplier < 0.40 {
            return 0.40
        }
        return multiplier
    }

    var yOffset: CGFloat {
        if scrollOffset.y == 0 {
            return 1
        } else {
            return scrollOffset.y > 200 ? 200 : scrollOffset.y
        }
    }

    var profilePictureOffset: CGFloat {
        if scrollOffset.y <= 0 {
            return 1
        } else {
            return scrollOffset.y > 100 ? 100 : scrollOffset.y
        }
    }

    var body: some View {
        OffsetObservingScrollView(showsIndicators: false, offset: $scrollOffset) {

            ZStack {
                Color.black

                VStack {
                    Text("Benjamin Ray")

                    HStack {
                        Text("4.5")
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 11, height: 11)

                        Text("|")

                        Text("92")
                        Image(systemName: "heart.fill")
                    }

                    searchBar
                        .padding(20)

                    NFTGrid(showBidTime: false)
                        .padding(.bottom, 60)
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.top, headerHeight + 40)
            }
        }
        .ignoresSafeArea()
        .overlay {
            bannerAndProfilePicture
        }
    }

    var banner: some View {
        Image.banner
            .resizable()
            .ignoresSafeArea()
            .mask {
                if yOffset > 100 {
                    Rectangle()
                } else {
                    BannerShape()
                }
            }
            .frame(height: 242 * heightMultiplier)
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .shadow(color: .white.opacity(0.2), radius: 10)
    }

    var profileImage: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.05))
                .frame(width: 152, height: 152)

            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 152, height: 152)
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                }
            Image
                .ape
                .resizable()
                .frame(width: 138, height: 138)
                .clipShape(Circle())
        }
    }

    var bannerAndProfilePicture: some View {
        banner
            .overlay() {
                profileImage
                    .scaleEffect(0.8)
                    .scaleEffect(heightMultiplier)
                    .padding(.bottom, 50)
                    .offset(x: -((UIScreen.screenWidth / 2 - 32) * (profilePictureOffset/100)))
                    .offset(y: -((headerHeight / 2.7) * (profilePictureOffset/100)))
            }
            .frame(height: 242)
            .frame(maxHeight: .infinity, alignment: .top)
    }

    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchWord)
                    .placeholder(when: searchWord.isEmpty) {
                        Text("Search")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .accentColor(.red)
                    .foregroundColor(.white)
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(.white.opacity(0.07))
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.3))
            }

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
