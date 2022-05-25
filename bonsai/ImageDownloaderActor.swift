//
//  ImageDownloaderActor.swift
//  bonsai
//
//  Created by justyn on 2022-05-19.
//
import UIKit
import Foundation

actor ImageLoader {
    
    private var images: [URLRequest: LoaderStatus] = [:]
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }

    public func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    // fetch image by URLRequest
    public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
       //check check if Url Request task is already in queue
        if let status = images[urlRequest] {
               switch status {
               case .fetched(let image):
                   return image
               case .inProgress(let task):
                   return try await task.value
               }
           }
        //synchronously grab image from filesystem. So next call of of fetch(_:) will receive the image from memory rather than the filesystem.
        if let image = try self.imageFromFileSystem(for: urlRequest) {
                images[urlRequest] = .fetched(image)
                return image
            }
        
        //create task to fetch image from network
        //then convert to UIImage and save to disk
        //Todo: use core data in the future?
        let task: Task<UIImage, Error> = Task {
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                //To:Do parse response throw apropriate exception
                let image = UIImage(data: data)!
                try self.persistImage(image, for: urlRequest)
                return image
            }
            
        //add inprogress task to existing image dictionary
        //do this before await, to prevent simultaneous tasks from reading the dict and sending an extra fetch request for an existing url
            images[urlRequest] = .inProgress(task)

            let image = try await task.value
        
            images[urlRequest] = .fetched(image)

            return image
        
    }
    private func imageFromFileSystem(for urlRequest: URLRequest) throws -> UIImage? {
        guard let url = fileName(for: urlRequest) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return nil
        }

        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
    
    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let fileName = urlRequest.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
                  return nil
              }

        return applicationSupport.appendingPathComponent(fileName)
    }
    
    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) throws {
        guard let url = fileName(for: urlRequest),
              let data = image.jpegData(compressionQuality: 0.8) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return
        }
        try data.write(to: url)
    }

}
