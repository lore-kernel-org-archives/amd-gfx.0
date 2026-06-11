Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C961CCD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A2010E49C;
	Thu, 11 Jun 2026 03:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMXh5ns1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3727410E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3PVkeEsbjvBYjwlD/6mLPMWeoV+uxVFPtyADTGKMJegdaCxBL7XnXiyQGXkSpS8brcKoPcHiE0IVn+zBj/LamS4BJH9WmltO9QT6D0jDZPTb9oTmgBqUrwYdZ4ET4dHjTynMHRkQFvCY6QZOvXbkuoic45XIpqxaZhcoVjOUHq4tHDr5fZdg9ZhQhG1/6vbnOMkZs/YXtsZUZb401XlxY1yqdcrEpAGecI4Rv6ogq2PZBHBwnt99fmu0sNydUn4PJ69oxdvhgq5mYUAdKZj1YdqFkWneDtgqN5xWDDprTgg1she55WraDW+a2d0QeojeIoUvfGJ1jqKMxWAYsgMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drqHC38MUnjjRb6OruGvYOC9tD46zRG94sNhC+uO9zo=;
 b=a29FJzmAKN8171qTRYJaY84OiYQw/BGz+8M2NJp5tTQD/RDeiF5YwHujhaoVsKlxSYz4xSSoF38LFQcrATeWLjJUzkoIrxsghAHISO5Y00kaDoH8yBoNrwKQxjD6ChGip4Y8I2U3+wkuhnF7TY7FTY+H0h4aV5kfuq5kYRD7QJMhXNE+tA+OznqqJ6O9JIHkYgE6A9abvBRhyXwhf04yT4oWkHLoTcIcuVMSm7P3rN/BNU0t3XuwireoIhjwe8hoIUX9iLfz4ZuxFq5OxcN7plqg4a+fFyB7M1PUzLoGauGGAl9Wa2+v1X8UTO7xOeAnfWDP9RxwViEhQ9dG689XLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drqHC38MUnjjRb6OruGvYOC9tD46zRG94sNhC+uO9zo=;
 b=jMXh5ns1OrGDDjdkRSiP+BozWOp8S6jZIO+IcuEv/VN2Mubs/6Sy6yjJTcX4GgBhaN2dF+we7Pq2+RkLRh2OBk8lk1vTLdn+UFnYqwRD9K56XyFwGE2oY4ukZqal/bM5h9X/yHUVS1k0DsgQvsi3z4OVQ+RWMS//nQYqhOohL6A=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 03:09:11 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0092.014; Thu, 11 Jun 2026
 03:09:11 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 5/6] drm/amdgpu/gfx11: try KQ ring_id match before
 user-queue lookup
Thread-Topic: [PATCH 5/6] drm/amdgpu/gfx11: try KQ ring_id match before
 user-queue lookup
Thread-Index: AQHc9NaYBzinxxGty0uXqd27W0wNlrYwZUaAgAhQJ/A=
Date: Thu, 11 Jun 2026 03:09:11 +0000
Message-ID: <DM4PR12MB5152346EA38DACB3F1AF2B97E31B2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
 <20260605103144.2537331-5-Jesse.Zhang@amd.com>
 <CADnq5_M394vxy35oLW=kSspQcvxhuu-tBXAnFBUNZJAy5koESQ@mail.gmail.com>
In-Reply-To: <CADnq5_M394vxy35oLW=kSspQcvxhuu-tBXAnFBUNZJAy5koESQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-11T03:08:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV8PR12MB9154:EE_
x-ms-office365-filtering-correlation-id: 0e1024cf-e429-446e-2a5d-08dec766cf7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|18002099003|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: kaHf0gpgiigXIcxzo7RisX73NJAGA5Kc4C/s76XKqfwUtP/b9yoWLPEkdYfJ8V7JEgL2J7iDSfVAlMFUSt+1APBuQFgfxvPyMJzUJ+rV4DDxFc2xsN/snJ6yWVd8Hxz2eWpfT4Xnqzjz/YGy18MjEsKAfP6FND2naGEbV5msNZiQDjE5hUkzqYRPHA+G37JJ3vg23yV6Ne0sqYuSGkjyLTWSo8du4B139ADYVS3Nti2w1o9hr2vLvFzw8yU0SN8MH6CjTIv2P21+66rtD00g/IVnTDHSx8fPzFAdpQC7gfEm2Vq3OrqfCEDEwoO1Yx+le2mMQ0fIDFsazA/1g04ujmy1FtD9Ol+sIz7nh9mGpDVGGcVdXodDoiVa1MXlZAI101KFdrX0FdqLbDC7SI6D7lc5YNm4qX99fLHvH9O1N0U2gb3NNwclqN4Dd4ejZ0wRTJ6iJjWTs/eRSpBvRRaqUJbVQhM1IkdnIi4nEV0ttaB+YItlL97upG7zSZOUf1p0C9JD7GowWQrF7U8CSop1agfCXlB08vvtf1SHD2QQlk3VWTjoahgh+v5JjwNKpvuSiBbwal/6JCw4amVSxlULIIbeTfjUsX/16Yp85xILoLqyQlYchwuDxIoLmMfbIRxah5+dFgkaKxVHhLvVI2PufL0yj/DiX5vfju6IYwPsyn6NJ075+j9zKzk8bJ9eVa7BSQxn/M5fZOew+wZxEAQKH934ZKbZVqZrGstlFe6vWViyskc2Tmqfp3fzXa0QKL1/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBPSDVTMXFVakNQUU9ncndSMHVURWJUU1NSbkhPc0xsRXJKaGJ2Qk41L3Vi?=
 =?utf-8?B?QU9xYlR1MlVYTGhLRVVFQmpvSTVaSjIrS3k4SFlma1lsUmJVVGplMS9kSmJk?=
 =?utf-8?B?YzRIVHIzbkRERExGQ3k3TW0yeUJLZVpHS29hU2svclNrdFhwU3BSU0hjNC9v?=
 =?utf-8?B?V3hDYWkwOVBQbzIwclc4TW1TTkVwSUgwZTJSNm9vM080dTBvSmlBSWlTVlpo?=
 =?utf-8?B?aEh5QmxUVkxzUUF6OWRneUtuRHhiSmhuUEhKZzVLYVdPN1ExYzZMVXoyYTl0?=
 =?utf-8?B?SlMzYUh5RVVGS1NmWTFGZ0NBOUJVTXFOTDFNMTlPR3pqSUZGRnN2OWJFKzNX?=
 =?utf-8?B?eW41ZG9TWXVtMkEwNDk1bXlORmZxVk5iaG5pRHBKaHdVT2NYNVJRR1crV0ln?=
 =?utf-8?B?U2xxUGhwMTAxc2JTaU9tQ1dUYk03NzJnVDlaa3RsZ2k1QnA1R2RNYk9KajhM?=
 =?utf-8?B?OGJzaHhsbHBJNUJ2aVA4aHBFejRnR3dzd0RicGkvMkMxSlZEc1J0aWtjZEc5?=
 =?utf-8?B?bjlScThua2lEeEJlMGN0N01veHJza3FiY2dwRzhtWi8xOXE0b0J5NTRmdmlj?=
 =?utf-8?B?d3dVcU5XN3BNWWpycFl6L3J6bEU2bEh0WHJyY1o0RGx0VWdIRG1rUFp6L21p?=
 =?utf-8?B?VC8zUDRqeVR2U2pOL0IxNFh5dkl4US9JcmYyUjZVMTIvOU0zZ1VWRERKOFg1?=
 =?utf-8?B?bVBTL3RVOTZOemhnU0FhVlpOSFNMdjhhVHBXSWUyb1VhNldsZ0hTVmFQSUFt?=
 =?utf-8?B?OFY3N1plNVFMcjZmKytnaW5kb2xvaE9CSWE2U1Fpc21EZzgxWi9Vazd4akx6?=
 =?utf-8?B?bTBmMkMvRTVjdXgydW9lbmw5eVJtSTVKMllrMzVXamlmVDhCTGZKajRvYmlH?=
 =?utf-8?B?eDBuVDJOQTNHUGdZT1RKWVFQay9CNWhzR2hmL1RVMXBaWEdYbVZVZ3V2bmFl?=
 =?utf-8?B?NnhVbXdMSnllOHJQYXJCWXFObVg1UFFqZFI4dUt5K1ovZUREWlB5VFBRdXpx?=
 =?utf-8?B?YXpCRzA5RTBLZjlyaXpiSzJsZVBoQ3I0QkxyNlVIbTczekRwVmhKRTdTOW5C?=
 =?utf-8?B?a21ZUmhyT1A2M0VUbmVXVkRNelJaclN4MWZMbnIvTXRRdjFidEhSd2pkYmZF?=
 =?utf-8?B?UFBpSWlWaUZPb0pCc3hNaExFMld0SzR1VU5iT1N2aldSZzk0TDFia0RzMm85?=
 =?utf-8?B?M0xwc3AyUURvVTY4eEJHWEpFWXk5U05Cb291Ym1TL1Uvd1djaXB0encvMkwv?=
 =?utf-8?B?TUxvWUF2NHBzTUNyT0hIT1JJQk85bzF6MDZSMXpHYXpOSFZRZ1VpdXVDbVNl?=
 =?utf-8?B?d0w4eXJnV3FnYU5aMzNhWE9qZlRUSXNlYXFJL1lIUDRaMjlWbDYyK0VlM3pt?=
 =?utf-8?B?OWhFdnBqK0pLY2FqTGs2OEhCdFFMdDIyUHphbjJhd0p3R2Y1RllrenhidmJo?=
 =?utf-8?B?YmNKN3UyQnhFeFEyK0pVNkVkTVJNci9CSTJXVkFVUU9yckxhZ2FJYmxpY0d1?=
 =?utf-8?B?clVneUd0RzNHN3hhNmRQTFhMcFdaSkRKMFZXSTFiOVZhVmdvL0sxQzFlbHUv?=
 =?utf-8?B?NlJFZU0yVENqS0VLZXRjY0owKzY1NTBETUgzYitISkUxZmwxUnAwV3JqNENl?=
 =?utf-8?B?UjBmWnM3WmQ2UWNBUlFUV3lZeE1lVkVsMi9pdU04MWNSb2JRTnlleUtoWEZw?=
 =?utf-8?B?SWdOUFhNTDV4a2t0aVFqVDRqQmptOExKbjFqMnRaa2tuNDN0ZWVNaURJV3lP?=
 =?utf-8?B?YStnUFNtcEFNMHBTQXBxVGphbHk1bFBGMnNONDNVZzdMT3dLRDhlMjhTaDll?=
 =?utf-8?B?OWpyTG03dnZZa0RPS09CaGkrQ09LMXpHUVpHbnpPUlhJdVFTVUtyaHQ3d1l0?=
 =?utf-8?B?NTQ0cmJNNTRtMFdxZDk0empBUEhFRFpQYit6UW1iMW1mN01PYktTeVg2dlMw?=
 =?utf-8?B?dGNhb1ZpUzBYRXZJSk5MLzRnMnJpb0dPeGNkbVlFR3pvclhkcXNWWjQwK1Mv?=
 =?utf-8?B?cVd1Nm9JTTdibS9BS0hDOHBOQlhTM284Nkk4YWkzK1E0MW1lK0J3VHc0aWI0?=
 =?utf-8?B?NjdwUGFWcVlKQ0dPR2owYlVleUkyYStranYzb0F1Y1lTUXJ6K0JsYy9PdVRo?=
 =?utf-8?B?OFdWRzJwT1RyZW1TaFFzQlF4OHZoeVlPeEtFVXRRYXMxQUxidUhTQ1N5ek96?=
 =?utf-8?B?SGs2cUJpTlp4ajdYbGJEYTNIN2dWODZhbXE2aVd6Qm9QZ040SEhZV3VsVlZw?=
 =?utf-8?B?UmNRMnpEK3g3ZnFTQnYzYUFrdkQrYjRnVUtMcmdzdDFaTUNyRi9ibkluQ2RN?=
 =?utf-8?Q?Lf5oQc6qIW0QZ1dE+v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1024cf-e429-446e-2a5d-08dec766cf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 03:09:11.4651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzB5y6/OmevVkE6/739SMBkYZ+TaY0do8Fn+vLRPmCKQc3Vr+dX1z7+1jWSmg2oTlJTk3UIUDuo1MiHck+MgcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUg
NiwgMjAyNiA0OjExIEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1k
LmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gZHJt
L2FtZGdwdS9nZngxMTogdHJ5IEtRIHJpbmdfaWQgbWF0Y2ggYmVmb3JlIHVzZXItDQo+IHF1ZXVl
IGxvb2t1cA0KPg0KPiBPbiBGcmksIEp1biA1LCAyMDI2IGF0IDY6MznigK9BTSBKZXNzZSBaaGFu
ZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBLQ1EgYW5kIHVzZXIgcXVl
dWVzIG5ldmVyIHNoYXJlIGEgSFcgc2xvdCwgc28gYSBLUSByaW5nX2lkIGhpdCBpcw0KPiA+IGF1
dGhvcml0YXRpdmUuIE1hdGNoIEtRIGZpcnN0OyBvbmx5IGNhbGwgaW50byB0aGUgdXNlcnEgcGF0
aCB3aGVuIG5vDQo+ID4gS1Egb3ducyB0aGUgZmF1bHRpbmcgc2xvdC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyB8IDIzICsrKysrKysrKysr
KysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTFfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEx
XzAuYw0KPiA+IGluZGV4IDI3ZDBhM2RiZmNlOC4uMWYxNTljOTMzM2E1IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiBAQCAtNjY4OCwxMCArNjY4
OCwxMiBAQCBzdGF0aWMgdm9pZCBnZnhfdjExXzBfaGFuZGxlX3ByaXZfZmF1bHQoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAgICAgIHUzMiBk
b29yYmVsbF9vZmZzZXQgPSBlbnRyeS0+c3JjX2RhdGFbMF0gJiAweDNmZjsNCj4gPg0KPiA+IC0g
ICAgICAgaWYgKGFkZXYtPmVuYWJsZV9tZXMgJiYgZG9vcmJlbGxfb2Zmc2V0KSB7DQo+ID4gLSAg
ICAgICAgICAgICAgIGFtZGdwdV91c2VycV9wcm9jZXNzX3Jlc2V0X2lycShhZGV2LCBlbnRyeS0+
cGFzaWQsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkb29yYmVsbF9vZmZzZXQpOw0KPiA+IC0gICAgICAgfSBlbHNlIGlmICghYWRldi0+Z2Z4LmRp
c2FibGVfa3EpIHsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBUcnkgS1EgZmlyc3Qg
YnkgcmluZ19pZCAoSFcgc2xvdCBpcyBhdXRob3JpdGF0aXZlKS4gVGhlIE1FUyA8LT4NCj4gPiAr
ICAgICAgICAqIEtNRCBjb21wdXRlX2hxZF9tYXNrIGNvbnRyYWN0IGd1YXJhbnRlZXMgS0NRIGFu
ZCB1c2VyIHF1ZXVlcw0KPiA+ICsgICAgICAgICogbmV2ZXIgc2hhcmUgYSBIVyBzbG90Lg0KPiA+
ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoIWFkZXYtPmdmeC5kaXNhYmxlX2txKSB7DQo+
ID4gICAgICAgICAgICAgICAgIHU4IG1lX2lkID0gKGVudHJ5LT5yaW5nX2lkICYgMHgwYykgPj4g
MjsNCj4gPiAgICAgICAgICAgICAgICAgdTggcGlwZV9pZCA9IChlbnRyeS0+cmluZ19pZCAmIDB4
MDMpID4+IDA7DQo+ID4gICAgICAgICAgICAgICAgIHU4IHF1ZXVlX2lkID0gKGVudHJ5LT5yaW5n
X2lkICYgMHg3MCkgPj4gNDsgQEAgLTY3MDMsOA0KPiA+ICs2NzA1LDEwIEBAIHN0YXRpYyB2b2lk
IGdmeF92MTFfMF9oYW5kbGVfcHJpdl9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRl
diwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4
Lm51bV9nZnhfcmluZ3M7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmluZyA9ICZhZGV2LT5nZnguZ2Z4X3JpbmdbaV07DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAocmluZy0+bWUgPT0gbWVfaWQgJiYgcmluZy0+cGlwZSA9PSBwaXBl
X2lkICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmluZy0+cXVl
dWUgPT0gcXVldWVfaWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmluZy0+cXVldWUgPT0gcXVldWVfaWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZHJtX3NjaGVkX2ZhdWx0KCZyaW5nLT5zY2hlZCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGNh
c2UgMToNCj4gPiBAQCAtNjcxMiw4ICs2NzE2LDEwIEBAIHN0YXRpYyB2b2lkIGdmeF92MTFfMF9o
YW5kbGVfcHJpdl9mYXVsdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRl
X3JpbmdzOyBpKyspIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmcg
PSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChyaW5nLT5tZSA9PSBtZV9pZCAmJiByaW5nLT5waXBlID09IHBpcGVfaWQg
JiYNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT5xdWV1ZSA9
PSBxdWV1ZV9pZCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5n
LT5xdWV1ZSA9PSBxdWV1ZV9pZCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkcm1fc2NoZWRfZmF1bHQoJnJpbmctPnNjaGVkKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgICAgZGVmYXVs
dDoNCj4gPiBAQCAtNjcyMSw2ICs2NzI3LDExIEBAIHN0YXRpYyB2b2lkIGdmeF92MTFfMF9oYW5k
bGVfcHJpdl9mYXVsdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIC8qIE5vIEtRIG1hdGNoZWQ6IEhXIHNsb3QgaXMgYSBN
RVMtc2NoZWR1bGVkIHVzZXIgcXVldWUuICovDQo+ID4gKyAgICAgICBpZiAoYWRldi0+ZW5hYmxl
X21lcyAmJiBkb29yYmVsbF9vZmZzZXQpDQo+ID4gKyAgICAgICAgICAgICAgIGFtZGdwdV91c2Vy
cV9wcm9jZXNzX3Jlc2V0X2lycShhZGV2LCBlbnRyeS0+cGFzaWQsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkb29yYmVsbF9vZmZzZXQpOw0KPg0K
PiBXaGlsZSB5b3UgYXJlIGF0IGl0LCBjYW4geW91IGNoZWNrIGlmIGdmeF92MTFfMF9lb3BfaXJx
KCkgYW5kDQo+IGdmeF92MTJfMF9lb3BfaXJxKCkgaGF2ZSBzaW1pbGFyIGlzc3Vlcz8gIE1heWJl
IHRob3NlIHNob3VsZCBiZSByZXdvcmtlZA0KPiBzaW1pbGFybHkuDQo+DQpUaGFua3MgQWxleCwg
SSB3aWxsIHRyeSB0aGF0IGFuZCB1cGRhdGUuDQpKZXNzZQ0KDQo+IEFsZXgNCj4NCj4gPiAgfQ0K
PiA+DQo+ID4gIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX3ByaXZfcmVnX2lycShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gPiAtLQ0KPiA+IDIuNDkuMA0KPiA+DQo=
