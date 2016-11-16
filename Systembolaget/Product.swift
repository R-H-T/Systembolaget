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
        static let `Type` = "Typ"
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

}
