//
//  WikiView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import SwiftUI
import WebKit

struct WikiView: View {
    @State var webView: WKWebView?
    @State var canGoBack: Bool = false
    @State var canGoForward: Bool = false
    @State var lastURL: String = ""
    
    private let lastURLKey: String = "lastURL"
    
    private let mainPageURL: String = "https://wiki.melvoridle.com/w/Main_Page"
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            MelvorWikiWebView(
                webView: $webView,
                canGoBack: $canGoBack,
                canGoForward: $canGoForward,
                lastURL: $lastURL
            )
            
            HStack(spacing: 40) {
                Button {
                    webView?.goBack()
                } label: {
                    Image(systemName: "arrow.left")
                }
                .frame(width: 18, height: 18)
                .buttonStyle(WebViewButton(isEnabled: $canGoBack))
                
                Button {
                    webView?.goForward()
                } label: {
                    Image(systemName: "arrow.right")
                }
                
                .frame(width: 18, height: 18)
                .buttonStyle(WebViewButton(isEnabled: $canGoForward))
            }
            .padding()
        }
        .onAppear {
            loadLastURL()
        }
        .onChange(of: lastURL) { _, newValue in
            updateLastURL(to: lastURL)
        }
    }
    
    private func loadLastURL() {
        let isLoadLastURLActive = UserDefaults.standard.bool(forKey: "loadLastURLActive")
        
        if isLoadLastURLActive {
            lastURL = UserDefaults.standard.string(forKey: lastURLKey) ?? mainPageURL
        } else {
            lastURL = mainPageURL
        }
    }
    
    private func updateLastURL(to lastURL: String) {
        UserDefaults.standard.set(lastURL, forKey: lastURLKey)
    }
}

struct MelvorWikiWebView: UIViewRepresentable {
    @Binding var webView: WKWebView?
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    @Binding var lastURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        return webView
    }
    
    func updateUIView(
        _ webView: WKWebView,
        context: UIViewRepresentableContext<MelvorWikiWebView>
    ) {
        if webView.url == nil,
        let url = URL(string: lastURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            webView: $webView,
            canGoBack: $canGoBack,
            canGoForward: $canGoForward,
            lastURL: $lastURL
        )
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var webView: WKWebView?
        @Binding var canGoBack: Bool
        @Binding var canGoForward: Bool
        @Binding var lastURL: String
        
        init(
            webView: Binding<WKWebView?>,
            canGoBack: Binding<Bool>,
            canGoForward: Binding<Bool>,
            lastURL: Binding<String>
        ) {
            _webView = webView
            _canGoBack = canGoBack
            _canGoForward = canGoForward
            _lastURL = lastURL
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            self.webView = webView
            canGoBack = webView.canGoBack
            canGoForward = webView.canGoForward
        }
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            preferences: WKWebpagePreferences,
            decisionHandler: @escaping @MainActor (WKNavigationActionPolicy, WKWebpagePreferences) -> Void
        ) {
            if let url = navigationAction.request.url {
                lastURL = url.absoluteString
            }
            
            decisionHandler(.allow, preferences)
        }
    }
}
#Preview {
    WikiView()
}
