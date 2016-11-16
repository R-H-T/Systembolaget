//
//  Product.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 16/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import Foundation

class Product: NSObject {
    
    // MARK: - Properties
    
    // We'll temprorarily asume everything property to be a string to avoid confusion.
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
    
    struct Keys {
        
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
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        // init
    }

    
    // Convenience initializer which takes a dictionary as its argument
    convenience init(with dictionary: [String : Any?]) {
        self.init()
        
        self.number = dictionary[Keys.Number] as? String
        self.articleID = dictionary[Keys.ArticleID] as? String
        self.productNumber = dictionary[Keys.ProductNumber] as? String
        self.name = dictionary[Keys.Name] as? String
        self.name2 = dictionary[Keys.Name2] as? String
        self.priceVATIncluded = dictionary[Keys.PriceVATIncluded] as? String
        self.volumeInML = dictionary[Keys.VolumeInML] as? String
        self.pricePerLiter = dictionary[Keys.PricePerLiter] as? String
        self.soldSince = dictionary[Keys.SoldSince] as? String
        self.expired = dictionary[Keys.Expired] as? String
        self.productGroup = dictionary[Keys.ProductGroup] as? String
        self.typeDesc = dictionary[Keys.TypeDesc] as? String
        self.style = dictionary[Keys.Style] as? String
        self.packaging = dictionary[Keys.Packaging] as? String
        self.seal = dictionary[Keys.Seal] as? String
        self.origin = dictionary[Keys.Origin] as? String
        self.originCountryName = dictionary[Keys.OriginCountryName] as? String
        self.manufacturer = dictionary[Keys.Manufacturer] as? String
        self.provider = dictionary[Keys.Provider] as? String
        self.fromYear = dictionary[Keys.FromYear] as? String
        self.sampledYear = dictionary[Keys.SampledYear] as? String
        self.alchoholLevel = dictionary[Keys.AlchoholLevel] as? String
        self.supply = dictionary[Keys.Supply] as? String
        self.supplyText = dictionary[Keys.SupplyText] as? String
        self.ecological = dictionary[Keys.Ecological] as? String
        self.koscher = dictionary[Keys.Koscher] as? String
        self.rawIngredientsDescription = dictionary[Keys.RawIngredientsDescription] as? String
        
        self.lastUpdatedDate = Date()
    }
}