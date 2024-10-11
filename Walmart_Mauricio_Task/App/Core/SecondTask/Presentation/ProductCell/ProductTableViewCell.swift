//
//  ProductTableViewCell.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let stockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stockLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            stockLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            stockLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            stockLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            stockLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = product.price
        stockLabel.text = "Disponibles: \(product.stock)"
        print("IMAGEN URL:")
        print(product.imageUrl)
        if let imageUrl = URL(string: product.imageUrl) {
            productImageView.loadImage(from: imageUrl)
        }
    }
    func resetContent() {
        nameLabel.text = nil
        priceLabel.text = nil
        productImageView.image = nil
    }
}
