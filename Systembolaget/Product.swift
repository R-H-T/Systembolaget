//
//  Product.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 16/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding {
    
    
    // MARK: - Properties
    
    var number: String?
    var articleID: String?
    var productNumber: String?
    var name: String?
    var name2: String?
    var priceVATIncluded: String?
    var volumeInML: String?
    var pricePerLiter: String?
    var soldSince: String?
    var expired: String?
    var productGroup: String?
    var typeDesc: String?
    var style: String?
    var packaging: String?
    var seal: String?
    var origin: String?
    var originCountryName: String?
    var manufacturer: String?
    var provider: String?
    var fromYear: String?
    var sampledYear: String?
    var alchoholLevel: String?
    var supply: String?
    var supplyText: String?
    var ecological: String?
    var koscher: String?
    var rawIngredientsDescription: String?
    
    var lastUpdatedDate = Date()
    var isFavorite: Bool = false
    
    // MARK: Keys
    struct Keys {
        
        // Default values since 16th Nov 2016
        static let Number = "nr"
        static let ArticleID = "Artikelid"
        static let ProductNumber = "Varnummer"
        static let Name = "Namn"
        static let Name2 = "Namn2"
        static let PriceVATIncluded = "Prisinklmoms"
        static let VolumeInML = "Volymiml"
        static let PricePerLiter = "PrisPerLiter"
        static let SoldSince = "Saljstart"
        static let Expired = "Utgått"
        static let ProductGroup = "Varugrupp"
        static let TypeDesc = "Typ"
        static let Style = "Stil"
        static let Packaging = "Forpackning"
        static let Seal = "Forslutning"
        static let Origin = "Ursprung"
        static let OriginCountryName = "Ursprunglandnamn"
        static let Manufacturer = "Producent"
        static let Provider = "Leverantor"
        static let FromYear = "Argang"
        static let SampledYear = "Provadargang"
        static let AlchoholLevel = "Alkoholhalt"
        static let Supply = "Sortiment"
        static let SupplyText = "SortimentText"
        static let Ecological = "Ekologisk"
        static let Koscher = "Koscher"
        static let RawIngredientsDescription = "RavarorBeskrivning"
        
        /* XML Output
         <nr>101</nr>
         <Artikelid>1</Artikelid>
         <Varnummer>1</Varnummer>
         <Namn>Renat</Namn>
         <Namn2/>
         <Prisinklmoms>205.00</Prisinklmoms>
         <Volymiml>700.00</Volymiml>
         <PrisPerLiter>292.86</PrisPerLiter>
         <Saljstart>1993-10-01</Saljstart>
         <Utgått>0</Utgått>
         <Varugrupp>Okryddad sprit</Varugrupp>
         <Typ/>
         <Stil/>
         <Forpackning>Flaska</Forpackning>
         <Forslutning/>
         <Ursprung/>
         <Ursprunglandnamn>Sverige</Ursprunglandnamn>
         <Producent>Pernod Ricard</Producent>
         <Leverantor>Pernod Ricard Sweden AB</Leverantor>
         <Argang/>
         <Provadargang/>
         <Alkoholhalt>37.50%</Alkoholhalt>
         <Sortiment>FS</Sortiment>
         <SortimentText>Ordinarie sortiment</SortimentText>
         <Ekologisk>0</Ekologisk>
         <Etiskt>0</Etiskt>
         <Koscher>0</Koscher>
         <RavarorBeskrivning>Säd.</RavarorBeskrivning>
         */
    }
    
    // MARK: NSCoding Keys
    enum NSCodingKeys: String {
        
        case lastUpdatedDate
        case isFavorite
        case number
        case articleID
        case productNumber
        case name
        case name2
        case priceVATIncluded
        case volumeInML
        case pricePerLiter
        case soldSince
        case expired
        case productGroup
        case typeDesc
        case style
        case packaging
        case seal
        case origin
        case originCountryName
        case manufacturer
        case provider
        case fromYear
        case sampledYear
        case alchoholLevel
        case supply
        case supplyText
        case ecological
        case koscher
        case rawIngredientsDescription
    }
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        // init
    }
    
    // Convenience initializer which takes a dictionary as its argument
    convenience init(with dictionary: [String : Any?]) {
        self.init()
        
        self.number = dictionary[Keys.Number] as? String ?? "N/A"
        self.articleID = dictionary[Keys.ArticleID] as? String ?? "N/A"
        self.productNumber = dictionary[Keys.ProductNumber] as? String ?? "N/A"
        self.name = dictionary[Keys.Name] as? String ?? "N/A"
        self.name2 = dictionary[Keys.Name2] as? String ?? "N/A"
        self.priceVATIncluded = dictionary[Keys.PriceVATIncluded] as? String ?? "N/A"
        self.volumeInML = dictionary[Keys.VolumeInML] as? String ?? "N/A"
        self.pricePerLiter = dictionary[Keys.PricePerLiter] as? String ?? "N/A"
        self.soldSince = dictionary[Keys.SoldSince] as? String ?? "N/A"
        self.expired = dictionary[Keys.Expired] as? String ?? "N/A"
        self.productGroup = dictionary[Keys.ProductGroup] as? String ?? "N/A"
        self.typeDesc = dictionary[Keys.TypeDesc] as? String ?? "N/A"
        self.style = dictionary[Keys.Style] as? String ?? "N/A"
        self.packaging = dictionary[Keys.Packaging] as? String ?? "N/A"
        self.seal = dictionary[Keys.Seal] as? String ?? "N/A"
        self.origin = dictionary[Keys.Origin] as? String ?? "N/A"
        self.originCountryName = dictionary[Keys.OriginCountryName] as? String ?? "N/A"
        self.manufacturer = dictionary[Keys.Manufacturer] as? String ?? "N/A"
        self.provider = dictionary[Keys.Provider] as? String ?? "N/A"
        self.fromYear = dictionary[Keys.FromYear] as? String ?? "N/A"
        self.sampledYear = dictionary[Keys.SampledYear] as? String ?? "N/A"
        self.alchoholLevel = dictionary[Keys.AlchoholLevel] as? String ?? "N/A"
        self.supply = dictionary[Keys.Supply] as? String ?? "N/A"
        self.supplyText = dictionary[Keys.SupplyText] as? String ?? "N/A"
        self.ecological = dictionary[Keys.Ecological] as? String ?? "N/A"
        self.koscher = dictionary[Keys.Koscher] as? String ?? "N/A"
        self.rawIngredientsDescription = dictionary[Keys.RawIngredientsDescription] as? String ?? "N/A"
        
        self.lastUpdatedDate = Date()
    }
    
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        
        self.number = aDecoder.decodeObject(forKey: NSCodingKeys.number.rawValue) as? String
        self.articleID = aDecoder.decodeObject(forKey: NSCodingKeys.articleID.rawValue) as? String
        self.productNumber = aDecoder.decodeObject(forKey: NSCodingKeys.productNumber.rawValue) as? String
        self.name = aDecoder.decodeObject(forKey: NSCodingKeys.name.rawValue) as? String
        self.name2 = aDecoder.decodeObject(forKey: NSCodingKeys.name2.rawValue) as? String
        self.priceVATIncluded = aDecoder.decodeObject(forKey: NSCodingKeys.priceVATIncluded.rawValue) as? String
        self.volumeInML = aDecoder.decodeObject(forKey: NSCodingKeys.volumeInML.rawValue) as? String
        self.pricePerLiter = aDecoder.decodeObject(forKey: NSCodingKeys.pricePerLiter.rawValue) as? String
        self.soldSince = aDecoder.decodeObject(forKey: NSCodingKeys.soldSince.rawValue) as? String
        self.expired = aDecoder.decodeObject(forKey: NSCodingKeys.expired.rawValue) as? String
        self.productGroup = aDecoder.decodeObject(forKey: NSCodingKeys.productGroup.rawValue) as? String
        self.typeDesc = aDecoder.decodeObject(forKey: NSCodingKeys.typeDesc.rawValue) as? String
        self.style = aDecoder.decodeObject(forKey: NSCodingKeys.style.rawValue) as? String
        self.packaging = aDecoder.decodeObject(forKey: NSCodingKeys.packaging.rawValue) as? String
        self.seal = aDecoder.decodeObject(forKey: NSCodingKeys.seal.rawValue) as? String
        self.origin = aDecoder.decodeObject(forKey: NSCodingKeys.origin.rawValue) as? String
        self.originCountryName = aDecoder.decodeObject(forKey: NSCodingKeys.originCountryName.rawValue) as? String
        self.manufacturer = aDecoder.decodeObject(forKey: NSCodingKeys.manufacturer.rawValue) as? String
        self.provider = aDecoder.decodeObject(forKey: NSCodingKeys.provider.rawValue) as? String
        self.fromYear = aDecoder.decodeObject(forKey: NSCodingKeys.fromYear.rawValue) as? String
        self.sampledYear = aDecoder.decodeObject(forKey: NSCodingKeys.sampledYear.rawValue) as? String
        self.alchoholLevel = aDecoder.decodeObject(forKey: NSCodingKeys.alchoholLevel.rawValue) as? String
        self.supply = aDecoder.decodeObject(forKey: NSCodingKeys.supply.rawValue) as? String
        self.supplyText = aDecoder.decodeObject(forKey: NSCodingKeys.supplyText.rawValue) as? String
        self.ecological = aDecoder.decodeObject(forKey: NSCodingKeys.ecological.rawValue) as? String
        self.koscher = aDecoder.decodeObject(forKey: NSCodingKeys.koscher.rawValue) as? String
        self.rawIngredientsDescription = aDecoder.decodeObject(forKey: NSCodingKeys.rawIngredientsDescription.rawValue) as? String
        self.isFavorite = (aDecoder.decodeObject(forKey: NSCodingKeys.isFavorite.rawValue) as? NSNumber)?.boolValue ?? false
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.number, forKey: NSCodingKeys.number.rawValue)
        aCoder.encode(self.articleID, forKey: NSCodingKeys.articleID.rawValue)
        aCoder.encode(self.productNumber, forKey: NSCodingKeys.productNumber.rawValue)
        aCoder.encode(self.name, forKey: NSCodingKeys.name.rawValue)
        aCoder.encode(self.name2, forKey: NSCodingKeys.name2.rawValue)
        aCoder.encode(self.priceVATIncluded, forKey: NSCodingKeys.priceVATIncluded.rawValue)
        aCoder.encode(self.volumeInML, forKey: NSCodingKeys.volumeInML.rawValue)
        aCoder.encode(self.pricePerLiter, forKey: NSCodingKeys.pricePerLiter.rawValue)
        aCoder.encode(self.soldSince, forKey: NSCodingKeys.soldSince.rawValue)
        aCoder.encode(self.expired, forKey: NSCodingKeys.expired.rawValue)
        aCoder.encode(self.productGroup, forKey: NSCodingKeys.productGroup.rawValue)
        aCoder.encode(self.typeDesc, forKey: NSCodingKeys.typeDesc.rawValue)
        aCoder.encode(self.style, forKey: NSCodingKeys.style.rawValue)
        aCoder.encode(self.packaging, forKey: NSCodingKeys.packaging.rawValue)
        aCoder.encode(self.seal, forKey: NSCodingKeys.seal.rawValue)
        aCoder.encode(self.origin, forKey: NSCodingKeys.origin.rawValue)
        aCoder.encode(self.originCountryName, forKey: NSCodingKeys.originCountryName.rawValue)
        aCoder.encode(self.manufacturer, forKey: NSCodingKeys.manufacturer.rawValue)
        aCoder.encode(self.provider, forKey: NSCodingKeys.provider.rawValue)
        aCoder.encode(self.fromYear, forKey: NSCodingKeys.fromYear.rawValue)
        aCoder.encode(self.sampledYear, forKey: NSCodingKeys.sampledYear.rawValue)
        aCoder.encode(self.alchoholLevel, forKey: NSCodingKeys.alchoholLevel.rawValue)
        aCoder.encode(self.supply, forKey: NSCodingKeys.supply.rawValue)
        aCoder.encode(self.supplyText, forKey: NSCodingKeys.supplyText.rawValue)
        aCoder.encode(self.ecological, forKey: NSCodingKeys.ecological.rawValue)
        aCoder.encode(self.koscher, forKey: NSCodingKeys.koscher.rawValue)
        aCoder.encode(self.rawIngredientsDescription, forKey: NSCodingKeys.rawIngredientsDescription.rawValue)
        aCoder.encode(self.lastUpdatedDate, forKey: NSCodingKeys.lastUpdatedDate.rawValue)
        aCoder.encode(NSNumber(value: self.isFavorite), forKey: NSCodingKeys.isFavorite.rawValue)
    }
}
