Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BA3F532D4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 05:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A291B10E58A;
	Tue, 24 Mar 2026 05:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41+Efa3A";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDDC10E58A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 05:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqG6yegVk37ertLOxHa3t1n3/qy2Y6mpSZlHMV+kTJZvBGKVtplBxJspivrBTZAJMd9vMFAB9Q8zfVWsO/1V0eJlA15JBwyVqArltu1zU5AdJ48OOxjfy542YRd0WIlK7988MiXCCY2B2sXGMQpGwy51GSz55tCrGa7vTmKWVIHIE40kj2+IyoNQ51fhjtc5Pjx/2+vZBBSft/DLpxhL/NF+t77FTgNliFGn5yirvAgwRwADd5RK1UfYrikbTODeXEzfm/+FyDT9iSeB7RS5xxw8JWRhVd8/4pTpDHA7equeDcMoZ9+ZAdVHFKPGzkAZt8umQC7cNdPxj+lgSoib6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q92BkrHBdJjGLl6RWHMM+0g03jj1A73zlOGdiOIQ4vE=;
 b=jKLMZf0so73en4JYpd/2oTOJkTlJXbqPKODQBqocQw+hZ6VwUuqiGfiT+cPjnFBBw4bA+inVtMVgBsr6J00dFPXBwdiVwgnKUQNopnPVk7zYgz6MdRaqNLwBNzZsdgWdkVTlDDTHhFTqT4HtVAgujY/WnLGrRVXdUAaefvc7Qkq97zVpREHHQVbow4AKevVaMDohzRJlMwJ4YZF6VhkGrRvtAw0J4MIZfMdCNp3tbrONLBCq2pevXGbmuXl8gcBp3lmERqP4vKGLfDqYEMMarOCMu/32rGzz20JdB8ZLucjtmoxgjDyu0BqdDwg8T8xrHG/MiyvZkLJOyp2r9tOhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q92BkrHBdJjGLl6RWHMM+0g03jj1A73zlOGdiOIQ4vE=;
 b=41+Efa3A2RpsxCSoHA2QihxaXyKkYBZXJwDGPWFN2uUoCYzrqd2H4Kz9v8A1BmrM2d5ygIbQRMBFxus7FhD0aJZ7Li+TGZvFAv3Ek4uXcgF3qXfZRl+RqfVyeUi9Oq9WzHMDs6Y5s33pTbaQbv7v5mqqNYMiwknlYw4Y9x+TrRY=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 05:48:54 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 05:48:54 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the idr allocation flags
Thread-Topic: [PATCH] drm/amdgpu: fix the idr allocation flags
Thread-Index: AQHcuqCWr21HdKy090yi0eNHNjQrP7W74MQAgAAmtwCAASYhMA==
Date: Tue, 24 Mar 2026 05:48:53 +0000
Message-ID: <PH7PR12MB6000D706B3CC5758E03FC5B6FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260323083923.3348059-1-Prike.Liang@amd.com>
 <1b28c112-c9c5-417d-b9e7-088100cbd22d@amd.com>
 <PH7PR12MB60006CEADD1F895156C60120FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60006CEADD1F895156C60120FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-23T12:12:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MW4PR12MB6779:EE_
x-ms-office365-filtering-correlation-id: f7c556d7-bc69-4d42-ab1a-08de89690873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 6B/Ped1Ks5PH4UtB/8pO2obEROUOg+LsSzZFUO8c6kH+nTg45w/ff2F+Tmad6FDvFEwXiuPEgUbUyTjkDEeyzXIQPVwv33D78vxOvKZUplrLutS05YARh06aJL/QW2htR+NcLOcQNhpyv5LXbZsqJKdWsS7JIP333OdK6TWEd+XyY2raKgpyftt2fGUybJLDgGbArdrgIcR20x1Qd9mKpKDE+/pNHn/o60gprAtx6U3bZXpNNe9U3a96bWy6NrpjyoIbcn4VAJjw29aMIURMdeVT4Pai6uHf9OkxbA57AILGqrUjLok22Xqgk6ttfXX7P5cfU9AzCPy4ifWhPbX+kKwxEHx9YVYUMzhHk/rKgcW1/n2vnWMygQxNrT8gOPPND820RW+y4Kkvv4W24OpDCheVnrLOdehuZkNUh9eZRMnhkISiA+Jef5Tu3FUNV9zv7pEhOcFiqkZoX3tfdZWkygle32WWdDv7Tz6gA41pmGLaX17VvtGXsohbp4gxW6quF45jZDo/946YNxcSqwYYVNqHwjDPiD/2iYb++Z7JdGKj8bcrCkveoqFjp/+Od8qxU23ExoIboHoXbPJGUcS6CAK929c/Dj4cHG8dhBhvrFBU8C/2Y9ebBC8Ix3lde+edbTqUue/9Jv63/al7zhbWESjER2JOLl6rugmt+i6vZRtld0w9MtgB2DxtvFg9U3Y7t0lavTa/wFDokNFO6GVoTVFokPwfQylLefsF0j9DtUpT+SwWe/EiXVFQ809CW3KlGuT7EjLMBPpTPvkjFFQTit1l58G5H/5KEfcVHiOPD3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVR1ellxSjhQVFd5cWN6bXdDbWx2aFV1c0JZVVNCMnFoQjJxYnZORklEWmV2?=
 =?utf-8?B?bk5aRzRkMUVtaGh3V0crY2NZMVJHWmlwOEdlSStYVXBtSUxKaUErQ3lOMTRi?=
 =?utf-8?B?VjJIS2lLVXVyMWNMWjd1enBmZG4wc1E4YWtkeUNXb2JjZkhZSXVYMGZWODVS?=
 =?utf-8?B?aEoycVZYLzVlTFJCS00rbDFCRDJtdjNOQ1ZFb25mUlEybjFIMmdQWjJveVp3?=
 =?utf-8?B?TEEySmxCWWpXTVdIbjBOT1c1UVJSbUFIQzRPTzZNTm8rMjJrSzRYVXNJZ0Ur?=
 =?utf-8?B?VWlLSENmWmNTdUc3ZjYyWlcxejh0KzUwelRQQlJEeU5ZTzkzQ2JXdnBsZmpY?=
 =?utf-8?B?NmNQaWdzY2JBWUJteVljUVVLRUhpVkxsdGlQa0JDR0hRUHlndVZZN2FBTUFj?=
 =?utf-8?B?cFJBZUtFOTlhOFR1N045Ymc3bHR0OTNKNHNMZE40MnBWVTV1TG54RWV1VkpM?=
 =?utf-8?B?aDBhMXNwMVVoVUlWUEE0ZDJvdlVMWExKVDdOekp0d3g0Ump2WmZraTd6dm5J?=
 =?utf-8?B?VGEyTUpnaVIyaHhSSWNWZ1hzZlhVZlVxNlB0dE1sQTkySkxhUnR2bGNyZXkw?=
 =?utf-8?B?L2wzanBsVE1UTDBSbFZlSGRiU0F4MjI0SWdCbDdHMDEzNHg5UlFOaXowRWZx?=
 =?utf-8?B?aW1oaUdnbGVGODBlRDVMNmRhMzFoOG5qUFF4S2VTSElxU0hYMnFsN3NSaTc3?=
 =?utf-8?B?eDZncUY1WTUrQmxDSzhJb09wc0Q3ZVYwem13SkF3eG4zM3JoRGMvZGF2MEEr?=
 =?utf-8?B?ckFBbGJIS2tXVTRscDhlSFlMM3NLcitoSTh4MWt1ZUdMQmdMSDlmeUJTTW51?=
 =?utf-8?B?YjhWM1owNHluZWh5dUZKZnZ5R25LeENlSVdYakpPNVhnK1UrSmxoMmJtWXQw?=
 =?utf-8?B?MlRoMlF6Q3NxSUMzRUhLb0dXYnZ0ckc0ajdLUDVQUW9mOXlEMGJYNW4rNkRz?=
 =?utf-8?B?L3BOelJRV0xKRmRPdXIwWkRmME1GU3ZNbDgvVkYxY2NMdmJscGlFTDRDWWFu?=
 =?utf-8?B?UmVjNjdkQUY1VDVMTUIxM0FHWDRqNW1taFJCZXNhRXRzRWZ5ZGZIYzhYYTVE?=
 =?utf-8?B?NXBQb2FGd3lwWjdheTNCT2hnMHpVdEFFeE90dFFHQStncDFSM1kvYkpnbVZt?=
 =?utf-8?B?eEtJT3oyajJtejgvMENxL1lHbTJydmdkdS8vV1pWUjFtQUR4TldVTWxuZWFu?=
 =?utf-8?B?cmNvdmludTE1VXNReHpEZGg3OUFPYjUzNFdDdmJMVUFQOHhuK2JzMm1oL09E?=
 =?utf-8?B?dWxHN2FkVmpuY0IreEx6TVl2N1ZNWGF5VjlIVHRad2JhN3FtNW5JdjJiZlVV?=
 =?utf-8?B?aGNLT3AvM2tmRlowVlhWdUNZcjcreC9YMi9kZkhZOVJIWkE3cjdXb2NZZEVp?=
 =?utf-8?B?QlBZWUk3NXRWbE1ScWhOOFdDcmlPSTMwTkJ0YzlDWm96cmlKVTBWUGJ3OEtD?=
 =?utf-8?B?dDd1NjYvbGhEM3JKRUJ6Q0ZYV05USU10UVZtWWZZUDFQMjB3S05HYUI0cFFN?=
 =?utf-8?B?aWl4ei9WbUVOU0dLQ05XQ2pyN25qamlWSWlTRTN0WVB4RDZQcXFXZHdVZ21W?=
 =?utf-8?B?Zm5ldldMV3FkT3hmV0tWR2hSdlFZYlQzb1dUdFdxN25lWk1EUmNGRy9lVjdw?=
 =?utf-8?B?REZkWnNOK3ZsaFNhUFhISnp5VzZMN1N5V3BKa0NNSU9vSkp0WW1lZWZ0V3Js?=
 =?utf-8?B?T2tWNWhQTTYzZkhkOE5zRFJwYnpPK0wxRVh4NG5NTi9pQkFOZEdQbEZ5bGhm?=
 =?utf-8?B?YWpoSWg5U0o3dCt6RTlDcS9KQWhPQ3kyTk9kbzdmWTlHTE5MRkhTUVErZ3d2?=
 =?utf-8?B?cVUxQ082NUNLOGpPdy9GQldOU1UyVVVzUzJYMTdhdDhGZ0JHVEsweTczeitP?=
 =?utf-8?B?V0FpTEpXcTlKOE8xMFJvQU94eEorL21hZUxPL1E4aGdyUTNqNHNJS0lkdTAz?=
 =?utf-8?B?YXVwa2lVRzllL3M5VUJWME1GNWNTVmN5UW1TYmxRd05ZU1lMd1BUZ1dObHNS?=
 =?utf-8?B?TUNlQSt5elRMWlBnbGhlbXBIejZNWlY3dVF2NmNkOXpHbDBkc2RzTzI5di8x?=
 =?utf-8?B?VlhVeVBOSjJuYnoycmtLRTJJc28xK1YyakZOVHhXODdBd3YxTU5WQXpvK29T?=
 =?utf-8?B?YS9zdVZ1QXZRM0Zxd0xmU1JWUnRyUHZEUlZXeml2Q2x5MzM0UFlSWkIrdWNY?=
 =?utf-8?B?SWRqOVplZ2dZbW9jcWFlTHFPQlFnc20xYW1LZUVhNysvejRCTEYyRWN2Q3Fq?=
 =?utf-8?B?V3ZPOXdYVEMxVGYrTXAyVFVvc1RTY1ZVcDdmdS8rNitINkUrWHpndDU2VEM2?=
 =?utf-8?Q?7Cx63nQtOijF6L2O9W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c556d7-bc69-4d42-ab1a-08de89690873
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 05:48:53.9173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HCIMwyyT880E1DqtbLqBcZMgcyvQFwMZTAfqs+pZbNfIwSZZpQ6TBP09ZBUYRZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIExpYW5nLCBQcmlrZQ0KPiBTZW50OiBNb25kYXksIE1hcmNo
IDIzLCAyMDI2IDg6MTQgUE0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIEppbkh1aUVy
aWMNCj4gPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogZml4IHRoZSBpZHIgYWxsb2NhdGlvbiBmbGFncw0KPg0KPiBbUHVibGljXQ0K
Pg0KPiBSZWdhcmRzLA0KPiAgICAgICBQcmlrZQ0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gPiBTZW50OiBNb25kYXksIE1hcmNoIDIzLCAyMDI2IDU6NTQgUE0NCj4gPiBUbzog
TGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgSHVhbmcsIEppbkh1aUVyaWMNCj4gPiA8SmluSHVpRXJpYy5IdWFuZ0BhbWQuY29t
Pg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCB0aGUgaWRyIGFsbG9j
YXRpb24gZmxhZ3MNCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiAzLzIzLzI2IDA5OjM5LCBQcmlrZSBM
aWFuZyB3cm90ZToNCj4gPiA+IEZpeCB0aGUgSURSIGFsbG9jYXRpb24gZmxhZ3MgYnkgdXNpbmcg
YXRvbWljIEdGUCBmbGFncyBpbg0KPiA+ID4gbm9u4oCRc2xlZXBhYmxlIGNvbnRleHRzIHRvIGF2
b2lkIHRoZSBfX21pZ2h0X3NsZWVwKCkgY29tcGxhaW50Lg0KPiA+ID4NCj4gPiA+ICAgMjY4LjI5
MDIzOV0gW2RybV0gSW5pdGlhbGl6ZWQgYW1kZ3B1IDMuNjQuMCBmb3IgMDAwMDowMzowMC4wIG9u
DQo+ID4gPiBtaW5vciAwIFsgIDI2OC4yOTQ5MDBdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2Fs
bGVkIGZyb20gaW52YWxpZA0KPiA+ID4gY29udGV4dCBhdCAuL2luY2x1ZGUvbGludXgvc2NoZWQv
bW0uaDozMjMgWyAgMjY4LjI5NTM1NV0gaW5fYXRvbWljKCk6DQo+ID4gPiAxLCBpcnFzX2Rpc2Fi
bGVkKCk6IDAsIG5vbl9ibG9jazogMCwgcGlkOiAxNzQ0LCBuYW1lOiBtb2Rwcm9iZSBbDQo+ID4g
PiAyNjguMjk1NzA1XSBwcmVlbXB0X2NvdW50OiAxLCBleHBlY3RlZDogMCBbICAyNjguMjk1ODg2
XSBSQ1UgbmVzdA0KPiA+ID4gZGVwdGg6IDAsIGV4cGVjdGVkOiAwIFsgIDI2OC4yOTYwNzJdIDIg
bG9ja3MgaGVsZCBieSBtb2Rwcm9iZS8xNzQ0Og0KPiA+ID4gWyAgMjY4LjI5NjA3N10gICMwOiBm
ZmZmOGMzYTQ0YWJkMWI4ICgmZGV2LT5tdXRleCl7Li4uLn0tezQ6NH0sIGF0Og0KPiA+ID4gX19k
cml2ZXJfYXR0YWNoKzB4ZTQvMHgyMTAgWyAgMjY4LjI5NjEwMF0gICMxOiBmZmZmZmZmZmMxYTZl
YTc4DQo+ID4gKGFtZGdwdV9wYXNpZF9pZHJfbG9jayl7Ky4rLn0tezM6M30sIGF0OiBhbWRncHVf
cGFzaWRfYWxsb2MrMHgyNi8weGUwDQo+ID4gW2FtZGdwdV0NCj4gPiA+IFsgIDI2OC4yOTY0OTRd
IENQVTogMTIgVUlEOiAwIFBJRDogMTc0NCBDb21tOiBtb2Rwcm9iZSBUYWludGVkOiBHICAgICBV
DQo+IE9FDQo+ID4gNi4xOS4wLWN1c3RvbSAjMTYgUFJFRU1QVCh2b2x1bnRhcnkpDQo+ID4gPiBb
ICAyNjguMjk2NDk4XSBUYWludGVkOiBbVV09VVNFUiwgW09dPU9PVF9NT0RVTEUsDQo+ID4gW0Vd
PVVOU0lHTkVEX01PRFVMRQ0KPiA+ID4gWyAgMjY4LjI5NjQ5OV0gSGFyZHdhcmUgbmFtZTogQU1E
IE1ham9saWNhLVJOL01ham9saWNhLVJOLCBCSU9TDQo+ID4gPiBSTUoxMDA5QSAwNi8xMy8yMDIx
IFsgIDI2OC4yOTY1MDFdIENhbGwgVHJhY2U6DQo+ID4gPg0KPiA+ID4gRml4ZXM6IGU2ZDc2NWRl
M2Q2YiAoImRybS9hbWRncHU6IHByZXZlbnQgaW1tZWRpYXRlIFBBU0lEIHJldXNlDQo+ID4gPiBj
YXNlIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lkcy5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWRzLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2lkcy5jDQo+ID4gPiBpbmRleCA2NDRlNDEzYTRlNjkuLjJmNTUyMzUyZTA0NiAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0K
PiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jDQo+ID4g
PiBAQCAtNjksNyArNjksNyBAQCBpbnQgYW1kZ3B1X3Bhc2lkX2FsbG9jKHVuc2lnbmVkIGludCBi
aXRzKQ0KPiA+ID4NCj4gPiA+ICAgICBzcGluX2xvY2soJmFtZGdwdV9wYXNpZF9pZHJfbG9jayk7
DQo+ID4gPiAgICAgcGFzaWQgPSBpZHJfYWxsb2NfY3ljbGljKCZhbWRncHVfcGFzaWRfaWRyLCBO
VUxMLCAxLA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAxVSA8PCBiaXRzLCBH
RlBfS0VSTkVMKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgMVUgPDwgYml0
cywgR0ZQX0FUT01JQyk7DQo+ID4NCj4gPiBXZSBzaG91bGQgYXZvaWQgdXNpbmcgR0ZQX0FUT01J
QyBoZXJlIGFuZCByYXRoZXIgcmVwbGFjZSB0aGUgc3BpbmxvY2sNCj4gPiB3aXRoIGEgbXV0ZXgu
DQo+IE9LLCBJIHdpbGwgY2hlY2sgdGhhdCB3aGV0aGVyIGNhbiB1c2UgYSBtdXRleCBmb3IgdGhl
IGlkciBhbGxvY2F0aW9uIGluIG90aGVyIHBsYWNlcy4NCldlIG1heSBjYW4ndCByZXBsYWNlIHRo
ZSBzcGlubG9jayB3aXRoIG11dGV4IGhlcmUsIHNpbmNlIHRoZSBsb2NrIG5lZWQgdG8gYmUgdXNl
ZCBpbiB0aGUgRE1BIGZlbmNlIGNhbGxiYWNrIHdpdGhpbiB0aGUgYW1kZ3B1X3Bhc2lkX2ZyZWVf
ZGVsYXllZCgpLg0KDQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPiA+ICAg
ICBzcGluX3VubG9jaygmYW1kZ3B1X3Bhc2lkX2lkcl9sb2NrKTsNCj4gPiA+DQo+ID4gPiAgICAg
aWYgKHBhc2lkID49IDApDQoNCg==
