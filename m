Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441ADC54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 18:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BF610F1E7;
	Tue, 26 Mar 2024 18:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSGUp1kU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2123.outbound.protection.outlook.com [40.107.102.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41E710F1E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 18:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwS2GOge2H7+YvdWR58XzOTBcpGTOSvAzhvWFVs9u0fNb1covm9eMjlEsKnxvSWSlG6gRA2ftXLWzCs0o1L846O+CmwohnZ81lHRcewuwDLrYGXEUpMrgauOm28FKsTiaFrMbFULB/+ZSgyW9I1SeftIhm+eCu8b9ej404WqPts6QLAFzxxZzdlgeYVuXKyBePfblGMBY8gi7vr0ESajrfvNoooI6Dk6i4Lv4cX9tTxAtmAIxWYAjGwh/Ud2NHDBihNeEUuCQNK2ijaVZph3BavccLvdVQ4XFY5pg02G8g6hk53kIKp4LVBgKhr0HfjF5TLtUr6a1D6Nb7k24mcjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exBg1LmlDufKTrLG47raUwW3puSRMzKMMU7wJL4xaRA=;
 b=DISJMPWBXHLIPnJ8Pk7nLTERr4UkHC2KAYMpZ+qUnUDUccK1cmdtypc0l5hselIBXyHrYBn93UxcZfCPP701y8ZUnmuQWkY2bca9K62IB3CzseJplHup5MzQuv+ho4jOUwkcR0AESoGTY9G6g98cFfXoWAoXUzOTvrvIMqSMunKIYoW81MvE4Makp65goxRO1zk6/AhqCZgj0gNZ+Gj/DU8FkdxSdbLQU+hdRpGCpITcdtFcP4gd8G9Sb6XQR3MRXXlGsRRhbbJZFA6MoD0guZ6m73P+lW+b1Nr/DArInFqA5Mh/XQAGoSVWMlvyZQZz5mUc91cGH746mHVabkn0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exBg1LmlDufKTrLG47raUwW3puSRMzKMMU7wJL4xaRA=;
 b=lSGUp1kU4y7dGT5R0QnvohhbCW5DfWHal+0ha4X5POj84RWXK24uRAyztV0Sbwu+Xc311ZGJ196Xtu3GmVQSTZ3uSTjPr2/hY3qRwY52NQmpuCrvK7Q/c8xlrrKaOaWDDl4kF54YnK4q+B1D0DNA6gix0GBlsxZM66BwYQHU4xc=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 18:47:20 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:47:20 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Topic: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Index: AQHafHkE7VgplRr2nUa/aZd+99nt3bFI08YAgABMO+CAATfQgIAAB6fA
Date: Tue, 26 Mar 2024 18:47:19 +0000
Message-ID: <CH0PR12MB53723A3A4EF7793C03CB82CFF4352@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
 <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
 <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
 <d7323c74-f12f-48d5-b1e5-18e6b9a7e3ff@amd.com>
In-Reply-To: <d7323c74-f12f-48d5-b1e5-18e6b9a7e3ff@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=705e6be6-65a6-4077-b92f-dff6ff05af5e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T18:34:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA1PR12MB8540:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9XHPqCTSLPbj9t0yFFGnWksEDJCL9bc52pIj34212xPO//vbRbJLiYWkSIwrTiaxz9N1aU2SczA4t+qdVfGzurWJ64SL0aOVHd/3MWIjaoPMS+uhsnqIuO3ffwBQyAZAg7363BRaPWO34Ul/dO7vZTW6VCxYXCiDiexd52NLEKiynTb1X3wptMvLta0Mfe5vmvulTVTQ50On8gc+IjuH31nckzopgoT2fkTJePZQXRVTYBouQ9T0y8UL3F67OtObXjhdMyHUA0xHECegdWP1VUPcOjyHOcu3O5uofTCeWruygDO0PlssrCFid59Vm/jsUHQpiNi6Ct4cBAm71kNmIAjMncfmz9i0vdexA5YJXzgoCT5PfCxu7O6PLtqqKfe8d3orAWuZ+RReynBvZNcggcVTBhNsutPCn86v2ic2capkf3LbWRZqxy9vThJ8LV//zINyYEfLs/GrYEJFTqFWwj0G3OjnPJxIS4js48jLVh+4Qy6DnDYbE1ySPLIs4t5pkuor2p3WL0LoIJWBDlKIUlVsgyqzuAneTS3vYm1HE66e7tgKctyzvTPj9w1PQLBVOJ4KoKx1WH/LdI/FhcGo0I4p9TAkEP1LpYkwur1GezTiouLVOf1DPl0sf5N0QSiN8MFW38GbCeYXJyc5o4IYMDw94npfTV3iouAEI2QC+xw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2swb0JlQXJnSHp5d3VMd0RaZjJaTEc3RFNqbWN2UGRUN3J6MzB0MnB5aGVB?=
 =?utf-8?B?NVlFaVpJQVZ0UlFFMHdBTVA1MTg0Q1JYUXVGSGoyRW9iU01nUWtsZTVZOVha?=
 =?utf-8?B?SExuUDZ0N0tWTzZnWnh5VUFZc3Q1akVSQ2dnZ25qL2luSFUyTkl5b0hLaC8x?=
 =?utf-8?B?eGRMN1hsU0pYM1RwN2pGUnZ4TENyM1B6M3lNWmdQaEliUExUT3pJZDFvTWVO?=
 =?utf-8?B?Njd2aXh3OFZBZEdvWmgzM2lwOERZeHRXdGhHOFNUWVExVHBRMkxVU0JqdHpS?=
 =?utf-8?B?Z3cvVEFnQTdTUllSWWkrSHJMVmdZMkVyWWdFMWt3VDRDOEt6NXFjckV4S01G?=
 =?utf-8?B?bmtBZGhIWHRXMVZ6RGhHMVJoQXdXbFdHaE5CbWFQU0Z3VHR1UytsNXJldTJG?=
 =?utf-8?B?RG8yUnBvWVQxMGhFMkN4K2RFeGEwQTdLRyswcjMrT1M3Sk5FUHoxQ25zTFZK?=
 =?utf-8?B?YUx5ejJTUWRDQjJvQTJ5Z1FaWUlyQ1pwK09IY1lucmhaVVBXdkw2Z2VRbS9R?=
 =?utf-8?B?eGRaTUFZa2ZIekZIazV0Uzl5KzhXTTBKcXlTWWZMWURvUzJSTis3M0pzUVh6?=
 =?utf-8?B?Sk5Eb094WjhGZm9meFRNVWs2LyszeXMyME9rTjNmNXMwMzVuNVg4bE83R2Fp?=
 =?utf-8?B?a29Rd0RZT2xNaEVjWHRPeXIvdkdZMU8xZzRGaDJtZzBKQjdXRGY0V2ZhTjdm?=
 =?utf-8?B?eFFQaFVqWExaVE1iaEM1N1YvRWVYYXQvNmg3RE9UeVlsRlBMdHhUMTMxaVE0?=
 =?utf-8?B?dk9uUFdCbHhhVElPLzJPdTNvNVg5aVJDVnZJZzZCdHNIbE1HbjVQdWJyTURr?=
 =?utf-8?B?ejRtZGliUzV2a0pjUjFyUzlKRTlDQi9Cb0wwRVZBNkNVQXdoZnVTWUZOUGg5?=
 =?utf-8?B?dFVETzczb1lOK1p0UjlRSTF1b1hMaURUYkFqMlZmdWxLZlJtbHlKbUV6NmFn?=
 =?utf-8?B?bWo0S1AvRXJsdk90S0ZwRkNnMDdaejkraVkxZG9HUHdSdDg3cUg5NVU2N3FL?=
 =?utf-8?B?NGVBVnlOaVFndVpBT21PVi9pQmhRY2dkMEd1K3l4YUl5OWxDK1IzN0FDQ1Nh?=
 =?utf-8?B?emdhbkUrQ3hyQ0ZkbEhHeFFYenB3K1RzZm9iSFhRU3hLeEp0N1dINHdueUdO?=
 =?utf-8?B?NkVnZ3NKTWhaQVR2TE9Db1ZUUlZjNXJRNTd1cEFLZ0piYVZ0MEJkdHo0N2hz?=
 =?utf-8?B?enpzY0hWWFRXYTZIVUp4aEUrOGYwT2cxbnpBZzFUMnRuUzI4cFF4MndORlRi?=
 =?utf-8?B?WFZCUDllWVdMT082clY0eGgydzY0cGh5MmZzeW5SZmtMUmxBWklJRjRUaGp6?=
 =?utf-8?B?VDlwREtrb1NLa3VSZzJxaXVwdTVTRmlCNWhNbEhqVVVxMFFXR0ZSdTExOCtH?=
 =?utf-8?B?cnhZRmZHa29VZE13VnNyb3hGSVQvdUc5N3o1dGRHdFowcUxKVCtwaDJSR1Rw?=
 =?utf-8?B?MzdPVis5Zk9XdWlhUG9vVUtTM2ovZzFiUjNDcXVKbEJCbjRJT3dpRE9INENu?=
 =?utf-8?B?MnExYjlQUnl4aVdxK1poUk5HZ1ZXS3NaWEhJZGhGQkZONHJYRE14SHBMWHdm?=
 =?utf-8?B?bXRDVS8rTUJZakZ3SUN2RjltU29FK3hYM3VMZUNHSStCRlJMZFBZK1pTZFgv?=
 =?utf-8?B?ZGZYNDBjUHIvRmJQMlYzUDVOQ1cvdGFwTVRuckNnbEZ6b2VvRkMzcGJrTisy?=
 =?utf-8?B?LzFmNHhLcUd3K01DU0FENHJob0ZjZGpDMEVXTkFTbnBKUzE4UCtMUEpQeVo5?=
 =?utf-8?B?UUFPSUNYbWwwcVJIRk1hTS9JOHRoSVRma2NNcko4eFZ0elVuN0ZVeGVwVjJU?=
 =?utf-8?B?b3pmT3J6SEtpQ3h3TlhudVpPb3ZlVzNYMjhLYmlmNUQwTjAwSnkvRXpTOFpu?=
 =?utf-8?B?ZTlFcTl4akpITlJKTXpJWStTR21rc2RPUjZkTXkwQktJT0g2cWJablIzRWFJ?=
 =?utf-8?B?dXBnTDF4U2lSNDlDQWtDTEgyREJoSm5rUm00aHlESStBeXhSOTE4TUYvZGIr?=
 =?utf-8?B?RVZWQkpWYk14ZjFKZzlrdmdyaXRoZmlGbFo4dFhTbmxLcFE5Snl0UnFwdjZn?=
 =?utf-8?B?T2dIY2JVSm5tMFRzR1BGbXdCVUFpTUMwb1cxbTBJSWhxZ2FHcklpU1U5MjUz?=
 =?utf-8?Q?dIUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5326ceac-63c9-47fd-cae3-08dc4dc52ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 18:47:19.9912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAdmFMUrSzfz7iik1mW7RDQYcrKwB3+3ZiIhgkI0Co7xrQgDmtElLeALG9UD8bDJoIO9yGFhghTuXxR/iJLvpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYXQgcmVxdWlyZXMgZXh0cmEg
d29yayBpbiBNRVMgYW5kICBBUEkgIGxldmVsIGNoYW5nZSB0byBsZXQgZHJpdmVyIHNlbmQgdGhp
cyBpbmZvIHRvIE1FUyAuIEkgdGhpbmsgdGhhdCdzIGtpbmQgb2YgdW5uZWNlc3NhcnkgY29tcGxp
Y2F0ZWQuDQpUaGUgb3JpZ2luYWwgcHJvYmxlbSBpcyBNRVMgZncgZG9lc24ndCBlbmNhcHN1bGF0
ZSB0aGVpciBBUEkgZGVmaW5lcyAgZ29vZCBlbm91Z2ggLiAgV2luZG93cyBkcml2ZXIgZGlyZWN0
bHkgdXNlIE1FUyBpbnRlcm5hbCBzdHJ1Y3R1cmUgdG8gY2FsY3VsYXRlIHRoZSAgYnVmZmVyIHNp
emUuDQpJIGFscmVhZHkgcHVzaGVkICBNRVMgdGVhbSB0byBoYXZlIGFsbCB0aGUgIG5lY2Vzc2Fy
eSBpbmZvIGluY2x1ZGluZyB0aGlzICBsb2cgYnVmZmVyIHNpemUgZGVmaW5lZCBpbiBtZXNfYXBp
X2RlZi5oICAuICBXZSBhbHNvIGFncmVlZCB0aGF0IG1heGltdW0gbG9nIGJ1ZmZlciBzaXplIHdv
bid0IGV4Y2VlZCAweDQwMDAgaW4gdGhlIG5lYXIgZnV0dXJlIC4gVGhpcyB3aWxsIGhhcHBlbnMg
b24gdGhlIG5ldyBNRVMgcmVsZWFzZSAgYW5kIG1heSB0YWtlIHNvbWUgdGltZSBmb3IgZHJpdmVy
IHNpZGUgdG8gcGljayBpdCB1cCAsIGJ1dCBiZWZvcmUgdGhpcyBJJ2QgbGlrZSB0byBoYXZlICBh
IHNvbHV0aW9uIHRoYXQgY2FuIGZpeCB0aGUgIGlzc3VlIEFTQVAgLg0KDQpSZWdhcmRzDQpTaGFv
eXVuLmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZl
bGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KU2VudDogVHVlc2RheSwgTWFyY2ggMjYsIDIw
MjQgMjowNyBQTQ0KVG86IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
IDogSW5jcmVhc2UgdGhlIG1lcyBsb2cgYnVmZmVyIHNpemUgYXMgcGVyIG5ldyBNRVMgRlcgdmVy
c2lvbg0KDQoNCk9uIDIwMjQtMDMtMjUgMTk6MzMsIExpdSwgU2hhb3l1biB3cm90ZToNCj4gW0FN
RCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEl0IGNhbiAgY2F1c2UgcGFnZSBm
YXVsdCAgd2hlbiB0aGUgIGxvZyBzaXplIGV4Y2VlZCB0aGUgIHBhZ2Ugc2l6ZSAuDQoNCkknZCBj
b25zaWRlciB0aGF0IGEgYnJlYWtpbmcgY2hhbmdlIGluIHRoZSBmaXJtd2FyZSB0aGF0IHNob3Vs
ZCBiZSBhdm9pZGVkLiBJcyB0aGVyZSBhIHdheSB0aGUgdXBkYXRlZCBkcml2ZXIgY2FuIHRlbGwg
dGhlIEZXIHRoZSBsb2cgc2l6ZSB0aGF0IGl0IGFsbG9jYXRlZCwgc28gdGhhdCBvbGQgZHJpdmVy
cyBjb250aW51ZSB0byB3b3JrIHdpdGggbmV3IGZpcm13YXJlPw0KDQpSZWdhcmRzLA0KICAgRmVs
aXgNCg0KDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5n
LCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAy
NSwgMjAyNCAyOjU4IFBNDQo+IFRvOiBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1IDogSW5jcmVhc2UgdGhlIG1lcyBsb2cgYnVmZmVyIHNpemUgYXMNCj4gcGVyIG5l
dyBNRVMgRlcgdmVyc2lvbg0KPg0KPg0KPiBPbiAyMDI0LTAzLTIyIDEyOjQ5LCBzaGFveXVubCB3
cm90ZToNCj4+ICAgRnJvbSBNRVMgdmVyc2lvbiAweDU0LCB0aGUgbG9nIGVudHJ5IGluY3JlYXNl
ZCBhbmQgcmVxdWlyZSB0aGUgbG9nDQo+PiBidWZmZXIgc2l6ZSB0byBiZSBpbmNyZWFzZWQuIFRo
ZSAxNmsgaXMgbWF4aW11bSBzaXplIGFncmVlZA0KPiBXaGF0IGhhcHBlbnMgd2hlbiB5b3UgcnVu
IHRoZSBuZXcgZmlybXdhcmUgb24gYW4gb2xkIGtlcm5lbCB0aGF0IG9ubHkgYWxsb2NhdGVzIDRL
Qj8NCj4NCj4gUmVnYXJkcywNCj4gICAgIEZlbGl4DQo+DQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBz
aGFveXVubCA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jIHwgNSArKy0tLQ0KPj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5oIHwgMSArDQo+PiAgICAyIGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPj4gaW5kZXggOWFjZTg0OGUxNzRjLi43OGU0Zjg4
ZjUxMzQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
bWVzLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0K
Pj4gQEAgLTEwMyw3ICsxMDMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9tZXNfZXZlbnRfbG9nX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAgICAgaWYgKCFhbWRncHVfbWVz
X2xvZ19lbmFibGUpDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiAtICAgICBy
ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgUEFHRV9TSVpFLCBQQUdFX1NJWkUsDQo+
PiArICAgICByID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgQU1ER1BVX01FU19MT0df
QlVGRkVSX1NJWkUsDQo+PiArUEFHRV9TSVpFLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBTURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZhZGV2LT5tZXMuZXZlbnRfbG9nX2dwdV9vYmosDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5tZXMuZXZlbnRfbG9nX2dwdV9hZGRy
LCBAQA0KPj4gLTE1NDgsMTIgKzE1NDgsMTEgQEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc19t
ZXNfZXZlbnRfbG9nX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp1bnVzZWQpDQo+PiAg
ICAgICAgdWludDMyX3QgKm1lbSA9ICh1aW50MzJfdCAqKShhZGV2LT5tZXMuZXZlbnRfbG9nX2Nw
dV9hZGRyKTsNCj4+DQo+PiAgICAgICAgc2VxX2hleF9kdW1wKG0sICIiLCBEVU1QX1BSRUZJWF9P
RkZTRVQsIDMyLCA0LA0KPj4gLSAgICAgICAgICAgICAgICAgIG1lbSwgUEFHRV9TSVpFLCBmYWxz
ZSk7DQo+PiArICAgICAgICAgICAgICAgICAgbWVtLCBBTURHUFVfTUVTX0xPR19CVUZGRVJfU0la
RSwgZmFsc2UpOw0KPj4NCj4+ICAgICAgICByZXR1cm4gMDsNCj4+ICAgIH0NCj4+DQo+PiAtDQo+
PiAgICBERUZJTkVfU0hPV19BVFRSSUJVVEUoYW1kZ3B1X2RlYnVnZnNfbWVzX2V2ZW50X2xvZyk7
DQo+Pg0KPj4gICAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X21lcy5oDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tZXMuaA0KPj4gaW5kZXggN2Q0ZjkzZmVhOTM3Li40YzhmYzMxMTdlZjggMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPj4gQEAgLTUyLDYgKzUyLDcg
QEAgZW51bSBhbWRncHVfbWVzX3ByaW9yaXR5X2xldmVsIHsNCj4+DQo+PiAgICAjZGVmaW5lIEFN
REdQVV9NRVNfUFJPQ19DVFhfU0laRSAweDEwMDAgLyogb25lIHBhZ2UgYXJlYSAqLw0KPj4gICAg
I2RlZmluZSBBTURHUFVfTUVTX0dBTkdfQ1RYX1NJWkUgMHgxMDAwIC8qIG9uZSBwYWdlIGFyZWEg
Ki8NCj4+ICsjZGVmaW5lIEFNREdQVV9NRVNfTE9HX0JVRkZFUl9TSVpFIDB4NDAwMCAvKiBNYXhp
bXUgbG9nIGJ1ZmZlciBzaXplDQo+PiArZm9yIE1FUyAqLw0KPj4NCj4+ICAgIHN0cnVjdCBhbWRn
cHVfbWVzX2Z1bmNzOw0KPj4NCg==
