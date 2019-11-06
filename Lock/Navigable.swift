// Navigable.swift
//
// Copyright (c) 2016 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Auth0

protocol Navigable {

    func reload(with connections: Connections)
    func navigate(_ route: Route)

    func present(_ controller: UIViewController)

    func exit(withError error: Error)

    func resetScroll(_ animated: Bool)
    func scroll(toPosition: CGPoint, animated: Bool)

    func onBack()
}

extension Navigable {
    func showTermsPrompt(atSource source: UIView?, successHandler: @escaping (UIView?) -> Void) {
        let terms = "Terms & Policy".i18n(key: "com.auth0.lock.alert.tos.title", comment: "tos title")
        let alert = UIAlertController(title: terms, message: "By signing up, you agree to our terms of service and privacy policy".i18n(key: "com.auth0.lock.alert.tos", comment: "tos & privacy"), preferredStyle: .alert)
        if let source = source {
            alert.popoverPresentationController?.sourceView = source
            alert.popoverPresentationController?.sourceRect = source.bounds
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Accept", style: .default) { _ in
            successHandler(source)
        }
        [cancelAction, okAction].forEach { alert.addAction($0) }
        present(alert)
    }
}
