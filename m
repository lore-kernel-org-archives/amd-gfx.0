Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952FCCD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 18:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7061123F5;
	Fri, 29 May 2026 18:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvppNICi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE38F1123F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 18:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w03AxusOm12sMyeZfLn0gsoBpUjVOgE2hlx2BmkVBJayjz9CeZX53g3M5+X3c7hHO/ARjwczSN+0OY9G8JfqjLCHfmoh+fw4Tb57rMzpdcZeGy1+Ew1n5YSLIbBsCxq3ciYpDRSgpKKi+hkkQtRGGRvMfO93dyHgyno8180xYdAcpVQ7TfP3Escgkmp1uFkxOQacn8ptYCdp6qmOLQN9AJuOqIfNGs17mjA2Z3cPJHOy4UwYHhC9gFBKHjQ9NCeIF0bHFRpGzHgwBe75pGdcPaz/8e+xWla7ejvluIbyCCE33FMOK7inbA9l3DIqOdE12cLYOSoAw5Yh0dHSfPKmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OX2YC+oaXjW04i5b79Egy1kYez0WNA9gwlebsBB27c=;
 b=nwG6p+wzrAb81hRTYUD/1G3lcsTn/Csp/+feUWKGyIqU+I1rlk4T/H94TWjWyTwRhG+1lgUWDLCSkIwrTSXoKcM/DO/ifid/zAbAzNDOS6m9w3pUZMMqhPIDDgLOl9rHjA0wlEwaxbMVvUqOY/Ym23HGqw4NCbiYzoveJT/W2dcRrH9VZqpnmqlrmJuYtCISgyjbhz6xmdI2Ds7SK7dYiU7OixPps9m1hkpG3+PGApGznkHwDTUSAuqALQ19Pg4XUW5HMRxiyIuFtRrGBxb4yAvo5QkF9GdAjdWI3mC7PEMmj3KFOTOMFFNffoJG4nQ3VS8qJtODfesG4uwfnWY90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OX2YC+oaXjW04i5b79Egy1kYez0WNA9gwlebsBB27c=;
 b=vvppNICiwVfenPK5rBznxxXw92xGPaXF+QgqEr6/dHFxipTyWIaAKzHC9I7PqCFy/vH0bQe+hxz31bPbrTakF5+Xg0IJ16qPZBgyH2h4norzwl0YA/X2FrZ8HUYdNTs6aH8d951MyDr3SOESAGCnUwf1a9fLuHwj2kjJ+qu+PFo=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by MW4PR12MB7013.namprd12.prod.outlook.com
 (2603:10b6:303:218::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:49:32 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0025.020; Fri, 29 May 2026
 18:49:32 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, 
 "Li, Roman" <Roman.Li@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
Thread-Topic: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
Thread-Index: AQHc70rXEoPKjyzjIEqcKEsgzUBClrYlWMCw
Date: Fri, 29 May 2026 18:49:31 +0000
Message-ID: <CHXPR12MB9992202F881883E2C2C2D5FA6FE5162@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260529090909.13206-1-timur.kristof@gmail.com>
In-Reply-To: <20260529090909.13206-1-timur.kristof@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T18:47:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|MW4PR12MB7013:EE_
x-ms-office365-filtering-correlation-id: 624d6a7b-7563-406d-2a4b-08debdb3053d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020|18002099003|22082099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info: 5PlQeWSYpetvGX28vnhQ5vvrKFyvagj02kkxKRABim6u2fleZO06FUTgKNaQjZYlC/lwxiEcFT4EfA+nwBQr9gi+RGrv497IBW9hcsk6QTUluxZJbQmr3A2Skjz2vl0uW+nzRBzbHmyRKFDieYVQWU7fcX/TNBlCr7JCUYiH57uTnC79eqT/TYHmGxQT9WgvN6dtLTL0gsnsfcNZg6UKTLz0sAx/r4kSAkByK5jAaDzfCgJTAA1L9WdOPPTUjybHi59SSGFfHBLpcMkNJSRvFqZVQkkNCMwT/bhGBgZGmSUXnyiCfc9+pxqaU34hgI39rUBF0Ye/MtjPFUrILRYXJfGjvqfXYSPxFaMNx7BciyRqPdEdO8ifGFREhXQKhtr6hJvAWKSvKLotTYysr5Bct69pRJcDuBh81Fbma5XicXaB2LoYB+UP6IKf72tutYPqyjuS3SL+K9CSl5SXnqzphLPrZA+QrdnzH5lfz1ILt8dBtovx/jL99Rp3BnP2K53GNlHtgPFnbpIp91NZIG3tUYKbjYELuWBY94lntji50+/Y6upnyebTv3dOwYJSPs/gszIco8nxCmlwBuSLn5pA1rGdYo91djM/Y+o6+Wqmr87F01hs2f9jDEKkKKKC+VrF9RwOWksabQ7187HvMCd/6VDY1seWHRr5kKtg/dkaNseSmKHPX2L59vv/M+21jPswO8fG8l035ETifuXoFJ4IqiTjDfa+a2A3ub3tfci9jICydNNaK0Sq3mSxzzh+4AlDnWThJ+oHZ0cdqYCc89lQEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlNjZnAxcy9ta1g4MTk4VHNMWURGZnN1Ymd5QXliNDd4ZlJ4ZVBQcnNGcTE4?=
 =?utf-8?B?REh4R1JkRTlJa1FuWk5yODhOSitaR3RqM0IvSEg3dmhBcnFMalFCekVobWFv?=
 =?utf-8?B?YkMzSmJWUnZYbE43OVlwY2NxZlp0cS9EN3UwTjlXRjNTV3BWMkZ4Y3A5bVNE?=
 =?utf-8?B?cThUVTZ2Lzd1YUg1cHZCaE8xVkRhdXFHeitEL0JlOHB5bkUyRW5Kbmp0WjFF?=
 =?utf-8?B?Q0lXRGtQZUJWd2IxUDlZL2hIR09FOEtrekJNd2ZkaFRBOGFRVGJKY0g3MDlE?=
 =?utf-8?B?NnRCbFFvNmkxUFlGaDNYWERJV2lxelZrU3dMS0RiUHJNNjNEenBxNExidnhR?=
 =?utf-8?B?SWhVeDBMTUpaaHdoSXdoNTJoWnZKUlVNc1d4enowYXZKcjF3SzZtSktGM0JS?=
 =?utf-8?B?L2hDdkVZK1l0TW5zbU1pa1RGWDVocUQvQUVYTmpiV1lpSnJPRUNDSzJyTDZr?=
 =?utf-8?B?cVZRU2hzWllhTW9zTTNkZFEwSGJZTWZNU2xrZVlNWSszVjI2V2lVWks2eWMy?=
 =?utf-8?B?M3pVblBRTTh0NFlWQUNBTnVxOXdyelVFbG9XeEZ0alN6R2lkUSt6MmtvMi91?=
 =?utf-8?B?a0dFNFJCbUt5TWVybGErUXFicnNJSElBalEyUVNhRm9TeFR3TjBmRytkK2pJ?=
 =?utf-8?B?ZHZTOFZNWjRRK2ZDdS9RR29mdjV1dkRHZTFJQk1YQ01aR3N2cHRTdVVYVXJO?=
 =?utf-8?B?NGJJb25YYTBRTDVkQXNTa2VwUlBIeWE5SVoxYzRXdmZkOHNRSmxZVTVlRXZq?=
 =?utf-8?B?UDZJMmlPYk1JRnNsUVNqaEtuYndvZkg0djZoN1JiMHFLTzlFY09RN1k5TzB4?=
 =?utf-8?B?WW54TTB0c0l3em5acHRnSE1LWlRZSTZqY1NRS0lPdkpZckYvK08rNUtSVm9Z?=
 =?utf-8?B?TUNSTlh2bnZGMFVaZU5qbGVHQWF4YXFpdTA0Vzl1YnU2RzZTSUZ2NVk0K0Jt?=
 =?utf-8?B?Nm4zM1ZZdnlhc1E2MTFCTmZLKzhDdW5xT1RQMUlzQmk4MlYwRVpjc2hVemJ6?=
 =?utf-8?B?VEt0YWpkRWcwd2lsYllBK0cwbDlqSytXSFlNQ01hc2lwaVVCa3FjYS9ReVFF?=
 =?utf-8?B?QWVOTjhuTTZieTAyTkRVblpEL20raGZKVEFZQUh3RkZaSmhyM1BxNDRITG1u?=
 =?utf-8?B?L3BUUUhhK0pqYnpxN1JYMVdqTkYyMmxqNSs3aTR2Q2YwY0pqS2xpMjN5QTRM?=
 =?utf-8?B?c3dFdytoN1gzVGtsL3F6ZnFhZ3BXTWZKaGV0ekl3VmJQSUJYKzlyODF3UmJy?=
 =?utf-8?B?NFQ1RG5RS2VSMWJ2MWRZWUNwL1R4bFhjdUJUVlhJRDFCTGYwQ0dtL0JCMmlO?=
 =?utf-8?B?bURVS2Y5ckRWY000VFpqcEJrTVZUTDRBWjg3VzBGQ0ZHZmI4VkxXRnBtY0JG?=
 =?utf-8?B?WUVtMytoWWIyc1k2aFlEY3VtSEoxMVl2cUxIREJvMGZGUEF6L04xRWhLbGlm?=
 =?utf-8?B?TFhXcnVORUpoNklQVlBZNFBnMUZzcTJ1aVpHaEgrQnlLaFRtL1VoazhoQ25F?=
 =?utf-8?B?SWlNWkg1bThWSnRFd3c0MnMzQlp4WElMVEVhOFlrYm0yU1N0ZlRkY3VHV0R0?=
 =?utf-8?B?Wjdza1U4UGtvRmZKdXNKNzVpQUVuT0R5bkhFUEhhVis2U2liWGFLWHE2YVVQ?=
 =?utf-8?B?L3FsL3M5b0hqemZScG1mc0NiclRWZzRBczhqQ1N6dENzQ013bjY5SE1TZktC?=
 =?utf-8?B?d0NrZEtkdGpNV2ZHSUJsWkx6T01YSG9raU1rdGdyTHVqdVRLcXpONHczRDJQ?=
 =?utf-8?B?TE0vdmlqYis0M3BkWUNLaWY1dDNtcnIwUlJTQlJjemZzeDBpWk5JU1VWMWtB?=
 =?utf-8?B?WW91U0ZQVUhic3lZb0psYlNKanQxc2piZW1BeGpYTGFkcVVpY0ZOZHUrVmlU?=
 =?utf-8?B?TC9MZHI0WTlLMjZvM0loWGZ3Q0VDNjMzaGpsREgzZklZU2xvRldKN2o3aG9F?=
 =?utf-8?B?eGVCcElzNWh1TVNUUUZqc3c2YnlUOCs0bFJmK0VFamNMWkh5azlQbEwvZHVQ?=
 =?utf-8?B?NDQ1cE1nU1JYYlByUUpyQXBNWVB6VFJQeEYyNHZXV2pueXVnWFl0UFpKT1Jz?=
 =?utf-8?B?VXpuWHNDdStOR0MrcUNQMXEzQXh5cDZONk9sV0xkRVhaTGsvSDNlREpNOE1K?=
 =?utf-8?B?MjZkeEZXWmY5OHFsMVk3NkxMOWYzRm9QN0pkTTJqdWIyTUVOVmJyc0lXTng2?=
 =?utf-8?B?NS9DUnhBMmN3eWd4STgyOEFtUFpBSm5vQmJwOG05YXJ6N1NOdW5nUFFGeFlF?=
 =?utf-8?Q?fIz34n/AGG3B0+1iu4Dtl/EE4Pm5v6Q4hlpyLZ0Zug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d6a7b-7563-406d-2a4b-08debdb3053d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:49:31.7763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ur993+0fytKcc7LChA2mrWsn4FT47eVugX9PpQqr+VJCbIlWSsN9MssiRKDc2Bwh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEZhbmd6aGkgWnVvIDxKZXJyeS5adW9AYW1kLmNv
bT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgVGltdXINCj4g
S3Jpc3TDs2YNCj4gU2VudDogRnJpZGF5LCBNYXkgMjksIDIwMjYgMDU6MDkNCj4gVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBMSVBTS0ksIElWQU4gPElWQU4uTElQU0tJQGFtZC5jb20+Ow0K
PiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBIdW5nLCBBbGV4DQo+
IDxBbGV4Lkh1bmdAYW1kLmNvbT47IFd1LCBSYXkgPFJheS5XdUBhbWQuY29tPjsgTGl1LCBXZW5q
aW5nDQo+IDxXZW5qaW5nLkxpdUBhbWQuY29tPjsgUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5k
by5QaWxsYWlAYW1kLmNvbT47DQo+IENodWFueXUgVHNlbmcgPENodWFueXUuVHNlbmdAYW1kLmNv
bT47IExpLCBSb21hbg0KPiA8Um9tYW4uTGlAYW1kLmNvbT47IFdoZWVsZXIsIERhbmllbCA8RGFu
aWVsLldoZWVsZXJAYW1kLmNvbT4NCj4gQ2M6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9m
QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZC9kaXNwbGF5OiBGaXgg
cHJlZmVycmVkIGxpbmsgcmF0ZSBmb3IgTlVUTUVHDQo+DQo+IFdoZW4gdGhlcmUgaXMgYSBwcmVm
ZXJyZWQgbGluayByYXRlIHNldHRpbmcsIGl0IG5lZWRzIHRvIGJlIGFwcGxpZWQgdG8gYm90aCB0
aGUNCj4gY3VycmVudCBhbmQgaW5pdGlhbCBsaW5rIHJhdGUuDQo+IFRoaXMgd2FzIHJlZ3Jlc3Nl
ZCBieSBhICJjb2Rpbmcgc3R5bGUiIGZpeCwgd2hpY2ggY2F1c2VkIHRoZSBjdXJyZW50IGxpbmsg
cmF0ZQ0KPiB0byBub3QgcmVzcGVjdCB0aGUgcHJlZmVycmVkIHZhbHVlLg0KPg0KPiBUaGlzIGNv
bW1pdCByZXN0b3JlcyB0aGUgZnVuY3Rpb25hbGl0eSBvZiBOVVRNRUcsIHRoZSBEUCBicmlkZ2Ug
ZW5jb2Rlcg0KPiBmb3VuZCBvbiBvbGQgQVBVcyBzdWNoIGFzIEthdmVyaS4NCj4NCj4gRml4ZXM6
IGI3NDMyMmVlYTM2YiAoImRybS9hbWQvZGlzcGxheTogRml4IGNvZGluZyBzdHlsZSBpc3N1ZSIp
DQo+IENjOiBDaHVhbnl1IFRzZW5nIDxDaHVhbnl1LlRzZW5nQGFtZC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gLS0tDQo+
ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfZHBfY2FwYWJpbGl0
eS5jICAgIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvbGluay9wcm90b2NvbHMvbGlua19kcF9jYXBhYmlsaXR5LmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvbGluay9wcm90b2NvbHMvbGlua19kcF9jYXBhYmlsaXR5LmMN
Cj4gaW5kZXggODE3YjQwMTBlZGNiZS4uZjQ0YzEzMzAwYTU5YyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfZHBfY2FwYWJp
bGl0eS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9saW5rL3Byb3Rv
Y29scy9saW5rX2RwX2NhcGFiaWxpdHkuYw0KPiBAQCAtNzUwLDggKzc1MCwxMCBAQCBzdGF0aWMg
Ym9vbCBkZWNpZGVfZHBfbGlua19zZXR0aW5ncyhzdHJ1Y3QgZGNfbGluaw0KPiAqbGluaywgc3Ry
dWN0IGRjX2xpbmtfc2V0dGluZw0KPiAgICAgICBpZiAocmVxX2J3ID4gZHBfbGlua19iYW5kd2lk
dGhfa2JwcyhsaW5rLCAmbGluay0+dmVyaWZpZWRfbGlua19jYXApKQ0KPiAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4NCj4gLSAgICAgaWYgKGxpbmstPnByZWZlcnJlZF9saW5rX3NldHRp
bmcubGlua19yYXRlICE9IExJTktfUkFURV9VTktOT1dOKQ0KPiArICAgICBpZiAobGluay0+cHJl
ZmVycmVkX2xpbmtfc2V0dGluZy5saW5rX3JhdGUgIT0gTElOS19SQVRFX1VOS05PV04pIHsNCj4g
ICAgICAgICAgICAgICBpbml0aWFsX2xpbmtfc2V0dGluZy5saW5rX3JhdGUgPSBsaW5rLQ0KPiA+
cHJlZmVycmVkX2xpbmtfc2V0dGluZy5saW5rX3JhdGU7DQo+ICsgICAgICAgICAgICAgY3VycmVu
dF9saW5rX3NldHRpbmcubGlua19yYXRlID0gbGluay0NCj4gPnByZWZlcnJlZF9saW5rX3NldHRp
bmcubGlua19yYXRlOw0KPiArICAgICB9DQo+DQo+ICAgICAgIC8qIHNlYXJjaCBmb3IgdGhlIG1p
bmltdW0gbGluayBzZXR0aW5nIHRoYXQ6DQo+ICAgICAgICAqIDEuIGlzIHN1cHBvcnRlZCBhY2Nv
cmRpbmcgdG8gdGhlIGxpbmsgdHJhaW5pbmcgcmVzdWx0DQo+IC0tDQo+IDIuNTMuMA0KDQo=
