//
//  MainTableViewCell.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    //MARK: - Implementation
    static let identifier = "MainTableViewCell"
    
    public func populate(from model: SearchResponse.Item) {
        self.model = model
        
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.loginLabel.text = model.owner.login
        
        self.isPrivateLabel.isHidden = !model.private
        
        if let imageURL = URL(string: model.owner.avatar_url){
            let request = URLSession.shared.dataTask(with: imageURL) { (imageData, _, error) in
                guard let image = imageData else {return}
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: image)
                    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            }
            request.resume()
            self.request = request
        }
    }
    
    //MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        reuse()
    }
    
    //MARK: - Private Implementation
    private var model: SearchResponse.Item?
    private var request: URLSessionDataTask?
    
    /// - `ImageView`
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    /// - `Label`
    @IBOutlet private weak var nameLabel: TitleLabel!
    @IBOutlet private weak var descriptionLabel: TextLabel!
    @IBOutlet private weak var loginLabel: TextLabel!
    @IBOutlet private weak var isPrivateLabel: UILabel!
}









//MARK: - Private Methods
private extension MainTableViewCell {
    
    func reuse() {
        isPrivateLabel.isHidden = true
        avatarImageView.image = nil
        request?.cancel()
        request = nil
    }
    
}
