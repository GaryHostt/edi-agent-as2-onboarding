%dw 2.0

var endpointTypes =[
	{
		"endpointType": "as2",
		"endpointTypeId": "ab4c76b7-01b0-4bba-8f04-31c1487a3708"
	},
	{
		"endpointType": "http",
		"endpointTypeId": "aa1fd35b-50af-47fe-91bb-48a7ed4ab685"
	},
	{
		"endpointType": "sftp",
		"endpointTypeId": "3bcc65e5-040b-47eb-8fc7-27c89225f1bc"
	},
	{
		"endpointType": "ftp",
		"endpointTypeId": "6e0e5036-a9b7-47e9-bba8-0b1fad471a53"
	}
] 



var APMIdentifiers = [
	  {
	    "qualifierCode": "AS2 ID",
	    "qualifierLabel": "AS2 Identity",
	    "qualifierId": "25c1bc8a-801f-4947-a2a6-7721ef971460"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 01",
	    "qualifierLabel": "01 (Duns Number)",
	    "qualifierId": "dacbb21c-f452-434e-985f-c8c588ebf2f2"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 02",
	    "qualifierLabel": "02 (SCAC - Standard Carrier Alpha Code)",
	    "qualifierId": "888bbdfc-4693-4267-a0d4-22a059fde2e4"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 03",
	    "qualifierLabel": "03 (FMC - Federal Maritime Commission)",
	    "qualifierId": "4f583fac-07f0-439a-9596-4459b9b07f99"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 04",
	    "qualifierLabel": "04 (IATA - International Air Transport Association)",
	    "qualifierId": "34ec0e15-b57f-4f57-b70e-3b25e55ee200"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 07",
	    "qualifierLabel": "07 (GLN - Global Location Number)",
	    "qualifierId": "95858b12-5475-4d05-8fcb-b3111213ead3"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 08",
	    "qualifierLabel": "08 (UCC EDI Communications ID)",
	    "qualifierId": "789fb88c-c353-46f6-ba7e-2f9784e5e504"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 09",
	    "qualifierLabel": "09 (X.121)",
	    "qualifierId": "912a6767-ae6b-45b1-a552-689057d1ad29"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 10",
	    "qualifierLabel": "10 (DoD - Department of Defense Activity Address Code)",
	    "qualifierId": "05a7c47a-24f3-4f90-ac6e-7dde0e083690"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 11",
	    "qualifierLabel": "11 (DEA - Drug Enforcement Administration)",
	    "qualifierId": "2cab1b3a-3128-4e41-9e75-85d5bc9dd350"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 12",
	    "qualifierLabel": "12 (Phone Number)",
	    "qualifierId": "26432f80-b58b-4c96-aac6-58af5d5580fc"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 13",
	    "qualifierLabel": "13 (UCS Code)",
	    "qualifierId": "94cfbc8c-efbf-444a-a452-98fed4932dbd"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 14",
	    "qualifierLabel": "14 (Duns Number and Suffix Number)",
	    "qualifierId": "2e92b8d1-0510-4d59-ac3b-953d08127f78"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 15",
	    "qualifierLabel": "15 (Petroleum Accountants Society of Canada Company Code)",
	    "qualifierId": "2067c9c9-30d7-40f7-a902-a53094f46840"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 16",
	    "qualifierLabel": "16 (Duns Number With 4-Character Suffix)",
	    "qualifierId": "b606f1cc-c717-4389-9800-556993e3a943"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 17",
	    "qualifierLabel": "17 (ABA - American Bankers Association - Transit Routing Number Including Check Digit, 9 Digit)",
	    "qualifierId": "53bce625-88fd-4cc8-b8b3-67bc2cdc041e"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 18",
	    "qualifierLabel": "18 (AAR - Association of American Railroads - Standard Distribution Code)",
	    "qualifierId": "3eb1ed80-b665-4bd4-af1a-104c731dcc61"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 19",
	    "qualifierLabel": "19 (EDI Council of Australia Communications ID)",
	    "qualifierId": "ba360720-ac58-4823-a324-649c78d15223"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 20",
	    "qualifierLabel": "20 - (HIN - Health Industry Number)",
	    "qualifierId": "2d3cd43f-e6f8-4967-9083-7b0b4f2122e4"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 21",
	    "qualifierLabel": "21 (IPEDS - Integrated Postsecondary Education Data System)",
	    "qualifierId": "03e47906-ad60-4617-9354-5ad67bd67c8e"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 22",
	    "qualifierLabel": "22 (FICE - Federal Interagency Commission on Education)",
	    "qualifierId": "649f0257-e327-486e-bec5-52b7dc5cc3f8"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 23",
	    "qualifierLabel": "23 (NCES - National Center for Education Statistics Common Core of Data 12-Digit Number for Pre-K-Grade 12 Institutes)",
	    "qualifierId": "5df29d63-8a31-44b2-8776-d48cc48c60b9"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 24",
	    "qualifierLabel": "24 (ATP - The College Board's Admission Testing Program 4-Digit Code of Postsecondary Institutes)",
	    "qualifierId": "9c7609f5-ca49-49e6-ae47-a36e4778a117"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 25",
	    "qualifierLabel": "25 (ACT - Inc. 4-Digit Code of Postsecondary Institutions.)",
	    "qualifierId": "6f8a3ea3-26fe-4c16-b29f-14558b28ec2b"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 26",
	    "qualifierLabel": "26 (Statistics of Canada List of Postsecondary Institutions)",
	    "qualifierId": "b0eb4238-51a4-491b-a754-9697747d18ab"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 27",
	    "qualifierLabel": "27 (Carrier Identification Number)",
	    "qualifierId": "b241529a-0129-4efc-88ea-4561a17ff5fb"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 28",
	    "qualifierLabel": "28 (Fiscal Intermediary Identification Number)",
	    "qualifierId": "cc9c8949-a371-46d2-b397-c8582d47329b"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 29",
	    "qualifierLabel": "29 (Medicare Provider and Supplier Identification Number)",
	    "qualifierId": "743a7c05-7c15-41bb-9649-33ff4c066ee0"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 30",
	    "qualifierLabel": "30 (U.S. Federal Tax Identification Number)",
	    "qualifierId": "e6b315d7-6335-4e53-95de-996ddbfcc95c"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 31",
	    "qualifierLabel": "31 (Jurisdiction Identification Number Plus 4)",
	    "qualifierId": "26dee3cd-f0ce-46d5-b682-59794dd04093"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 32",
	    "qualifierLabel": "32 (FEIN - U.S. Federal Employer Identification Number)",
	    "qualifierId": "4e591ed6-97bb-4486-ba98-5f92d3da1b34"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 33",
	    "qualifierLabel": "33 (NAIC - National Association of Insurance Commissioners Company Code)",
	    "qualifierId": "604c5087-cfdf-42e6-832f-48fd3b17ae66"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 34",
	    "qualifierLabel": "34 (Medicaid Provider and Supplier Identification Number)",
	    "qualifierId": "41efeeab-67a4-4405-9f32-7b35626aa472"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 35",
	    "qualifierLabel": "35 (Statistics Canada Canadian College Student Information System Institution Codes)",
	    "qualifierId": "0c0f552f-ad85-468f-aeef-234116c82774"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 36",
	    "qualifierLabel": "36 (Statistics Canada University Student Information System Institution Codes)",
	    "qualifierId": "704193da-865e-47b0-93ea-71066dd39c2c"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 37",
	    "qualifierLabel": "37 (Society of Property Information Compilers and Analysts)",
	    "qualifierId": "c632daef-3f72-41c0-a9ac-08c872609ed8"
	  },
	  {
	    "qualifierCode": "X12 - ISA: 38",
	    "qualifierLabel": "38 (The College Board and ACT, Inc. 6-Digit Code List of Secondary Institutions)",
	    "qualifierId": "c1576faa-89c1-4bc8-9fae-fc03f729501a"
	  },
	  {
	    "qualifierCode": "X12 - ISA: AM",
	    "qualifierLabel": "AM (AMECOP - Association Mexicana del Codigo de Producto Communication ID)",
	    "qualifierId": "9eb7ea5a-ce91-4cc4-8f4f-e0c2d9efd5ce"
	  },
	  {
	    "qualifierCode": "X12 - ISA: NR",
	    "qualifierLabel": "NR (NRMA - National Retail Merchants Association)",
	    "qualifierId": "e5e79171-07cd-413b-a9db-37f276ab0dfa"
	  },
	  {
	    "qualifierCode": "X12 - ISA: SA",
	    "qualifierLabel": "SA (User Identification Number)",
	    "qualifierId": "21fa4ff4-08d7-468d-a7e9-206cd721f5cb"
	  },
	  {
	    "qualifierCode": "X12 - ISA: SN",
	    "qualifierLabel": "SN (Standard Address Number)",
	    "qualifierId": "447b44ac-977d-4dca-a49a-59bf56e65c8d"
	  },
	  {
	    "qualifierCode": "X12 - ISA: ZZ",
	    "qualifierLabel": "ZZ (Mutually Defined)",
	    "qualifierId": "fc397111-9590-4fea-a238-5853d575e04e"
	  },
	  {
	    "qualifierCode": "X12 - GS",
	    "qualifierLabel": "Group ID (GS)",
	    "qualifierId": "5982e3de-4878-44ec-b55d-a39d60064250"
	  },
	  {
	    "qualifierCode": "Reference ID",
	    "qualifierLabel": "Reference Value",
	    "qualifierId": "5217a9a0-9bc2-47cc-8803-a9c51713e9a3"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 1",
	    "qualifierLabel": "1 - DUNS (Data Universal Numbering System)",
	    "qualifierId": "70a3217e-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 103",
	    "qualifierLabel": "103 - TW, Trade-van",
	    "qualifierId": "70a23a16-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 12",
	    "qualifierLabel": "12 - Telephone number",
	    "qualifierId": "70a2e006-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 128",
	    "qualifierLabel": "128 - CH, BCNR (Swiss Clearing Bank Number)",
	    "qualifierId": "70a2394e-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 129",
	    "qualifierLabel": "129 - CH, BPI (Swiss Business Partner Identification)",
	    "qualifierId": "70a23886-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 14",
	    "qualifierLabel": "14 - EAN International",
	    "qualifierId": "70a2df2a-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 144",
	    "qualifierLabel": "144 - US, DoDAAC (Department of Defense Activity Address Code)",
	    "qualifierId": "70a23610-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 145",
	    "qualifierLabel": "145 - FR, DGCP (Direction Generale de la Comptabilite Publique)",
	    "qualifierId": "70a23548-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 146",
	    "qualifierLabel": "146 - FR, DGI (Direction Generale des Impots)",
	    "qualifierId": "70a23476-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 147",
	    "qualifierLabel": "147 - JP, JIPDEC/ECPC (Japan Information Processing Development Corporation / Electronic Commerce Promotion Center)",
	    "qualifierId": "70a2337c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 148",
	    "qualifierLabel": "148 - ITU (International Telecommunications Union) Data Network Identification Code (DNIC)",
	    "qualifierId": "70a23200-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 18",
	    "qualifierLabel": "18 - AIAG (Automotive Industry Action Group)",
	    "qualifierId": "70a2de3a-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 22",
	    "qualifierLabel": "22 - INSEE (Institut National de la Statistique et des Etudes Economiques - SIREN)",
	    "qualifierId": "70a2dcc8-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 30",
	    "qualifierLabel": "30 - ISO 6523: Organization identification",
	    "qualifierId": "70a2d3c2-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 31",
	    "qualifierLabel": "31 - DIN (Deutsches Institut fuer Normung)",
	    "qualifierId": "70a2d250-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 33",
	    "qualifierLabel": "33 - BfA (Bundesversicherungsanstalt fuer Angestellte)",
	    "qualifierId": "70a2b982-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 34",
	    "qualifierLabel": "34 - National Statistical Agency",
	    "qualifierId": "70a2b8c4-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 4",
	    "qualifierLabel": "4 - IATA (International Air Transport Association)",
	    "qualifierId": "70a32066-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 5",
	    "qualifierLabel": "5 - INSEE (Institut National de la Statistique et des Etudes Economiques - SIRET)",
	    "qualifierId": "70a2e97a-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 51",
	    "qualifierLabel": "51 - GEIS (General Electric Information Services)",
	    "qualifierId": "70a2b7f2-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 52",
	    "qualifierLabel": "52 - INS (IBM Network Services)",
	    "qualifierId": "70a2b734-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 53",
	    "qualifierLabel": "53 - Datenzentrale des Einzelhandels",
	    "qualifierId": "70a2b66c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 54",
	    "qualifierLabel": "54 - Bundesverband der Deutschen Baustoffhaendler",
	    "qualifierId": "70a2b5ae-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 55",
	    "qualifierLabel": "55 - Bank identifier code",
	    "qualifierId": "70a2b4e6-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 57",
	    "qualifierLabel": "57 - KTNet (Korea Trade Network Services)",
	    "qualifierId": "70a2b1f8-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 58",
	    "qualifierLabel": "58 - UPU (Universal Postal Union)",
	    "qualifierId": "70a2b11c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 59",
	    "qualifierLabel": "59 - ODETTE (Organization for Data Exchange through Tele-Transmission in Europe)",
	    "qualifierId": "70a2b054-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 61",
	    "qualifierLabel": "61 - SCAC (Standard Carrier Alpha Code)",
	    "qualifierId": "70a2af78-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 63",
	    "qualifierLabel": "63 - ECA (Electronic Commerce Australia)",
	    "qualifierId": "70a2aeb0-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 65",
	    "qualifierLabel": "65 - TELEBOX 400 (Deutsche Telekom)",
	    "qualifierId": "70a2add4-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 8",
	    "qualifierLabel": "8 - UCC Communications ID (Uniform Code Council Communications Identifier)",
	    "qualifierId": "70a2e66e-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 80",
	    "qualifierLabel": "80 - NHS (National Health Service)",
	    "qualifierId": "70a2ad02-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 81",
	    "qualifierLabel": "81 - Statens Teleforvaltning",
	    "qualifierId": "70a2a99c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 84",
	    "qualifierLabel": "84 - Athens Chamber of Commerce",
	    "qualifierId": "70a2a8b6-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 85",
	    "qualifierLabel": "85 - Swiss Chamber of Commerce",
	    "qualifierId": "70a2a7e4-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 86",
	    "qualifierLabel": "86 - US Council for International Business",
	    "qualifierId": "70a2a71c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 87",
	    "qualifierLabel": "87 - National Federation of Chambers of Commerce and Industry",
	    "qualifierId": "70a2a636-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 89",
	    "qualifierLabel": "89 - Association of British Chambers of Commerce",
	    "qualifierId": "70a2a53c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 9",
	    "qualifierLabel": "9 - DUNS (Data Universal Numbering System) with 4 digit suffix",
	    "qualifierId": "70a2e2a4-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 90",
	    "qualifierLabel": "90 - SITA (Societe Internationale de Telecommunications Aeronautiques)",
	    "qualifierId": "70a2a30c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 91",
	    "qualifierLabel": "91 - Assigned by seller or seller's agent",
	    "qualifierId": "70a23b9c-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: 92",
	    "qualifierLabel": "92 - Assigned by buyer or buyer's agent",
	    "qualifierId": "70a23ade-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: EDIFACT-UNB",
	    "qualifierLabel": "NONE - Not Used",
	    "qualifierId": "5e8e05f5-0bab-422d-afff-7a8a03982461"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: Z01",
	    "qualifierLabel": "Z01 - Vehicle registration number",
	    "qualifierId": "70a22864-9240-11eb-a8b3-0242ac130003"
	  },
	  {
	    "qualifierCode": "EDIFACT - UNB: ZZZ",
	    "qualifierLabel": "ZZZ - Mutually defined",
	    "qualifierId": "70a225b2-9240-11eb-a8b3-0242ac130003"
	  }
]