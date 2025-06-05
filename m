Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E6C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 12:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D9810E881;
	Thu,  5 Jun 2025 12:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v0UXEXR2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857D910E83C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 12:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbP0kEqrPiJh6ci/jSW5FsYjqSTHG4BfHCyhmMvUn0YgilpqfDi4i7Upa6xPJd3UIUNLAMKMpAh96JMsYyfqmtJQMisIV10p+l4b4R510aYPhIstNS/vrbWdDH29Bc9VYdLY8A7llIdjghtKsv/RQljxkXui8VC5wSdhIx2WBVlfEXSor9xrM0GbnOPOVOBn40jno/fwJcLqHifYov4kVSeb6QVMQEmebUVfOZ1XlIhNZ1+7j+KJ+SSD63rHx7J7BwCHrEQ6mZJ5KihOuKULN8HgzmM5ZjeQUQGXhDCHF3GrNx0gDeq2i5wjo5nCIzJ7ZIrlEP7lfSGQ6tXKk2sSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2hWx+tBRwO4k2m4JTmG/bBXZSUzfvjQQDL700i2Oro=;
 b=qtf2VjZZPzgjNxGkhm8AQqUvimP2DmpyuOeGN5Fi2EfIzjzl2gO6YhJ4tfs5+9OtEbgbDCSMxqcSn8Y7+kjGhVyBe74woZWCislDqYApz/AdhAalR9VBkSVTTX43k6RFVfW8BKrPP8JrmcOpxGyJgqfuxdErn8+lndvnims4sLsMjv7NwQAWdHM5RXgpnT9GUSz/j7JR6I35ss6uHa3kPZ50/sU8on0x57dWUZEfU2Z+n0FIK81RuYglv/y9oAKJFX8RoEcViiujYeMtLs1hvpyybT9+gZwEpIS5yWZn4n33Dy6r+JyJOVz9HhM2lXSyBYvIRZPICOLptUHsoBbHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2hWx+tBRwO4k2m4JTmG/bBXZSUzfvjQQDL700i2Oro=;
 b=v0UXEXR28HfUk26T+zYREyjzWyIojJGzhsdRZZ5qHZuqKzvKrMWgRe/vwVH65pXzzEw2mlqvijov/g97ieeJPAWNKQUtK4MA780HFACGVmswdxXk7tuJ7W+dIxwnKSNDofXUAs+4/xE0YA+VdL7SunQ4tQE9eXpIJZDhrtarHLo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 12:48:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 12:48:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Topic: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Index: AQHb0TgzsvvuSO+E80Oz8dMCPvga+7PrszWAgAjVxDA=
Date: Thu, 5 Jun 2025 12:48:07 +0000
Message-ID: <DS7PR12MB60053B5CB2D5704A883AE144FB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
 <CADnq5_MiNwVgkAhK+17_WW-guameouvy=Wj307jNXS5jO0429g@mail.gmail.com>
In-Reply-To: <CADnq5_MiNwVgkAhK+17_WW-guameouvy=Wj307jNXS5jO0429g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=54bc8003-4ba4-4e4c-ad00-ec9659235af8;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-05T12:31:15Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 5257dbcd-ba59-4de9-bb79-08dda42f387a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1lkRFZuaGZZN3l4bUN6VHEzODBnaHkwWVhmS1pxSE9oYklVdW1Pak9ORGxt?=
 =?utf-8?B?bGliUUV3eU5TYThGNWxuYklRcVV4aTloNmVTRXVpTXZlT2VMOWdIM0tSQ3lF?=
 =?utf-8?B?dkxOTXFocDBCWUN3Q3VNY2tzY2IwenhBTk9oektrQW9HdzdsNFBWMmZ0ejBI?=
 =?utf-8?B?S2xJekt1akxENjdiSFRjQTdtVGJXYnRtcWZ1UFJEbE9IV1dBRkdZR0hxN3Q1?=
 =?utf-8?B?RUtndUhBc3dBRzRXMm1pRFM0czBKZk1oWHhCeGo1ckhqK21tNHRGZ3hQSFR1?=
 =?utf-8?B?UStDaStSYVl0bDRETDE3Zld1TXlYcmhLTUpJQjZ2dWhHeHlqVXdOcGVDM0dS?=
 =?utf-8?B?eWZaQmFQZmFhZ2NqRlpkaEVnaUtuYWdLK1NMWkpRdlozYUwwQjRNOXhaQ2V6?=
 =?utf-8?B?VVNEUEpFTWRiSFVtUVJySUxjUUcvZko0VU5xTEl3NVVNLzEvWmh6eTRRWDZp?=
 =?utf-8?B?UXBsUk9ROFY4Q1dyZUhzL2JOeW5ybjhBY1Q0NG51UEdRMkF3SGFpT3JpTTA0?=
 =?utf-8?B?eXpKcVYrRktZNHE3aVAvd3lSQ1dINFVmaWRycVh2Zmk1TXBRMUZ2Wjlxb25V?=
 =?utf-8?B?VFVVYndOSGdHMEJnNTJ5T2pCMDVSU1hBSTQyVlpScXFNZFV4akhWTm9VV0Ft?=
 =?utf-8?B?K1l2TWllMlRRaGdZVEtYMmlGVEhhcmR1RXZhV25oZ3JQNE9uTGsxb3ZuUWZ1?=
 =?utf-8?B?UkZxSGVoZE1rcTdoSU5DSDM0QklQK1p3Vk9JQjhKdlkzbGhKWUxMVUYwOFBn?=
 =?utf-8?B?RWdvdGt2cWYyKyt1NTRGWlRFTy9yekRSclUyT2tjWE9hUGVFeHh5M1BoNmZN?=
 =?utf-8?B?Sjlrbjh0Y1laQkhtL1pTREdNbmpmN0V1SDg5MGxxc2RNWUhrUDMyd3lSY2JT?=
 =?utf-8?B?S3BUdDJvbHc0OVYzVk9FUGhTS0h1K01LUy9OKyt4bHppRE5pRndnZlZ3d05G?=
 =?utf-8?B?RnNiekVtQ2xEWnRqbHJEd0tvdmRRUUQ2NEl5NWVjaWhMREpzK2x6UjE3Njlr?=
 =?utf-8?B?VEpYMjBZckI0aXoybW1oYXd6LzA4N09zWTEvMi9OYnVPVGxzL21iSG5qU3A3?=
 =?utf-8?B?Nkd5RnlzdnpsaE9aY25DV2FIcTVWeXFkMlM2ZlN0ZjRVaGtTbzAvTlQ4eUlV?=
 =?utf-8?B?MS9UMDdCT3dSMjZVM1hIN1lHQ1Q1dE1MWTRXUmt5Ni9ici9OME84UC9DTEF2?=
 =?utf-8?B?dkNyYVhGdWxQaVBQRUdXNjNrMDhPelhGdjdwM2NObEZZVmMyVVBOeWN4cVJy?=
 =?utf-8?B?WGFGM0k3MmdLUTM2SnZjVi9qRTE5Rzl5TTFCNnI5ZjNOM2VCQlNSbnVuNzd1?=
 =?utf-8?B?TmViL2dFYUtCUjVBaE5VNFA2UzVBVXZoRW81b0h5cDRxVXRWbjVtam5aYTZv?=
 =?utf-8?B?V0dtUVdNandXQlhMdlBRd3NrYTJHNjg2SG43aTVzTWhaNW1kREZGZmFJR2dI?=
 =?utf-8?B?RHRQTW5IdjY3UUowVWdHTmlIY0p5Y2lkeUR4cldXd0dRVUIvcnNFRVFQc3Ju?=
 =?utf-8?B?MjlBcTZFSXJmbW9MdjlVbFR1QnUraitZT29wZXp4YS9YZ1MvS29Gc0NoZWU3?=
 =?utf-8?B?eFdraTdWMFF1RktDNkJsL3RpeXpUQlB6K2RqQVBJbUcvRU0xalR3eHBZZFRk?=
 =?utf-8?B?eUwrdXN3VEJ0ZkdwbWhUeHkyNncrZFZpK0pWL3Q2QjlXeDNKcUgvUmZHOTJF?=
 =?utf-8?B?QktQWXFhS09HMkNtT1BiamlEMTlJQ0l1ZWtTOGhvVmllU3BOazd6Vk5pK3VK?=
 =?utf-8?B?bVF4cTd4dVlsbVRPTzhzZlRmdDhnV2tld01HL3h4Ni96Mm5ZeWVJMUJXNDBK?=
 =?utf-8?B?OFdFNWw4WUxDd0x2OWdKU3B5NDFwaGo0dGhNdGg1L2psVHVtY01qZ0VEaXJG?=
 =?utf-8?B?YmxiM09wK2NvMjZmQWJ6VWxjakJCODkycGZlVm9JYVgzV01hZ1pEK2tReWRk?=
 =?utf-8?B?ZmpkQzEwdTJsOUdXY1hZZnZ4U2dtK3pzbGdSUTdFVUtpMjRscG53aXYxZ0Rq?=
 =?utf-8?Q?toR61TbzNZhvthyKAks7if+RTJhLtE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnNpTHJ4Tzg2ZUgxMS9FNGEvWHFjSTBUYUZwd0tlalh2UWxyNHBYeUthVCtX?=
 =?utf-8?B?aWhCdDZieWhHNnB0MmUvQ0RlM0U2NnhnZTZvTHlNeDkzRkFuVUNEd0V3dzBC?=
 =?utf-8?B?VGVCUUorbnkzTlF5a0x3bFoyTW1RNzZaMTRyMW5MaEJtM3dvd1Y4RjlnSDlO?=
 =?utf-8?B?ZHpiU1RXbkQ3NVNISTFqcldZRWMvcW1wTzJta05NTjk0TlduV3ZxOHVoMkVM?=
 =?utf-8?B?QnVLdVNHOVl0MU5CRTUzdm1STC83czRYRXVMc2V4cXZGL3U3UU1sWUppR3Zj?=
 =?utf-8?B?OG1tMmVnMzA1bWRmanlubDEwa0hKK2NySHJTOG5QaDE1bjl2OEQydkdVWWZX?=
 =?utf-8?B?c2h3OXRVeStvYWxYTTc1Y054NlFacmtvQ09ndlBKeEhYYUF5Zkx0MFA5dlIy?=
 =?utf-8?B?dUNOUlprQzluVWdseUplNFVNbEJPZ1VhVmJreTB2VkxZRE5yQ1JnRGFRb0NK?=
 =?utf-8?B?YytyK2piYy8yMm5ZVTlXd0ovT3hZMjFGVFJaaThscng1U3FnckNPRlUyN1pK?=
 =?utf-8?B?R0FjNHBOekRUVDZmM01IQ0VveGIxNWQ5YmVkREh2WWZ1ekx0TzBmQkh2MkEz?=
 =?utf-8?B?RDhaa0t6SjRJbFJzckxqcDIwUFRJajBYRHpSZnltUVZHemlZOVV3MEJ3cXYy?=
 =?utf-8?B?QmZRSVZHUURXWWZWb1lHd1A5bmpKQ1QvQk1GcjQwbjJXRWVkYmNsaDFUL3pG?=
 =?utf-8?B?MEdJUDBUb3pqK3g4elJuc0UvTXVGT0ZNb2JHRGZUN0tkK0xyQUhPVDVtMVBY?=
 =?utf-8?B?R2lNSE5LZmZ5S1RUOVhCd2N1UG93ZW1YaGJycytWbzNSVUUzdUpYQWh2Tlpt?=
 =?utf-8?B?VWIrUVFrUitrd1lPMDZKemNveWRISjRIOEUzQnFuaGVMLy9hUk8wUDIxbHl3?=
 =?utf-8?B?SDloUlZJUlJLMVBRQ2VKZmc1N3R5MWlSNDJLS3dLRkZ2VjZjU3BoUHU4Qk9w?=
 =?utf-8?B?MXJwZWNtd1J5Vzg3cXJWNHRITDU1Njd6T0FpT29sRnhuLytscTJPVDkrRGdV?=
 =?utf-8?B?V3ptdG9BY0Z3ZVlOS29TQ2NNY0dJNHMvS0VZYUp4Rmg1cndRNWQ1RHByRkUy?=
 =?utf-8?B?aGhsYWN6aUFIL2lUMTRQdlJEWjA2TEIxeER1dWZGVEtuOGg3a00zekVKUFdS?=
 =?utf-8?B?QWRVVWQyOVFHL2NyRm9xM2M5Nng4R0lHUk1LMXBoR29tQzM2bEFDZXlFUkNW?=
 =?utf-8?B?SFliQ1BITWZzdlI3QUNlUGduVHpwZUJlNlY2cU1wL0dOTmZiMVVtUjlJNlU5?=
 =?utf-8?B?ZFNySUxkOFgxNUZPKzBxd3JKVW5LaHRaOWwvN0ZwU2lUbmpsVmJDcXlzajR4?=
 =?utf-8?B?RGdnZGJqUHFudUN6Wi9LSW9FUzNmaGNYMkxIZHpURjU2cUxZak9sSHNzQ1g3?=
 =?utf-8?B?U0E3Rk5RY0E2Zkdzc2hLUjhoRnl4bUVVNjF4T3BZOU1TdkdOV3dJSHIyNnIw?=
 =?utf-8?B?VzdNdDF1dkRBazlOMjRxZlhoZEpiVkhROXY5K0lqdkZEdTNvbTc2Y25FK0d4?=
 =?utf-8?B?WlNFRUlqOUQyUDdJU0NCczNUM1RUZWZuamZiZzZUYUFFdmhWcHhOOG9OSG9h?=
 =?utf-8?B?Mzg1dVo2MjFFZDFESkc0MnNnbzB0djQ0MSt4Z1R4QlYreUhlV1lyTnlPMWhL?=
 =?utf-8?B?NUszZVNSU0QwSkkxSnBJK3VacGJOSWVYell3ZFZ2M1RiTGJveStnL1ZWdjR0?=
 =?utf-8?B?OVpVaVlBNmJhRndnUktoQ2NDYnN3Wmd4dU5WSi9Kb1l0QTVpOWxBWEhXclVD?=
 =?utf-8?B?aUFZSmVjS2JJWGJnVDQwMGhrTkxGOTZlbmM0Snpwb1hMemdjVWQ2L01pd09t?=
 =?utf-8?B?WHNGNDA2U2Y5S3BQdERZSHR5SzdDRkp1UVVNY3h1MSt3cmUwSUFFNEVJZHlu?=
 =?utf-8?B?dFovVklFb25VcS95Smd2d24yWWsrUU9ORnFWQ0xpKzc3TU85WS9WdFhNM3NV?=
 =?utf-8?B?OWZnb1hvc2szOS9MYXRMblVHVkJicTdHTEw3RE5QSnR1MFdraVhKQlZlL2hF?=
 =?utf-8?B?N2ZTeFVLczUvdE94dXJKTTVKazlqbVJ2TE55YTVPZkFOMitweVlOQWExN1Vo?=
 =?utf-8?B?cG1ZRVZ4eWdxMVRJaTdtOElDSC93c2ZMMzNyZGVobktnbjdWeWlRODkwVzJs?=
 =?utf-8?Q?b2KQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5257dbcd-ba59-4de9-bb79-08dda42f387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 12:48:07.4148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezVgX/B+NmWYzAQ2ySPVY9xOjtGIYC5QpGT/DBwySM9+JRYJ8/KwuO1eV5uKkHK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogU2F0dXJkYXksIE1heSAzMSwgMjAyNSA1OjM2IEFNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47DQo+IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy85XSBkcm0v
YW1kZ3B1OiB3YWl0IGZvciB0aGUgdXNlciBvYmplY3RzIGRvbmUgYmVmb3JlDQo+IGRlc3Ryb3lp
bmcNCj4NCj4gT24gRnJpLCBNYXkgMzAsIDIwMjUgYXQgNDoyMOKAr0FNIFByaWtlIExpYW5nIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSB1c2VycSBidWZmZXIgc2hv
dWxkIGNvbXBsZXRlIGl0cyBhdHRhY2hlZCB3b3JrIGJlZm9yZSBiZWluZw0KPiA+IGRlc3Ryb3ll
ZC4NCj4NCj4gSSBkb24ndCB0aGluayB0aGF0IGlzIHBvc3NpYmxlLiAgVGhlIHVzZXIgbWF5IG5v
dCBoYXZlIGEgZmVuY2UgYXNzb2NpYXRlZCB3aXRoIHRoZQ0KPiBxdWV1ZS4gIElmIHRoZSB1c2Vy
IGRlc3Ryb3lzIHRoZSBxdWV1ZSwgd2Ugc2hvdWxkIGp1c3QgdW5tYXAgaXQgYW5kIGNsZWFuIHVw
Lg0KDQpbUHJpa2VdIFRoZSB1c2VyIHF1ZXVlIGJ1ZmZlciBvYmplY3QgbWF5IGFkZCB0aGUgZXZp
Y3Rpb24gZmVuY2UgYW5kIHBhZ2UgdGFibGUgdXBkYXRlIGpvYiBzY2hlZHVsZWQgZmVuY2UsDQph
bmQgYnkgZHVtcGluZyB0aGUgcXVldWUgb2JqZWN0IHJlc2VydmF0aW9uLCBpdCBzaG93cyB0aGUg
ZmVuY2VzIGFyZSBhdHRhY2hlZCB3ZWxsLiBJbiBtb3N0IGNhc2VzLCB0aGUgcXVldWUNCm9iamVj
dCBmZW5jZXMgYXJlIHNpZ25hbGVkIGF0IHRoZSB1c2VyIHF1ZXVlIGRlc3Ryb3kgcGhhc2UsIGJ1
dCBzb21laG93IHRoZXJlIGlzIHNvbWV0aW1lcyBhbiBhdHRhY2hlZCBmZW5jZQ0Kd2l0aG91dCBi
ZWluZyBzaWduYWxlZCBwcmlvciB0byBkZXN0cm95aW5nIHRoZSBxdWV1ZS4gSW4gdGhpcyBjYXNl
LCBkbyB3ZSBzdGlsbCBub3Qgd2FpdCBvciB0ZXN0IHRoYXQgdGhlIGJ1ZmZlciBvYmplY3Qncw0K
ZmVuY2VzIGFyZSBzaWduYWxlZCBiZWZvcmUgdHJ5aW5nIHRvIGRlc3Ryb3kgaXQ/DQoNCj4gQWxl
eA0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycS5jICB8IDMgKystDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJx
dWV1ZS5jIHwgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiBpbmRleCA4ZWVhMGUxZTFiNmEuLmY0NTU4NWJkNTg3MiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAg
LTIxNyw2ICsyMTcsOCBAQCBpbnQgYW1kZ3B1X3VzZXJxX2NyZWF0ZV9vYmplY3Qoc3RydWN0DQo+
ID4gYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLCAgdm9pZCBhbWRncHVfdXNlcnFfZGVzdHJveV9v
YmplY3Qoc3RydWN0DQo+IGFtZGdwdV91c2VycV9tZ3IgKnVxX21nciwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX29iaiAqdXNlcnFfb2Jq
KQ0KPiA+IHsNCj4gPiArICAgICAgIGFtZGdwdV9ib19zeW5jX3dhaXQodXNlcnFfb2JqLT5vYmos
DQo+IEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZmFsc2UpOw0KPiA+ICAgICAgICAgYW1kZ3B1X2JvX2t1bm1hcCh1c2VycV9vYmotPm9i
aik7DQo+ID4gICAgICAgICBhbWRncHVfYm9fdW5yZWYoJnVzZXJxX29iai0+b2JqKTsgIH0gQEAg
LTMxNyw3ICszMTksNiBAQA0KPiA+IGFtZGdwdV91c2VycV9kZXN0cm95KHN0cnVjdCBkcm1fZmls
ZSAqZmlscCwgaW50IHF1ZXVlX2lkKQ0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfYm9fdW5w
aW4ocXVldWUtPmRiX29iai5vYmopOw0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfYm9fdW5y
ZXNlcnZlKHF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPiAgICAgICAgIH0NCj4gPiAtICAgICAgIGFt
ZGdwdV9ib191bnJlZigmcXVldWUtPmRiX29iai5vYmopOw0KPiA+ICAgICAgICAgciA9IGFtZGdw
dV91c2VycV91bm1hcF9oZWxwZXIodXFfbWdyLCBxdWV1ZSk7DQo+ID4gICAgICAgICBpZiAociAh
PSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQpIHsNCj4gPiAgICAgICAgICAgICAgICAgZHJt
X2RiZ19kcml2ZXIoYWRldl90b19kcm0odXFfbWdyLT5hZGV2KSwgIkNhbid0IHVubWFwDQo+ID4g
dGhlIHF1ZXVlIGZvciBkZXN0cm95aW5nLlxuIik7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4gaW5kZXggMTQ1N2ZiNDlhNzk0Li5iNDZl
NjdiMTc5ZmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVz
X3VzZXJxdWV1ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3Vz
ZXJxdWV1ZS5jDQo+ID4gQEAgLTMzNiw2ICszMzYsOSBAQCBtZXNfdXNlcnFfbXFkX2Rlc3Ryb3ko
c3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21nciwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqcXVldWUpICB7DQo+ID4gICAgICAg
ICBhbWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmZ3X29iaik7DQo+
ID4gKyAgICAgICBpZiAocXVldWUtPmRiX29iai5vYmotPnRiby5waW5fY291bnQpDQo+ID4gKyAg
ICAgICAgICAgICAgIGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gKyAg
ICAgICBhbWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmRiX29iaik7
DQo+ID4gICAgICAgICBrZnJlZShxdWV1ZS0+dXNlcnFfcHJvcCk7DQo+ID4gICAgICAgICBhbWRn
cHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPm1xZCk7ICB9DQo+ID4gLS0N
Cj4gPiAyLjM0LjENCj4gPg0K
