Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADB7C44500
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 17:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842210E3F5;
	Mon,  6 Jul 2026 17:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUBusz3v";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A554710E3F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 17:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyITljoSOOUQqJDSq1TA5mHeIo2GtP6r4o3ToZIXbtO0VyCFUFaIT9zKh4uXWl5ybnkFa9r4dgUZIRcw3z5ACUlDReUf4lAUzEjcGKyHkSyYJwVnRbzUFJ+Yl+ycCPPt5z+nUQc26s3+8Taf8yuy3rkm+P9OE9wqSXd49WCGKmZPsQXotTf+Y9l5TFOYFxr/R4gKiERfGQvZrpD0oijGMP9YrfamA8pZh1WMBGb/Cw1ynyvaKxCcrY1J/5WeljgHRTU0y6LCjKUZZOeTtIbB9aIRolpymZ0/4FFM1fYrNREZj6R+/6SMtLtMQyf2tBYJs1vi2LKySjA0/iP88HIPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTBCWXVJYUWp03VA4zPLWgw0bOU2lwl1wmB61vHIKa4=;
 b=HfXNVNPXlVqlVWrkDdVp7njr5gULYMH4I3zqcYHawDUj/oNqNjK9CfZyPe+CyhSMC6f4OVQN2++Oh7nJuNiesombBkvgcFS20h1KQ0oVfmkXo1fQ+aAIxDpUP5V8/i1nbRXQvgrS7nBnwP6kHXoxDmKokypsNVDAH/5Me0jfjQIQN67t7HzmhzUnsuelo+TIIrsM96tG9Gt7IWYkOBJB9kpTD6FN1spA1QBHKT+obVIPV/caEuaaIwKWChQCtilvICQ2cFa287k6eT+z/r6lzO18QII+2sIFfNsj4CxumBgDLgRHQb/9VuhPWpPVirp5NDtMtogJPhpEJoEaeKpfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTBCWXVJYUWp03VA4zPLWgw0bOU2lwl1wmB61vHIKa4=;
 b=YUBusz3vQ2aPC2AV4ydCCqBnZlxk1F6lSv5JFRQZYEvmywqnzFJ1wdhOge2a48XhnSQwZB00ShCzgIF3sIoyIy3xh8pO3506Tq+OdNAIxGRes+SOVxjIJRFT/v7sFX4UUT5ZF6hFhKRXGQ74hBY16H0Fz3ZXyO/7iabvf5qz4Sc=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 17:48:29 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 17:48:29 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Shetaia,
 Amir" <Amir.Shetaia@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
Thread-Topic: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
Thread-Index: AQHdCXUveB3zQ9WQh0KlDFNEzCPVhbZb/tEQgAAlYYCABKekwA==
Date: Mon, 6 Jul 2026 17:48:28 +0000
Message-ID: <BL3PR12MB64257E98740CDB903C4B2BE1EEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-13-timur.kristof@gmail.com>
 <BL3PR12MB64256E6E84188CD2CCAB6C09EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
 <5742390.E0xQCEvomI@timur-max>
In-Reply-To: <5742390.E0xQCEvomI@timur-max>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T17:46:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ2PR12MB8718:EE_
x-ms-office365-filtering-correlation-id: b832cd21-b4cb-41a9-f06e-08dedb86c9a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|921020|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 79B1kK/PEFag0WvqCkyj/H2hg1YHEGedLq05JWXSiToWyVRxwCMKj9PTj71QFO0QAcGKA5SeOmSKJMN8ULmWIY8SFbyHDhd4qzT7iwevXs+okgypsp+N0DmZscvng48+4gK1XGj4XOmHMqatpwo3whIapaPVLsZ8aelu5Su/t4FTWh+WAdzqbUeu7463u4V+Ou2T6m95aPKQyMyyn1IDLWDLII1naweb7HpwWznWNXr7HKIbua3k8ytvOyH1x4MDyQtSYKFNzp2KoOQBxU3sepYFAtVwaFTerwjGiVCVcUqko8K5QuaLsdy9CvA0mKRF7QTdgXSrJbQMS8U0GpvZhQgMk3hjhgazS+tpiYbPAvuXmD3PcLlncHQZadvjD6/cRTXdXEhmaT8v/2aZ6YizOHHd4XUbae970Udf1yJ1JS2NSd7MwUY7d2KJu/lGGos2RAvAal+42NerZhKedg2hZdTl1EkviHSTkiG/vNxXJGI+ClFwAOiOcsyIsKAa/eQ7/wVLX3cOlVD8mHuqa1ZucOkuNznb81eIDhFGmo//qncX3rTAdIRofNaK2HBfFFusSZOJgApkbWr/ag6W6XJPqr5tEykQMZdjiIluWflJDuA5ARRSu83o9TfI4cOlRp7ViT3y0m2alkHjRhxPqLFky4+fTPTc6y6ROkyEgUJeIiSz29GR52NxKwQcr+z72qs+wUQcfz+9ibNgHYDThJYYh8n+moa6ZzxtYytSrFG1XhfTqfHJYGRvFfBnlc2S/btg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(921020)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VENWMVoyMERaRlhlWVJyZmlKQ0xmSmMrWllVQkN3Yk84MzdCN0hIYU50b2M0?=
 =?utf-8?B?b3ZVR0krNWpXc3Z1dFFaQlpRRTlEaXU5QTZwR0l3UFRKT2NJUTUyZFpMdnJ2?=
 =?utf-8?B?UGlqbEtYQmt2TUxPa1h4NjdOSlNoKzJJTmVXOVNVcmZPWi9HWmZZZjAwMGFJ?=
 =?utf-8?B?WXMxSzl5N0FXeVhOSnFkVmJZaWNMcUhiZEUvcDNmM3Bmb1hUV3ZVQ054cW43?=
 =?utf-8?B?aVJ0VTk2UkNJbGV2dHBoQkJ3Zm9MVitQTXJvczlpMEpYWVE2Wno1UmtkQlVS?=
 =?utf-8?B?cjBEcCtiRm10WmsrZ1VjaXlNRys4US81VGl0VVFibUhwZWdqUWo3L3dVa0hs?=
 =?utf-8?B?NW9SZ29iTFMwdk1wVGMwc3lPRjBoYkZ4OGFQK1BMRlhpaEJnSWdoL3FENytL?=
 =?utf-8?B?TllWWDFGOHFaMGQ3eVNvUmpadjBuZWpubWpud3pkZkRuL2tmWlBGMnBRMHAz?=
 =?utf-8?B?VkxLMnI3bGNNc1p3ZUF6ckhwcU03UDlERVltNDlod2tETG5WN2Z2NjFGdnN1?=
 =?utf-8?B?Nktud2V4dGpabDk3d01WWktjaGJNUkg4aEJjRGJIT0ZYUS96cW5CSU9oVVJS?=
 =?utf-8?B?ZXRmVUJtMzYydVZmZGJ0WVQ0Q1FDV1BSMGNucG5yOWhHZFhkeHgvSk5LUFQz?=
 =?utf-8?B?WFZ4dUtXWDlCWUo2eDRXbkVISDI0aFJqbWR1UG95ZmZWRCtydUtmclVrMk5p?=
 =?utf-8?B?WlV1bjlsZ2NJR1IybHh4dGh6L0N1TTJsL2o0RE9Eb05ib1dDUnk0ejVuMjA0?=
 =?utf-8?B?OFlsMGJBMmM4OE9KcDJUT0tKbnhwK3dlRGtxMm1KZWJHbG1kTE0wSThhalRk?=
 =?utf-8?B?Y3ZFK2lsYnUvR2kyanpyMnNmZWhvR3Q0K2pVOVhCNGNJeTR3OVRvM2xxaXVV?=
 =?utf-8?B?czAzdHM0RzdlQXNHeFkxS21nUFJscEhKbGlqREE0YmZQV0tobEVTWG5WWDJ6?=
 =?utf-8?B?MGV3andPSlN2VlI3Sy9ZYlVIUE1nZmhpQ2luUklDd2djc1YvSmNlbUpqT3dI?=
 =?utf-8?B?ZFVHMG9CSWtqbmozUktyVWtYRVpXRFF1WnpZTTV6MlMrc3VpYmpzSWxEa01P?=
 =?utf-8?B?ZktZUlBPYm1hYyt1WVdtTzJDN00xQXRwNnU2MXZJMkZpNmdUVlQwOHdSS3Qy?=
 =?utf-8?B?aVVHalV2RUcyVlV5WG9hWUhZZWtHNFo1UlYvOFdsT2gwaWs5U3JaY09aWjgz?=
 =?utf-8?B?dzRHTENQS053Z1NrdzAwOFdLdWZjcUhwREkyM2ZMd29rbVJJS2tTYW5XNUlx?=
 =?utf-8?B?MVlUNUJOcEorQjMwQzhYSmE4UStYQlBpN2REWG9GenBDSUhBMHdGc0Ixektq?=
 =?utf-8?B?c3lYZ04zdkpCSkJsYlN1SHUwYlJxSHpJSzRaRUFJZWV3SG54Rkc2RzNSUGsx?=
 =?utf-8?B?bG9BZUZGdG5xVHNKaUZxZDNGUW1PUE9lL2dxWHFmd2F0ZFRFUUQxZHdpM3Yy?=
 =?utf-8?B?emxoRityMW5NWGVrN2Rac3VKeGwwTTZ4Y3JVN2REb3RKREdoM1ZubEcxbUFz?=
 =?utf-8?B?dXNUcjg4REVBNTRiZzBQeXc2RDY4dzhTcDNqYVJwWHhHWXZBUXVBeEx6M0pN?=
 =?utf-8?B?UTNablBuSklHR0U4cUNHcGp5Q2RaL0lVOWZFam5FN1JhSFB6SzNPRDdkVXN4?=
 =?utf-8?B?OHdPTGlpa0g3c0xDR0xDcjFPeFcyMHBmRENYWUNPUnhub2kvMkI4aGM4STFL?=
 =?utf-8?B?TXdmOWJ2c2hBVWFxQzJPMmtmdUhKOHVsZ3pIRG1NaFNkNzRZVW4zZERrbVY2?=
 =?utf-8?B?MXBVa09TejVNU2lENTA5S1BkendRTWlqdEpPU3cvTFViNENyZ0VkbVVGRXg0?=
 =?utf-8?B?cVllSzIremppRlprMUpkWFBsQ3pRSUFRSjlBRXEvdlRablJNZGR2Z2drTjBQ?=
 =?utf-8?B?UUVuZFllUnArWStVL1VlU0dmL2lIeHdrZEtyWXdKQzU3Z05XRGg2Q0tuY0lM?=
 =?utf-8?B?UUZLQ1F1ZEM2QUQweHpQMkRXbkY0TkZsc0VMbFJTamlYNUtpZ0JvTlUwL0N2?=
 =?utf-8?B?RHpaYmZJZlh6cS9pcmhJL2ZyNW9xM2l2SnlBVThzNHZDU2tvczBIRStMWXNt?=
 =?utf-8?B?UzlIcDV0eEdpUiswK2ZOTHdDdWJNcHFtTmU1SEptZmRaNXZkK1gvR1dFY3Q0?=
 =?utf-8?B?cGxDeG1WVzJJTGJ3MTNuQU9hOTlnVjNEeEpYRkxYeW1WVjFIanlSbjFKeTVX?=
 =?utf-8?B?ejE1Tm9OUVN4dUxPR2VzdjZSd0Vlak1CMmRMNldWY2F0bklNTlJPTTc3c2t5?=
 =?utf-8?B?YUY5QUNpMzRpM2piS0pha1FIM2FzakxWN21mU0tSUFpwaVEzNlpzaWRwQXZr?=
 =?utf-8?Q?iauXz+suXqGZXdCvj5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b832cd21-b4cb-41a9-f06e-08dedb86c9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 17:48:28.7757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1g0QdC5LWmsycd1FhjOUaxuUgWNn8luggDHjNzT+cz+7gzFSBpYO8POfihxCJqfsy2Kiwr6nydizbAczPUuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVs
eSAzLCAyMDI2IDI6NDEgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTmF0YWxpZSBWb2NrIDxu
YXRhbGllLnZvY2tAZ214LmRlPjsgU2hldGFpYSwNCj4gQW1pciA8QW1pci5TaGV0YWlhQGFtZC5j
b20+OyBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPjsNCj4gTGltb25jaWVsbG8sIE1h
cmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgVHZydGtvIFVyc3VsaW4NCj4gPHR1cnN1
bGluQHVyc3VsaW4ubmV0PjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
PjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IEhlLCBTaXdlaSA8U2l3ZWku
SGVAYW1kLmNvbT47IFlhbmcsIFBoaWxpcA0KPiA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEpvc2hp
LCBNdWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMi8x
NF0gZHJtL2FtZGdwdS9paDcuMDogVXNlIE1NSU8gQUNLIGluc3RlYWQgb2YNCj4gZG9vcmJlbGwg
Zm9yIHJldHJ5IENBTSBvbiBJSCA3LjANCj4NCj4gT24gMjAyNi4gasO6bGl1cyAzLiwgcMOpbnRl
ayAxODozMToxMiBrw7Z6w6lwLWV1csOzcGFpIG55w6FyaSBpZMWRIEpvc2hpLCBNdWt1bA0KPiB3
cm90ZToNCj4gPiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPiA+IFRpbXVyIEtyaXN0w7NmDQo+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIEp1bHkgMSwgMjAyNiAxMjoxNyBQTQ0KPiA+ID4gVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPiA+IDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBOYXRhbGllIFZvY2sgPG5hdGFsaWUudm9ja0BnbXguZGU+Ow0KPiA+
ID4gU2hldGFpYSwgQW1pciA8QW1pci5TaGV0YWlhQGFtZC5jb20+OyBNYXJlayBPbMWhw6FrDQo+
ID4gPiA8bWFyYWVvQGdtYWlsLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT47DQo+ID4gPiBUdnJ0a28gVXJzdWxpbiA8dHVyc3VsaW5AdXJzdWxpbi5u
ZXQ+OyBLdWVobGluZywgRmVsaXgNCj4gPiA+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGF6
YXIsIExpam8NCj4gIDxMaWpvLkxhemFyQGFtZC5jb20+OyBIZSwgU2l3ZWkgPFNpd2VpLkhlQGFt
ZC5jb20+OyBZYW5nLCBQaGlsaXANCj4gPiA+IDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgSm9zaGks
IE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiA+ID4gQ2M6IFRpbXVyIEtyaXN0w7NmIDx0
aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxMi8xNF0gZHJt
L2FtZGdwdS9paDcuMDogVXNlIE1NSU8gQUNLIGluc3RlYWQgb2YNCj4gPiA+IGRvb3JiZWxsIGZv
ciByZXRyeSBDQU0gb24gSUggNy4wDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGUgZG9v
cmJlbGwgaXMgbm90IHdvcmtpbmcgb24gTmF2aSA0OC4NCj4gPiA+IFVzZSB0aGUgSUhfUkVUUllf
Q0FNX0FDSyByZWdpc3RlciBqdXN0IGxpa2Ugb24gTmF2aSAzeC4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdt
YWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9paF92N18wLmMgfCAxNyArLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4NCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjdfMC5j
DQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2loX3Y3XzAuYw0KPiA+ID4gaW5k
ZXggZjFkZTY0NTBhMzFkLi4yOTEzMjZkMmVlOGIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9paF92N18wLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2loX3Y3XzAuYw0KPiA+ID4gQEAgLTI3OSwxOSArMjc5LDkgQEAgc3RhdGlj
IGludCBpaF92N18wX2VuYWJsZV9yaW5nKHN0cnVjdA0KPiA+ID4gYW1kZ3B1X2RldmljZSAqYWRl
diwNCj4gPiA+DQo+ID4gPiAgICAgICByZXR1cm4gMDsNCj4gPiA+DQo+ID4gPiAgfQ0KPiA+ID4N
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gLXN0YXRpYyB1aW50MzJfdCBpaF92N18wX3NldHVwX3JldHJ5
X2Rvb3JiZWxsKHUzMiBkb29yYmVsbF9pbmRleCkgLXsNCj4gPiA+IC0gICAgIHUzMiB2YWwgPSAw
Ow0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgdmFsID0gUkVHX1NFVF9GSUVMRCh2YWwsIElIX0RPT1JC
RUxMX1JQVFIsIE9GRlNFVCwNCj4gPiA+IGRvb3JiZWxsX2luZGV4KTsNCj4gPiA+IC0gICAgIHZh
bCA9IFJFR19TRVRfRklFTEQodmFsLCBJSF9ET09SQkVMTF9SUFRSLCBFTkFCTEUsIDEpOw0KPiA+
ID4gLQ0KPiA+ID4gLSAgICAgcmV0dXJuIHZhbDsNCj4gPiA+IC19DQo+ID4gPiAtDQo+ID4gPg0K
PiA+ID4gIHN0YXRpYyB2b2lkIGloX3Y3XzBfcmV0cnlfY2FtX2FjayhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdTMyDQo+ID4gPg0KPiA+ID4gY2FtX2luZGV4KSAgew0KPiA+ID4gLSAgICAg
V0RPT1JCRUxMMzIoYWRldi0+aXJxLnJldHJ5X2NhbV9kb29yYmVsbF9pbmRleCwgY2FtX2luZGV4
KTsNCj4gPiA+ICsgICAgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAsIHJlZ0lIX1JFVFJZX0NBTV9B
Q0ssIGNhbV9pbmRleCk7DQo+ID4gPg0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPg0KPiA+ID4NCj4g
PiA+ICAjZGVmaW5lIHJlZ0lIX1JJTkcxX0NMSUVOVF9DRkdfSU5ERVhfVjdfMSAgICAgICAgICAg
ICAweDEyMg0KPiA+ID4NCj4gPiA+IEBAIC00MDEsMTEgKzM5MSw2IEBAIHN0YXRpYyBpbnQgaWhf
djdfMF9pcnFfaW5pdChzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UNCj4gPiA+ICphZGV2KQ0K
PiA+ID4NCj4gPiA+ICAgICAgIHBjaV9zZXRfbWFzdGVyKGFkZXYtPnBkZXYpOw0KPiA+ID4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4gICAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE9TU1NZ
U19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDcsDQo+ID4gPiAxLCAwKSkNCj4gPiA+DQo+ID4gPiB7
DQo+ID4NCj4gPg0KPiA+IFdlIGFyZSByZS1wdXJwb3NpbmcgdGhlIElIIDcuMCBmaWxlIGZvciBJ
SCB2Ny4xIHNpbmNlIG1vc3Qgb2YgaXQgaXMgc2FtZS4NCj4gPiBUaGUgY29kZSBiZWluZyByZW1v
dmVkIGJlbG93IGlzIGZvciBJSCA3LjEgYW5kIG5vdCA3LjAuDQo+ID4gVXNpbmcgZG9vcmJlbGxz
IGZvciBhY2tpbmcgSU5UIENBTSB3b3JrcyBjb21wbGV0ZWx5IGZpbmUgZm9yIEdGWCAxMi4xDQo+
ID4gYW5kIElIIDcuMS4NCj4gPiBJIHdvdWxkIHJlY29tbWVuZCB0byBkcm9wIHRoaXMgcGF0Y2gu
DQo+ID4NCj4NCj4gSGVsbG8gTXVrdWwsDQo+DQo+IFVuZm9ydHVuYXRlbHkgSSBjb3VsZG4ndCBm
aWd1cmUgb3V0IGhvdyB0byBnZXQgdGhlIGRvb3JiZWxsIHdvcmtpbmcgb24gTmF2aSA0OA0KPiBh
bmQgaW4gdGhlIHByZXZpb3VzIHRocmVhZCBBbWlyIHNhaWQgdGhhdCBpdCBhbHNvIGRpZG4ndCB3
b3JrIGZvciBoaW0sIGFuZCB0aGF0J3MNCj4gd2h5IEkgZGVjaWRlZCB0byB0cnkgdGhlIE1NSU8g
cmVnaXN0ZXIuDQo+DQo+IElmIHlvdSBoYXZlIGFuIGlkZWEgaG93IHRvIGdldCB0aGUgZG9vcmJl
bGwgdG8gd29yayBvbiBOYXZpIDQ4LCBJJ20gaGFwcHkgdG8NCj4gdHJ5IHlvdXIgc3VnZ2VzdGlv
bi4NCj4NCj4gSWRlYWxseSBJJ2QgcHJlZmVyIGEgc29sdXRpb24gaGVyZSB0aGF0IHdvcmtzIG9u
IGJvdGggTmF2aSA0OCBhbmQgR0ZYMTIuMSB0bw0KPiBrZWVwIHRoZSBjb2RlIG1haW50YWluYWJs
ZS4gSWYgaXQncyBub3QgcG9zc2libGUgdGhlbiB3ZSBjYW4gYWxzbyBoYXZlIGEgc2xpZ2h0bHkN
Cj4gZGlmZmVyZW50IGNvZGUgcGF0aCBmb3IgdGhlIHR3byBkaWZmZXJlbnQgSUggdmVyc2lvbnMg
aGVyZS4NCj4NCg0KSGkgVGltdXIsDQoNCkFzIEkgaGFkIG1lbnRpb25lZCBvbiB0aGUgb3RoZXIg
cGF0Y2gsIHdlIG5lZWQgdG8gZW5hYmxlIHRoZSBOQklPIHBhdGggdG8gcm91dGUNCnRoZSBkb29y
YmVsbCBjb3JyZWN0bHkuIFRoYXTigJlzIHRoZSByZWFzb24gd3kgeW91ciBkb29yYmVsbHMgYXJl
IG5vdCB3b3JraW5nIG9uDQpOYXZpM3ggYW5kIE5hdmk0eC4NCg0KSSBhbSB3b3JraW5nIG9uIHRo
ZSBjaGFuZ2UgZm9yIE5hdmk0eCBmaXJzdCBhbmQgd2lsbCBzZW5kIGl0IG91dCB0byB5b3Ugc29v
biBvbmUgSSBoYXZlIHZlcmlmaWVkIGl0IG9uDQpteSBlbmQuDQoNClJlZ2FyZHMsDQpNdWt1bA0K
DQoNCj4gVGhhbmtzICYgYmVzdCByZWdhcmRzLA0KPiBUaW11cg0KPg0KPiA+DQo+ID4NCj4gPiA+
IC0gICAgICAgICAgICAgLyogQWxsb2NhdGUgdGhlIGRvb3JiZWxsIGZvciBJSCBSZXRyeSBDQU0g
Ki8NCj4gPiA+IC0gICAgICAgICAgICAgYWRldi0+aXJxLnJldHJ5X2NhbV9kb29yYmVsbF9pbmRl
eCA9IChhZGV2LQ0KPiA+ID4NCj4gPiA+ID5kb29yYmVsbF9pbmRleC5paCArIDIpIDw8IDE7DQo+
ID4gPg0KPiA+ID4gLSAgICAgICAgICAgICBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCByZWdJSF9E
T09SQkVMTF9SRVRSWV9DQU0sDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
aF92N18wX3NldHVwX3JldHJ5X2Rvb3JiZWxsKGFkZXYtDQo+ID4gPg0KPiA+ID4gPmlycS5yZXRy
eV9jYW1fZG9vcmJlbGxfaW5kZXgpKTsNCj4gPiA+DQo+ID4gPiAtDQo+ID4gPg0KPiA+ID4gICAg
ICAgICAgICAgICAvKiBFbmFibGUgSUggUmV0cnkgQ0FNICovDQo+ID4gPiAgICAgICAgICAgICAg
IHRtcCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsDQo+ID4gPg0KPiA+ID4gcmVnSUhfUkVUUllf
SU5UX0NBTV9DTlRMKTsNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRf
RklFTEQodG1wLCBJSF9SRVRSWV9JTlRfQ0FNX0NOVEwsDQo+ID4gPg0KPiA+ID4gRU5BQkxFLCAx
KTsNCj4gPiA+IC0tDQo+ID4gPiAyLjU0LjANCj4gPg0KPiA+DQo+DQo+DQo+DQoNCg==
