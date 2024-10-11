//
//  UIImageView.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
