Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A442DC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 15:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CBC10F82B;
	Fri,  3 Jul 2026 15:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3Vn6f7v";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AE110F82B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 15:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV1lYRx87IRT9QjBLV5exrpt1VrWJINPvOu0fLgRk69+ddVnTkckqPU+dpFpUoZj4YxccjgcAsj7885myBfBr75m+cn5pjNeqo0nvln2oAFTIMniozj+moUaHObrKvyoDC9TNuz75z8EClP3pY85QZnDnItfu1tBFWMubNLBP0yzCuYtbMf3WqwTavjD81h/x/Z3KPH7s8x3ZoHQ1exlfaLl31MbNDg4SLbDhOhQcz27jwXCCo8u5HDmj9OaFp/fC4DcO4oD0O4Z7ykhQ2ZHrRG5xa+MWRCCE9ynOBtmzQ7GfK4NyNHLOgD9Hh8xwgOtjwy656pFUzvIqA2wibCR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfYpJ7a9SnwfNV6XA528umJKGkzwW68TtL0Y4r6Cr6o=;
 b=xrlGhnJPXXJ+5UlOsRpnI9dkLWvidwgt7LtrddYBwDoH0iyOSvEnZSPy3East5UwEiAwhJwczGYrD0+ASr4u5Q3z9s1EXfKKRBktFiYxL4G0UtDEgPaYCM6QgkF70iInHGd2P6o7K8ebht1wuA257lLSVsQ8och8f/r47ofjzXoMOFFGf2QubbHqVz6mRwmDBbS/UXnUWlW44Q6GHvfgerWp7h9myqi/eHqUb3+FR0U1ItzA0FJ0tseK+di74iLD4dOA2ezCX04fp2epExzK4s0QUDCZxV68mN5QSoWFWSPyigfMdac3qlFCg8NB7UBix5JJF4ToQiRGl78rwz8pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfYpJ7a9SnwfNV6XA528umJKGkzwW68TtL0Y4r6Cr6o=;
 b=B3Vn6f7vNmeX+vjB6IwluxaGrGHmtrUv//si2vXMV62uIwqK1O2SG9/+zmjkysiR/S1Vl/Ck0kWmCkij6FQ/LaC9Fb4YK+O1MmDfQyJgoNvyxlYolsjC3Up9BA3Go41zLatkKFpNbs/by+/GEnlCLQ32nmSScg4WwwtIyTksLzs=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 15:00:42 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 15:00:42 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 1/3] drm/amdgpu: Allow PASID allocator to store fpriv
 owner
Thread-Topic: [PATCH v4 1/3] drm/amdgpu: Allow PASID allocator to store fpriv
 owner
Thread-Index: AQHdCrPXvGQfUmUg6kuaEhUVii1C1rZbaGwAgAB67IA=
Date: Fri, 3 Jul 2026 15:00:41 +0000
Message-ID: <IA0PR12MB82082CFB215248D098DB12B590F42@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-2-srinivasan.shanmugam@amd.com>
 <9a74a1b3-3f8f-4caa-b0ce-a94dd34d4a7d@amd.com>
In-Reply-To: <9a74a1b3-3f8f-4caa-b0ce-a94dd34d4a7d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T14:58:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS7PR12MB5719:EE_
x-ms-office365-filtering-correlation-id: 809caf40-b52e-4d7b-d588-08ded913da1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|4143699003|11063799006|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: YCi3ywN9D+tRxL4Mquf6o8bbYlo/eYn5OQDqv9661Dtw3XJPuyeairRLwtdyeUlfnCc0qfKK6eJAfdK8wvmsFpvxyrK+PDCPMCCdKvakesGWyRV0XK7u19rkCZVKNgtfmUsCZ9d3E3RE5au1bfETwsqeDjdzFTQvdltf2ZXsj+7vPMfjU69YikzomK34B7vHrE+gnH73IcGRIVMV/mBuGsUKmOwAZm1pDznFi1tAiSSg16GNpMFrzgYOU2y5Cvt/S2ywRx4kYk1vqKFmtu3CfMJe7TgRE9AtmUeWYMM4AOFPrDsVoHicK8PNWUmj0uaxM9QgZqN6K1ae+SpT/QX0TAgagUpNZbh5ETrEL/j2KQm7vdjvnUinQgNsQeXXtl4BmlPXxxeCAYX58NmhtRWP10upPerKEgP2wlHrMgj0Mlrt66gMs+NLTrBO1lCXJTQh5uxCtH3KKFvFaEzWvjCxLbYgeu6wyXQQ/k/v5cRNawnd2UYg/Bt2wJqiz5WJNDtC84VBDoOIvEfsIylzQBaRKl5P/+Up0/9CNxEQ2dCqEYmXQ4Osl/fDvTB1MZIwrEYxmbGYN7siDPH9rGJFL4DA5ZXm3rDxojXDabpigRLz7h0Lo0AplIlyYpX0Kvt9s/cJPuPb/aKY2v0CVVHTLuL+VjACvpKR86/CwwRc6JLQFSeWiKEZs3XKMtuqzAdmr4jqpyK5DoQFOzTrmlg/sMwv+Lhzr2NCtwj995eeKL0s/88=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(4143699003)(11063799006)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnAvNndERFVzcDZQOFdRZU1yZ2NjYU1QNHh4N3d5blg5Tnh1RThsMXJRUHVn?=
 =?utf-8?B?eG5pYk43b0l0WEZ1alJLUmYwWFF2K01xMXVkVWRpbG93cGxLRGR4ZEMwbGlx?=
 =?utf-8?B?RC9jNUJRZGNsdGNHSWV3eXRaYmZGajJwYWpVWUNNcXFSSW1FbnFvWElhUzBH?=
 =?utf-8?B?WDRoVmJSSW1kZFl0V29HMkwvQTRiUnVNS0djaHRkZmhCU0lEem5Hc0VMdzdh?=
 =?utf-8?B?SkhxbitHOTdiellmUmMxdmcybWU5VEtJdWdiaW1XOXphRDV3Q1RSa0FrZzEx?=
 =?utf-8?B?K1FjNDIvSHpFWEthT05uZFo1eWQzcXNIdzNMTCtTblprQmZJNFN5S1FUM3Rv?=
 =?utf-8?B?UnNtT04zd1hHWDJCR2JhM2xBR2FkT3h2b20vaTZ6clhVdUtkRmNRNUo4SWRU?=
 =?utf-8?B?K20vNWRTL2JYYjY4ZFF4T1NWUk9lUTk5dFFGQ3d6NE9Rem1Xak84WnFwTm5B?=
 =?utf-8?B?TzYyOFdqVjBTaUdHdUY1VlMvVFcrQ2NIdVVXcktTSlE4VzJQTTVmNjBNSEd6?=
 =?utf-8?B?aHFrdmFta3Rqd1dwK2FrLzFpOFFyV3NObUNKUzhjMXlUMitEOUpHMXRJRlZl?=
 =?utf-8?B?dG1QaVpvTC9pM2dlczBpWWZFRWJwV0F2ODlhdG5xNEJDNTRVNGVLRmM0T1U3?=
 =?utf-8?B?dzRVY2VmQmI4akVNR29tckluQ1hZVnk1bG5DOUYvZGN1cjFudjF1akFtZFFp?=
 =?utf-8?B?ZkVDR2MrSDRlRjc0SDFjSjc4MHJMbWlVaVJPTW4yeTA3cXZTeStORi9BZTVq?=
 =?utf-8?B?bXlLWTlnSGhiZG9PdG9vbytmc3ZGeXorSzd0ZmVybGxYTVJqN3VsQ3Y0WDZn?=
 =?utf-8?B?aEpUYmhoVGVpNlMwamdIb29VWnc5MHhrb0xLSUNuNTc0cnVFbFkrbTJqSlh3?=
 =?utf-8?B?YisyY0x6RUFxb2FURHhIWVFGd2VYY3JnVTdtcWlQY3dsWXdJODFna2tUcEwy?=
 =?utf-8?B?SG0xOHNleGZibmFQSGxBeXRKbk9uZFdONExkVDFMQWczTVJwMUExbm5yVWRW?=
 =?utf-8?B?Q0ZFMURVOXNSY1pRQ3k4OGs5c05NODRlWkRXV3BLcWNrdGdsdWQwQ1NrVEpy?=
 =?utf-8?B?UUxaWjhXcGcxTnA1bFc1OXl5SU5Nd1dVNkFHbkZ6c2pvUXliTmY1R1U2YVhI?=
 =?utf-8?B?R1lNWFFiZDFNOU1Zc2hGcHlxbXkxd282ZzRrZkJpSHMzbHFpeFg4blFLeWJq?=
 =?utf-8?B?eWp1bVZpOVM3NXdTaXNqKy9zWDVmTWltRU51YVlaREQ4eGZGbWNyRXlDZWxG?=
 =?utf-8?B?V0c1Uy9xcWFJemdTV2RMTWoxVG1EUXUyL0pPSjArMlErSzlCZjNnREIwaWMw?=
 =?utf-8?B?cVRjOGdaVGdiWTRyZDhYU2NCMTFvNTdGdzM2cTFJSTVETDZTR1R4bFlJQmM3?=
 =?utf-8?B?UXpscXlVaG9EczhFT1ZDWFpzY0NjQVF0c2lad2tpSmdLR0N1UythR1ErRk1W?=
 =?utf-8?B?R0Q4elE2aTZGRlBqWHFSNmVNWmtpYTgxMWRiM2d6MktTdTBvOG5hck5JMGpG?=
 =?utf-8?B?YVkvMWZ1cElFLzdwRnV1NEt0aFdJbDYzVWE1NTRvNHpjRENqT0xXUGsyWDYx?=
 =?utf-8?B?cGtuT1BwNkx5SHFObU1uVXdvRi9ZdHV0VmRpOWlwZTdZRWFzT2NJL3E3aGRO?=
 =?utf-8?B?WTdaMW1kblhuQkpLallhaFplRHlWcnZiTkd0VTc3aGtDbTdLNEpzNW14dVU5?=
 =?utf-8?B?NExEcEJhMVFyZENlZll4VmpSejIzeTc5WWhxNWE5dkRYOFZwczU5MjhoTDJn?=
 =?utf-8?B?ZWdERjN6SHVaQk5LK25vMGFHdFJ3L0lnZkhEUHJTSVYvbnZkcEhWRjY3TFY2?=
 =?utf-8?B?L3FXdFUvc2kyN2h0YmdMekxzUkRZMzM4Z0dkRmlLaSsxNjJCY0VBQU5XdTRU?=
 =?utf-8?B?TCswcUt6Wmsvd01ETGdqR2hwcFAyb1liT1dsdnBLNGdrT1RURmRibmI4ZmhE?=
 =?utf-8?B?WHRvMXpvSElJUUpMLzNOWHJCZmM1Z3hQSDBNeTFDSURNaHdXMTBXbTVLdTNs?=
 =?utf-8?B?TXBLWW8rdFNPd0d2ZGJENVBPa29mdTNtVTQxckxEbjVRT0FqY0JocTlKT0pD?=
 =?utf-8?B?V0M1T0orYkhtZlZVZjhXNkxkYVM3K3JNbHlTZVNML00weFJxM0tHYUxTSzZ0?=
 =?utf-8?B?YVg5cS9ScngvcjFCWnFhMnpuVnAwL1J6YXR1QTJ0WE1rQk1GSnQ4MytiSlRj?=
 =?utf-8?B?UExTY011QzVnRGlhZjlhNlVCSUJMM2VLY2N2RHdnZEFPeEJ2dkRIczRncGpy?=
 =?utf-8?B?Qkt2RUc5UHo3MlNCemdJQTQ4ekdWZDBiMmQ0dldKTG1saDkwNG5IQVg0Tk9R?=
 =?utf-8?Q?emCa3AUMllZncOihQx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809caf40-b52e-4d7b-d588-08ded913da1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 15:00:41.9802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYIGnBb5gCeJG4uGbcp1VH9Ny87q7deeX9SpXFCgdIXkXYEjBiiEgZLvejF1D7KpGs8xJ2BwdmmHQdiWzbJs4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXks
IEp1bHkgMywgMjAyNiAxOjA4IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gZHJtL2FtZGdwdTogQWxsb3cgUEFTSUQgYWxs
b2NhdG9yIHRvIHN0b3JlIGZwcml2DQo+IG93bmVyDQo+DQo+IE9uIDcvMy8yNiAwODoxOCwgU3Jp
bml2YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gQU1ER1BVIGFscmVhZHkgaGFzIGEgZ2xvYmFs
IFBBU0lEIHhhcnJheSB1c2VkIGJ5IHRoZSBQQVNJRCBhbGxvY2F0b3IuDQo+ID4NCj4gPiBBbGxv
dyBhbWRncHVfcGFzaWRfYWxsb2MoKSB0byBvcHRpb25hbGx5IHN0b3JlIHRoZSBvd25pbmcgRFJN
DQo+ID4gZmlsZS1wcml2YXRlIG9iamVjdCBkaXJlY3RseS4NCj4gPg0KPiA+IEluaXRpYWwgY2Fs
bGVycyBwYXNzIE5VTEwgYW5kIGtlZXAgdGhlIGN1cnJlbnQgZHVtbXkgYWxsb2NhdGlvbiBtYXJr
ZXINCj4gPiBiZWhhdmlvci4gQSBsYXRlciBwYXRjaCBpbiB0aGlzIHNlcmllcyBwYXNzZXMgdGhl
IERSTSBmaWxlLXByaXZhdGUNCj4gPiBvYmplY3QgZm9yIERSTSBQQVNJRHMuDQo+ID4NCj4gPiBU
aGlzIHByZXBhcmVzIGZvciB1c2luZzoNCj4gPg0KPiA+ICAgICBQQVNJRCAtPiBmcHJpdiAtPiBW
TQ0KPiA+DQo+ID4gaW5zdGVhZCBvZjoNCj4gPg0KPiA+ICAgICBQQVNJRCAtPiBWTQ0KPiA+DQo+
ID4gQWxzbyBjbGVhciBhbnkgc3RvcmVkIG93bmVyIGZyb20gYW1kZ3B1X3Bhc2lkX2ZyZWVfZGVs
YXllZCgpIGJlZm9yZQ0KPiA+IHdhaXRpbmcgZm9yIGZlbmNlcywgc28gUEFTSUQgbG9va3VwcyBj
YW5ub3Qgb2JzZXJ2ZSBhIHN0YWxlIGZwcml2DQo+ID4gd2hpbGUgdGhlIFBBU0lEIG51bWJlciBp
dHNlbGYgaXMgc3RpbGwgcGVuZGluZyBkZWxheWVkIHJlbGVhc2UuDQo+ID4NCj4gPiB2NDogKHBl
ciBDaHJpc3RpYW4pDQo+ID4gLSBBZGQgZnByaXYgYXMgYW4gb3B0aW9uYWwgcGFyYW1ldGVyIHRv
IGFtZGdwdV9wYXNpZF9hbGxvYygpLg0KPiA+IC0gRHJvcCBzZXBhcmF0ZSBhbWRncHVfcGFzaWRf
c2V0X2Zwcml2KCkvY2xlYXJfZnByaXYoKSBoZWxwZXJzLg0KPiA+IC0gQ2xlYXIgUEFTSUQgb3du
ZXIgZnJvbSBhbWRncHVfcGFzaWRfZnJlZV9kZWxheWVkKCkuDQo+ID4NCj4gPiBDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCA4
Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pZHMuaCB8DQo+ID4gNiArLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jIHwgIDIgKy0NCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djEyXzEuYyAgfCAgMiArLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2lkcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWRzLmMNCj4gPiBpbmRleCA2ODRmNDBmY2U3M2YuLjY2OWQwZmZmOGNiYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMNCj4gPiBAQCAtNTIs
NiArNTIsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Bhc2lkX2NiIHsNCj4gPiAgLyoqDQo+ID4gICAqIGFt
ZGdwdV9wYXNpZF9hbGxvYyAtIEFsbG9jYXRlIGEgUEFTSUQNCj4gPiAgICogQGJpdHM6IE1heGlt
dW0gd2lkdGggb2YgdGhlIFBBU0lEIGluIGJpdHMsIG11c3QgYmUgYXQgbGVhc3QgMQ0KPiA+ICsg
KiBAZnByaXY6IG9wdGlvbmFsIERSTSBmaWxlLXByaXZhdGUgb3duZXINCj4gPiAgICoNCj4gPiAg
ICogVXNlcyBrZXJuZWwncyBJRFIgY3ljbGljIGFsbG9jYXRvciAoc2FtZSBhcyBQSUQgYWxsb2Nh
dGlvbikuDQo+ID4gICAqIEFsbG9jYXRlcyBzZXF1ZW50aWFsbHkgd2l0aCBhdXRvbWF0aWMgd3Jh
cC1hcm91bmQuDQo+ID4gQEAgLTYwLDE3ICs2MSwxOSBAQCBzdHJ1Y3QgYW1kZ3B1X3Bhc2lkX2Ni
IHsNCj4gPiAgICogUmV0dXJucyAlLUVOT1NQQyBpZiBubyBQQVNJRCB3YXMgYXZhaWxhYmxlLiBS
ZXR1cm5zICUtRU5PTUVNIG9uDQo+ID4gICAqIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUuDQo+
ID4gICAqLw0KPiA+IC1pbnQgYW1kZ3B1X3Bhc2lkX2FsbG9jKHVuc2lnbmVkIGludCBiaXRzKQ0K
PiA+ICtpbnQgYW1kZ3B1X3Bhc2lkX2FsbG9jKHVuc2lnbmVkIGludCBiaXRzLCBzdHJ1Y3QgYW1k
Z3B1X2Zwcml2ICpmcHJpdikNCj4gPiAgew0KPiA+ICAgICB1MzIgcGFzaWQ7DQo+ID4gICAgIGlu
dCByOw0KPiA+ICsgICB2b2lkICplbnRyeTsNCj4gPg0KPiA+ICAgICBpZiAoYml0cyA9PSAwKQ0K
PiA+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gLSAgIHIgPSB4YV9hbGxv
Y19jeWNsaWNfaXJxKCZhbWRncHVfcGFzaWRfeGEsICZwYXNpZCwgeGFfbWtfdmFsdWUoMCksDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgWEFfTElNSVQoMSwgKDFVIDw8IGJpdHMpIC0gMSks
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgJmFtZGdwdV9wYXNpZF94YV9uZXh0LCBHRlBf
S0VSTkVMKTsNCj4gPiArICAgZW50cnkgPSBmcHJpdiA/IGZwcml2IDogeGFfbWtfdmFsdWUoMCk7
DQo+DQo+IFRoYXQncyBwcm9ibGVtYXRpYyBJIHRoaW5rLiBUaGUgeGFfbWtfdmFsdWUoMCkgdmFs
dWUgaXMgbm90IE5VTEwgYW5kIG5lZWRzIHRvIGJlDQo+IGZpbHRlcmVkIG91dCB3aGVuIHNvbWVi
b2R5IGxvb2tzIHRoZSBmcHJpdiB1cCB1c2luZyB0aGUgYXJyYXkuDQo+DQo+IEJ1dCB4YV9pbnNl
cnQoKSBjYW4gaGFuZGxlIE5VTEwgZW50cmllcywgYnV0IEknbSBub3Qgc3VyZSBpZiB4YV9hbGxv
Y19jeWNsaWNfaXJxKCkNCj4gY2FuIGRvIHRoYXQgYXMgd2VsbC4NCg0KVGhhbmtzIENocmlzdGlh
bi4NCg0KSSBjaGVja2VkIHRoZSBYQXJyYXkgaW1wbGVtZW50YXRpb24uIHhhX2FsbG9jX2N5Y2xp
Y19pcnEoKSBnb2VzIHRocm91Z2gNCl9feGFfYWxsb2NfY3ljbGljKCksIHdoaWNoIGNhbGxzIF9f
eGFfYWxsb2MoKS4gX194YV9hbGxvYygpIGNvbnZlcnRzIGENCk5VTEwgZW50cnkgdG8gWEFfWkVS
T19FTlRSWSBiZWZvcmUgc3RvcmluZyBpdCwgYW5kIHhhX2xvYWQoKSBjb252ZXJ0cw0KWEFfWkVS
T19FTlRSWSBiYWNrIHRvIE5VTEwgdGhyb3VnaCB4YV96ZXJvX3RvX251bGwoKS4NCg0KU28gTlVM
TCBzaG91bGQgd29yayBoZXJlIGFzIHdlbGwuIEknbGwgdXBkYXRlIHRoZSBwYXRjaCB0byBwYXNz
IGZwcml2DQpkaXJlY3RseSB0byB4YV9hbGxvY19jeWNsaWNfaXJxKCksIHJlbW92ZSB4YV9ta192
YWx1ZSgwKSwgYW5kIHNpbXBsaWZ5DQp0aGUgZnByaXYgbG9va3VwIHBhdGguDQoNCmludCBfX3hh
X2FsbG9jKHN0cnVjdCB4YXJyYXkgKnhhLCB1MzIgKmlkLCB2b2lkICplbnRyeSwNCiAgICAgICAg
ICAgICAgIHN0cnVjdCB4YV9saW1pdCBsaW1pdCwgZ2ZwX3QgZ2ZwKQ0Kew0KICAgICAgICAuLi4N
Cg0KICAgICAgICBpZiAoIWVudHJ5KQ0KICAgICAgICAgICAgICAgIGVudHJ5ID0gWEFfWkVST19F
TlRSWTsNCg0KICAgICAgICAuLi4NCiAgICAgICAgeGFzX3N0b3JlKCZ4YXMsIGVudHJ5KTsNCiAg
ICAgICAgLi4uDQp9DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCAqeGFfemVyb190b19udWxsKHZvaWQg
KmVudHJ5KQ0Kew0KICAgICAgICByZXR1cm4geGFfaXNfemVybyhlbnRyeSkgPyBOVUxMIDogZW50
cnk7DQp9DQoNCnZvaWQgKnhhX2xvYWQoc3RydWN0IHhhcnJheSAqeGEsIHVuc2lnbmVkIGxvbmcg
aW5kZXgpDQp7DQogICAgICAgIC4uLg0KICAgICAgICBlbnRyeSA9IHhhX3plcm9fdG9fbnVsbCh4
YXNfbG9hZCgmeGFzKSk7DQogICAgICAgIC4uLg0KICAgICAgICByZXR1cm4gZW50cnk7DQp9DQoN
CkJlc3QgcmVnYXJkcywNClNyaW5pDQo=
