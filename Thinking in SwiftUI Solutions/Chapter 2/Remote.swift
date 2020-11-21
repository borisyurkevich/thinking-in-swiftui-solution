//
//  Remote.swift
//  View Updates
//
//  Created by Boris Yurkevich on 04/11/2020.
//

import Foundation
import os.log

final class Remote: ObservableObject {
    
    let endpoint = URL(string: "https://picsum.photos/v2/list")!
    let logger = Logger(subsystem: "com.cocoaswitch.view_updates", category: "remote")
    
    @Published var photos = [Photo]()
    @Published var selectedPhoto: Data?
    
    // Keeps strong reference to self
    func load() {
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if let error = error {
                self.handleClientError(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            if let data = data {
                let worker = JSONDecoder()
                do {
                    let items = try worker.decode([Photo].self, from: data)
                    self.logger.info("\(items.count) items are loaded")
                    DispatchQueue.main.async {
                        self.photos = items
                    }
                } catch {
                    self.handleClientError(error)
                    self.logger.debug("\(data.debugDescription)")
                }
            }
            // FIXME: this code is used twice
        }.resume()
    }
    
    func download(link: URL) {
        selectedPhoto = nil

        // Reuse session in prod
        URLSession.shared.dataTask(with: link) { data,response,error in
            if let error = error {
                self.handleClientError(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            if let data = data {
                self.selectedPhoto = data
            } else {
                self.logger.fault("data is missing for URL: \(link)")
            }
        }.resume()
    }
    
    func handleClientError(_ error: Error) {
        logger.error("handle client error \(error.localizedDescription) \(error as NSObject)")
    }
    
    func handleClientError(_ response: URLResponse?) {
        logger.error("handle client response error \(response.debugDescription)")
    }
    
    func handleServerError(_ response: URLResponse?) {
        logger.error("handle server error \(response.debugDescription)")
    }
}
