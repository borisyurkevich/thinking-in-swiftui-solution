//
//  ViewUpdatesContentView.swift
//  View Updates
//
//  Created by Boris Yurkevich on 04/11/2020.
//

import SwiftUI

struct ViewUpdatesContentView: View {
    
    @StateObject var remote = Remote()
    // Solution uses ObservedObject. I don't
    // know which one to choose and what makes
    // them different? 😕
    
    var body: some View {
        NavigationView() {
            Group {
                if remote.photos.isEmpty {
                    Text("Photos are loading...")
                        .onAppear() {
                            remote.load()
                        } // Only loads when photos are empty
                } else { // 🎉🎉 This `else` is necessery to make the app work. Otherwise PhotosList is not created after remote is published.
                    PhotosList(photos: remote.photos)
                        .navigationTitle("Photos")
                }
            }.navigationTitle("Photos")
        }
    }
}

struct PhotosList: View {
    @State var photos: [Photo]
    
    var body: some View {
        List(photos) { photo in
            NavigationLink(photo.author, destination: PhotoView(downloadURL: photo.download_url))
        }
    }
}

struct PhotoView: View {
    let downloadURL: URL
    
    @StateObject var remote = Remote()
    
    var body: some View {
        // TODO: This doesn't need
        if remote.selectedPhoto != nil {
            if let data = remote.selectedPhoto, let picture = UIImage(data: data) {
                Image(uiImage: picture)
                    .resizable()
                    // Doc doesn't show what's resizable is doing 🤷🏻‍♂️.
                    // I suspect it resizes the image to fit the view.
                    .aspectRatio(picture.size, contentMode: .fit)
                    // What's cool we don't need the API to tell us the image size.
            }
        } else {
            Text("Loading \(downloadURL)")
                .onAppear() {
                    remote.download(link: downloadURL)
                }
        }
    }
}

struct ViewUpdatesContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ViewUpdatesContentView()
        }.previewLayout(.sizeThatFits)
    }
}
