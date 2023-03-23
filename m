Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CF7C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 09:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8D810E64D;
	Thu, 23 Mar 2023 09:34:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAB510E64D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 09:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMa5a7PU5PxoPSLJjREW84guEj9cs8aiMxauIF4WqE2xZAeVbp79ZSKmr/7Nlw29CjYG4DFM14lvnHwrEDvz1cNxBqvt2U8H8osD2aeSa3Qe2GrzaY4cj9ub0Yjbkhbv1Vs/0MAT2Kt2rqAZJuKaNv+Rk+icR37rJzVnlGcBj+B5WQu8/BBsHq6F4qtg9Q2KoPQrdabyT5ciNohZTX3ggBNOT14uAdW5FJ0CuOu3XhjeOmb4ypjzXDa1s4lyJBO/iHK9DVIlrOYXQd9NedASksWKgaYOZwl1zVZDpLKuIYMkAgBPKPmb3GLc/I/Y2ZRLCMtQ6sD/BJvVvgRGFKqGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je30oDevIYNFNsRsjP+CsJQm+XsqhFvadmesrnpArrk=;
 b=Jnw6XEFgSptFoI4ETV/x5M5ij1Gj9L9xnDSKx4pR7CbD/2GqEQj/xTxSVqa5EzUmZUOsDqd9hb1ZB4ZJIFJoIadkt92s24re5vTU8LyXo5+x/5E8kUr/jBk3kjjcgqeiCuWWV5wyKXv8RRooB+sjAWsWB50efdHLOnr4DE+xjiwKozRlg1HFq2YqJ8nkRy+wzKZ74Z8tcDvub3gZrR0jDD2waTxvryUoGxhpDi5S9rm8aoJgyZkEy9efz9aR1UjoOUNI9kZPJ2YANuFjjkZMx8j5WbgeYkwPZuRNMXmgswGRqSLlxWHSjkjJc+458ECymmIFU8J6os2Ft80sejItXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je30oDevIYNFNsRsjP+CsJQm+XsqhFvadmesrnpArrk=;
 b=n5HJ9eS8NAPBf47dO0RQvXNJH3i0s2NbC6Bokohyjdo5jR43IhD8UtIDMboYH9QhZRzN/4exoPMT0e0WvoGU9tEm+vMfN870aIKWDdRKmfJbHaNGjN/rJF2m/n4mewuLsITbPIwzyHvnmxdk8mWvncVfgCUrI4vvSMJZhMIVR3M=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:34:48 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 09:34:48 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Topic: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Index: AQHZXJ7/8i8fNRCjlEmsgmjrhqS5nq8ICdCAgAAQTaA=
Date: Thu, 23 Mar 2023 09:34:47 +0000
Message-ID: <DM6PR12MB35319D3D541B075510AFFDE1FD879@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-3-WenYou.Yang@amd.com>
 <94cea821-dc35-4324-6b65-6ed82a55b442@amd.com>
In-Reply-To: <94cea821-dc35-4324-6b65-6ed82a55b442@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T09:34:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33e7f1d0-c8b1-4e1e-b9fd-49c9ca002d87;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|CH2PR12MB4039:EE_
x-ms-office365-filtering-correlation-id: ae264d8a-87d9-422e-5b47-08db2b81d829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0YkgjY7STE18QEFQPNTZyjU93jkdM4pmJz2MUEbVb66oZiWjJlCHWcTHblNU9C6XRW5JJtW/f1skGPVNRO58EnCv4VzOHN1rZjLFSKlAs7ZV/N9G5pDnKrst/GQG4e9uhwYAQoJYMoiZMtfybcYFlKDaCEsDn19r463RpuUAFXLF3sSXfR+IvKJbIqUMI+rEhmR2yFebp+DLelygefckXSpwlU9YOh5qLT5/iuTf/Y5204g3o/1aLZ+Oh0Yv+xFJW9W0OWzrtfYSx+hZe89GWP50oweGOjokp0B3PjIg5XztcvesEgP7OnQAQygLVUWgy9qQeWw0LuFjG3z/KEce6jCPCFdatlDcmZX/HO7wBaHnjJr2z5+aSec/9GlQzsOTkFLAwzJtPWPt0mAenc1FcWahm/DZBnGM2MlQcdJZMF/zXURqPrvADyt8u11k4LNfCvG0toqSXrkNOgQ2PsyF42FOPPdGuO95iqVX6c2cfkVQfQ76QcDlQW8oIpDi/dh5E6rA6jWL3FJoaKQgMYlK4pGTQeUDPsjM1gNpltX8jrun8BMIjZbIuNnxffia7vbhes2/m+pupck9EBt7mTb4mBiuj22kLJhDldrQGdUaWGNSlPS0S/3MnIIh2cEhbhuHoqDoInYyecO+1L3QP3Pn9GIRq2CEaxm05KM4SN2403IUVDA0gprstaJsx1YQQ4dKQaOhAubprhRkpOxYGcz7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(7696005)(41300700001)(66476007)(66446008)(5660300002)(52536014)(66556008)(2906002)(15650500001)(64756008)(8676002)(86362001)(38070700005)(33656002)(122000001)(38100700002)(4326008)(76116006)(71200400001)(26005)(478600001)(110136005)(316002)(6636002)(8936002)(55016003)(66946007)(83380400001)(6506007)(54906003)(9686003)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Q1bEs4ellyWDBrclZFZW43U1cvTFduakVybzFBY01YSUl1dHZwQlBiazgz?=
 =?utf-8?B?bmoyYUhST0JzSXpiVXJwclZlUU9uQVhFYzZzK2JDYUlHYjJ0ak9tS1E3bGlk?=
 =?utf-8?B?Q1ZRUEMzOVVkT1cyTm5BK3JRTG8zQzkwMjZQSy9oaFBxaFE4UDFBRnA1WHNV?=
 =?utf-8?B?WGhyTnZ2T21rcW52K0NnVFFNdVhDWEI2RWx6SXhIN2J4SnpnaE5YR0dCNTFV?=
 =?utf-8?B?Mjg2cE9RS3c4QTczZjdUdVJHM2tRQjlKazBJbThYQko3OHdPRlJHeU8zZkpZ?=
 =?utf-8?B?YTd2cjZNSDJENlBFdHNobXY2ZHIwKy9WZDVvczNGWm01b09sRzRid1JSa0lE?=
 =?utf-8?B?cm5LN3lkakpaL01tOEZVejBjbEFmMk5VRTM4R1dPc3p0cWxBcXhkOXBFalM5?=
 =?utf-8?B?ZGN6SDJuTW1tejZpSG5ST09zSDExalg1UE1KMm5CUC9IQnBjWEJreGRFOTdY?=
 =?utf-8?B?dythYnVXNHFtMEFSSFRQd05MaHZLb0J4VURlTU5ORDZsV295QzVxeEhGaFE5?=
 =?utf-8?B?RTJVMk9GdXRZZnRXUktJWTBzOWZ3NlluN2xOemxBQU1ZeEtNZkh5d3lBek92?=
 =?utf-8?B?YWFrcU53OEVITHcyd3JNVklKdWxyZS9KbU1QcFJGKzhqK3lsczhXUFNvSy84?=
 =?utf-8?B?Mm1LZ1QyUWh2bEpPeWJKczdTMFhxRlpUTmM1a3V6eDFSaE5SR3JLUDJ1eXE0?=
 =?utf-8?B?dUcrclJtMjNKaG5icFhmbGtxY2daODJsNmRham1HUkNCMUdkN1k5cDU3eDNW?=
 =?utf-8?B?b0VlTkl5b2U0ZFhhK3M4dCtaVnN1S2s1TThTNWpzSGcxK1ZRS3IzQWxrQUxu?=
 =?utf-8?B?Z1hyN0h1Q3VvTC95OU5iNzhFWmFUZSsxSGZqUTRHcWdtWHZkcXpucGN2MUdS?=
 =?utf-8?B?NWhEZVdxOWp3MG9jcFg0YXRMZFRsci9DYXVtUVJpMEY4YlcrS0NaSmg5amlj?=
 =?utf-8?B?MVppQWJaaklnMzNCZ0lEVjROK3lCNlRXTnpBN1JXYzJMOW5WMGFKRUt3UUdG?=
 =?utf-8?B?NTdUc2IvTmo3NEtuT1RZZmRxZCsxc25PYks0NW1tbzRkUVI3Q2xYL2oxa0NY?=
 =?utf-8?B?bmdvYjB3NDV6dFl5ZFZjNWZkcVk2NUQ1M0NmU0NvWkZnQ3dyV0RtK28rSk9a?=
 =?utf-8?B?YlZkZlBQcEp6Q0doNHpHZjYvaS9LQXJ1OEttRjRhV3JNcnhwMC9OMFVlcG5P?=
 =?utf-8?B?WHBYR3RwOHBTMGdGWVVJS1U0QnAwUGo2V09qd2FhUmVQd0hKMlZFVWpKbmhG?=
 =?utf-8?B?L0VORmxXWFJjVndQMHI5aHBvOTl5Y1lYdW9QdXhkdFNNSy9RRXBlUWFBdTNx?=
 =?utf-8?B?TmdLazhCV1cvUDFuWDkxT05QVWF0M0dRU2JLUXZka1I0QmMvQi9obUJ4eVRD?=
 =?utf-8?B?NitmVFhWOGNUQjdyWm1YTVFPcTB6aEg3cjl5K0d0M245RytWZU1JQS9IZlBS?=
 =?utf-8?B?dkkwVVlQUUNxUDQ1SEdMZmcrUGE5MmZ0TlNFYU5hN2ltQnVWdElYbmJrRDJT?=
 =?utf-8?B?NUU5dEFQNDIrVEdrbzlHTUtTSWFUcHhOS2N0QmxHNFh6YXQrd0ttV29xRkY1?=
 =?utf-8?B?Ukdia1V3UERQV3ovMiswbm9uY2tpVjRMQS8xclBzeE82bmFPOHJQSUg3ZHNP?=
 =?utf-8?B?STZmaVp6T1ludkxzSldDVkgzaHV4OHlPWGFaVlpNUk5CeWk5UXc3eGNuNDJa?=
 =?utf-8?B?ZTE4aW1NVW10VVhWcDl2VkVqZW85cCsxMFMyWlhNNUpVdjhraUZhSHRBVFJ1?=
 =?utf-8?B?ZXk4cCtheFA4a2E4WExkS1hKOW9Ic3BDYllWSkltUFVRRzBmN3Fkc3BNT212?=
 =?utf-8?B?YkVXS0ZaUEVJN1NvTVBSNmdOTHZsaFcrTkovVEJQNkRhblBWYkNET1pOaHNv?=
 =?utf-8?B?YXhJUlYwZmw5b05scnB2a281MVdQWGp0M2lLTlVhS2U4WThFeXcySTlvTjhk?=
 =?utf-8?B?Nm5ldjk4TER2UGVOTHhOZjNXQjZEMkJrcVBmTFlyVHdNejdidGQvNFZQWUJr?=
 =?utf-8?B?MXdxcW9DcisvNXZmQTBuWEJFSGxIWmlid3pnZnNWd1B0V1FRZ3J5bHVxTGxk?=
 =?utf-8?B?Nk5DcitJdEdRdHVxRzQ2T3hQSFYzd2V6NjUwamg1Mk1tUGNjRHYwd2VQQVAx?=
 =?utf-8?Q?2U0q9MhPjf8JYAadHMm4saKY7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae264d8a-87d9-422e-5b47-08db2b81d829
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 09:34:47.9796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xh+tqln0H35pnD6fFffx6wtjcUFGLkdy30k2DGWVtyB8BfDSk9Zd0XE21wdsDu5Y1XnmZBDHqqFR4gG0JgEKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyA0OjI5IFBNDQo+IFRvOiBZYW5nLCBXZW5Z
b3UgPFdlbllvdS5ZYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4gQ2M6IFl1YW4s
IFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyBMaSwgWWluZyA8WUlORy5MSUBhbWQuY29tPjsg
YW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIEt1biA8S3VuLkxpdTJAYW1k
LmNvbT47IExpYW5nLCBSaWNoYXJkIHFpDQo+IDxSaWNoYXJkcWkuTGlhbmdAYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtSZXNlbmQgUEFUQ0ggdjEgMi8zXSBkcm0vYW1kL3BtOiBzZW5kIHRoZSBT
TVQtZW5hYmxlDQo+IG1lc3NhZ2UgdG8gcG1mdw0KPiANCj4gDQo+IA0KPiBPbiAzLzIyLzIwMjMg
Mjo0NiBQTSwgV2VueW91IFlhbmcgd3JvdGU6DQo+ID4gV2hlbiB0aGUgQ1BVIFNNVCBzdGF0dXMg
Y2hhbmdlIGluIHRoZSBmbHksIHNlbnQgdGhlIFNNVC1lbmFibGUgbWVzc2FnZQ0KPiA+IHRvIHBt
ZncgdG8gbm90aWZ5IGl0IHRoYXQgdGhlIFNNVCBzdGF0dXMgY2hhbmdlZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFdlbnlvdSBZYW5nIDxXZW5Zb3UuWWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgICAgIHwgNDEN
Cj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9pbmMvYW1kZ3B1X3NtdS5oIHwgIDUgKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDQ2IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2FtZGdwdV9zbXUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9h
bWRncHVfc211LmMNCj4gPiBpbmRleCBiNWQ2NDc0OTk5MGUuLjVjZDg1YTlkMTQ5ZCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+ID4gQEAg
LTIyLDYgKzIyLDcgQEANCj4gPg0KPiA+ICAgI2RlZmluZSBTV1NNVV9DT0RFX0xBWUVSX0wxDQo+
ID4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Zp
cm13YXJlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4NCj4gPiBAQCAtNjks
NiArNzAsMTQgQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9zcGVlZF9ycG0odm9pZCAqaGFuZGxl
LA0KPiB1aW50MzJfdCBzcGVlZCk7DQo+ID4gICBzdGF0aWMgaW50IHNtdV9zZXRfZ2Z4X2NncGco
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlZCk7DQo+ID4gICBzdGF0aWMgaW50
IHNtdV9zZXRfbXAxX3N0YXRlKHZvaWQgKmhhbmRsZSwgZW51bSBwcF9tcDFfc3RhdGUNCj4gPiBt
cDFfc3RhdGUpOw0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc210X25vdGlmaWVyX2NhbGxiYWNrKHN0
cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVuc2lnbmVkDQo+ID4gK2xvbmcgYWN0aW9uLCB2b2lk
ICpkYXRhKTsNCj4gPiArDQo+ID4gK2V4dGVybiBzdHJ1Y3QgcmF3X25vdGlmaWVyX2hlYWQgc210
X25vdGlmaWVyX2hlYWQ7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2Nr
IHNtdF9ub3RpZmllciA9IHsNCj4gPiArCS5ub3RpZmllcl9jYWxsID0gc210X25vdGlmaWVyX2Nh
bGxiYWNrLCB9Ow0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgc211X3N5c19nZXRfcHBfZmVhdHVy
ZV9tYXNrKHZvaWQgKmhhbmRsZSwNCj4gPiAgIAkJCQkgICAgICAgY2hhciAqYnVmKQ0KPiA+ICAg
ew0KPiA+IEBAIC02MjUsNiArNjM0LDggQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc211X2NvbnRleHQgKmN1cnJlbnRfc211Ow0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBpbnQgc211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+ICAgew0KPiA+
ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICop
aGFuZGxlOw0KPiBAQA0KPiA+IC02NDUsNiArNjU2LDcgQEAgc3RhdGljIGludCBzbXVfZWFybHlf
aW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAJbXV0ZXhfaW5pdCgmc211LT5tZXNzYWdlX2xvY2sp
Ow0KPiA+DQo+ID4gICAJYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSA9IHNtdTsNCj4gPiArCWN1
cnJlbnRfc211ID0gc211Ow0KPiA+ICAgCWFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyA9ICZzd3Nt
dV9wbV9mdW5jczsNCj4gPg0KPiA+ICAgCXIgPSBzbXVfc2V0X2Z1bmNzKGFkZXYpOw0KPiA+IEBA
IC0xMTA1LDYgKzExMTcsOCBAQCBzdGF0aWMgaW50IHNtdV9zd19pbml0KHZvaWQgKmhhbmRsZSkN
Cj4gPiAgIAlpZiAoIXNtdS0+cHB0X2Z1bmNzLT5nZXRfZmFuX2NvbnRyb2xfbW9kZSkNCj4gPiAg
IAkJc211LT5hZGV2LT5wbS5ub19mYW4gPSB0cnVlOw0KPiA+DQo+ID4gKwlyYXdfbm90aWZpZXJf
Y2hhaW5fcmVnaXN0ZXIoJnNtdF9ub3RpZmllcl9oZWFkLCAmc210X25vdGlmaWVyKTsNCj4gPiAr
DQo+IA0KPiBJdCBpcyBub3QgcmVxdWlyZWQgZm9yIGV2ZXJ5IGRHUFUgc211IHRvIHJlZ2lzdGVy
IGZvciBhbmQgcHJvY2VzcyB0aGlzDQo+IG5vdGlmaWNhdGlvbiByZWdhcmRsZXNzIG9mIHRoZSBz
eXN0ZW0gdGhleSBhcmUgaW4uIEl0IGlzIG9ubHkgYXBwbGljYWJsZSBmb3INCj4gdmFuZ29naCBh
bmQgaGVuY2UgdGhpcyBhbmQgYmVsb3cgc2hvdWxkIGJlIG1vdmVkIHRvIHNvbWUgcHB0IGZ1bmNz
IHVzZWQNCj4gaW4gc3dfaW5pdC9zd19maW5pIG9mIGFtZGdwdV9zbXUgZm9yIHZhbmdvZ2ggYWxv
bmUuDQoNClRoZSBmaXhlZCBpc3N1ZSBpcyBjb21tb24sIGl0IGlzIHBvc3NpYmxlIHRvIGtlZXAg
dGhpcyBpbnRlcmZhY2UgZm9yIG90aGVycy4gU28gSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gcHV0
IHRoZSBjb21tb24gY29kZSBoZXJlLg0KDQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+ID4g
ICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMTEyMiw2ICsxMTM2LDggQEAgc3Rh
dGljIGludCBzbXVfc3dfZmluaSh2b2lkICpoYW5kbGUpDQo+ID4NCj4gPiAgIAlzbXVfZmluaV9t
aWNyb2NvZGUoc211KTsNCj4gPg0KPiA+ICsJcmF3X25vdGlmaWVyX2NoYWluX3VucmVnaXN0ZXIo
JnNtdF9ub3RpZmllcl9oZWFkLCAmc210X25vdGlmaWVyKTsNCj4gPiArDQo+ID4gICAJcmV0dXJu
IDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMzI0MSwzICszMjU3LDI4IEBAIGludCBzbXVfc2Vu
ZF9oYm1fYmFkX2NoYW5uZWxfZmxhZyhzdHJ1Y3QNCj4gPiBzbXVfY29udGV4dCAqc211LCB1aW50
MzJfdCBzaXplKQ0KPiA+DQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gPiArDQo+ID4g
K3N0YXRpYyBpbnQgc211X3NldF9jcHVfc210X2VuYWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwgYm9vbA0KPiA+ICtlbmFibGUpIHsNCj4gPiArCWludCByZXQgPSAtRUlOVkFMOw0KPiA+ICsN
Cj4gPiArCWlmIChzbXUtPnBwdF9mdW5jcyAmJiBzbXUtPnBwdF9mdW5jcy0+c2V0X2NwdV9zbXRf
ZW5hYmxlKQ0KPiA+ICsJCXJldCA9IHNtdS0+cHB0X2Z1bmNzLT5zZXRfY3B1X3NtdF9lbmFibGUo
c211LCBlbmFibGUpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgc210X25vdGlmaWVyX2NhbGxiYWNrKHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIsDQo+ID4gKwkJCQkgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRhdGEpIHsNCj4g
PiArCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gY3VycmVudF9zbXU7DQo+ID4gKwlpbnQgcmV0
ID0gTk9USUZZX09LOw0KPiA+ICsNCj4gPiArCXJldCA9IChhY3Rpb24gPT0gU01UX0VOQUJMRUQp
ID8NCj4gPiArCQkJCXNtdV9zZXRfY3B1X3NtdF9lbmFibGUoc211LCB0cnVlKSA6DQo+ID4gKwkJ
CQlzbXVfc2V0X2NwdV9zbXRfZW5hYmxlKHNtdSwgZmFsc2UpOw0KPiA+ICsJaWYgKHJldCkNCj4g
PiArCQlyZXQgPSBOT1RJRllfQkFEOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1
X3NtdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211
LmgNCj4gPiBpbmRleCAwOTQ2OWM3NTBhOTYuLjdjNjU5NGJiYTc5NiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gPiBAQCAt
MTM1NCw2ICsxMzU0LDExIEBAIHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHsNCj4gPiAgIAkgKiBAaW5p
dF9wcHRhYmxlX21pY3JvY29kZTogUHJlcGFyZSB0aGUgcHB0YWJsZSBtaWNyb2NvZGUgdG8NCj4g
dXBsb2FkIHZpYSBQU1ANCj4gPiAgIAkgKi8NCj4gPiAgIAlpbnQgKCppbml0X3BwdGFibGVfbWlj
cm9jb2RlKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7DQo+ID4gKw0KPiA+ICsJLyoqDQo+ID4g
KwkgKiBAc2V0X2NwdV9zbXRfZW5hYmxlOiBTZXQgdGhlIENQVSBTTVQgc3RhdHVzDQo+ID4gKwkg
Ki8NCj4gPiArCWludCAoKnNldF9jcHVfc210X2VuYWJsZSkoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsIGJvb2wgZW5hYmxlKTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHR5cGVkZWYgZW51bSB7DQo=
