Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B465CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 08:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E2B10E542;
	Fri, 29 May 2026 08:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4PJriAu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E88410E542
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 08:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0XtmbI3EBKDEh2ByULW5kJIfRnK5V+Qsz/lTnsucjpWfbUBa08fhhWyJO3jLIKn44rAjpKiisSH3I+Xjn6zieYdns3p9/Exk0m/x8mqi9pMhsJz6zAjIMvHR94h2P76md2+mx6jMUwLVW6I6loAbIBnU9j8OGXMUj79m4Rjoq03/KKSA81W9/eJ3w8auSl6KmQK/A9IFZIlStl0w1cCBBtzUCNgBAI0IETcKf0eH53BvTkJtO5eYJo7douP5CvrqXGpJyIHZJr40fTrPsOrPxnPPv/0x/DZF/SnGzQd0pzWxbRVAmBdsPQHZedD0jvM2HaAwce3nRDJFnq5Q7Mgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXrlObmbTq0NbSDzATcg9aIHVEHGaoSAAccF4p6K+BE=;
 b=kd8oj/b0NJboCxI4xHxwu8NJe53TNq4QdNYoos81VbY8ftWXzqz22lybbWxwkd9cN2lvJwFBTn28Ld1qetnkQ50sIimLVPOM7XPtH7GpNkNVukiP002p/AIGVXNopQ5e1LrhWbDImv7sWO6Ivqdv1L28fCkAzFdCRL53GTJKrIfdFLJyTz5c8mzVZQwoyBVH+izXrgZZrrH8e9qU28nF5Cr3mRQIlwEMJCB3ialZToc6sGyTvVh+UhURqzWHZUVB9fkJPFPVAGYquqgZbOKlUmHvQoDYyhcBvANikapupNFaZhxFOXjiJPTBc16nh4NtJPlUPL0DsS52wLBFNBCtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXrlObmbTq0NbSDzATcg9aIHVEHGaoSAAccF4p6K+BE=;
 b=N4PJriAu6Zyout4Pphf3YrTXakSmu1pd9ibqe7/2FqPm+kZVufvo+YhnidvSz3tkDWAek3acqx3L7SI21hcdyD/NgqcfEdQV429f5NZHzlWjxivZpnzHj+75v7W+1BF3iP7wb+C00bM9WBC4GYTMr+KgZZE9FIm6SlnGVvaGhvw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 08:20:03 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 08:20:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Index: AQHc7PKUwStaNzpPRky6Lksvo9OH+rYgIHcAgAFWwnCAAAwkAIAC205g
Date: Fri, 29 May 2026 08:20:02 +0000
Message-ID: <DS7PR12MB6005E15B0AFF25A5B365C547FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
 <MN0PR12MB6004CE174D0E58CC6C3BC03DFB082@MN0PR12MB6004.namprd12.prod.outlook.com>
 <ca870fb4-1a61-4108-8e4a-94cdcf67efe0@amd.com>
In-Reply-To: <ca870fb4-1a61-4108-8e4a-94cdcf67efe0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T03:36:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB7923:EE_
x-ms-office365-filtering-correlation-id: 90d69d09-2d9e-48f8-c318-08debd5b14e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 1Y56L954DCM9Yfc74IS2KF3CQS6cZ3QA8AepokL5hXx9pJMOZ3f/Cy56OuPV+Q3okPUBYj6BryMdERgbU0C/xz3GewXTHf+5zTa0+9uPI+6KQGTYFoKCQeAjtPioc4dzbOMQ1t+CcNbWaBTRWP3GMhtSBm52sBALY6D006kRkqU7cVKiaer85MuCRQbbyzbSnR6atIVZjEhvtvSuU4WcKkzfcyrt8qaUxMHKN+gMHW4Foe5YtfELb58k0qjC7bLR5bjEPCTMlwCIcn4cJ7GsM3GLbnbGJO9A7VarMpDOONDnlfV5jjPHzB3gqsTjmrKOReMXaim0p1lVuyz/7LZGCVhcSWYGx/i+Lk5Dbh2NSdFrts4P/I+tqqOn2JojAF11bX0ZyR87PJgZxKYbi9FcG5ZOV5tY7YDP2mUb8rm5qBxTcPEwcyPoDB9wWBmRKqnW7KyFefQEbkO3yw9hwR50nOANsHpP5MNzVgxntymtPQpqP1L1F3F4BtDzjYHLPeee8dZM7aVbd4ng+ii0wfyNdZ15KkhhXnHSHtAoSb0YqYHr9xWNAlm8x2OOWjneCyv+ksvutYY4ivDkMTELr0WIu8M2FQTUsIwD5ZxKCtgSfanopjucIyyuemGPFzKTVK98EhtH5t/blUtZj/vFskY0g2DMhSkCHdxrAhaW+ramOUL4q7WvuQ8uXOdlQm4yPCwv//XEZzu5l2eS/wmlYJ7VHePmuC0nUSBJ8y0xdsoMjato6GpBkCtew7nepHrVZbzU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUtQM1BlL2hVcTNiZExNM0VuaXlrM3MrbjJLT1RjaEpmSjJJYXB0VmtPdTBW?=
 =?utf-8?B?VHg3UUhNcDlCLy9pdHhlR0JkMXZRc0o1OVdZNENsMWswM2dpS3RCbFpiVGQy?=
 =?utf-8?B?dW1nM0k0N242cmNlR3lVcVUvdHFVZHVidzlHMjZCWmwzZklXRk1KSG1PREkv?=
 =?utf-8?B?KzhiNzJ2eS9sUUxNZEFWdXgvQmFsTkpidmpQeklpaG9qTm9tMUQybkJIVW14?=
 =?utf-8?B?c21CV01XdE9iMEZNaUlNK3Ntdyt1Q0hhOTYrQVBtSjNUc3NHMDFrZjhUTVVL?=
 =?utf-8?B?TXY4R2xDR0lGbTE5VFg5ZzdOYnZOOTlpMFdVY0tDNEpoWll2Ny9XRHlsbjcz?=
 =?utf-8?B?T2RhUjhPZmVXWTdZTDI4NWlSR0IvbldLRzg4Ylg3QVpScXlMQUgzR1Q3MCtF?=
 =?utf-8?B?ZFdQT01IeDdlQ3MwL0FVMWFBUU1nMWlabW5EVDlPZTNHSi9XQ3g3VlRXd0JR?=
 =?utf-8?B?UjFicjhKdzhnNlZQd0ppK2hVUUNmL1Y2dWZSWW9KUWw0V2RIcFphSnhuYWRV?=
 =?utf-8?B?N3pwNVZlN0JtSVNFZytaNytlUkl5OHo1NXJvVGFTbkxoK1E4eUdZUW43NHlC?=
 =?utf-8?B?aEdkZXQ5emlyZ3JrU20wcFlGOEpaSStra2dtMmpIV1JUZ3UxQ0hLdExLdDhu?=
 =?utf-8?B?bDVrdUVmV0x0d2IwY2NzYzNKL2pqTnBkTFd2U2dOV2Y4cE1Cb1R2NU9DaWgx?=
 =?utf-8?B?eEMwTGhodjZiblVVcy92dnpnZDgvdGtORHZrdkhoR1k5SHIwa3MwRDdoVlVl?=
 =?utf-8?B?Wk5qOG9kbjhBTE91T0JxRzZPaGZTQ2hhS0d4Rm55RVRnbGJqYVIrc2ZMOUQ4?=
 =?utf-8?B?RFJNMlJCd2hLb2VuaGo3SFBCZVVsRHdaNFNSNnBEVExwazRDeFVGWTJpUUsw?=
 =?utf-8?B?MnFVdWVrSDhkNWpNVHAvdk9ZRjdaT2c0SFhQdVl4Sys0WWk2TEdFSDduV0lX?=
 =?utf-8?B?Nys5RXlEV3V6S2IzVDlCS3p5bGlXR3NOVjQrRVJ5NjQzdEFaZk91bUJiOHpm?=
 =?utf-8?B?bkNsOS9QalJYdDFXeE04aitBcVhGOUQ2MFovTDcrZ2l2Q0xEdVJyMDU4cnFn?=
 =?utf-8?B?MWdzU0NEUzV4dFVKaWRubm1welVDajNNR1oxYW5qV09BcjBJcytuZ2NYRGd3?=
 =?utf-8?B?S1JpKzNmNzFEMGd4eXJyT0hLbE5NZmtVSXY1bk5VVTZyNlNMeFBSWi9BOU5Y?=
 =?utf-8?B?T1VQQTl6T1h3Q3lsUDQxdzNDc1VuZUNKempJbm9QUWx2c2s5WUZGNldha2hy?=
 =?utf-8?B?cmJQR3dkand3bVI2WUU2UlIycTdWVmFONFJOMVRtZHF6THNEVjYyaFdKUWl3?=
 =?utf-8?B?aDhHQTl3Wk1ENndYMTVkb0xTdUhSTEhoSlZ6emdxb1NxMjNVVUU0RUFzWWR2?=
 =?utf-8?B?NzVuOTVUbmdMTjVVVzcxQWtOaWFFRndRQUNsWmg3c09ZcTZLbENlSzBiR2Vn?=
 =?utf-8?B?d3pNQUlFdDN3Z3FSK0NES1c4eG5HN3ZWMGNwbFd6eEQySENwd2VQRUV1MU14?=
 =?utf-8?B?WDcxZHBZdEI4OFUwbW9SNWtXczNIU3RINDB5cVpHM2UvZWJOanNXemtTK2lj?=
 =?utf-8?B?dHVjaEJnTnFMOVRTalJPV0JBQTVZUXFQc2Y1aVlKUkhJYjU1L2JXWkE3S3h3?=
 =?utf-8?B?TE1pTHN0TURMd1MzTHZtSy9zZGZEeE9hRTUvbW42QW1CKzFuMFVKSFJPd2Zp?=
 =?utf-8?B?TzFqNkQxQlBIV09GY2svV3NWQks5TStwSURleEpldzdoVlNqblZHellvOU95?=
 =?utf-8?B?THhmNzRGYk5VajVLK29lRDYvTHJhaCsvRzBSSDVGWWQ5K0I5djNJVmdWQjVG?=
 =?utf-8?B?cGpsMDBzNWxFTUlVME4ydEtCZE80UjJFdEplTjd2RndkREkrN3kzSW5UdVVu?=
 =?utf-8?B?Q3hSNjcyMlROaENUaDhFY2ljS3VBbFBhR2RoRFZ6eDNjdXM1ZWpDT3UrZitP?=
 =?utf-8?B?WWNvbUkxMjYvSzkzRzZrWmJlcTZhV281Rm96dzlySlZMd2g5NXU2ZmVhZGwz?=
 =?utf-8?B?WExJVzVmRUx4SzBlOFpqSTRTRjNNT0JWYVV5N1ZUbGNiYjYxRTlPSTRBeER6?=
 =?utf-8?B?bnhtdDlyQWlHVDN0SDZielpkczErdEtLUlk3YWh0SGN6RnQ1aWtISEt4VHQ3?=
 =?utf-8?B?aG01dGRNekhwWUtVN1RYOXR0T2RtWlZRRis4WG83NkhkTTVYQ0ZUREdlOStN?=
 =?utf-8?B?bjVwc0oyODhaV3lUZ3hMeW9wcnJrOUFqWkp6UFhHaXhDMUVCN2Y0QkpVWkcz?=
 =?utf-8?B?VVAyRDZZZ0x4WVVkcXMrT0JjQnd0bTMxVmFkUFFVdlZIWnBmK1FtNlkyWDlJ?=
 =?utf-8?Q?fiRxXr3hZR0DJ8AKbS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d69d09-2d9e-48f8-c318-08debd5b14e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:20:02.3417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zyx+AvVEbLlqZlegxZ6LMCykU1VEdo7GUmvO7ia4ivF3zGovYXZJz+YQ0cgjt0KY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjcsIDIwMjYgMzo1OSBQTQ0KPiBUbzog
TGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGF2b2lkIGV4dHJh
Y3RpbmcgZmVuY2VfZHJ2X2FycmF5IGZvciBlbXB0eQ0KPiB3YWl0IGZlbmNlcw0KPg0KPg0KPg0K
PiBPbiA1LzI3LzI2IDA5OjU1LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gQU1EIEdlbmVyYWwN
Cj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gICAgICAgUHJpa2UNCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBNYXkgMjYsIDIwMjYgNjo0OCBQ
TQ0KPiA+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9h
bWRncHU6IGF2b2lkIGV4dHJhY3RpbmcgZmVuY2VfZHJ2X2FycmF5DQo+ID4+IGZvciBlbXB0eSB3
YWl0IGZlbmNlcw0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA1LzI2LzI2IDExOjMyLCBQcmlr
ZSBMaWFuZyB3cm90ZToNCj4gPj4+IEF2b2lkIHhhcnJheSBleHRyYWN0aW9uIGFuZCB0ZW1wb3Jh
cnkgYXJyYXkgYWxsb2NhdGlvbiBpbg0KPiA+Pj4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2FsbG9jKCkg
d2hlbiB0aGVyZSBhcmUgbm8gcGVuZGluZyB3YWl0LXNpZGUgZmVuY2UNCj4gPj4+IGRyaXZlciBy
ZWZlcmVuY2VzLiBUaGlzIGtlZXBzIHRoZSBjb21tb24gZmVuY2UgZW1pdCBwYXRoIGNoZWFwZXIg
YW5kDQo+ID4+PiBlZmZpY2llbnQuDQo+ID4+DQo+ID4+IFRoYXQncyBhbiBhYnNvbHV0ZSBjb3Ju
ZXIgY2FzZSB3ZSBjbGVhcmx5IGRvbid0IG5lZWQgdG8gb3B0aW1pemUgZm9yLg0KPiA+Pg0KPiA+
PiBJbiBhbG1vc3QgYWxsIGNhc2VzIHdlIHNob3VsZCBoYXZlIGF0IGxlYXN0IG9uZSByZW1vdGUg
ZmVuY2UgZHJpdmVyIGhlcmUuDQo+ID4NCj4gPiBXaGVuIG9ubHkgdGhlIGRlc2t0b3AgY29tcG9z
aXRvciBpcyBydW5uaW5nLCB0aGVyZSdyZSBtYW55IG5vLXdhaXQgZmVuY2VzIGFyZQ0KPiBnZW5l
cmF0ZWQgd2hpbGUgZW1pdHRpbmcgdXNlcnEgZmVuY2VzLg0KPg0KPiBUaGF0IHNvdW5kcyBsaWtl
IGEgYnVnIHRvIG1lLiBJbiBhbG1vc3QgYWxsIGNhc2VzIHdlIHNob3VsZCBoYXZlIGFsd2F5cyBh
dCBsZWFzdA0KPiBvbmUgd2FpdCBmZW5jZSBpbiBoZXJlLg0KPg0KPiBPdGhlcndpc2UgdGhlIHN5
bmNocm9uaXphdGlvbiBiZXR3ZWVuIFgvV2F5bGFuZCBhbmQgcmVuZGVyaW5nIGNsaWVudCBpc24n
dCB3b3JraW5nDQo+IHByb3Blcmx5Lg0KPg0KPiBDYW4geW91IGludmVzdGlnYXRlIHdoeSB3ZSBk
b24ndCBoYXZlIGEgZmVuY2UgZGVwZW5kZW5jeSBoZXJlPw0KPg0KPiBXaGF0IGNvdWxkIGJlIGlz
IHRoYXQgd2UgZmlsdGVyIG91dCB0aGF0IGRlcGVuZGVuY3kgaW4gdGhlIHdhaXQgSU9DVEwgYmVj
YXVzZSBpdCBpcw0KPiBhbHJlYWR5IHNpZ25hbGVkLg0KDQpXaGVuIG9ubHkgdGhlIGRlc2t0b3Ag
Y29tcG9zaXRvciBpcyBydW5uaW5nLCB0aGUgd2FpdCBmZW5jZSBpb2N0bCBnYXRoZXJzIG9ubHkg
dGhlIFZNIHRpbWVsaW5lDQpmZW5jZS4gTm8gdXNlcnEgZmVuY2VzIGZyb20gZ2VuZXJpYyBzeW5j
b2JqcyBvciBCTyBpbXBsaWNpdCBzeW5jIGFyZSBwcmVzZW50LCBzbyBubyB1c2VycSBmZW5jZQ0K
ZHJpdmVyIGlzIHJlZmVyZW5jZWQgZHVyaW5nIHRoZSB3YWl0IHBhdGguIEluIHRoaXMgY2FzZSwg
c2tpcHBpbmcgdGhlIGFsbG9jYXRpb24gYW5kIGV4dHJhY3Rpb24gb2YgdGhlDQp1c2VycSBmZW5j
ZSBkcml2ZXIgd291bGQgcmVkdWNlIHRoZSBwZXIgc3VibWlzc2lvbiBvdmVyaGVhZCBvZiBlbWl0
dGluZyB1c2VycSBmZW5jZXMuDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+
IFJlcGVhdGVkbHkgYXR0ZW1wdGluZyB0byBleHRyYWN0IHRoZSB3YWl0IGZlbmNlIGFycmF5IHRh
a2VzIG1vcmUgdGhhbiAxMMK1cyAod2l0aCBhDQo+IG1heGltdW0gY29zdCBvZiBhcm91bmQgMzDC
tXMpLiBBZGRpdGlvbmFsbHksIHplcm8taW5pdGlhbGl6aW5nIHRoZSB1c2VycSBmZW5jZQ0KPiBh
bGxvY2F0aW9uIGNhbiBoZWxwIHJlZHVjZSBvdmVyaGVhZCBpbiB0aGUgdXNlcnEgZmVuY2UgcHV0
IHJvdXRpbmUuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGNhbiByZXR1cm4gYSB1c2VycSBmZW5jZSBk
cml2ZXIgZXZlbiB3aGVuIGZhbGxpbmcgYmFjayBmcm9tIGFuIGVtcHR5DQo+IGZlbmNlX2Rydl94
YSwgYmVuZWZpdGluZyBvbiByZWR1Y2luZyB0aGUgbGF0ZW5jeSBvZiB1c2VycSBmZW5jZSBkcml2
ZXIgZXh0cmFjdGlvbiBhbmQNCj4gZnJlZSBvcGVyYXRpb25zIHdoZW4gdGhlcmUgaXMgbm8gcGVu
ZGluZyB3YWl0LXNpZGUgZmVuY2UuDQo+ID4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFu
Lg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgfCA2ICsrKystLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4+
PiBpbmRleCAwMDgzMzBhMGQ4NTIuLjJhMmJmMTNhNTEzZCAxMDA2NDQNCj4gPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+Pj4g
QEAgLTIyNiw3ICsyMjYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV91c2VycV9mZW5jZV9hbGxvYyhz
dHJ1Y3QNCj4gPj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICp1c2VycSwNCj4gPj4+ICAgICBzdHJ1
Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNlICp1c2VycV9mZW5jZTsNCj4gPj4+ICAgICB2b2lkICplbnRy
eTsNCj4gPj4+DQo+ID4+PiAtICAgdXNlcnFfZmVuY2UgPSBrbWFsbG9jKHNpemVvZigqdXNlcnFf
ZmVuY2UpLCBHRlBfS0VSTkVMKTsNCj4gPj4+ICsgICB1c2VycV9mZW5jZSA9IGt6YWxsb2Moc2l6
ZW9mKCp1c2VycV9mZW5jZSksIEdGUF9LRVJORUwpOw0KPiA+Pj4gICAgIGlmICghdXNlcnFfZmVu
Y2UpDQo+ID4+PiAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPj4+DQo+ID4+PiBAQCAt
MjM1LDYgKzIzNSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2FsbG9jKHN0cnVj
dA0KPiA+PiBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJxLA0KPiA+Pj4gICAgICAqIHVzZWQg
YXMgc2l6ZSB0byBhbGxvY2F0ZSB0aGUgYXJyYXkuDQo+ID4+PiAgICAgICovDQo+ID4+PiAgICAg
bXV0ZXhfbG9jaygmdXNlcnEtPmZlbmNlX2Rydl9sb2NrKTsNCj4gPj4+ICsgICBpZiAoeGFfZW1w
dHkoJnVzZXJxLT5mZW5jZV9kcnZfeGEpKQ0KPiA+Pj4gKyAgICAgICAgICAgZ290byB1bmxvY2s7
DQo+ID4+PiAgICAgWEFfU1RBVEUoeGFzLCAmdXNlcnEtPmZlbmNlX2Rydl94YSwgMCk7DQo+ID4+
Pg0KPiA+Pj4gICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gPj4+IEBAIC0yNTYsNyArMjU4LDcgQEAg
c3RhdGljIGludCBhbWRncHVfdXNlcnFfZmVuY2VfYWxsb2Moc3RydWN0DQo+ID4+IGFtZGdwdV91
c2VybW9kZV9xdWV1ZSAqdXNlcnEsDQo+ID4+PiAgICAgeGFfZXh0cmFjdCgmdXNlcnEtPmZlbmNl
X2Rydl94YSwgKHZvaWQgKiopdXNlcnFfZmVuY2UtPmZlbmNlX2Rydl9hcnJheSwNCj4gPj4+ICAg
ICAgICAgICAgICAgIDAsIFVMT05HX01BWCwgeGFzLnhhX2luZGV4LCBYQV9QUkVTRU5UKTsNCj4g
Pj4+ICAgICB4YV9kZXN0cm95KCZ1c2VycS0+ZmVuY2VfZHJ2X3hhKTsNCj4gPj4+IC0NCj4gPj4+
ICt1bmxvY2s6DQo+ID4+PiAgICAgbXV0ZXhfdW5sb2NrKCZ1c2VycS0+ZmVuY2VfZHJ2X2xvY2sp
Ow0KPiA+Pj4NCj4gPj4+ICAgICBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2dldChmZW5jZV9k
cnYpOw0KPiA+DQoNCg==
