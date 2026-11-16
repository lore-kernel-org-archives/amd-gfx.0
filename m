Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB650606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BAttwT9e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFA410EA6A;
	Mon, 16 Nov 2026 21:01:01 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25AF510EA6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 21:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5QdoHvHKaurJ9Ie7RrfHsvvaK6pyzIj155GRBKM9OKliqP4s2H5MJOgKnoRdfgAl/pPUUySO3gtMYgqCJ+YpjotBu4vrc2bg4EEjR/qoah1NDvdSXO4Vanlur7qRv0U6cGeerhAErBKxt7ZOj9GbhPtzv4PpzjLJhkSj1p4OMu0BDkyCWBAqze6qj9ejeoCQGwVg+lqopCKJpPWHdyu8aKY1K7keLKQ0hQCt5XrhVEwN009+PtvSFI8b0lY44vuRAwd02eQUUx2yTCPKprf5w4cEouFZ4GMrE9uUMdNjOZfImL5M/ZUGL6lcEPphkcjccYKXHk2s+l/3/8v7hcyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYP6kICQnNin3IO0yrVazznr/1mUdtZArGMpFgmOBWc=;
 b=xJNFHSXhwvmFT4Oi00nDf+xa02Ty1bunttUZPizs6mimrayVxotQMrD12eZGgnH3k9Tr9qbTF0PVH31WRym6fq4Ud63tXW7BGm5p/gWztPF7ljOcHSD9IQqPmlRBXAP5x0KI5Bs/sfeQ6TMifMX5YB3KzsEeVF1onjjFvQNJyNAqfApB1YFbKwTu0dxWhwcyLr8ekLFnGhhEptR0QQRqzN6hWP/GsLPEfyogJnaRb0YnR34s4OZjpMwaOn8Gajm7WA2uNaFlPVYWP5mZHdqQuTvLnlYo59fSbvxO89RPp5PEuQNi+LAabTsNY48oELSiIqEKEI201g7Gb0CHLw8dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYP6kICQnNin3IO0yrVazznr/1mUdtZArGMpFgmOBWc=;
 b=BAttwT9eu1Sz5ypzJhYjfWG2d6QJeYVgUTp297q71pMpsC+CKPuJ4ZU3DOoe4VTG3J3Vt33I8/UC7AnXMkyzDqKRq/ruFAYzZ0Qr6f423TMyCz+HL8OY98G5fJhbE165W+yJs+Vxzon6uCU0w8ZaZ7v91IbEy17/mPbquwCmA18=
Received: from SA6PR12MB999202.namprd12.prod.outlook.com
 (2603:10b6:806:450::12) by SA3PR12MB138305.namprd12.prod.outlook.com
 (2603:10b6:806:517::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:59:51 +0000
Received: from SA6PR12MB999202.namprd12.prod.outlook.com
 ([fe80::547:be9f:5668:4a5c]) by SA6PR12MB999202.namprd12.prod.outlook.com
 ([fe80::547:be9f:5668:4a5c%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:59:51 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
Thread-Topic: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX
 12.1 helpers
Thread-Index: AQHdc39Nh4SeQrHoIEC2S1T8tSXKbbcwdsQAgAB85WA=
Date: Mon, 16 Nov 2026 20:59:51 +0000
Message-ID: <SA6PR12MB99920206F3B8C12E686FB2E921F17C2@SA6PR12MB999202.namprd12.prod.outlook.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-4-Zhigang.Luo@amd.com>
 <d9513d3f-ad10-4c68-8897-2411a8b3dcee@amd.com>
In-Reply-To: <d9513d3f-ad10-4c68-8897-2411a8b3dcee@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T17:10:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR12MB999202:EE_|SA3PR12MB138305:EE_
x-ms-office365-filtering-correlation-id: f2bf27b1-7f3f-4bf8-c87e-08df44248ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: r5Aj07m/Y/jrMIO9l7JgVAPQbIhFmudP8hMq0mQSLp2wI79jE5izN2LCx6e/WhDpmEvKz1fLoKmR56FNoly9Tn+jibu5lzEds0v/j3hEzpDvScgy54hGUemqT+5SyVM/2Roojzye/ricGKumeKAQxgb9rmCzlUE/2/p3FinelXykR7MFLPs10/TjJ67IrXqQfHB5kLRRHx543skxw8lSvTgeVaQstynUA9wwbux3UGnNr8QydD/gaLM8LBqxWEZzlfnQjk1GAKVo03GMU1eNpQ9Mx1m9FfnFpTwH3rMiI3s/c8VpDVvQl4BWHO3yOVVuNDspdk0MbPidSxzv1CC0dOtyEq8uwvCa82xECT1tdKbVVj+gu7vMVZ6Zx2rgxG5xuZrbfFIKQZP9pQmp8IOAYpiUkhZuDQ0somSyLOukHJZ/EedWYbgd2tjL9QKQ9ZQv0LqRD3DFROA9pP8fJF9kPT+p53Pp0xX4hICaHEKbLJtP+tXdkZYLg0Qy56ZOHjsk5O9ARUnbE/46x36L/E3h/hQbq5oxOzMSjRsb94YSUzjU6t8f06xLRpFB6Ycu7iMCK08sqvum003WcfBI9MWgfuzFDfvS5N5AH++NAGemcwX66TDkAET9ilb6DN+KnRenVXYBZPZwhyeBqvftAs7R5XRDfTKU7qSwXnzZVH4VAANXBFj/xrr2Vn8l5bfpcz4z4+Pva+rjlHbEUoXZGywsS6lxLkBjDBB0f15ojU7pIUU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR12MB999202.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXd6VW9aLzlrSzFoS1EyeUNuanVsbXNON0xJR3FWQ1lzRzdtZWI0c2FJaDNn?=
 =?utf-8?B?Z0tJQklrampEa1lNWnB4NWlCSEZCTVFJYmFac1djVnlPQzdwbXZYNWVsbG9T?=
 =?utf-8?B?WlJGbGRHUlRMVUtoUkx0SGpSZFUwWmoza1k2cUZBaXZENGJVRHozNGUvZkY0?=
 =?utf-8?B?SnA2YkV5bEJiOTRNVmlPWE5udG1sNWYzZDF0SUx3WU1Rb1JKNWZCVG9GL3N0?=
 =?utf-8?B?dEdIVWNpWDVXUllYK25xU21oZlpWbWJhUUtqbFhHUkF3RHJad1hnN1N5c25B?=
 =?utf-8?B?YzVHL1dzN2JzY2QvYlhJVGVWRnNnV3o0eDI0QmlSSlBVUXBCTFpIWkhJZitk?=
 =?utf-8?B?c0pYRTQyQ0xmYU5mOElyN0xQdmR1bEV3ODRBRnZWLzVRR0RqR29Qb0FhVUpK?=
 =?utf-8?B?b0ViQ1FZRkFBVVVKVS9yeHNKUVRxNVRNSmhVZmg0REpwdk93Y2dUbGRQaGUr?=
 =?utf-8?B?czlaMFdkYm85WGQ5NG52VkdYdzlyRXBSQkw2Z2hMa3MvLytkVm11YWgwcG1a?=
 =?utf-8?B?YUZ0SlhQZEhrcmR0UXYvZ0YyY3FvWExNQ1dQU0JwdnplZTV2UW54R3V6dDB4?=
 =?utf-8?B?OEMvZVFxWmxyOVZOTEdBSVpxVlBrWmpISWNQQ2M5a2FML3pTYlVOV3pFbFFW?=
 =?utf-8?B?Nks0MjgzTmFaeWZRY2NZWHVUSnFLcTVaY1Foell4WGJBVGllMjFNa3dEby8y?=
 =?utf-8?B?U2VDQ2RNL3hjV3FOMEJwbDZMSnJwSlZDQ2haUDIyYjNMRWU1THJRTG1TUklo?=
 =?utf-8?B?RG5keS9PbXJYNFRzRExhNlAwZUl3cndBd0dZT2JEZVB0TU1sRHZ0bThYRkxE?=
 =?utf-8?B?eE5LSGxQUzNzcW9xelppVzUwUjkzNVd4VFJmcllVamRPVVU3VTZET3pPUit6?=
 =?utf-8?B?VkJLR0tCMERBZXlEbmZrUnQ0d0RBbVBUcTFsR2ZlWGdYK0Rabyt2SnJ3YTV0?=
 =?utf-8?B?RGw3bUhHcUkvOFNwQ3NsOXRVdFliR2IrcU8yZGp3a1NTT3RqY0ExUGQrbVRi?=
 =?utf-8?B?NjBaVi9lSGFoSlBOc3p6TGFHclA5b2JWM0NTTUNPZHprZzFVNzdrcDIwVDQz?=
 =?utf-8?B?L2ZIS3FuYnZPVmRVUjdmcGhOYzF2UlNJSXlPd0pnd1d0dys1TFFCUlFpZUFS?=
 =?utf-8?B?ejcrZTIzdVUzaEhmVnhmR3VhNTB3V3pWeC9SWXRjellkb2c2cFRoNkhtUk05?=
 =?utf-8?B?V2dEZXF2TnF1Wng0T0krMFhUclIyb3NHNzhjbkJwbWhPWXgwTGZzUUhCREEy?=
 =?utf-8?B?VjdXN08zNXkwZXp4cVFjRTdqTmhNa052Q3JlVTI5N0JsWkhVUys0R1FOVVI4?=
 =?utf-8?B?S2lwdTVxSTVycWk2YTIrbzZYNVFTUlA1WWJoeFhPQmdqZUFrM0VwaHRrbEtU?=
 =?utf-8?B?dFhGQStGc2MrMDF2cmt2cTlQM3A2MHB4NnFoSTZTenlScWk0b3hpV3VqSElS?=
 =?utf-8?B?NklVMXZzeGd0eXFrUE5uN1JqZ3JPY3FHSUVGVjN6VUN5R2tsam10R01odkZP?=
 =?utf-8?B?NDFYMUYrYm52cWZSOUY3MG1ZclZiMWJuRm43d2xLclFpWkFiQmFVN1pQYzln?=
 =?utf-8?B?TG1CUmpoL21vSjhzSlk4MjlDQnQ1elptN2lKRDRZS2FPZ2JQdWJmMVk2eDBY?=
 =?utf-8?B?UW5QTkl0ckkxV0JTWnlNRzBSNkI3ZXpKc1NaUUVWRlhYTmpFbHJkWDJIcjVy?=
 =?utf-8?B?SHRCR25USVNJT2lBODZOREdMRUg4UjZWQVJmdmQyZWEzR096Nnk2SG1xbWQ4?=
 =?utf-8?B?ZTVIVHBhZG5PK2NpNHBZNzJvMGpadHRiaGlKTnJsQ1ZBMElPRDMyTk9NNXpX?=
 =?utf-8?B?cnBLVmpONVFtL2tyTENhOXdJSk1VN2t2RkRzRENBb2pMMzI2cEU3WXRZdTdB?=
 =?utf-8?B?YVFVRHYzU0NXenVOMmlhM3VYc0xZblNJa1k1dmtKNjNuNFZOZ1lUT0tKQlBm?=
 =?utf-8?B?MnFFT24rRTJaWDRJSndjZTZTWEQzMldEb29LNU1ScUU3Sjd4MlZCSS81Rmpv?=
 =?utf-8?B?TjB3bDJ0WFFjWEtDelFBUkRDRS9vb1RmMmgya3FRS093ZE8rNVZTbmVhOHdn?=
 =?utf-8?B?aDYxb0lNTWVwZE02amxFRzBpYVQrZGVmdGhnRkRrZnViRDEyYUt6SUpZWXhl?=
 =?utf-8?B?VkNVUWJqUzhOeHRtSU1IYTF6d1hJWmNibGR6TGRXYjlWbVdtTDlmeXRqREJH?=
 =?utf-8?B?OXJuVGppM0xLZDRsRHNEelE4NWdwMWg1SWhzSHkvZ05mbUVBWmw0STdZZ2Rs?=
 =?utf-8?B?UldKdXgxVDJJaTcxTHlSdVZPTEFVc2lCdUZIc0VVNEJtR1M0SFJlMlRRNElv?=
 =?utf-8?Q?3N5qkt9GOzpFd8fbBC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR12MB999202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bf27b1-7f3f-4bf8-c87e-08df44248ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 20:59:51.5215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qeapJU3Ejj/EO8Jdb/fmIemVwYfcVLIfze9BwUwbukUkYJ172dOePP/j/OzMP8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB138305
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIFlv
dSB3ZXJlIHJpZ2h0IHRoYXQgUFJUIGhhcyBubyBCTyBhbmQgbmVlZHMgYSBjaGVjay4NCg0KdjMg
Z2F0ZXMgdGhlIG5ldyBTWVNURU0gYml0IG9uIEFNREdQVV9QVEVfVkFMSUQgaW4gYWxsIHRocmVl
IHBsYWNlczoNCg0KLSBnbWNfdjEyXzFfZ2V0X3ZtX3BkZSgpOiBzZXQgUyBvbmx5IGlmIFZBTElE
IGlzIGFscmVhZHkgc2V0LiBUaGUgY2hlY2sgcnVucyBiZWZvcmUgdGhlIGFkZHJlc3MtbWFzayBj
aGVjayBjYW4gY2xlYXIgVkFMSUQuDQotIGdtY192MTJfMV9nZXRfdm1fcHRlKCksIFZSQU0gQk8g
YnJhbmNoOiBzYW1lIGNoZWNrIGJlZm9yZSB0aGUgbWVtX3R5cGUgdGVzdC4NCi0gZ21jX3YxMl8x
X2dldF92bV9wdGUoKSwgTlVMTC1CTyBlbHNlIChTVk0pOiBzYW1lIGNoZWNrLg0KDQpJIGNob3Nl
IFZBTElEIHJhdGhlciB0aGFuIHRlc3RpbmcgQU1ER1BVX1ZNX1BBR0VfUFJUIGluIHZtX2ZsYWdz
LiBnbWNfdjEyXzFfZ2V0X3ZtX3BkZSgpIGRvZXMgbm90IHJlY2VpdmUgdm1fZmxhZ3MsIHNvIFZB
TElEIGlzIHRoZSBvbmx5IGZsYWcgdGhhdCByZWFjaGVzIGJvdGggaGVscGVycy4gQSBQUlQgdXBk
YXRlIHJlYWNoZXMgZ2V0X3ZtX3B0ZSgpIHdpdGggVkFMSUQgY2xlYXIgYW5kIG5vIEJPLCBzbyBp
dCBnZXRzIG5vIFMuIEEgY2xlYXJlZCBwYWdlLWRpcmVjdG9yeSBlbnRyeSBhbmQgYSAyIE1CIE5Q
QSBsZWFmIGFsc28gaGF2ZSBWQUxJRCBjbGVhciBieSB0aGUgdGltZSBnZXRfdm1fcGRlKCkgcnVu
cywgc28gdGhleSBrZWVwIFMgY2xlYXIgdG9vLiBTVk0gc3RpbGwgZ2V0cyBTIGJlY2F1c2Ugc3Zt
X3JhbmdlX2dldF9wdGVfZmxhZ3MoKSBzZXRzIFZBTElEIGJlZm9yZSBpdCBjYWxscyBhbWRncHVf
Z21jX2dldF92bV9wdGUoKS4gUERCMCBzZXRzIFZBTElEIGJlZm9yZSBjYWxsaW5nIGdldF92bV9w
ZGUoKSwgc28gaXRzIGVudHJpZXMga2VlcCBTLg0KDQpUaGFua3MsDQpaaGlnYW5nDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNiwgMjAyNiA0
OjQzIEFNDQo+IFRvOiBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggNC83XSBkcm0vYW1kZ3B1OiBzZXQgdGhlIEErQSBWRiBTWVNURU0gYml0IGluIHRoZSBH
RlgNCj4gMTIuMSBoZWxwZXJzDQo+DQo+DQo+DQo+IE9uIDExLzEzLzI2IDE1OjU2LCBaaGlnYW5n
IEx1byB3cm90ZToNCj4gPiBnbWNfdjEyXzFfZ2V0X3ZtX3BkZSgpIGNvbnZlcnRzIGEgVlJBTSBN
QyBhZGRyZXNzIHRvIGEgcGh5c2ljYWwNCj4gPiBhZGRyZXNzIGFuZCBza2lwcyB0aGF0IGNvbnZl
cnNpb24gd2hlbiBBTURHUFVfUFRFX1NZU1RFTSBpcyBhbHJlYWR5DQo+ID4gc2V0LiBTZXQgdGhl
IGJpdCBhZnRlciB0aGUgdHJhbnNsYXRpb24gc28gdGhlIGFkZHJlc3Mgc3RheXMgcGh5c2ljYWwu
DQo+ID4NCj4gPiBnbWNfdjEyXzFfZ2V0X3ZtX3B0ZSgpIHNldHMgdGhlIGJpdCBmb3IgYSBWUkFN
IGJ1ZmZlciBvYmplY3QuIFNWTQ0KPiA+IGNhbGxzIGl0IHdpdGggYSBOVUxMIGJ1ZmZlciBvYmpl
Y3QsIGFuZCBzdm1fcmFuZ2VfZ2V0X3B0ZV9mbGFncygpIHNldHMNCj4gPiB0aGUgYml0IG9ubHkg
Zm9yIHN5c3RlbSBtZW1vcnksIHNvIHRoZSBOVUxMIGNhc2Ugc2V0cyBpdCBmb3IgU1BNIFZSQU0u
DQo+ID4gTlBBIG1hcHBpbmdzIGFyZSBsZWZ0IHVuY2hhbmdlZC4NCj4gPg0KPiA+IHYyOg0KPiA+
IC0gU2V0IHRoZSBiaXQgZm9yIGEgVlJBTSBCTyBpbnNpZGUgaWYgKGJvKSwgYW5kIGZvciB0aGUg
U1ZNIE5VTEwgQk8NCj4gPiAgIGluIHRoZSBlbHNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WmhpZ2FuZyBMdW8gPHpoaWdhbmcubHVvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMS5jIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjEyXzEuYw0KPiA+IGluZGV4IDc2MzkxZmNhNmM2Mi4uN2FjMGQ5
YzZmMjgwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTJfMS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8xLmMN
Cj4gPiBAQCAtNTg2LDYgKzU4NiwxMiBAQCBzdGF0aWMgdm9pZCBnbWNfdjEyXzFfZ2V0X3ZtX3Bk
ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGxldmVsLA0KPiA+ICAgICAgICAg
ICAgICphZGRyID0gYWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0ICsgKmFkZHIgLQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgYWRldi0+Z21jLnZyYW1fc3RhcnQ7DQo+ID4NCj4gPiAr
ICAgLyogU1BNIFZSQU0gaXMgcmVhY2hlZCBhdCBhIHN5c3RlbSBwaHlzaWNhbCBhZGRyZXNzLiBT
ZXQgUyBhZnRlciB0aGUNCj4gPiArICAgICogdHJhbnNsYXRpb24gYWJvdmUgc28gdGhhdCB0cmFu
c2xhdGlvbiBpcyBub3Qgc2tpcHBlZC4NCj4gPiArICAgICovDQo+ID4gKyAgIGlmIChhbWRncHVf
dmlydF92cmFtX2lzX3NwbShhZGV2KSkNCj4gPiArICAgICAgICAgICAqZmxhZ3MgfD0gQU1ER1BV
X1BURV9TWVNURU07DQo+ID4gKw0KPiA+ICAgICBpZiAoKmFkZHIgJiB+YWRldi0+Z21jLnB0ZV9h
ZGRyX21hc2spIHsNCj4gPiAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIkludmFsaWQg
UERFIGFkZHJlc3M6ICVsbHhcbiIsICphZGRyKTsNCj4gPiAgICAgICAgICAgICAqYWRkciA9IDA7
DQo+ID4gQEAgLTc1OCw2ICs3NjQsMTAgQEAgc3RhdGljIHZvaWQgZ21jX3YxMl8xX2dldF92bV9w
dGUoc3RydWN0DQo+ID4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPg0KPiA+ICAgICBpZiAoYm8p
IHsNCj4gPiAgICAgICAgICAgICBtZW0gPSBiby0+dGJvLnJlc291cmNlOw0KPiA+ICsgICAgICAg
ICAgIGlmIChhbWRncHVfdmlydF92cmFtX2lzX3NwbShhZGV2KSAmJg0KPiA+ICsgICAgICAgICAg
ICAgICBtZW0gJiYgbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVlJBTSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICpmbGFncyB8PSBBTURHUFVfUFRFX1NZU1RFTTsNCj4gPiArDQo+ID4gICAgICAg
ICAgICAgaWYgKG1lbSAmJiBtZW0tPm1lbV90eXBlID09IEFNREdQVV9QTF9OUEEpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgIGRldl9kYmcoYWRldi0+ZGV2LA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiU2V0dGluZyBQVEUgZm9yIE5QQSBCTywgbWVtLT50eXBlOiAlZCwgbWVt
LQ0KPiA+c3RhcnQ6ICVseCwNCj4gPiBtZW0tPnNpemU6ICV1LCBjdXJfZmxhZ3M6ICVsbHhcbiIs
IEBAIC03NjYsNiArNzc2LDkgQEAgc3RhdGljIHZvaWQNCj4gZ21jX3YxMl8xX2dldF92bV9wdGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgfSBlbHNlIGlmICgq
ZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBnbWNf
djEyXzFfZ2V0X2NvaGVyZW5jZV9mbGFncyhhZGV2LCBibywgZmxhZ3MpOw0KPiA+ICAgICAgICAg
ICAgIH0NCj4gPiArICAgfSBlbHNlIGlmIChhbWRncHVfdmlydF92cmFtX2lzX3NwbShhZGV2KSkg
ew0KPiA+ICsgICAgICAgICAgIC8qIFNWTSBoYXMgbm8gQk8uIFN5c3RlbSBtZW1vcnkgYWxyZWFk
eSBoYXMgUy4gVlJBTSBkb2VzDQo+IG5vdC4gKi8NCj4gPiArICAgICAgICAgICAqZmxhZ3MgfD0g
QU1ER1BVX1BURV9TWVNURU07DQo+DQo+IEJvdGggU1ZNIGFuZCBQUlQgZG9lc24ndCB1c2UgYSBC
Tywgc28gY291bGQgYmUgdGhhdCB0aGlzIGNhdXNlcyBwcm9ibGVtcw0KPiB3aXRoIFBSVC4NCj4N
Cj4gUGxlYXNlIGRvdWJsZSBjaGVjayB0aGUgVk0gcHJvZ3JhbW1pbmcgZ3VpZGUgdGhhdCB0aGlz
IGlzIG9rLCBpZiBub3QgY2hhbmdlDQo+IHRoZSBjb2RlIHNvIHRoYXQgUFJUIGlzIGV4Y2x1ZGVk
Lg0KPg0KPiBXaXRoIHRoYXQgZG9uZSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+
ID4gICAgIH0NCj4gPiAgfQ0KPiA+DQoNCg==
