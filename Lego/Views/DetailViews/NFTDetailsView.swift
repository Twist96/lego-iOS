//
//  NFTDetailsView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/04/2023.
//

import SwiftUI
import SceneKit

struct NFTDetailsView: View {
    var nft: NFT
    let assetModelCount: Int
    @StateObject var viewModel = NFTDetailsViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    init(nft: NFT) {
        self.nft = nft
        assetModelCount = nft.assetModels.count
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    ModelSceneView(assetModels: nft.assetModels)

                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 2) {
                            Group {
                                Text(nft.name)
                                    .font(.largeTitle)
                                + Text(" #\(nft.id)")
                                    .font(.title2)
                                    .fontWeight(.medium)
                            }
                            .frame(width: UIScreen.screenWidth * 2/3, alignment: .leading)

                            Text(nft.location)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }

                        Text(nft.description)
                            .font(.callout)
                    }
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    similarProperties

                    Spacer()
                }
                .padding(.bottom, 60)
            }

            VStack {
                Spacer()
                Button {

                } label: {
                    Text("Buy Shares")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white.opacity(0.75))
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 30)
                        .background(Color.blue)
                }
                .frame(maxWidth: .infinity)
            }

        }
        .overlay {
            VStack {
                dismissButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = true
            }
        }
    }

    var dismissButton: some View {
        Button {
            dismiss()
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = false
            }
        } label: {
            Image(systemName: "chevron.left")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 5)
                .padding(.top, 32)
                .padding(.leading, 16)
        }

    }

    var similarProperties: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Similar Properties")
                .font(.headline)
                .padding(.leading, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.similarProperties) { nft in
                        NavigationLink {
                            NFTDetailsView(nft: nft)
                        } label: {
                            TinyNFTCards(nft: nft)
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 8)
        }
    }
}

struct NFTDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NFTDetailsView(nft: NFT.fakeData[0])
            .environmentObject(AppState())
    }
}
