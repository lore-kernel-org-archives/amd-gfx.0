Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27870C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 15:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA8C89C28;
	Wed,  2 Sep 2026 15:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ix1rFrpe";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9CD89C28
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj3lbsigw3F1fZrJAlaOuBtDoqxEG0VoQVJI6RD8kzfGJJMQeaw0sROborEvyBQylgD3b6of8IpZxz1aEj3UIouJ0M2cYKvdMsAr4f6QkWcpsEBpFUwhbkfR1OAlbdlsZ2yYQgEM9gAPQ1h+5rxQ+Cxe5oS/YPihCTsUh+mbB5RsVkG6BjG6t4TgzVZv9E9MV7xUPiyuwE24rHy53T/w9Q12zARah9xhbRPskyHyGp06+r+1Pk/X77C0Mh6lzfjqItFwVL1YgsncTQTWFgWYdiRcZ2smp2ftvnonxLKxtv14od7qtV0vM7aRdGS4vPqKclA1U67sX5swgzjv0IDjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0jN8fuRQ/OxGcGZw4PNGGkkFB0tyXAeZmCXIF5Y7DM=;
 b=mYuLjvjhmeFgLmeYOcRaALSc2npow/sk9iyOeYSGEXhD5AgerZmPteBheu16fe0kkVp5xmThuf4804LsUfeRGdTVFQrlol2GWpNfyhC9q8te9jeFaXlbVx8sA32xJzqNoB0WBBRQItmeLlg+586WyPr1Q21qm1RQyc9EH/xOT/RGVpux6Gih9lUu3Jf6hBfcBK1OWKfUzMsM1IVh/ZzOAnaSZNH05t3zyv3j1LcY3R7eBlMwBg7nCsMTpTr1J0P2sIivv9xlV15IIFtdzcLRfAwxaXhPTKJlIVJNdesQfNaJ5BWTZ/vV9EHos7IIJ6lNomDep7gmBjmzHrRvxyPrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0jN8fuRQ/OxGcGZw4PNGGkkFB0tyXAeZmCXIF5Y7DM=;
 b=ix1rFrpehGhr23IiHRekmC6xnZNQLeh9d/eH/cGPOrlXNQpwI8ZnE99qgRCBwjs/SWM8ZusYD9RZwTYAVctd9y07NckA/vzgkUNhWUqBkIUofMKEtDw8VzAAqVDY0bIg4GLU589JwvgVtpT4Jfx1aTxEGj5Mocm3YDGOHzo36Rs=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by FT1PR12MB222952.namprd12.prod.outlook.com (2603:10b6:170:d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 15:59:38 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 15:59:38 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
Thread-Topic: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
Thread-Index: AQHdOuzHydv2vk0tFU2FDBmX3LtZaba7abOAgAAG84A=
Date: Wed, 2 Sep 2026 15:59:38 +0000
Message-ID: <IA0PR12MB8208E904460F474C4975950690B72@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
 <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
In-Reply-To: <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-02T15:54:09.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|FT1PR12MB222952:EE_
x-ms-office365-filtering-correlation-id: 02f07d92-b09d-4f44-bf72-08df090b312f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|38070700021|10067099003|4143699003;
x-microsoft-antispam-message-info: f+q26AcIMh1wx4y9IAbC8hRPTzRHSSF6CCOwuTBd+uo2PZ/BQYlpDRKSXWkhzuuot8wEmKgu6XgPfulzmAUZ1HS1j15z/uLbrn3r7w1hVhZAjEpFo6fDJatrpK/p5rjTlPQEkYyR2vqfeFV9BB6tTpKJuaNai7LJcc5KR3S5PH6CbrtvCHM6PwREsgrOuyahANMunSepY1WhzLGT3SKvIzqt/KQ+ldUZtmWJ2MvuUE7TO01wayF6rD3pWwwyvmWMJi/osQWsEkkmcWkggOI+D9OG24mcJZhvsVkAXZ0p3jFtxr5SCrPCN5lw4uSPJ1ztI1AknTuxWjK5wskACg5957r9eQhgX8UT2LEwSdbc/bccoOmwF/psCiTWXGZ1Ce9dqhPQOqGXNDntWD+urevEg74PaloMSy1seqJTz/PK1Uq6oj9gn2+fM/J1B9VV92isOYy8ygNDK4QBrWeROaDPB3GUQSojPUVIB3noMPkIx+gra1sdCSzFigWdThhsvGe4jwDql8c8de3LmdycVIXtNrc6ppcmhU/FqO807LkvTi9VjiSaI6MbA6o5mKJpI6Hh1GhJYtmW409KXzbzNLUuaZR0hc16Qh6yBwHbqgRQXl484b5xERM+Yqr7kew7UCU4j4kol4vmSY9bjlhEWqSed3Q63l7S+rQQGXVwqtL5+OzSK1u4ReU8L2sRpNV1wuWCjv9TNdU/CH7264FQXdVKvm82EVmGFgfmtw79r6BHMMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNvdlNhTzVyYkpCM3lCV1VuWlcwaFFDME9qclkrNGYwYTVyNWdnSGxkNUQy?=
 =?utf-8?B?YzJ6M0xYOGZMMzBTYkZ2MmNjd0VRcVY1Ukw0ZVQySkZLbEs2aGhhOEZ6VFY5?=
 =?utf-8?B?WlNsZ2pPSDBqT3JDemw5a0VLMXQvdXpwK0JuMmZidjREYmJVbHcyY2FDVXpo?=
 =?utf-8?B?VXNiQU1teVFoNllsSUhKTUMwcVB4amNSdElVSFMxWENvQmRDTFlQVk9hWWRT?=
 =?utf-8?B?OU5OWTJ1MFBxbTFPcU1jNDkycUUwWDFOcW9jdElxWndOMkR5c2RvTnZZNklC?=
 =?utf-8?B?WElYTkhmajE1SXBPN1JHYURsSThDSGpPbVpaVlBVWW1ab3ROSkY2WFhZWEZ3?=
 =?utf-8?B?MkpvcDlzcTdEQjM5TGNWUFc1cjRBeWxEeEZlOTU1U2RnRnBuM01hZk1PVGJS?=
 =?utf-8?B?RHNIUVBRSXlsU1o1eFlrSlFZYlFHOGFkRHRKMWhmSXZpUGl0dFZ4bFE5OTZj?=
 =?utf-8?B?SzJTcTNya01iaWRQbGo4aWxKdzlFUVM5UGxwYzZMdm0yMEFJVXQvQVozVlpw?=
 =?utf-8?B?SFBEWkswbnJPNkc5TjYyN2xudU1rVlZFVWRHL3paQ3RqL3ZyZ2FBZVhYSmhX?=
 =?utf-8?B?Nzh0NWdUUFYxdUh6TmZIUFlva3RMM0p5d2Q1UUozMmZyOWNSQWl2NUN2T1Bv?=
 =?utf-8?B?c1VuVzdVajI0bk50Z3ptTHJ5Nm5sZ3U3TlBNN3F5YWFyenY5SlZIUGx1TURQ?=
 =?utf-8?B?bEV4OVRyMnVtVkFkNHZtTCtURG1RZXJWaHlLLzdhQlRSUEc5dUJ3TzRaWHhO?=
 =?utf-8?B?Mk5SaVIxQy8zNmI5MHhtK29pVHFsZ0lQZDBtTmJsREFEWFcxVW5TU013YVgr?=
 =?utf-8?B?VHhzbUlneDV2ZGd2VXRxRTNiSlAySFpQYUxiUFBNbmlybHJCUWEraURYaEtm?=
 =?utf-8?B?a1ZZRlBrSEROU1Z2WHc1MG5SRUF4eHFMVFFpd3VxVUJCenoweGpnZkpVcldu?=
 =?utf-8?B?NDU1YThZZXFHUFdVdmhaZ3ZyTGZBNkN0UURwRi9yeHJ3cDBlOUpKaGQ0MnBh?=
 =?utf-8?B?UjFPY04rTGloNzkzbC9IUHRTM3NrWTNyVHhveVE5bllnMndrdVlaQ1pkYU9s?=
 =?utf-8?B?bmVrSEFwK0VJSGJYSXdVQ3p3ZFFWVi9ZQitoZGdaU2hhOFkyRDhabTJMdE0w?=
 =?utf-8?B?UDNEa0N2a1J2N3VmMDlyMnR3aE10US9IUUs4b1AxVGtuOUxYNVNaeGdVN0Jw?=
 =?utf-8?B?ZStPbExPWlN5cy9vMmhPcUF4bEdjRXZudThNdGoxSWRHaURhTTVzc0dINjRs?=
 =?utf-8?B?ZnFMSlc1ZkttNmR4UjVLTWljc21mYjBlUGpMc29XZEh4RzBwSkw1SUJkZVZJ?=
 =?utf-8?B?ckpuc1BsRDFLbi9vaHdNNFNDeG16ZW9zOVlla1pud0JIYktUcmExckFyTk5h?=
 =?utf-8?B?WlhTN2NYOTRQZldmR0o4b2VXT2UwUEJibVh2aVFlczhkNHkxSFhQQVFNUE9Q?=
 =?utf-8?B?RzFHZDBZc2paQjdRMHRsSERySkJZY1FIUjdQQUlDV1E4ZWd6LzZIeDhRYXEy?=
 =?utf-8?B?Y1o2dElXeGxsdzFOVXVRYVVWN1ZPcFFqYkkzM1pDUGdnUnEvSEY4VEtoVngw?=
 =?utf-8?B?QmM5aUF5b2dSSmdicnhBTXozV3gyZzdXOGZCM3VXcWFZa2l5RnkyVUpXREN6?=
 =?utf-8?B?L2dIcEZiamplZ0V2OXJYM2pua01nNXcyQ0FhWHlDcU0vS1lJb2VFWXE2S2kr?=
 =?utf-8?B?M3UxWnEwd05jR2VYZUlmam5ueE9mOCs0VUJtTnl2ckhNRHllNUVUN2RPc015?=
 =?utf-8?B?ZzhqQllIWkVlUTljdkljbGdVVnIxRDUrRHp4V3NhU0FST2VlcW1KM0hPWjFH?=
 =?utf-8?B?cUhDbkx4QzZUR0k4SWdzNC9ySk5nMVp2WE9QUnRsVDE1cTM2akRhZS9vSkI2?=
 =?utf-8?B?VXJZb3NHL2RPb3ZpbVkwZU5rT0dEYmhNWUYrcWhhd3I2TFFOWmw5QmhsNTV5?=
 =?utf-8?B?dXZRSEl3czRka3RCNVlncERtYWsxZU9scWVvUzdGSEtVK2pWbE55RTBtb1VI?=
 =?utf-8?B?Q0RXUlR6RURCb25VTVNDK3V0dEJWMEVNSXU0L0Z5VjBuY2lFWTJMeXMrVXVn?=
 =?utf-8?B?Q2FxODQzaFlTeDg0a2MwdE5oT0tiRFB2NThxcE9kSU85dkExZ1NVbEQ4OFlJ?=
 =?utf-8?B?Nmg1cnQ4RlNNUldTYWtROEZGKzFQM2pZUTdrS2docWdoeGtsMFpVV0lDdXU1?=
 =?utf-8?B?M2RnYTNUYWVZVW9CQm0wSHpuR3V3VkZlSURsK2pwMUlPY2V4dHZWZTY5VHlW?=
 =?utf-8?B?d2w1ZXZyVk84ZUNKMnEvVldiRlBvblY0YUp4VDZzbU5MeHRVY0lHSkNlL0pm?=
 =?utf-8?Q?N2WmuKzBaBVieNLcpi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f07d92-b09d-4f44-bf72-08df090b312f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 15:59:38.4129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nmkbv9p30IUVI9bnliwVPaZZESj79DcE4d4rwyIUTR22GNT+ZElA5oxpBdakOFrlqYNNhxt3R9XKrhvRJyvuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB222952
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExp
am8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMiwg
MjAyNiA4OjU5IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hB
Tk1VR0FNQGFtZC5jb20+Ow0KPiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBBZGQga2VybmVsIFZNSUQgdHJhcCBoYW5kbGVyDQo+
IGluZnJhc3RydWN0dXJlDQo+DQo+DQo+DQo+IE9uIDAyLVNlcC0yNiA4OjM2IFBNLCBTcmluaXZh
c2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPiBNRVMgb3ducyBrZXJuZWwgcXVldWUgVk1JRHMgKDEu
LmZpcnN0X2tmZF92bWlkLTEpIGJ1dCBkb2VzIG5vdCBwcm9ncmFtDQo+ID4gU1FfU0hBREVSX1RC
QS9UTUEgcmVnaXN0ZXJzIGZvciB0aGVtLiBBZGQgaW5mcmFzdHJ1Y3R1cmUgdG8gbGV0IHRoZQ0K
PiA+IGRyaXZlciBwcm9ncmFtIHRoZSBmaXJzdC1sZXZlbCBDV1NSIHRyYXAgaGFuZGxlciBmb3Ig
dGhlc2UgVk1JRHMNCj4gPiBkaXJlY3RseSB2aWEgU1JCTSBzZWxlY3QuDQo+ID4NCj4gPiBBZGQg
a3FfdG1hX2JvIOKAlCBhIHBpbm5lZCBHVFQgQk8gdXNlZCBhcyBkZXZpY2UtbGV2ZWwgVE1BIHNj
cmF0Y2ggZm9yDQo+ID4ga2VybmVsIHF1ZXVlIFZNSURzLiBVbmxpa2UgcGVyLXByb2Nlc3MgVE1B
IChjcmVhdGVkIGluDQo+ID4gYW1kZ3B1X3RyYXBfYWxsb2MpLCB0aGlzIGlzIGRldmljZS1sZXZl
bCBhbmQgbGl2ZXMgZm9yIHRoZSBsaWZldGltZSBvZg0KPiA+IHRoZSBkZXZpY2UuIEl0IGlzIHpl
cm8taW5pdGlhbGl6ZWQgYnkgdGhlIE9TOiB0aGUgc2Vjb25kLWxldmVsIGhhbmRsZXINCj4gPiBh
ZGRyZXNzIGlzIDAgdW50aWwgdXNlcnNwYWNlIGNhbGxzIFNFVF9MMl9UUkFQLg0KPiA+DQo+ID4g
QWRkIGFtZGdwdV90cmFwX3Byb2dyYW1fa2VybmVsX3ZtaWRzKCkgd2hpY2ggZGlzcGF0Y2hlcyB0
byBhIHBlci1IVw0KPiA+IHZtaHViIGNhbGxiYWNrLCBhbmQgYSBuZXcgcHJvZ3JhbV9rZXJuZWxf
dHJhcF92bWlkcyBob29rIGluDQo+ID4gYW1kZ3B1X3ZtaHViX2Z1bmNzIGZvciBwZXItR0ZYLWdl
bmVyYXRpb24gcmVnaXN0ZXIgd3JpdGVzLg0KPiA+DQo+ID4gUmVxdWlyZWQgZm9yOg0KPiA+ICAg
IC0gUkFEViBncmFwaGljcyBkZWJ1Z2dpbmcgb24gVmVnYS9OYXZpL1N0ZWFtIERlY2sgKFZhbHZl
IHJlcXVlc3QpDQo+ID4gICAgLSBDb25zaXN0ZW50IHRyYXAgaGFuZGxlciBiZWhhdmlvciB3aGVu
IHN3aXRjaGluZyBiZXR3ZWVuIGtlcm5lbA0KPiA+ICAgICAgcXVldWVzIGFuZCB1c2VyIHF1ZXVl
cw0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQo+ID4gQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmlu
aXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiA+IENoYW5nZS1JZDogSTA3MDllNzg4ODM1YjY5
ZDNkNDkyODY0ZGU4ZDVjMmQzNmQwZjA4YzgNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCAgfCAgMSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhcC5jIHwgMzcNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhcC5oIHwgIDIgKysN
Cj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+ID4gaW5kZXggM2NhMTg3ZjVh
ZGU4Li41NjI0YTVhYjVjNjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oDQo+ID4gQEAgLTExNSw2ICsxMTUsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3ZtaHVi
X2Z1bmNzIHsNCj4gPiAgICAgdm9pZCAoKnByaW50X2wyX3Byb3RlY3Rpb25fZmF1bHRfc3RhdHVz
KShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBzdGF0dXMpOw0KPiA+ICAgICB1aW50MzJf
dCAoKmdldF9pbnZhbGlkYXRlX3JlcSkodW5zaWduZWQgaW50IHZtaWQsIHVpbnQzMl90DQo+ID4g
Zmx1c2hfdHlwZSk7DQo+ID4gKyAgIHZvaWQgKCpwcm9ncmFtX2tlcm5lbF90cmFwX3ZtaWRzKShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdHJ1Y3Qg
YW1kZ3B1X3ZtaHViIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3RyYXAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3RyYXAuYw0KPiA+IGluZGV4IDMxZjY1M2VjM2ZiMS4uMGUwYWVlYTBhYTJkIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFwLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhcC5jDQo+ID4gQEAgLTI1Niw4
ICsyNTYsMjMgQEAgaW50IGFtZGdwdV90cmFwX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ID4NCj4gPiAgICAgbWVtY3B5KHB0ciwgdHJhcF9pbmZvLT5pc2FfYnVmLCB0cmFwX2lu
Zm8tPmlzYV9zeik7DQo+ID4NCj4gPiArICAgLyoNCj4gPiArICAgICogRGV2aWNlLWxldmVsIFRN
QSBmb3Iga2VybmVsIHF1ZXVlIFZNSURzLiBQaW5uZWQgR1RUIOKAlCBub3Qgc3ViamVjdA0KPiA+
ICsgICAgKiB0byBldmljdGlvbi4gWmVyby1pbml0aWFsaXplZCBieSBPUzogc2Vjb25kLWxldmVs
IGhhbmRsZXIgYWRkcmVzcw0KPiA+ICsgICAgKiBpcyAwIHVudGlsIHVzZXJzcGFjZSBjYWxscyBT
RVRfTDJfVFJBUC4NCj4NCj4gSG93IGlzIHRoZSBleGNsdXNpdml0eSBtYWludGFpbmVkIGFzIGEg
dXNlciBhcHAgZG9lc24ndCAnb3duJyBrZXJuZWwgcXVldWU/IEhvdyBpcw0KPiB0aGUgY29uZmxp
Y3Qgb2YgZGlmZmVyZW50IHVzZXIgYXBwcyB0cnlpbmcgdG8gaW5zdGFsbCB0aGVpciBvd24gc2Vj
b25kIGxldmVsIGhhbmRsZXIgb24gYQ0KPiBrZXJuZWwgcXVldWUgaGFuZGxlZD8NCg0KQXMgcG9p
bnRlZCBvdXQgYnkgQWxleDoNCg0KICAtIEVhY2ggcHJvY2VzcyBnZXRzIGl0cyBvd24gcGVyLVZN
IFRNQSBidWZmZXIgZm9yIGtlcm5lbCBxdWV1ZXMNCiAgLSBJdCBpcyBhbGxvY2F0ZWQgYW5kIG1h
cHBlZCBhdCBhIGZpeGVkIFZBIGluIHRoZSBwcm9jZXNzJ3MgR1BVVk0NCiAgICB3aGVuIHRoZSBk
ZXZpY2UgaXMgb3BlbmVkLCBzaW1pbGFyIHRvIGFtZGdwdV9tYXBfc3RhdGljX2NzYSgpDQogIC0g
QmVmb3JlIGVhY2ggam9iIGlzIGRpc3BhdGNoZWQgdG8gYSBrZXJuZWwgcXVldWUgVk1JRCwgdGhl
IGRyaXZlcg0KICAgIHByb2dyYW1zIFNRX1NIQURFUl9UTUEgdG8gdGhhdCBwcm9jZXNzJ3Mgb3du
IFRNQSBWQQ0KDQpUaGlzIHdheToNCiAgLSBBcHAgQSBzdWJtaXRzIGpvYiDihpIgVE1BID0gQXBw
IEEncyBUTUEg4oaSIGpvYiBydW5zDQogIC0gQXBwIEIgc3VibWl0cyBqb2Ig4oaSIFRNQSA9IEFw
cCBCJ3MgVE1BIOKGkiBqb2IgcnVucw0KICAtIE5vIGNvbmZsaWN0IOKAlCBlYWNoIHByb2Nlc3Mg
aGFzIGl0cyBvd24gVE1BIGJ1ZmZlcg0KDQpOb3RlOiBTRVRfTDJfVFJBUCBmb3Iga2VybmVsIHF1
ZXVlIFZNSURzIGlzIG5vdCBwYXJ0IG9mIHRoaXMgc2VyaWVzLg0KVGhpcyBzZXJpZXMgb25seSBp
bnN0YWxscyB0aGUgZmlyc3QtbGV2ZWwgdHJhcCBoYW5kbGVyLg0KDQpGb3Igc2Vjb25kLWxldmVs
IGhhbmRsZXIgc3VwcG9ydCBvbiBrZXJuZWwgcXVldWVzLCBJIHRoaW5rIHNpbmNlOg0KDQogIC0g
RWFjaCBwcm9jZXNzIGhhcyBpdHMgb3duIHBlci1WTSBUTUEgYnVmZmVyIChhbGxvY2F0ZWQgYXQg
ZGV2aWNlDQogICAgb3BlbiwgbWFwcGVkIGF0IGEgZml4ZWQgVkEgaW4gdGhlIHByb2Nlc3MncyBH
UFVWTSkNCiAgLSBVc2VyIGNhbGxzIFNFVF9MMl9UUkFQIOKGkiB3cml0ZXMgc2Vjb25kLWxldmVs
IGhhbmRsZXIgYWRkcmVzcw0KICAgIGludG8gdGhhdCBwcm9jZXNzJ3Mgb3duIFRNQSBidWZmZXIN
CiAgLSBXaGVuIHNoYWRlciBjcmFzaGVzIOKGkiBmaXJzdC1sZXZlbCBoYW5kbGVyIHJlYWRzIGZy
b20gdGhhdA0KICAgIHByb2Nlc3MncyBUTUEg4oaSIGp1bXBzIHRvIHRoYXQgcHJvY2VzcydzIHNl
Y29uZC1sZXZlbCBoYW5kbGVyDQogIC0gTm8gY29uZmxpY3Qg4oCUIGVhY2ggcHJvY2VzcyBoYXMg
aXRzIG93biBUTUEgd2l0aCBpdHMgb3duDQogICAgc2Vjb25kLWxldmVsIGhhbmRsZXIgYWRkcmVz
cw0KDQpUaGUgcGVyLVZNIFRNQSBkZXNpZ24gaXMgdGhlIGZvdW5kYXRpb24gZm9yIHRoaXMgZnV0
dXJlIHNlcmllcy4NClRoZSBkZXZpY2UtbGV2ZWwga3FfdG1hX2JvIHdpbGwgYmUgcmVtb3ZlZCBp
biB2Mi4NCg0KRm9yIGxvbmcgdGVybSDigJQga2VybmVsIHF1ZXVlcyBhcmUgcmVwbGFjZWQgYnkg
dXNlciBxdWV1ZXMgZW50aXJlbHkNCiwgd2hlcmUgTUVTIGFscmVhZHkgaGFuZGxlcyB0aGlzIGNv
cnJlY3RseSB2aWEgQUREX1FVRVVFLg0KDQpUaGFua3MsDQpTcmluaQ0K
