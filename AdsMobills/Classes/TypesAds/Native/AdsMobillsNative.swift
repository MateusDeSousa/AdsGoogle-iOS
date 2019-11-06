//
//  AdsMobillsNative.swift
//  AdsMobills
//
//  Created by Mateus de Sousa on 24/10/19.
//

import Foundation
import GoogleMobileAds

public class AdsMobillsNative: NSObject, GADUnifiedNativeAdLoaderDelegate {
    
    public static var shareInstance = AdsMobillsNative()
    
    static var adIdExpansive = ""
    static var adIdDefault = ""
    var viewTemplate: UIView!
    static var fromController = UIViewController()
    static var adNative: GADAdLoader!
    
    public func loadAdsNative(fromController: UIViewController, viewTemplate: UIView){
        AdsMobillsNative.fromController = fromController
        self.viewTemplate = viewTemplate
        AdsMobillsNative.adNative = loadExpansiveNative()
    }
    
    private func loadExpansiveNative() -> GADAdLoader{
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 5
        
        let adLoad = GADAdLoader(adUnitID: AdsMobillsNative.adIdExpansive, rootViewController: AdsMobillsNative.fromController, adTypes: [.unifiedNative], options: [multipleAdsOptions])
        adLoad.delegate = AdsMobillsNative.shareInstance
        adLoad.load(GADRequest())
        return adLoad
    }
    
    private func loadDefaultNative() -> GADAdLoader{
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 5
        
        let adLoad = GADAdLoader(adUnitID: AdsMobillsNative.adIdDefault, rootViewController: AdsMobillsNative.fromController, adTypes: [.unifiedNative], options: [multipleAdsOptions])
        adLoad.delegate = AdsMobillsNative.shareInstance
        adLoad.load(GADRequest())
        return adLoad
    }
    
    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        let adLoadId = AdsMobillsNative.adNative
        if adLoadId?.adUnitID == AdsMobillsNative.adIdExpansive{
            AdsMobillsNative.adNative = loadDefaultNative()
            return
        }
    }
    
    public func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        if #available(iOS 9.0, *) {
            if let view = viewTemplate as? GADTMediumTemplateView{
                view.setNativeAd = nativeAd
            }else if let view = viewTemplate as? GADTSmallTemplateView{
                view.setNativeAd = nativeAd
            }
        }
    }
    
}