Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B1FC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F7810F0FE;
	Wed, 23 Sep 2026 15:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJ7shOEZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EF210F0FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMiCvFWh/gBuwdF95OnFm3KEnnX3grGiBbGZnGh+4Uiae8nr+0kLlhcE5nGflur4LFLz3rSR+owwy0356j6lHi55AA43m0E6jHxlwDBCIdK5GAJ4c2Wn0lVHqH+j47YqqATMFmRk5kUuA7FrpNsZJp8uk898X8HInuvZ+/9l7l11SdvcY8dQIzI0hUWf0mqXOoVILQhpfv9ClNpj2i4TbfEfF8Jh2BJxIMlCGNqVoPcBTkyjUFz1qqyMDUdRG3za17jxU/u/FzDPAd2SjHGys5qUVYFtW9HiAgpQj0m9d9PiQq4jGXg/gqGx55x7mXlyIMYYkcHsHkoASepV3RZ8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9quRJxMuLczZbeREYQNCP9xy2BS3wm3jPXZTVQH6OKs=;
 b=uIbPVO94v4G8GbW4QWKUye3etFoggguWMhmM1W/+gVwtHpl+Bz847Oa7eEYSnbvw701NQ0JrtYEPE8wVWzarH2FQhA+E3TN4ToIS/Fa1ZYRu6+ixadV7WlRH9lQ/6kU6ELwVfBD1mo+JyMcWTmEcmOId0U18LtY3vv2IfjlpM9cuf2KVsC94Agc6VJkyVOLcB9dLzikSSWrfDyrlbgJ+Q8sM7cUz2w1O3cWjv4XSjSalwfRFdkxgag/OvWJFjqt22aMBEziicKEBmGMcRjgb1cxLCa7jGkCMpQvFM7Wr68vlPgcAQECG3Ue6sLho9gvRwMxOrltHKgXPd3ZJJjXOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9quRJxMuLczZbeREYQNCP9xy2BS3wm3jPXZTVQH6OKs=;
 b=NJ7shOEZc87aakh/y9PhKzT2fx7/d3Jp0PGDvwNGgHrEMHJ6AL13nEBlXuVXT2DYdCOfSUaG+mtbLlIQCU8iQ9QwEGYSWk067ytyffPw8QTlJ8JhIOSohhWJvjkYxFjS8Kmuef4/g+05PA5rwVF9BWzUskaryeyq3av8yT+y3ms=
Received: from LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:02:09 +0000
Received: from LV9PR12MB9831.namprd12.prod.outlook.com
 ([fe80::4443:20b2:9c80:56c8]) by LV9PR12MB9831.namprd12.prod.outlook.com
 ([fe80::4443:20b2:9c80:56c8%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:02:09 +0000
From: "Welton, Benjamin" <Benjamin.Welton@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
Thread-Topic: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
Thread-Index: AQHdS2Qr80mAaEspy025vnk1bYPg6bbcP3HA
Date: Wed, 23 Sep 2026 15:02:08 +0000
Message-ID: <LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <a97514f5-8a01-48bb-b1f0-645ac657bb0f@amd.com>
In-Reply-To: <a97514f5-8a01-48bb-b1f0-645ac657bb0f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T14:52:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR12MB9831:EE_|DS5PPF5C0B6C3B6:EE_
x-ms-office365-filtering-correlation-id: 8ac51ebb-ab3f-4e60-3d2c-08df1983a3d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: p++yu3xI5PaUCyrLzZ7XSnp4S3bxaBtuw/vusjHg4n9Gjs39O8v8CP9bRYel9EkaT2Lq8Mj1+eCTcCOKMOqS+v0EthQn1z4jQbD5BSbxOCxrJItfJnJRI9rPwn0vplqHuacOtMv0n4T5+BpSwpaVVRQsEvh2Snb0AMZYw04/cv0V5+qj8yajnXCEQ26yJhAvfF/trxc1WxyKf57bRXlMmXxMbXcFMfNIGWYjdfATZfjm1e8myi3AU1kRLhTozsuKvZd+D45bbbCLJvXeFhIdPIU8errdgjowM9w8+QLHF70dy2mg4vH59N1RCAxqe9QYblcxFZyStZcPukWOzW7pd+z4w8mH24yWKh0f5GK5GzHTBtdXcrVJlMm22NlfZjYDBKFWa5O6OSRF3aKYfD2no1ARBLR4QGpAQFBirtxkvtj2zVOqwXGX1e/DcgP+BBsByuyUXvo52lfeGC3m3s9uyXjY5uvg/2TWafwBAorMEst5pwJ8uaZh3neiT4fBToK3nJzwgaUZ/3IwO/PRAcsyomIyE9iizFPHY7+AzWjlgK4XsW0gHqNV3t707+riL0FkWhy3CXXGm91ROUcbTd8IjArQY+iBY7pOIK6MH1Sk+Wj89Br/IfgyECjCUD3OEGTrItMgHN6tYilOKH8u2E4/7AuHJoeOmf6fFFEOGl+Edto=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV9PR12MB9831.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNUOEtOZS9zU05sQ2Q1czg5QjFQck1GYTdaOVFJTDZnMUE1Nm16NXBPMHdX?=
 =?utf-8?B?enpGcXN4L1FuRS8wQ05OMlpmSHVzTjEvTDBwektiWWJBNTdQYTJzNXh0b2s4?=
 =?utf-8?B?WlpuZEwvT25MZ3p4Rks3d1B2OW5uRjlOSXR6MWY0QVZRV01KaEREd3J3bTQw?=
 =?utf-8?B?blBNajQ3cEE3TzI1UTg1RVhpQ1AvU1M4bDd0dGNyTGZKWUQ3SW5XY3BHdUlT?=
 =?utf-8?B?TE44b2xUVFdRU3c0dk1CMUxZa2Y5STVYRVRFSWtFaFVkQ3Vxa0tnb0NscjZm?=
 =?utf-8?B?b2dNQTF2TkQ4VVFMRG9MTHVwNVNTcUQxTG9EVm9XVDJjVWMzelczeWduK0hs?=
 =?utf-8?B?M3hFSURiemRWNVN0MW4rRGtiQm52aUxlQnYzam00c3g4bldPU0N4Q3FEK2k0?=
 =?utf-8?B?UjF4REloa3FsUDE0ak84U2ZZclp1Q2lNdkJwS3Z2UHRjcjNKT1pxUy9oajUr?=
 =?utf-8?B?V3BMKzh2U3NsNnZLemdLTWp1QUNDU3JBUVAzbEZmSFEveU5HbDE3cnpOajk2?=
 =?utf-8?B?L0R4QzlqR2pjVmtNdTg5bUw0TUwrZGxtTUVWVDZxYy9SQWlrMWVCdWtCM21L?=
 =?utf-8?B?dE5rSVZ5VzlhRFBYV1JPaFpzRjBYSEZzaHBHYmQ4alZxTjI1Q3V1bEJnWG5R?=
 =?utf-8?B?NjNEQThsZXZrSUZYTUZHVU1DRnVXTVYxN2dFYkQwbjlCdkdHdEVBZ25iZzlu?=
 =?utf-8?B?OHcxRDE5dmRYSFduYjlUT3V0UmMrTXMzamZ3bmJ0bnQ2VkllcWNLcjkvcjZS?=
 =?utf-8?B?K2dZQUJjVFlyRXp0M1Z4U29vaWJzcDhZeDhHakFDRlhUUXR1K0NZTkJLRHNo?=
 =?utf-8?B?RlVyajFraWVyZ0d3TkJkbGNNZ1diNVNIZm94ejQ0S3pVMGxMVnl1MmlIK1Nr?=
 =?utf-8?B?TU1FdHBiYXIyL3JGSUhuUUp2bWovRzQ2WlBCV3Q5K29pWitMZVlrOVEvcDBL?=
 =?utf-8?B?WEdGTGROWW9EVEpnUXR3T0dRWmdMaDYrUVdLb1BETzlTQ084cnZvZVlrOWhq?=
 =?utf-8?B?anRvUUwyNEhCS1BXMDRjTFE1OWM2WHZlVFhreUVnTGllVVhTLzlwODZZQkFQ?=
 =?utf-8?B?MTEzYzVvbGVxdVFNdkRMdHMyQTliM2R4MHBTRGx3c0ErNmRmUjZVNEcwbEdq?=
 =?utf-8?B?SG40YjQvUmc1MGpweU0vQUNPR2tmODFKOTNhTjhaNmpSaVNXeDNOa29FU0lN?=
 =?utf-8?B?ZW9sR3JnZmlDR1A0K21TZnd1aU5RamdOc2wybDN6bExXdFNEbC9lejg3Rm9J?=
 =?utf-8?B?Q1pGQ3R0WjAxWEVsbDF2eE9OK1EzL0RCQ1ltZlNVUmRJN0N4c2ljU050WkJ6?=
 =?utf-8?B?WGUyMkZFeDIrOWlPS0NuU0FBVGRjR2xzZlZ1bWpsQXEwcjNTWGswM1MxU28z?=
 =?utf-8?B?bDNjUXRnckxDYnFROG92Y1hLZmNaRVhMYXdqK0xPVDdtd1FIQXhlaEZqWkwy?=
 =?utf-8?B?N1dmQWJ0dUdMU1RWeHEyeFlnTkR5SitIbjNlRzJtQ0crYUR0T3NMVHpoVEYy?=
 =?utf-8?B?SEE2cFhzbTY2RHdQRDYxSVNQbEswWGorOXc2S1NZOEZQMmd2azNMYmlCTTda?=
 =?utf-8?B?VVpUaGF1VldFMEw0TmNoVGR6ZWV1cGlIL3lYQktSZ0lsRlpQQWNwZE9Zd3g3?=
 =?utf-8?B?di95N1c0U0ZlYXRtZXFJckxNdGhlc1llSjMxMkp0SDN0cjBvRUhXQ2VtdXZm?=
 =?utf-8?B?TVNObXVzWmYvMmNqc2JoY0xodEdHWmtkekFGeFNQM25jWTVPQ2NYbUdzTG44?=
 =?utf-8?B?YWtkSnorWTJHdW1FN3EyWHQySThKYVo4OWpITGJqZ2JydnR3ZWlGLzdSNHN4?=
 =?utf-8?B?OVFpTmw3TXVtSHBnWDNLbk8zV09DTDY1T0FXb3dyd0F4NkRpcXZCUS9lanNq?=
 =?utf-8?B?dXJuRGVvbVRYK256N0RDU29TbG5OcE5haU5rOWRLYVFpaGVhajgxTkhmc3g3?=
 =?utf-8?B?QW9Edy96bVZtT2Z3T1doT1AyUXVRWTZhV2JyNTNWTCttN2xldUYyVFI3ZVhJ?=
 =?utf-8?B?UG1IOERZNXZWUzBEaHdNeEV4SnJnVEJ2K1RwcGh5cGpJSTRqYk4zbHpFYktE?=
 =?utf-8?B?QkEwS01PQmZTWXVZb2U1dzBVVk5sQ29SYlZ5ZG5RMzd3M2NDR21CdndZUThS?=
 =?utf-8?B?bFVCdEViNE1PMlE1d0wySUI3bXlTc2Z0NjVDcnFWQTZoeWNtMGRRRmxIS25j?=
 =?utf-8?B?Z3J1dGJzU0xSRmNramhCclUyQ2RYTGNINHBvT1ltaVpVWit0U2o5bit2SW4r?=
 =?utf-8?B?SjZ6OHFiZk15VWZQUnQrNFRmNkloYUFhVUtudHJ4MGdnZ0h1K0phTkljTlBF?=
 =?utf-8?Q?cIz/x6mcCWJED1YiMA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac51ebb-ab3f-4e60-3d2c-08df1983a3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 15:02:08.9687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +o8PR2ZbVhJ2lNybDxG9oGXkolxcwwp3UX9/2dFX7jZJ9CaDgJ+VSNGKxkbR5kc+MaAqvn/mCqOc6cEigIO/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6
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

QU1EIEdlbmVyYWwNCg0KRm9yIHNvbWUgYmFja2dyb3VuZCBvbiBteSBlbmQsIGlzIHRoaXMgdGhl
IHBvcnRpbmcgb3ZlciBvZiB0aGUgZXhpc3RpbmcgcHJvZmlsZXIgd29yayB0byBLR0Q/DQoNCkJl
bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmh1LCBKYW1lcyA8SmFtZXMu
Wmh1QGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMywgMjAyNiA3OjAyIEFN
DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFdlbHRvbiwgQmVuamFtaW4gPEJl
bmphbWluLldlbHRvbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtSRkMgMDAvMTBdIGFtZGdwdTog
aW1wbGVtZW50IFBlcmZvcm1hbmNlIE1vbml0b3IgQ291bnRlciBzdXBwb3J0DQoNCkhpIEJlbiwN
Cg0KUGxlYXNlIHJldmlldyB0aGVzZSBQTUMgcGF0Y2hlcyBmb3IgdW5pZmllZCBLZXJuZWwgaW50
ZXJmYWNlLg0KDQpUaGFua3MgYW5kIEJlc3QgUmVnYXJkcyENCg0KSmFtZXMgWmh1DQoNCk9uIDIw
MjYtMDktMjIgMDU6MzQsIFpodSBMaW5nc2hhbiB3cm90ZToNCj4gVGhpcyBzZXJpZXMgaW1wbGVt
ZW50cyBQTUMgc3VwcG9ydCBmb3IgYW1kZ3B1LiBJbmNsdWRpbmcgdHdvIHBhcnRzOg0KPiAxKSBQ
TUMgRW5hYmxlbWVudA0KPiAyKSBQcm9maWxlciBSZXNlcnZhdGlvbg0KPg0KPiBUaGUgdXNlciBz
cGFjZSBzaG91bGQgdGFrZSB0aGUgcmVzZXJ2YXRpb24sIHRoZW4gc2V0IFBNQy4NCj4NCj4gVGhp
cyBzZXJpZXMgZGVwZW5kcyBvbiBhbmQgdXNlZCBuZXcgaGVscGVyIGludHJvZHVjZWQgaW4gYW5v
dGhlcg0KPiBzZXJpZXM6DQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVz
L2FtZC1nZngvMjAyNi1BdWd1c3QvMTUxNjkyLmh0bWwNCj4NCj4gUGxlYXNlIGhlbHAgUmV2aWV3
DQo+DQo+IFRoYW5rcyENCj4NCj4gWmh1IExpbmdzaGFuICgxMCk6DQo+ICAgIGRybS9hbWRncHU6
IGltcGxlbWVudCBQTUMgaW9jdGwgZnJhbWV3b3JrDQo+ICAgIGRybS9hbWRncHU6IGFkZCBkZXZp
Y2Utd2lkZSBQTUMgY29uZmlnDQo+ICAgIGRybS9hbWRncHU6IGludHJvZHVjZSBQTUMgaW9jdGwg
aGFuZGxlcg0KPiAgICBkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgcmVzZXJ2YXRpb24gbWVjaGFuaXNt
IGZvciBQTUMNCj4gICAgZHJtL2FtZGdwdTogc2V0IGRldmljZS13aWRlIFBNQyBlbmFibGVtZW50
IGluZGljYXRvcg0KPiAgICBkcm0vYW1kZ3B1OiBHRlgxMTogc2V0IG1xZC0+cGVyZmNvdW50IGZy
b20gbXFkX3Byb3ANCj4gICAgZHJtL2FtZGdwdTogR0ZYMTI6IHNldCBtcWQtPnBlcmZjb3VudCBm
cm9tIG1xZF9wcm9wDQo+ICAgIGRybS9hbWRncHU6IEdGWDEyLjE6IHNldCBtcWQtPnBlcmZjb3Vu
dCBmcm9tIG1xZF9wcm9wDQo+ICAgIGRybS9hbWRncHU6IGltcGxlbWVudCBkZXZpY2UgUE1DIGhh
bmRsZXINCj4gICAgZHJtL2FtZGdwdTogc2V0IHVzZXJxIHBlcmYgc3RhdGUgYmVmb3JlIHB1Ymxp
c2ggaXQNCj4NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZSAgICAgICAg
ICB8ICAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAg
ICAgIHwgICA4ICsNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgICB8ICAgMyArDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
ICAgICAgfCAgIDQgKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMu
aCAgICAgIHwgICA2ICsNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJv
ZmlsZXIuYyB8IDE2NiArKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Byb2ZpbGVyLmggfCAgMzggKysrKysNCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyAgICB8ICA5NSArKysrKysrKysrLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oICAgIHwgICAyICsNCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyAgICAgICB8ICAxMSArKw0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMC5jICAgICAgIHwgIDExICsrDQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8xLmMgICAgICAgfCAgMTEgKysN
Cj4gICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAgICAgICB8ICAzNiAr
KysrDQo+ICAgMTMgZmlsZXMgY2hhbmdlZCwgMzkwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wcm9maWxlci5jDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wcm9maWxlci5oDQo+DQo=
