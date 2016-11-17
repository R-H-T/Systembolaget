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
        
        // NSCoding
        static let LastUpdatedDate = "last_updated_date"
        static let IsFavorite = "is_favorite"
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
        
        self.number = aDecoder.decodeObject(forKey: Keys.Number) as? String
        self.articleID = aDecoder.decodeObject(forKey: Keys.ArticleID) as? String
        self.productNumber = aDecoder.decodeObject(forKey: Keys.ProductNumber) as? String
        self.name = aDecoder.decodeObject(forKey: Keys.Name) as? String
        self.name2 = aDecoder.decodeObject(forKey: Keys.Name2) as? String
        self.priceVATIncluded = aDecoder.decodeObject(forKey: Keys.PriceVATIncluded) as? String
        self.volumeInML = aDecoder.decodeObject(forKey: Keys.VolumeInML) as? String
        self.pricePerLiter = aDecoder.decodeObject(forKey: Keys.PricePerLiter) as? String
        self.soldSince = aDecoder.decodeObject(forKey: Keys.SoldSince) as? String
        self.expired = aDecoder.decodeObject(forKey: Keys.Expired) as? String
        self.productGroup = aDecoder.decodeObject(forKey: Keys.ProductGroup) as? String
        self.typeDesc = aDecoder.decodeObject(forKey: Keys.TypeDesc) as? String
        self.style = aDecoder.decodeObject(forKey: Keys.Style) as? String
        self.packaging = aDecoder.decodeObject(forKey: Keys.Packaging) as? String
        self.seal = aDecoder.decodeObject(forKey: Keys.Seal) as? String
        self.origin = aDecoder.decodeObject(forKey: Keys.Origin) as? String
        self.originCountryName = aDecoder.decodeObject(forKey: Keys.OriginCountryName) as? String
        self.manufacturer = aDecoder.decodeObject(forKey: Keys.Manufacturer) as? String
        self.provider = aDecoder.decodeObject(forKey: Keys.Provider) as? String
        self.fromYear = aDecoder.decodeObject(forKey: Keys.FromYear) as? String
        self.sampledYear = aDecoder.decodeObject(forKey: Keys.SampledYear) as? String
        self.alchoholLevel = aDecoder.decodeObject(forKey: Keys.AlchoholLevel) as? String
        self.supply = aDecoder.decodeObject(forKey: Keys.Supply) as? String
        self.supplyText = aDecoder.decodeObject(forKey: Keys.SupplyText) as? String
        self.ecological = aDecoder.decodeObject(forKey: Keys.Ecological) as? String
        self.koscher = aDecoder.decodeObject(forKey: Keys.Koscher) as? String
        self.rawIngredientsDescription = aDecoder.decodeObject(forKey: Keys.RawIngredientsDescription) as? String
        self.lastUpdatedDate = aDecoder.decodeObject(forKey: Keys.LastUpdatedDate) as! Date
        self.isFavorite = aDecoder.decodeObject(forKey: Keys.IsFavorite) as! Bool
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.number, forKey: Keys.Number)
        aCoder.encode(self.articleID, forKey: Keys.ArticleID)
        aCoder.encode(self.productNumber, forKey: Keys.ProductNumber)
        aCoder.encode(self.name, forKey: Keys.Name)
        aCoder.encode(self.name2, forKey: Keys.Name2)
        aCoder.encode(self.priceVATIncluded, forKey: Keys.PriceVATIncluded)
        aCoder.encode(self.volumeInML, forKey: Keys.VolumeInML)
        aCoder.encode(self.pricePerLiter, forKey: Keys.PricePerLiter)
        aCoder.encode(self.soldSince, forKey: Keys.SoldSince)
        aCoder.encode(self.expired, forKey: Keys.Expired)
        aCoder.encode(self.productGroup, forKey: Keys.ProductGroup)
        aCoder.encode(self.typeDesc, forKey: Keys.TypeDesc)
        aCoder.encode(self.style, forKey: Keys.Style)
        aCoder.encode(self.packaging, forKey: Keys.Packaging)
        aCoder.encode(self.seal, forKey: Keys.Seal)
        aCoder.encode(self.origin, forKey: Keys.Origin)
        aCoder.encode(self.originCountryName, forKey: Keys.OriginCountryName)
        aCoder.encode(self.manufacturer, forKey: Keys.Manufacturer)
        aCoder.encode(self.provider, forKey: Keys.Provider)
        aCoder.encode(self.fromYear, forKey: Keys.FromYear)
        aCoder.encode(self.sampledYear, forKey: Keys.SampledYear)
        aCoder.encode(self.alchoholLevel, forKey: Keys.AlchoholLevel)
        aCoder.encode(self.supply, forKey: Keys.Supply)
        aCoder.encode(self.supplyText, forKey: Keys.SupplyText)
        aCoder.encode(self.ecological, forKey: Keys.Ecological)
        aCoder.encode(self.koscher, forKey: Keys.Koscher)
        aCoder.encode(self.rawIngredientsDescription, forKey: Keys.RawIngredientsDescription)
        aCoder.encode(self.lastUpdatedDate, forKey: Keys.LastUpdatedDate)
        aCoder.encode(self.isFavorite, forKey: Keys.IsFavorite)
    }
}
