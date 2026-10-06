Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22245CA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 13:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B029610E32B;
	Tue,  6 Oct 2026 13:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nikIChBh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F4410E379
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 13:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCQL2v2a6fj4XI7KEQBr/FKgk0vNBKdKFGJpoGUbwUVChyRu4Xg1KCviSATisfsCyQkBe88GV/oJ1GiBE5pna02BJJvHCp8+W2Q+wfd/Jpftkt0QT/t5O6bynm5EHgYNgKbG6+iLr22DJlIh4oTbuN2zm+tUxU5S61HOz1olrs3NHgtR5UAslDFQhwmx7nsq32XLCWmsCTKuHkM9i96/ANr94KE7c0o1hnv1NFbMzrWCAoWDReOA26Vl6CpuLIKzv/EdTDbiMHBtRO/q2PrKB9YGBL0wMt68no+set5MkbLxiVaKl4EDCyVkHem0SlKVpnesmcBybzRX0cYeQbCIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQaW9/y8B8UD3JHh5v/1BHJ9IxT9bABqZPqVn5UYyak=;
 b=ZU4HtS8+xDnMXrPGD1O7AkIabDQRvAfMWEKI+aC2xkV65j0hpMMHWkjJ9KF6mpjgzfxEOaneK0F4RCAVrtqgKwANd+6D20Vczx9bUTYqJr9JdoO978V7yD71vEd6RHeVik9nGdOgsXqz+Ec2paO/XTEhwrcLOeyadDMk+yoRcQsb3E+wbAI49R/YArgSuExcA6YzyNwxVRZNh41kJgwwP8LAZhHHeQl1N9JsFn1xCgNcVV3RRNiNcgHYW/WAomKohxVKqoTCoICi0/irv/8rsyR7HzZUCHDCqKAD8yxIXRObMkW0lE5NTp/bvZPezBiE7wB4jclO/XW2aZNKjrvfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQaW9/y8B8UD3JHh5v/1BHJ9IxT9bABqZPqVn5UYyak=;
 b=nikIChBhkTotH63jDQddwFp4QMInOMx1RYWiU8TwxaY5Ym8ms9QxwWYDBjpYLorE5Ro0odJaEYaTPiHukmxBdxBfxVY+6tMRpB9Cq1TKXkKVFKqBtnh4GWg5cKazOdEbyFpDArlorIGQfC+5vNGUjySKvErHJOVp2TYUB9CyiBM=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 6 Oct
 2026 13:42:27 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:42:23 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Mani, Bincy" <Bincy.Mani@amd.com>, Cursor <cursoragent@cursor.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't drop the TLB flush fence in the GEM VA
 ioctl path
Thread-Topic: [PATCH] drm/amdgpu: don't drop the TLB flush fence in the GEM VA
 ioctl path
Thread-Index: AQHdVRKYShdX4JB7uUqm7XlBuJMP6rbwHhCAgABoQaA=
Date: Tue, 6 Oct 2026 13:42:23 +0000
Message-ID: <SA0PR12MB4397BD62ADF80FD8F8C6CF1195952@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20261005214318.2272476-1-David.YatSin@amd.com>
 <04899fe2-1b3c-43f2-a130-9c71b56715c1@amd.com>
In-Reply-To: <04899fe2-1b3c-43f2-a130-9c71b56715c1@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T13:40:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|IA1PR12MB7543:EE_
x-ms-office365-filtering-correlation-id: 6f285f54-352d-46ed-a4f4-08df23afa6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: QpWifUfD3oBlktyE22E8j8t7X2dBOLQCB59YhoKHVpkW45kklgAmeaRRgb5pAr7tEs1ziUTCm7j/jiwaOwqvoh8pH38Wo7wzhK57HFIE8NYLqpoh639zmcMjEkPtiJC6zy/GWc9UeHLxTMCMmtB+PgW/5xfXicWRLDnZSn4hkkEKMaVe/2BiGXL94trljdhxrMOgWgApXJfOEScbHJgiM7oq8BuWNSDyfOsn8PdvlsbDPIqtdDr4cRrACgGRmpW3quwRjamYmPCcuaSFgLtC+MVwyKs3Cp7YTusSZcN+uuDqEi4OAfAG5bm3JAu7vKN8QM8puZCL7Wc107KhKGTEa1UrmNF4iaz6YeiS661VzkR3OniLnhv4F+FVcFBGNDWbxhQ3ccKe2yUZkns3GRyKBW6ZNT919O5WM20Q4KLxec/D8S2qsLapZCN6b7DIJnTZmiJSJ5saK1a/bWP+X3m2i1xrhqPrLTFwhwEzf2XpadKcfNaiphLvwNDJUAv+8QUqge+rbPtPIC33G9khsZsxeL6SzcuXCDfACPcc/8kUMuC84rpe+EG2RTCwnWQVo/CoypOFaSX8hVtv6tw//CxwtjcqN687Zy5bIlPZ3aKPga/6IjhdfOpNlmnL6f6qFphKtQLzfejZdXW2M4bI+y46grGBUsWoSQrp8iZE45gsQOziNtrbMqYqQJuExScK80MR6DG+Hkb7u87iScqA6e/R+S/o+USJTA8KRhz+CkBizB0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0VFem11NUE2Rk55aFhoVWhhclZvS2EzbU16UnNBUEREL2ZOWXd3bDFCWHRC?=
 =?utf-8?B?T013TnVWenB3WDlENDloVG9wN2FwZ3hENVdha1creFQ2TjJjYTRBSHhyaURR?=
 =?utf-8?B?eVhpTXFnVjVocXgwOFdBazJSaHdyQ25lajRvNU9pa0F4THJobElOK3BBTXAx?=
 =?utf-8?B?UHpDb3dHdlFnUC83UkltMjhzQ21obEdzeFRFdTIyc1ZWMTFKUW80UFBxOWxJ?=
 =?utf-8?B?WXpNMWlQL1N5Vk1UKzI4NElQQ2RKZHZKczlUUEVsbHlwelpGNVhZVXRwYTRp?=
 =?utf-8?B?U2J5Rmp5NDlURUEwQ1ZBaThQc2ZoYlNWWnljU3JIOWF3SXZ3MDUveFZEUGJv?=
 =?utf-8?B?a095bmhudEZtQ1ExTjJhckkyWkUwZlppQ2JKR2JtWTVRNk1HUndrTU16Z0FI?=
 =?utf-8?B?TjFJd1BtYW5WOVBFZUdOaDdXa1U2bzFieCtsc2VMakY1b29sb0hCL1Fxbm44?=
 =?utf-8?B?dDczbzMzRjA4Q0ZoWXJJUTYzK0dIRC9UUE81blp0NFBmcmxKRXVQS1Y1akJB?=
 =?utf-8?B?dWJZdXgrRkJ6SmFXM2JEVW1RVkk5ZndMdStpSXpDQ01NZ0JRZGVDaTJua3Bt?=
 =?utf-8?B?TU1XRW5jelg3N2R4ZVUzbkpJWHl4U0JtRlY1SEs0TmpBM1BTRURIbFBXOW9h?=
 =?utf-8?B?QjUvZUFGQlorNVZad0gxMEFybnFZdjZ3WkRSOXpmY0RnT3FhNVZmQ1dOR3pU?=
 =?utf-8?B?WWdLNDgyOGhHbldwKzdCWjFwelpoTFJwS0piSFNjZ0N4Q1c4M1V6R0haUTBM?=
 =?utf-8?B?K2xJN1haTjFkaUJTMkRvdXJlMlp2QnA1bjNqQWNzOVMzaDRtRGQyMEJ1QmIw?=
 =?utf-8?B?bDkwajlicERubHc5STFZMWMwRm91bXBnL0tYUnNHMUxtdHAvWkNhWW5iUjdy?=
 =?utf-8?B?Yldua1ZMTGc4aUV3b3kzT0dPNi8xRkMycWhPWTdQQVlSVmdrTkFwV2pTUXNM?=
 =?utf-8?B?SVJoVTh2OHBybmVKWnVJSzllWUQvdjBPd2kraVcyQlVwMFlobytGNGgxRjBC?=
 =?utf-8?B?bmdDNDZpT003NXlJS2tjNlZrNGVoMHJXNHZBcTZkNDhudExNOGlyczJEYTVT?=
 =?utf-8?B?R3FhN1Fzd3c3RVpZU3hmNzVJaW56QXFRcGpEcm1BaHAzUDZEYXdNNmdDbnUx?=
 =?utf-8?B?YkZxbzNTZ2x0LytaWll0VFhEN0o4Mmg0cHZJaXFYbnB4ZEJOV3NJTzJuejNq?=
 =?utf-8?B?OHpyQ2RST0s0SFNzbzZjQzhFWW8vQmpEQ1ovc3M5ZCtuRjg0b2E1YVp1ZlZK?=
 =?utf-8?B?NEtEOEZoMVBnTW5ZVWY3Q2NZMGNSM0FWSS9ncEdnSUFSY3NreGJoelhRdGQr?=
 =?utf-8?B?Tm8wc1Q2dU01enJBdFdlUjVSVkFSZ1E4NnNHV3RyU01nckdZVUFOT0sxeERO?=
 =?utf-8?B?R3hmVHV2RTY1aDVtRHA2L2t2aGlkTXR2cHhnR3BkYjZlNGR0dnkyNlAraGlO?=
 =?utf-8?B?dTNaVHh3MUxPYUVaT2pRcFN3Y1RRTlp5aUNwenpsUGU5U0dVaGNXUlhzM0x4?=
 =?utf-8?B?WHRleWU0U2JFL1M3QTF5eU5mOC9EM2htSDFGMUd2NUZnd1pZeDVBM2hvdjZl?=
 =?utf-8?B?RFNyTDZwOWlwN0I5QmJEaS95amV3bUlKaDJVcEZxL3hvMXNEaEdlQmc0eE1B?=
 =?utf-8?B?WUJXZVNWSG1YK2RqeW5qenp0bHBEVDlybkJRaUY2czlEZEQ2elM2bXNMSk9H?=
 =?utf-8?B?WmJRcW5yaWdERWJDeS9NYUlrcTZWUW9TN2tycnk1U2VmMkNDZnlEZ2NUeHFi?=
 =?utf-8?B?ckZ4RFZGczRIUmE4YWlDajlYZWxEMzFjbjI1bzMxMUxvWWR0b3FtTTFZTUhk?=
 =?utf-8?B?Q1hNRUFySWRXVlAyYk13OG5peXNqR2IvUEp0S1VhQjV0K3VYdGlmWE1qa2Mz?=
 =?utf-8?B?amhITWFjeHM1VkRXR01YUDFhWDFUZS9JTGxJdXROMVlDWkxSUGltWlN2NmxV?=
 =?utf-8?B?SnpQZ2JhY3hFMkNSaEE5T29Ubmh2SUtEd3pTVkx2b2dBRGIzQXpyTWVhOWJB?=
 =?utf-8?B?NkdpVVg4cCtVVisxY1hleERvZDl0VDdkc0E3d2x5NVQxVUhoU0RhSTU4T1d2?=
 =?utf-8?B?aGVxaTl2R3QyaTZOMXVOdWRJY3hrTkR2SzJFdkpLS2ZzbjlyZGhNOHlCZFow?=
 =?utf-8?B?azBWWHMvNXpkbm5BZkQwbHF5M0FUbno0c25QZkVraHczWis5QWxuemM5bEFm?=
 =?utf-8?B?bEVIRGk5djdVV3RsUHdzRTVXWnZRUWx6dSt1S2JRV1JENDhNUmNRL3d3WVBL?=
 =?utf-8?B?NkgrMjlBR3BqUDhTZHpLN1l6RGpJNDZzZXhjdXhNdGlmcUxPQU5IeDNoUDFE?=
 =?utf-8?Q?j7OY0YV98e3Fpxec7k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f285f54-352d-46ed-a4f4-08df23afa6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 13:42:23.2003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++hfkbDCJbvOey6PA5v75KsrGrPLgGnTl/9Srw71P3rkSTGpDoGyIBFHnoGtc2FICletK4MUzBMKs2PcRS7NGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KT2suIENvbnNpZGVyIHRoaXMgcGF0Y2ggYWJh
bmRvbm5lZC4NClBsZWFzZSBDQyBtZSB3aGVuIHlvdSBoYXZlIGZpeCBzbyB3ZSBjYW4gdmFsaWRh
dGUgdGhhdCB1c2UgY2FzZSBvbiBvdXIgc2lkZS4NCg0KfkRhdmlkDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDYsIDIwMjYgMzoyNyBBTQ0K
PiBUbzogWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IE1hbmksIEJpbmN5IDxCaW5jeS5NYW5pQGFtZC5jb20+
OyBDdXJzb3IgPGN1cnNvcmFnZW50QGN1cnNvci5jb20+Ow0KPiBOYXRhbGllIFZvY2sgPG5hdGFs
aWUudm9ja0BnbXguZGU+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZG9uJ3QgZHJvcCB0aGUgVExCIGZsdXNo
IGZlbmNlIGluIHRoZSBHRU0gVkENCj4gaW9jdGwgcGF0aA0KPg0KPiBIaSBEYXZpZCwNCj4NCj4g
ZHJvcHBpbmcgdGhlIGludGVybmFsIGxpc3QgYW5kIGFkZGluZyB0aGUgcHVibGljIGxpc3QgYW5k
IGEgZmV3IHBlb3BsZS4NCj4NCj4gT24gMTAvNS8yNiAyMzo0MywgRGF2aWQgWWF0IFNpbiB3cm90
ZToNCj4gPiBXaGVuIGEgY29tcHV0ZSBWTSBpcyBtYW5hZ2VkIHRocm91Z2ggdGhlIERSTSBHRU0g
VkEgaW9jdGwsIHRoZSBWTQ0KPiA+IHRpbWVsaW5lIHN5bmNvYmogY2FuIHNpZ25hbCBiZWZvcmUg
dGhlIFRMQiBpbnZhbGlkYXRpb24gaGFzIGNvbXBsZXRlZC4NCj4gPiBVc2Vyc3BhY2UgdGhhdCB3
YWl0cyBvbiB0aGUgdGltZWxpbmUgYW5kIHRoZW4gcmV1c2VzIHRoZSBWQSBjYW4gaGl0IGENCj4g
PiBzdGFsZSB0cmFuc2xhdGlvbiBhbmQgYWNjZXNzIHRoZSBwYWdlcyBvZiB0aGUgcHJldmlvdXMg
bWFwcGluZy4NCj4gPg0KPiA+IFRoaXMgd2FzIHRoZSBjYWxsIGZsb3c6DQo+ID4gYW1kZ3B1X3Zt
X2NsZWFyX2ZyZWVkKCkgYWxyZWFkeSBhc2tzIGZvciBhIFRMQiBpbnZhbGlkYXRpb246IGl0IGNh
bGxzDQo+ID4gYW1kZ3B1X3ZtX3VwZGF0ZV9yYW5nZSgpIHdpdGggZmx1c2hfdGxiIHNldCwgd2hp
Y2ggcmVhY2hlcw0KPiA+IGFtZGdwdV92bV90bGJfZmx1c2goKSBhbmQsIGZvciBhIFZNIHdpdGgg
bmVlZF90bGJfZmVuY2UsIHJlcGxhY2VzIHRoZQ0KPiA+IHVwZGF0ZSBmZW5jZSB3aXRoIG9uZSBj
cmVhdGVkIGJ5IGFtZGdwdV92bV90bGJfZmVuY2VfY3JlYXRlKCkuIFRoYXQNCj4gPiBmZW5jZSBv
bmx5IHNpZ25hbHMgb25jZSBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoKSBoYXMgcnVu
LCBzbw0KPiA+IHZtLT5sYXN0X3VwZGF0ZSBjb3JyZWN0bHkgY292ZXJzIHRoZSBpbnZhbGlkYXRp
b24gYXQgdGhhdCBwb2ludC4NCj4gPg0KPiA+IGFtZGdwdV9nZW1fdmFfdXBkYXRlX3ZtKCkgdGhl
biBjYWxscyBhbWRncHVfdm1fdXBkYXRlX3BkZXMoKSwgd2hvc2UNCj4gPiBjb21taXQoKSBkb2Vz
IHN3YXAoKmZlbmNlLCBmKSBvbiAmdm0tPmxhc3RfdXBkYXRlLiBXaGVuIGFueSBQREUgaXMNCj4g
PiBkaXJ0eSB0aGlzIG92ZXJ3cml0ZXMgdGhlIFRMQiBmbHVzaCBmZW5jZSB3aXRoIHRoZSBQREUg
dXBkYXRlIGpvYg0KPiA+IGZlbmNlLCBhbmQgdGhhdCBpcyB3aGF0IGdldHMgYXR0YWNoZWQgdG8g
dGhlIHVzZXIgdmlzaWJsZSBWTSB0aW1lbGluZSBzeW5jb2JqLg0KPg0KPiBHb29kIGNhdGNoLCB3
ZSBhbHJlYWR5IGhhZCBtdWx0aXBsZSBwZW9wbGUgcnVubmluZyBpbnRvIHRoaXMgcHJvYmxlbS4g
SW5jbHVkaW5nDQo+IFN1bmlsIHdpdGggdXNlcnF1ZXVlcy4NCj4NCj4gQnV0IHRoaXMgZml4IGhl
cmUgaXMgY29tcGxldGVseSBicm9rZW4uIFdoYXQgd2UgbmVlZCB0byBkbyBpcyB0byB0cmFjayB0
aGUgVExCDQo+IGludmFsaWRhdGlvbiBhbmQgcGFnZSB0YWJsZXMgdXBkYXRlcyBzZXBhcmF0ZWx5
Lg0KPg0KPiBOYXRhbGllIGFuZCBJIGFscmVhZHkgZGlzY3Vzc2VkIHBhcnRzIG9mIHdoYXQgaXMg
bmVjZXNzYXJ5IGhlcmUgYW5kIHdpbGwgcHJvYmFibHkNCj4gY29tZSB1cCB3aXRoIGEgZnVsbCBw
YXRjaCB0byBmaXggdGhlIGlzc3VlLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+
ID4NCj4gPiBVc2Vyc3BhY2Ugd2FpdGluZyBvbiB0aGF0IHRpbWVsaW5lIHRoZXJlZm9yZSBvbmx5
IGxlYXJucyB0aGF0IHRoZSBwYWdlDQo+ID4gdGFibGUgd3JpdGUgbGFuZGVkLCBub3QgdGhhdCB0
aGUgVExCIHdhcyBpbnZhbGlkYXRlZC4gV2hlbiBubyBQREUgaXMNCj4gPiBkaXJ0eSBhbWRncHVf
dm1fdXBkYXRlX3BkZXMoKSByZXR1cm5zIGVhcmx5LCB0aGUgZmVuY2Ugc3Vydml2ZXMgYW5kDQo+
ID4gdGhlIHNhbWUgc2VxdWVuY2Ugd29ya3MsIHdoaWNoIGlzIHdoeSB0aGlzIG9ubHkgcmVwcm9k
dWNlcyBmb3Igc29tZSBzaXplcy4NCj4gPg0KPiA+IFB1Ymxpc2ggYSBmZW5jZSB0aGF0IGNvdmVy
cyB0aGUgaW52YWxpZGF0aW9uIGZvciBjb21wdXRlIFZNcywgd2l0aCB0aGUNCj4gPiBwYWdlIHRh
YmxlIHVwZGF0ZSBhcyBpdHMgZGVwZW5kZW5jeSwgaW5zdGVhZCBvZiBibG9ja2luZyBpbiB0aGUg
aW9jdGwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBZYXQgU2luIDxEYXZpZC5ZYXRT
aW5AYW1kLmNvbT4NCj4gPiBBc3Npc3RlZC1ieTogQ3Vyc29yIDxjdXJzb3JhZ2VudEBjdXJzb3Iu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMgfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4g
PiBpbmRleCBlZmMyNzBlOTliNGUuLjg0ZjdkNTZhMTVlYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiBAQCAtNzk5LDYgKzc5OSwxNiBAQCBh
bWRncHVfZ2VtX3ZhX3VwZGF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4g
PiAgICAgICAgICAgICBmZW5jZSA9IGRtYV9mZW5jZV9nZXQodm0tPmxhc3RfdXBkYXRlKTsNCj4g
PiAgICAgfQ0KPiA+DQo+ID4gKyAgIC8qDQo+ID4gKyAgICAqIEEgY29tcHV0ZSBWTSBpcyBzaGFy
ZWQgd2l0aCBLRkQgYW5kIHVzZXJzcGFjZSByZXVzZXMgdGhlIFZBIGFzIHNvb24NCj4gPiArICAg
ICogYXMgdGhpcyBmZW5jZSBzaWduYWxzLiBUaGUgVExCIGZsdXNoIGZlbmNlIHByb2R1Y2VkIHdo
aWxlIGNsZWFyaW5nDQo+ID4gKyAgICAqIHRoZSBmcmVlZCBtYXBwaW5ncyBpcyBkcm9wcGVkIHdo
ZW4gYW1kZ3B1X3ZtX3VwZGF0ZV9wZGVzKCkgcmVwbGFjZXMNCj4gPiArICAgICogdm0tPmxhc3Rf
dXBkYXRlLCBzbyBwdWJsaXNoIGEgZmVuY2UgdGhhdCBjb3ZlcnMgdGhlIGludmFsaWRhdGlvbg0K
PiA+ICsgICAgKiBpbnN0ZWFkIG9mIGJsb2NraW5nIGhlcmUuDQo+ID4gKyAgICAqLw0KPiA+ICsg
ICBpZiAodm0tPmlzX2NvbXB1dGVfY29udGV4dCkNCj4gPiArICAgICAgICAgICBhbWRncHVfdm1f
dGxiX2ZlbmNlX2NyZWF0ZShhZGV2LCB2bSwgJmZlbmNlKTsNCj4gPiArDQo+ID4gICAgIHJldHVy
biBmZW5jZTsNCj4gPg0KPiA+ICBlcnJvcjoNCg0K
