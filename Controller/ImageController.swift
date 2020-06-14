//
//  ImageController.swift
//  Colorizer
//
//  Created by debavlad on 14.06.2020.
//  Copyright © 2020 debavlad. All rights reserved.
//

import UIKit

protocol Notifiable {
	
	func colorChanged(to color: UIColor)
}

class ImageController: UIViewController, Notifiable {

	func colorChanged(to color: UIColor) {
		colorInfoView.set(color: color)
	}

	var pickerView: PickerView!

	private var scrollView = UIScrollView()

	private var colorInfoView: ColorInfoView!

	var photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(white: 0.95, alpha: 1)
		setupSubviews()
	}

	private func setupSubviews() {
		scrollView.delegate = self
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 8.0

		view.addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])

		scrollView.addSubview(photoImageView)
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			photoImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			photoImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
			photoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			photoImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
		])

		colorInfoView = ColorInfoView()
		colorInfoView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(colorInfoView)
		NSLayoutConstraint.activate([
			colorInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
			colorInfoView.heightAnchor.constraint(equalToConstant: 50),
			colorInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			colorInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
		])

		pickerView = PickerView(frame: CGRect(origin: .zero, size: CGSize(width: 35, height: 35)))
		pickerView.delegate = self
		photoImageView.addSubview(pickerView)
		photoImageView.isUserInteractionEnabled = true
		pickerView.center = view.center
	}
}

extension ImageController: UIScrollViewDelegate {

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return photoImageView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let scale = scrollView.zoomScale
		pickerView.transform = CGAffineTransform(scaleX: 1/scale, y: 1/scale)
	}
}