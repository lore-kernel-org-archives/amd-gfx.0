Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE9BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 14:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CEB210E6CD;
	Tue,  4 Apr 2023 14:45:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FBC10E6CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 14:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvtbdtgyVKwPIcAKZ8NiKNP/34bJe4fxetsRt3YL7TwuQ0SB7jaZJAPskkCbqozrDFYrlb0HqZr2wH6xLHGVhj0rTM/0Vasq3OpBf/YXXCDxJdtlWywR+7rHH/+NuYG4z3JEz2oXzOGkS/lwEynE14BgCXNFeXd2mggytsRzWsxVpA3PuU4pFv+sqjdqN33nHt4bUe+kAdMG9jJC3FH622d9tjxHfus0z5gDLKqhlGAcg/M5lj8fapUoUdekCAjs3zgRIFbHbgQHyb2tRrGMP/IFskYG1x64TT9UtSkTymNMKNtyIebhPpbP9vU1PhC6qAzJc82DKJa3luYb+xxBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjmLeO/ylOYeS5gJV/1KDicthZHHjPCk0qD1CLDTb0o=;
 b=fpHbDGGwwTdeA936gp6jr9GQ8j3nFPeYMVvhDrUZ5p/ZggUA6YiA6QHHY6BU7r8lzwYZg0ESZAFJ6n2vuNJJ7UAWEjnRqYoxo6C3ZKHC3sOU1/8xQ39MFWpeLN/j+rtBYM9zuIX9t16U1VqAukyZyQvU3CLgampfABKsGEYI+NPQiw0euZZqM7yhAJcnT3Vcurwl3+OpJchqo3Dr8DNrnZXfSIt9/0fZ2iey9P1uf1sDeDS2bVjDPa/gmDyYriXfMo1h5gVdzlkQA3J5WhojTkPo1RsT2deOBezCgfREQZpp8hJq92JJMMLxvemMvJPBZewNFt+PeZBMc2ceLSMi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjmLeO/ylOYeS5gJV/1KDicthZHHjPCk0qD1CLDTb0o=;
 b=z1O+wXRyGfcDf5gk8wc1GXk9F+1yaOG0JLGuvl4KiJ56QQpkBVDAnk0OT8gDvE9Zvc8wh2YgU3nd4FqaSbobeVnD7MjJM7/vbwMWsZ5GHVYJug2jN7RiKR15qT/KYvaQ2qEARqNddcY88s4C/G1FjrtQLM4MYk2j6rNp7QU7tsE=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:45:18 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:45:18 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original
 BO flags
Thread-Topic: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original
 BO flags
Thread-Index: AQHZZtvcAvnMzEXjhk+uiCy80ibXWa8bK44AgAAOQkA=
Date: Tue, 4 Apr 2023 14:45:17 +0000
Message-ID: <DM4PR12MB5261EB263BE3E7A956B707D89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <20230404095640.3277840-2-shane.xiao@amd.com>
 <ead2bf27-f496-47b0-53fc-7796582d0ab5@amd.com>
In-Reply-To: <ead2bf27-f496-47b0-53fc-7796582d0ab5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T14:45:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3d45d154-9351-4acd-89a5-be9620a304b3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-04T14:45:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5d3d529d-36c3-45ac-bec4-b339afb2d589
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|PH8PR12MB7184:EE_
x-ms-office365-filtering-correlation-id: 500a019b-25b9-4e13-003d-08db351b3566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D5E24Z5B7xc4vTNCLxKw7RSBAbR2cYsTHOw4DzY7lG1ts4xzIWGq4uW6Y1/5KAnboyo6kAAFTTPSD0v/DVKer/abw8jus9PPB6Dk80lCXmNjgMW9iKDAOvm9YuSav2zY/u3qEQDa6UNVQdIjUF54KhsWm+bx8WNi2URGheF7T/dHxQTetfkOJ9Ytqt65LNz/8sov6bRv5FVGCUT1ZGdsR7ORXcTuGTiotcxMMCukHyQ98YOzEznZPXWpAaILdQDgBsvtWKkSM5DMyvw7rC2llqAeGpynSq/eQTDLVu3wFvVTxqiWEP8xq7hUPMzvvG2JmjPEuIsqx/i13oWGiSleqnITB49jirBGGSiEiK2nLAdiPEfgRu5Uc74CLt5GcZdvcGz3iDNtmf6IsV0EaMeNBITCjUFH2Y7VV4p66uB/CKfMg7IwLYc2GieKN5gNeI2HqjIM5D7Piv31jfx6alF1EUoiwwf8HQ1cnOLsk32egrqk7QoVj4R03819XKTDMUhSezQ7zcqCdcCEwsVf8qAfbT51QNqGSUaGvbW5s2u6ugKqRYXe985fjIKZNhfJbkN9BK4ERGfo8jngqjgGUvpTv1AuR9UOGcw5hTFM0Rlu6iHiUBhvW5W1zaMVxnED/+J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(83380400001)(86362001)(186003)(6506007)(9686003)(26005)(66446008)(8676002)(4326008)(66476007)(66556008)(66946007)(76116006)(122000001)(38100700002)(52536014)(64756008)(2906002)(38070700005)(55016003)(41300700001)(478600001)(53546011)(316002)(6636002)(110136005)(54906003)(7696005)(33656002)(71200400001)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWVxdHlSRG9UOTZwcDdSb2xyQ1ZBNFY0Y0pBOERIenBtRlEvNmptVENCQTA4?=
 =?utf-8?B?SEllbEZDNjRLaE1keUdudFhqT1o3TkZxSmdTUldSYlU5N29QYUh3dFBySXBO?=
 =?utf-8?B?azFocTR2SWw2MStmb3ByRUszSjdZUW1lWEFGL25sZ05BOUtFMlBPMUlGRnh6?=
 =?utf-8?B?WVNtRWw2Wjl4SnJNZjFBeVRkeitWVTlXeHduRHBsekUrcnFLbGNuOURQdXV3?=
 =?utf-8?B?SkxpWkh6MndOb1dHUUpCWjdxdUI5ejlrWVJ2a1krOUhRTFk5dHZKalNOVUIx?=
 =?utf-8?B?STROU3RFTmd6eHc1TVlFTkY0UWtPQlErNGh0dUszV3RTTkpBMTE4TElVdllN?=
 =?utf-8?B?c1g4dlhlV0dpL2ZlMWpjNVVSU09kZ09mS01DNVdxMjFuOVlqelRlRm1DREJy?=
 =?utf-8?B?R1A2Ni8yRjRLcFFkWG1UcmV5Y2QzbmV0TjdCRnlXaEw5aXFpeTdrdkhOZE9Q?=
 =?utf-8?B?TUdyeXdxTkhYK04zVGFJUkpWUWkyR0Q3YzBFdTNQQ3RPQzlUazUvY0UwYVI3?=
 =?utf-8?B?UmxzVDBJTi8xMDJCVW0zbllwVXR3VDVCRlBmODllalZHNllmOVVtRzFOUSty?=
 =?utf-8?B?SVluTDRzMEdyenErWHFKNlcySk41L1JiS2NUTTlROXNjRVlyQjN2OXhRU1R1?=
 =?utf-8?B?YnM0RFArRGhjWXVQS0dUS2NEa1BTV2dGb1RxVHJrMzh2UkxyTWZKY1FOVVVQ?=
 =?utf-8?B?eHNaVTdaZlNyaVUvMzdOZWw2YXp0WkQzWkRzNHF6ZUhISUduL0R5ZGNiVER1?=
 =?utf-8?B?a1FNdkt0R0U4QS9USENldjhmTnVLbHd0U3Jxa1FlRkpscnZuMENsRC9wZnNV?=
 =?utf-8?B?dDU4L016WW9WMU1Qc05aVGxEWStyMnpYdzY2WnlWV0hVamRJTXZuNnlvL0Nl?=
 =?utf-8?B?QXFnejc3N2V4SEtlT0VqdXgyWjdQQnd3cXZJT3NhaWNOWnYxMDlPbUprWHpW?=
 =?utf-8?B?aFhJZWxaVzlUR3oyZk9ZaFgxRjhpSmd2eWxwZi9oMXBFWVRIUmxBSUxIWWVs?=
 =?utf-8?B?L2t3b1F5Wmh2Z1VYeXNSL3JkaTFjSVMrTEJ6UkovbHU3NzB6VFpxL3pyZU5D?=
 =?utf-8?B?VEVtSFRPR3p1WkxtWWRSOE1BQXM1a3FzRkF6dEtpdmFYWFpKVGhxQVNuWlZr?=
 =?utf-8?B?dVM4Z1R3M0JIbjNzS0JBSjFnc01hNGtwNEUxNVFXUU4yNGpvY29rS1RKWStr?=
 =?utf-8?B?Q1loQ243TldoQjdxNXdLbDVMVkFMQzMxSXFRMmxWZnVyTU5hcTBXWk5xL2xi?=
 =?utf-8?B?YTd4dmdNa3ROOFJUUVJYb0YrYmJMaEwyTE0wVGxBTXBIRGc2cUJPWUg4cnRH?=
 =?utf-8?B?UXdWLzVuVTJFdDdvYlBuR1UzMUJTakNqd2JZekpsWmlWNzQrZ1FpczdRRWlt?=
 =?utf-8?B?NnNqVUNlWWRrT2Z0Qkxza2xubVgyZ1Rjc2Q0eEEzZ2hvb0Uxb1J3Y1pHR0ox?=
 =?utf-8?B?cm1WbncyMmFYU0lUaDBHRzA0YkRkYy9Cbm8wZjk1M1JkakpmdjRvQlByZkl0?=
 =?utf-8?B?bzdIN0dUbEJrN3VWNVZ4OEg4QTZGcGRqRGVMQXlxdVBCWndGc0U0aGFhTmo0?=
 =?utf-8?B?T2I3WlpKZlZjWW5oT3ZWNzNlSEM4cExRb3o1MEcxcGZsVUdzckl6UXo2ZFFt?=
 =?utf-8?B?T1hJY3lxUVhhOENuYUI2MHhpZlVGR3Y5RXJIUTNFTHM0ZjlhdWhkVWtOUEpJ?=
 =?utf-8?B?SXVJK3JjUFBxS3AvQzJ4MU5ZS0J1UWdLa3JoazZhVnQxL2Nad0Z4WTJwZkQr?=
 =?utf-8?B?NmdZZDA0WDZhK0N2TWhRc1drK3g2R1dIaGtxRWNSMVFBR2N3WlplQXV0bDVy?=
 =?utf-8?B?TTliZWF4bk9qekQyV0ZCTjJHaGtmcEpxby9WOHBSc1lKYUNwRHpubDJETndv?=
 =?utf-8?B?dXdHK3FFS1dSQ0IyclpTWVRvTTA5Y0J3SzNOVjVYNlYzSVpTS09HSkFkdFRr?=
 =?utf-8?B?Y1J2b0dtSXd5WVpSTXBaamg2d2tPcGhFUFY2TklKY3lWeG90SkZrbmhsZHhi?=
 =?utf-8?B?ZFNpcUVBTmw3Um9qWlhaWDdRYjZ1czgwNDRrNjlCYm92aEorZVRna0VVRmZK?=
 =?utf-8?B?RTFsL3pQaFVOZFNTYll1YlpmWHZTWk9YUnl6Z0QwZXJzWHlLbHF6RWtybitG?=
 =?utf-8?Q?Or9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500a019b-25b9-4e13-003d-08db351b3566
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:45:17.9088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+Tvs5Y9/C0lFTHCbO2k6/1DhlMu7j61SdHKYr7nAXxDdpUnj07g4dnnpM42I/DqpNRzEtVNdmfwMPxORYqN3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgNCwgMjAyMyA5OjUyIFBNDQo+IFRvOiBYaWFv
LCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IENj
OiBMaXUsIEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT47IEd1bywgU2hpa2FpIDxTaGlrYWkuR3Vv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBhbWQvYW1kZ3B1OiBJbmhlcml0
IGNvaGVyZW5jZSBmbGFncyBiYXNlIG9uIG9yaWdpbmFsDQo+IEJPIGZsYWdzDQo+IA0KPiBBbSAy
MDIzLTA0LTA0IHVtIDA1OjU2IHNjaHJpZWIgU2hhbmUgWGlhbzoNCj4gPiBGb3IgU0cgQk8gdG8g
RE1BLW1hcCB1c2VycHRycyBvbiBvdGhlciBHUFVzLCB0aGUgU0cgQk8gbmVlZCBpbmhlcml0DQo+
ID4gTVRZUEVzIGluIFBURXMgZnJvbSBvcmlnaW5hbCBCTy4NCj4gDQo+IEdvb2QgY2F0Y2guIFNl
ZSB0d28gY29tbWVudHMgaW5saW5lLg0KPiANCj4gDQo+ID4NCj4gPiBJZiB3ZSBzZXQgdGhlIGZs
YWdzLCB0aGUgZGV2aWNlIGNhbiBiZSBjb2hlcmVudCB3aXRoIHRoZSBDUFVzIGFuZCBvdGhlciBH
UFVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbmUgWGlhbyA8c2hhbmUueGlhb0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIHwgMTAgKysrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gaW5kZXggMzNjZGEz
NThjYjllLi5iY2IwYTdiMzI3MDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gQEAgLTI1MywxNCArMjUzLDIy
IEBAIGNyZWF0ZV9kbWFtYXBfc2dfYm8oc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+
ID4gICB7DQo+ID4gICAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnZW1fb2JqOw0KPiA+ICAgCWlu
dCByZXQsIGFsaWduOw0KPiA+ICsJdWludDY0X3QgZmxhZ3MgPSAwOw0KPiA+DQo+ID4gICAJcmV0
ID0gYW1kZ3B1X2JvX3Jlc2VydmUobWVtLT5ibywgZmFsc2UpOw0KPiA+ICAgCWlmIChyZXQpDQo+
ID4gICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiAgIAlhbGlnbiA9IDE7DQo+ID4gKwlpZihtZW0t
PmFsbG9jX2ZsYWdzICYgS0ZEX0lPQ19BTExPQ19NRU1fRkxBR1NfVVNFUlBUUikNCj4gPiArCXsN
Cj4gPiArCQlmbGFncyB8PSBtZW0tPmJvLT5mbGFncw0KPiAmKEFNREdQVV9HRU1fQ1JFQVRFX0NQ
VV9HVFRfVVNXQyB8DQo+IA0KPiBJIHRoaW5rIHVzZXJwdHJzIG5ldmVyIHVzZSBVU1dDIGJlY2F1
c2UgdGhlIHBhZ2VzIGFyZSBub3QgYWxsb2NhdGVkIGJ5IHRoZQ0KPiBkcml2ZXIuIFlvdSBjYW4g
ZHJvcCB0aGlzIGZsYWcuDQoNCk9LLiBJIHdpbGwgZG8gaXQuDQoNCj4gDQo+IA0KPiA+ICsJCQkJ
QU1ER1BVX0dFTV9DUkVBVEVfQ09IRVJFTlQgfA0KPiBBTURHUFVfR0VNX0NSRUFURV9VTkNBQ0hF
RCk7DQo+ID4gKwkJYWxpZ24gPSBQQUdFX1NJWkU7DQo+IA0KPiBJc24ndCBhIHBhZ2UgYWxpZ25t
ZW50IGltcGxpY2l0IGFueXdheT8gSSBkb24ndCBzZWUgd2h5IHdlIG5lZWQgdG8gdXNlIGENCj4g
ZGlmZmVyZW50IGFsaWdubWVudCBmb3IgdXNlcnB0cnMuIElmIFBBR0VfU0laRSBpcyBuZWVkZWQg
Zm9yIHRoaXMgY2FzZSwNCj4gd2UgY2FuIHVzZSB0aGUgc2FtZSBmb3IgYWxsIGNhc2VzIFdlIGRv
bid0IGV2ZW4gbmVlZCBhIGxvY2FsIHZhcmlhYmxlDQo+IGZvciB0aGlzLg0KDQpZZXMsICBhIHBh
Z2UgYWxpZ25tZW50IGlzIGltcGxpY2l0LCBhbmQgdGhlIGxvY2FsIHZhcmlhYmxlIHdpbGwgYmUg
cmVtb3ZlZC4NCg0KQmVzdCBSZWdhcmRzLA0KU2hhbmUNCg0KPiANCj4gUmVnYXJkcywNCj4gIMKg
IEZlbGl4DQo+IA0KPiANCj4gPiArCX0NCj4gPiArDQo+ID4gICAJcmV0ID0gYW1kZ3B1X2dlbV9v
YmplY3RfY3JlYXRlKGFkZXYsIG1lbS0+Ym8tPnRiby5iYXNlLnNpemUsIGFsaWduLA0KPiA+IC0J
CQlBTURHUFVfR0VNX0RPTUFJTl9DUFUsDQo+IEFNREdQVV9HRU1fQ1JFQVRFX1BSRUVNUFRJQkxF
LA0KPiA+ICsJCQlBTURHUFVfR0VNX0RPTUFJTl9DUFUsDQo+IEFNREdQVV9HRU1fQ1JFQVRFX1BS
RUVNUFRJQkxFIHwgZmxhZ3MsDQo+ID4gICAJCQl0dG1fYm9fdHlwZV9zZywgbWVtLT5iby0+dGJv
LmJhc2UucmVzdiwgJmdlbV9vYmopOw0KPiA+DQo+ID4gICAJYW1kZ3B1X2JvX3VucmVzZXJ2ZSht
ZW0tPmJvKTsNCg==
