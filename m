Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27085CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 07:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB50E10E4F0;
	Mon, 12 Oct 2026 07:15:53 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDF810E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 07:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/RxCYR98YngAbdFHJhmg9zjD5C4s6cnZePQQ0MMMsilJN+WMbsMY8H/GjCmHzU8fl3armfPHfvB5XHyMowCcOBGdUbYnxUkVeIbuuxTcXuUQAtxJI/rzYu3/BfGBStNQ8vBSCDm6kXP2k8H1sNsluw913gmc/IKuesXzp0aCFtOEX9x7vhdqBrZZizThBFAXDRecbdynLfbbUq5TToB6UKUNZzqZ5yd0aL5cYiQtPssUnzg2Cl2jhEXGp6NQ4ilAxtTyrX6NPQ5WKPHW/PPyKtYHwfcKJR+H6bKmjhFZUcgngowVMwUXgTxPFGIJbFNzV9wNOFwVbFxHyX4+k0BPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy/n+JDzfVmXlLOQkS3HBWnv9m7ke9DfmdBwWPBk++A=;
 b=bzluR2wmJIHFkv175VIaCW7+wVI2LrzHo48snZw56/4cQSmDzSOThtEgFJQDgmPyjtFTuAM5v59qE0phA3w8SlCcby4L8GzROCjHsEtLVACSkGs6N9lkAzJgbpl1TREMbhIvsTuLMX1ZG6tJAoY9/U/+oLgmmfsFl8AXPWCfcZDXF0WyT4UGNfu5Oysvw27BfzSj10bNmmbBUThpOEhhteCxglTEgcJbhIzNIKdOIp4+2wCfrtnN8v8311lPyA2LWyHmH7e14+ledVvIAxpd9o996hbmrEm/B7hTMCZxB00dOXtWmaPs/DIGB+7Bat6P/igFhw48stmytSvbv0NxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy/n+JDzfVmXlLOQkS3HBWnv9m7ke9DfmdBwWPBk++A=;
 b=k5ogLIyDR/hO+Kga4v3AnlmPiaHiNCB0u3idW5arVZwj7fG6GuVTi+STvC57NYoEfrLYKxdSiotJYhc99iJ9wlw4EdNRdw8cMQDT+qswprkq4aH9C8XrSCzNZP86HhPeV4Y8V4KPJyVa2D11h9VtISmFHRjW3kMezkQMW3AbtN8=
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::12) by LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:15:44 +0000
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926]) by PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:15:38 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: mark the current DPM clock level active
Thread-Topic: [PATCH] drm/amd/pm: mark the current DPM clock level active
Thread-Index: AQHdWej5kzGCdI3Ke02OrNL8SuS5Fbb5S9CAgAAzGGA=
Date: Mon, 12 Oct 2026 07:15:37 +0000
Message-ID: <PHXPR12MB9992550B67868CF6578256894A939F2@PHXPR12MB999255.namprd12.prod.outlook.com>
References: <20261012012748.3150968-1-kevin.wang@amd.com>
 <142bb98f-2b90-44ac-9e69-8700b4130e5c@amd.com>
In-Reply-To: <142bb98f-2b90-44ac-9e69-8700b4130e5c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-12T07:14:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999255:EE_|LV8PR12MB9714:EE_
x-ms-office365-filtering-correlation-id: 919ee2f9-c555-4df9-4999-08df28309dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: a7rmtzgpAzkh24dKLMBfYFEEuAMHl83z/JVIXRMOW2U6M9YeNs1PtpbvqwSDuKWaEXF8ipz3iMP593zjz/zn0U35wTQ1IgV7C/XmRYThM+Nz3y8CUt6ZvREhIj5+4u8oRnfGGDg7PKlZD28M4kemTMSEIvdXVBiWEBxYiR/+GoyGWJp0Q0YxL1jr94jj9FIXaqzcQp4qir4rP5W2awSdDaLbhHRRUIZWtHXnOg3WmmzF7qxSmjk/pbETGcRWlVtsM6LKa9kWh9r76rt8G70pKMCqaotzZwlPVDO6berIYpqs19eXUw8vxmc42oXZO1CJU4MBDmTKRiY8ueNi3+db7lE1xHJr9ozRWUNDjYoJccfDtlEaUnhf/M2NLOojDLFNZfL5exp584S8JSH+/ZaS7NdJ/sX7FBUFpY+5WaJTmEUyodHZJJWZtvmoZAFtGQBIuTtnh5EDLWCfh6R1q7xD6226A4EZzu0LLxM1bEx88gE7jnS1fxLBAl7+ZOl2KQsRbdxTjk6ooRitL+ZmylG4xCuuGsJPByAXXlVYJ56hIvLI0NHhfKzkYxBA6JPfrP4Z5QXYctDBGcg/tWw2XTFfFKG9riVj3DVYbyrACivHk5UkvkIIW2F6ES6WFBH/poiWpi2CcCSOxmtfa1SWSVOMI9Lz/WdQdwbutkfQ+ZXf/RxP2WFP9ZGxUQv02F8+34BPZ/DevAsTGTgMO9fnPF41LR8snZP2tGl3lk8bJMTH9eU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999255.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RCs2RHFtdW9PUlF3UDRiRU1BeU5QQ2dUZWNvWi9ieGp4RFBWL1VRTk8wbit3?=
 =?utf-8?B?YkZvdmZCYnhMMXhUMklPaWRmVDdXSWJ2RERIYWt6TjVIOEJianhkSXUxck50?=
 =?utf-8?B?MU1aK3FKTU5YVWg5UDRJTE9TT0V3bUZibENNUGlGRmxiRWNwdTBVeitGcGJz?=
 =?utf-8?B?WWx6bFlNQlMxcjMrSzJzc2sreW1FdHJrL09qZCtUdlYzenlreVhtZU5rTUov?=
 =?utf-8?B?Vmd2UncvK0Jtd0NGVGxrVGdyZUYrSFc0eE5RYXlDOEFJRksrT0twZjFidURz?=
 =?utf-8?B?bW0rSlNxZVZTTEtuV1NNNDF1TzcwM3FKWnFscEdQV0tCOStnSjBPTXZNVzNo?=
 =?utf-8?B?bnRUaWZjYS9YbGE1NGRhSVV3aVkrR29zTzNTVlRiRHdUdmFZVWZoNFcrZFNx?=
 =?utf-8?B?bkNGUURvL3lmY0J6TXlvdndDc2ZydUV3c055WTI5MUVqRXdHMlpSeExxMlRS?=
 =?utf-8?B?Y1N2MWJLMXh6SzUwVm13ZVNHYzVHaUt5b092eWlsdU0yWXdsTFI3YWRxb2p2?=
 =?utf-8?B?a0JhRmxGMHlxemdYazRReERzdHhiaENHVGVCRXl4ako2RjYwdFVDbThmQWVv?=
 =?utf-8?B?U1pCRnNlVmlyN25kSVpyS3lvNHZjbzRoZHdyRHVsbVR1NkptTWFXMlloTW44?=
 =?utf-8?B?MGtwTk55Wlh5RGxIMlBhZUt3bTRTYURKbXNwTHJnWG1POFJlK2FaWVZQalVm?=
 =?utf-8?B?Rkg2WmNja2J0NTdpaUJZOWU4VjB4MmVNOGJyUkpDZWprWXVlSlBSUUFRTWFP?=
 =?utf-8?B?cWxLKzF0M3lMaVJHdHBNMGYvMmRWRUNPZU5Rc0ovNGFlSkF3THZROGVKTHhC?=
 =?utf-8?B?K3o2WGJ0Um5FaFAwS045N3dGMEQvbHJydmxqaWJjYUZIMEFjOERDcDRsK0RF?=
 =?utf-8?B?OWdhK2l0TnhHcXQ2Y05OczRUaTFqUmx0d2RHWU5UUVNYSFJmUTRFbW9ZM2pH?=
 =?utf-8?B?SkpFeFJzUlowWUdNeW8xbWY1Wklad3pIN1JBNFoxSWJHZm9manJKWTdzUSsz?=
 =?utf-8?B?TEEvNkkvaFc2S0IwYVNKZlV5QW52Z0VicVNZVGYvb3ZnaGNIWXRwNStuYUlU?=
 =?utf-8?B?QlpBemJpamlKZjNGNGZGZW9na0hQY2ErVzh5bld3UkZ4djBRQTZpY2k0eDBv?=
 =?utf-8?B?ODNJeHhoTE91VHNkeWEzZ2pLeElpN29iWTgzdFZDOGFEY1Y3TXVyMHQ3QkRu?=
 =?utf-8?B?OGIzTlVYYSt2d2toanExZlhIL1kvWE9zdi9CTFRRbXdJUHRSOGw0U1I0Nzlz?=
 =?utf-8?B?b0lyNXh5a1N6VEhjZ2pvQnlVakxMejBYRkhZd2ZvU0ZnTFlhcUl4Q3dNMEll?=
 =?utf-8?B?U2Y3Yy8wV1VWOVRiTE02K3pGQTZoR2ROSFJzbXh1SnVZSUFzcXlRZUpoYm5y?=
 =?utf-8?B?Tnlqc0M0YjZzdVMzbUVpYjJHbGxqZnd1UVlGTlBkdkY1NEEzcnFMWFpLekMx?=
 =?utf-8?B?QTBFVlBNVGVkUmVUMDNWU092aU84V0VYSFJwdG5CNU4rY09DZW1vNUVVaTJa?=
 =?utf-8?B?VUhxTVdCa0ZhSEE1bmFXZGpVaFlCVWczWjA4TU1wUXBaWFUxNnJCN1huSDBL?=
 =?utf-8?B?UkkwSHo1aE9TaGNOeUNsNUFoVDJEdHBDYXlMMHo1N0JOcWJ3YlJ4MnNOWEZO?=
 =?utf-8?B?eCtSNmZqUzl4L1BhS2x4dmE4dWZxUERuUFBtWnJjR0p6SkFvUzhab3JSQ3Y3?=
 =?utf-8?B?bEd5bW9rVTZqeXVlS3NiT05ZKzJlMEF0TmZBSm5uS01uZ3B4SEhCZDNSTEpK?=
 =?utf-8?B?WDk2SmdQTHVyOW56dVVVTTdmaytCVlA2SThJSS9PcjhZcVluUmdvaURuT2lq?=
 =?utf-8?B?YXBIT2tyYVBZdDBDclltK1lEM2Y0RjR1Tk9lMTBaRGRlUlhqbDBZb0xXc3VB?=
 =?utf-8?B?cFFrZ2IxQmZOS0tlRk45RWxmd1NTSnUrNXB0aG9lSy90VkRkdGFMOE1lTTJa?=
 =?utf-8?B?d0ZHSEtzSHFid2lzTnlQRFBzNncxUHVIN1hoUjlva1pSNE5HRkt3d3o3OWRq?=
 =?utf-8?B?dEFxY0RzUjJ2SEtuN2I3OWZUZFVWVzFNbFMvckpUYndhMWdNYlJSYkVIV291?=
 =?utf-8?B?d0MyYnNSS0xxTFpHT3AwSElwMXZmZmEzMC9iSHpEWHM2NHlWQjN2VXJnWWkw?=
 =?utf-8?B?T2xXR3A4SW9HYS9RMHdlM3N0bllBVWJwQnF4MXRaT3lYNW5HQUZqajJPVnlE?=
 =?utf-8?B?bUtpTzlJem9BeTNZVWFabE9lMWFjYUZpZWdZRW9QNzBPM0IrODQvSmo0WjZ6?=
 =?utf-8?B?ZTh0ZklTMnNaa2prM0FIeVJHRTBSSFNFN2ZYV1h1ZSs0dlJBQTBXZnhmZFhw?=
 =?utf-8?Q?h9b7BB2dATANcTHMvM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919ee2f9-c555-4df9-4999-08df28309dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:15:37.9908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2wrz4eH5IhNlXmr3QSWXsKhDnn/K5LrmEUzbRel3dQr+ujdz8g1JcLAJ08YSLtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTIs
IDIwMjYgMTI6MTINCj4gVG86IFdhbmcsIEtldmluIDxLZXZpbi5XYW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBtYXJrIHRoZSBjdXJyZW50IERQTSBjbG9jayBsZXZl
bCBhY3RpdmUNCj4NCj4NCj4NCj4gT24gMTItT2N0LTI2IDY6NTcgQU0sIEtldmluIFdhbmcgd3Jv
dGU6DQo+ID4gUE1GVyBjYW4gcmVwb3J0IGNsb2NrcyBvdXRzaWRlIG9yIGJldHdlZW4gYWR2ZXJ0
aXNlZCBEUE0gbGV2ZWxzLg0KPiA+DQo+ID4gUmVwb3J0IGEgY2xvY2sgYmVsb3cgRFBNMCBhcyBh
IHNwZWNpYWwgYWN0aXZlIFMgbGV2ZWwuDQo+ID4gTWFyayB0aGUgbmVhcmVzdCBsZXZlbCBhY3Rp
dmUgZm9yIGEgZGlzY3JldGUgRFBNIHRhYmxlLg0KPiA+IENsYW1wIGEgY2xvY2sgYWJvdmUgdGhl
IHRhYmxlIHJhbmdlIHRvIHRoZSBtYXhpbXVtIERQTSBsZXZlbC4NCj4gPiBLZWVwIHJlcG9ydGlu
ZyB0aGUgYWN0dWFsIGNsb2NrIGZvciBhIGZpbmUtZ3JhaW5lZCBEUE0gdGFibGUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbi53YW5nQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyB8IDM1ICsrKysr
KysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXVfY21uLmMNCj4gPiBpbmRleCAzNjE2NTdjMTllYTMuLjhjZjYxNjUxN2RkZCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ID4gQEAgLTEz
OTEsMTEgKzEzOTEsMTIgQEAgaW50IHNtdV9jbW5fcHJpbnRfZHBtX2Nsa19sZXZlbHMoc3RydWN0
DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBjdXJfY2xrLCBjaGFyICpidWYsIGludCAqb2Zmc2V0KQ0KPiA+ICAgew0KPiA+ICAg
ICB1aW50MzJfdCBtaW5fY2xrLCBtYXhfY2xrLCBsZXZlbF9pbmRleCwgY291bnQ7DQo+ID4gKyAg
IHVpbnQzMl90IG5lYXJlc3RfbGV2ZWwgPSAwLCBuZWFyZXN0X2RpZmYgPSBVMzJfTUFYOw0KPiA+
ICAgICB1aW50MzJfdCBmcmVxX3ZhbHVlc1szXTsNCj4gPiArICAgdWludDMyX3QgY2xrX2RpZmYs
IGxldmVsX2NsazsNCj4gPiAgICAgaW50IHNpemUsIGx2bCwgaTsNCj4gPiAgICAgYm9vbCBpc19m
aW5lX2dyYWluZWQ7DQo+ID4gICAgIGJvb2wgaXNfZGVlcF9zbGVlcDsNCj4gPiAtICAgYm9vbCBm
cmVxX21hdGNoOw0KPiA+DQo+ID4gICAgIGlmICghZHBtX3RhYmxlIHx8ICFidWYpDQo+ID4gICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTE0MDcsMjMgKzE0MDgsNDEgQEAgaW50
IHNtdV9jbW5fcHJpbnRfZHBtX2Nsa19sZXZlbHMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUs
DQo+ID4gICAgIG1pbl9jbGsgPSBTTVVfRFBNX1RBQkxFX01JTihkcG1fdGFibGUpOw0KPiA+ICAg
ICBtYXhfY2xrID0gU01VX0RQTV9UQUJMRV9NQVgoZHBtX3RhYmxlKTsNCj4gPg0KPiA+IC0gICAv
KiBEZWVwIHNsZWVwIC0gY3VycmVudCBjbG9jayA8IG1pbl9jbG9jay8yLCBUQkQ6IGN1cl9jbGsg
PSAwIGFzIEdGWE9GRiAqLw0KPiA+IC0gICBpc19kZWVwX3NsZWVwID0gY3VyX2NsayA8IG1pbl9j
bGsgLyAyOw0KPiA+ICsgICAvKiBBIGNsb2NrIGJlbG93IERQTTAgaXMgcmVwb3J0ZWQgYXMgYSBz
cGVjaWFsIGRlZXAtc2xlZXAgbGV2ZWwuICovDQo+ID4gKyAgIGlzX2RlZXBfc2xlZXAgPSBjdXJf
Y2xrIDwgbWluX2NsazsNCj4gPiAgICAgaWYgKGlzX2RlZXBfc2xlZXApIHsNCj4gPiAgICAgICAg
ICAgICBzaXplICs9IHN5c2ZzX2VtaXRfYXQoYnVmLCBzaXplLCAiUzogJXVNaHogKlxuIiwgY3Vy
X2Nsayk7DQo+ID4gICAgICAgICAgICAgbGV2ZWxfaW5kZXggPSAxOw0KPiA+ICAgICB9DQo+ID4N
Cj4gPiArICAgLyoNCj4gPiArICAgICogRGlzY3JldGUgdGFibGVzIG1hcmsgdGhlIGxldmVsIG5l
YXJlc3QgdG8gdGhlIGN1cnJlbnQgY2xvY2suICBDbGFtcA0KPiA+ICsgICAgKiBjbG9ja3MgYWJv
dmUgdGhlIGFkdmVydGlzZWQgcmFuZ2UgdG8gdGhlIGxhc3QgbGV2ZWwuICBGaW5lLWdyYWluZWQN
Cj4gPiArICAgICogdGFibGVzIGtlZXAgcmVwb3J0aW5nIHRoZSBhY3R1YWwgY3VycmVudCBjbG9j
ayBiZXR3ZWVuIG1pbiBhbmQgbWF4Lg0KPiA+ICsgICAgKi8NCj4gPiAgICAgaWYgKCFpc19maW5l
X2dyYWluZWQgfHwgY291bnQgPT0gMSkgew0KPiA+ICsgICAgICAgICAgIGlmICghaXNfZGVlcF9z
bGVlcCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgaWYgKGN1cl9jbGsgPj0gbWF4X2Nsaykg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBuZWFyZXN0X2xldmVsID0gY291bnQg
LSAxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZXZlbF9jbGsgPSBkcG1fdGFibGUtPmRwbV9s
ZXZlbHNbaV0udmFsdWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2xrX2RpZmYgPSBjdXJfY2xrID4gbGV2ZWxfY2xrID8NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cl9jbGsgLSBsZXZlbF9jbGsgOiBsZXZlbF9j
bGsgLQ0KPiBjdXJfY2xrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChjbGtfZGlmZiA8IG5lYXJlc3RfZGlmZikgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbmVhcmVzdF9kaWZmID0gY2xrX2RpZmY7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZWFyZXN0X2xldmVsID0g
aTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgIH0NCj4gPiAr
ICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBjb3Vu
dDsgaSsrKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICBmcmVxX21hdGNoID0gIWlzX2RlZXBf
c2xlZXAgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbXVfY21uX2Zy
ZXFzX21hdGNoKA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3VyX2NsaywNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRw
bV90YWJsZS0+ZHBtX2xldmVsc1tpXS52YWx1ZSk7DQo+DQo+IEJ5IHRoaXMgY2hhbmdlLCBpZiB0
aGlzIGZ1bmN0aW9uIGlzIG5vIGxvbmdlciB1c2VkLCBpdCBjYW4gYmUgcmVtb3ZlZCBhcyB3ZWxs
Lg0KDQp0aGlzIGZ1bmN0aW9uIGlzIHN0aWxsIHVzZWQgaW4gZmluZS1ncmFpbmVkIGNhc2UuDQoN
CkJlc3QgUmVnYXJkcywNCktldmluDQo+DQo+IFRoYW5rcywNCj4gTGlqbw0KPg0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgc2l6ZSArPSBzeXNmc19lbWl0X2F0KGJ1Ziwgc2l6ZSwgIiVkOiAldU1o
eiAlc1xuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBs
ZXZlbF9pbmRleCArIGksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZHBtX3RhYmxlLT5kcG1fbGV2ZWxzW2ldLnZhbHVlLA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyZXFfbWF0Y2ggPyAiKiIgOiAiIik7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCFpc19kZWVwX3NsZWVw
ICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgPT0g
bmVhcmVzdF9sZXZlbCkgPyAiKiIgOiAiIik7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICB9
IGVsc2Ugew0KPiA+ICAgICAgICAgICAgIGNvdW50ID0gMjsNCg0K
