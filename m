Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DBAC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 23:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA4110E0B0;
	Thu,  6 Feb 2025 23:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ei8sUjW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260AC10E0B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 23:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJCZNBRHgY5gIKb+/LkNikhRpEkcaRHaveBj2eIeIjXvoNUblmpt1S+jMARapYGt97djjjDO0btbJeMf4IONgI9gXIB+qZkb65CsCnJtWCKH6KHByIjjriG3+J8nElm4KYjV/AuPkgtkpzY6vi7RTBc1edKPf+3xNZwZO5i6HNQ+Uh1oayFdnak98qtQWQVHEYT5+9T3BDSLZ6tyvu9va+VQp+yvspUnqg2wznWSNDt4lmROYUfyHBqsLcnyqqkcZPSwS/ju9kayu+ygW1y1zdYQU6BYqvQDm8F9mz5QdQczPSVcrPVau+99LaYVD9jfyntt3kz9fcHNDX7zRiLpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN71PsztHG8FFJ7HcnKyFYNbA/cYcmE6pXgSGFC57PU=;
 b=W7KHZIf8d9I2dmSg0M5xhx+0M86FYU/TqJJvXo8FBaz+MYHm3JnRj4JluVSyNtEpeQh+lrn+JrRECJ8lkJN8AClLIaTXmGkm+tBPm0C5kW8qbkGhb+kNBkUyHbfDyio6SQMtXhPCo368vd3fk1oURL47pxuizmHTEO5xhvFRrF6zg/kQf6rrmGnOuqXvVRbU1ccsKHkl9ZRxHhbTNg0MZN7Z49kBQwdd692V8UNhDElOpSpA31FJv/Y7ArHV2ydY8RRWC6N5bi8RWGZVH7MhY/25xwRUFs5X6YpK664Q+ICEW3r+DrEFTRnuopaKhqluShV5MKixwCrimRh1p/kxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN71PsztHG8FFJ7HcnKyFYNbA/cYcmE6pXgSGFC57PU=;
 b=5ei8sUjWEsxndXjboMJTmnEQj53+OcZoJCz3OvOaPH3D6Wr7VexUPot6ntm019MsTqbQ1gBEkH4ykds4B55rJUvS/UAInTIGR+54i4Z8dAr+A63235AEyhiqFpgpf+bjM9Z7gna9+GvYabgRWW4SVBODckCqwnu6oPf2LMDFrNs=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 23:45:32 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 23:45:32 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Sakhnovitch, Elena (Elen)"
 <Elena.Sakhnovitch@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Don't modify grace_period in helper
 function
Thread-Topic: [PATCH 2/3] drm/amdgpu: Don't modify grace_period in helper
 function
Thread-Index: AQHbZr4Oi4tJJL8aAUWsLWBUH6ksO7M69qSAgAATa0A=
Date: Thu, 6 Feb 2025 23:45:32 +0000
Message-ID: <CY8PR12MB7099A9B426590079F2A386DC8CF62@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
 <20250114195251.42661-2-Elena.Sakhnovitch@amd.com>
 <822d7a16-1220-49ea-80bf-36217d052f4d@amd.com>
In-Reply-To: <822d7a16-1220-49ea-80bf-36217d052f4d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8e0e5090-1222-456f-b9bc-0880025f9654;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-06T23:06:49Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: b72d73d2-3aee-439a-99ff-08dd47085832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZkJDME01RU1pZnZrZmVwZWdibEhGbjB0NG5NVnhNR29HckE5MmdNSXJTS3JN?=
 =?utf-8?B?dlBjZ1Fxekk2SDBTaWttekdtSVF5czlLZDQ2dGxIM3Q2c2hKczNUaDRETTY1?=
 =?utf-8?B?UElYWkRyZTI4R3BNT210VVAyMnRGVkNJN2lFVDNiSXBab1RBRGlSZk1lVnZU?=
 =?utf-8?B?S1U1bDdjckpkUFBFOEVvUHh0cXlFRUw3elluMjVEYmdjbUFwMkwzem4yZTA5?=
 =?utf-8?B?VFROSkc0N09ESU0xRUdVbVQyTHFveDRqWDBoZXFwdFdtelpPalkvTXR2MWtP?=
 =?utf-8?B?Ymc2QVlockRsRXVyeHFOOURqYjM5aEpzVUVXY3R1YjVXenZmVWswS09maG0v?=
 =?utf-8?B?OHY5aDdsN0FGbVBmcHh6bG1Rc2ZvNUFkMlJXR0RqY2Z3MnhySktEdGZ6SFVE?=
 =?utf-8?B?cFB5dTZBeWxGSld0cEdKT1lGeU5yd3FZbGhzTTBjK00rS0Fja3RSeDYyMVdH?=
 =?utf-8?B?Vkh4S043VVBtaWpraUgwWDF1bG9BWE9OYUZWd1N4eHlOaVgxUmdEdmUxYWxn?=
 =?utf-8?B?eWovRGxOeGNLNU5YT1g1ZTZ3S2tEcnVXQkdUakpPQ3N0ODlXMjR1WldHa0ti?=
 =?utf-8?B?Rk1UOE01THF4ZlNQOWZhZys1SElkRWVEM0wrTzkwUmJRMjB2eCs3OGtibjEz?=
 =?utf-8?B?WFZLS1YwNjhrVFlXUHRRVmFmdjFsWW9HWWVJeTZQRWljeUxqREtLL0huTE9T?=
 =?utf-8?B?Ni96cEx6VkVuZHk2OFJzR09kNEZwOVErZFVsUWFGMUNKcGRvRm9kSFk3VFRD?=
 =?utf-8?B?Q1BUMWFBNjFqdGhHK2VmNmlyVExnUkFYWVlzcVNkWVBpTUtlaXFORGYvaGVH?=
 =?utf-8?B?NjFmNzIyR2hpRThZcWNMRDV1c2dDamQyclo3SnJHVUZZUFhqdVdRa2lqdk9v?=
 =?utf-8?B?VHhKQVNad3NlZUI0Y0YxbktPcG44RFlTbndKcTByVXcrNGw3blhZQWFHRVNn?=
 =?utf-8?B?OFBzZmp1aERKWXIrWUN1VjdvSGN5UHZMSVVYb0RvNlR4M2JoK0d5T2dCTHRN?=
 =?utf-8?B?SlhIaW9sRkFueEI3ckRKdWJhT3lKelRHUkdyQU10dFR5OVF5dWN5U3VLNGYr?=
 =?utf-8?B?Z3FqWDVoNnMyak1OdWtaQXZJVVhSTEpOYUU1TkJOWkZ5R0UyTFNBeHBNMlc3?=
 =?utf-8?B?c1A1d1ZpbENsLzg3bHFGTjFSVmpxL0FMekVHbDBqMlNTeEFIWlRyaWxBYXYr?=
 =?utf-8?B?QWhFa1hRdDYxNVBCMDJzUzNYR3JXeWpTQzlhbVBrNDZoblpxVk4yS3lJTHcz?=
 =?utf-8?B?V1FRVlQyY25FOG9jaTZ1VWZ4dGdsQmRwM2MxSmJuSzFqQ0NzSEJReDYvVXJR?=
 =?utf-8?B?SldHeVR0YStjTmY5dWRPYi9XVDFsWVVnU2QzTHlhajJLQTZDcW1YY0hoYXNG?=
 =?utf-8?B?KzA4amd3Nis1TUxSSjcwK3dteXpzN3kvZGdBd3UvMkRIVEo1eEtoUVczdlJo?=
 =?utf-8?B?L20rMFRPbkFiRVVtbFNNYkVCVm5hc1VOd3BaNS95UGk3a1VDRlpQWUlSaVpT?=
 =?utf-8?B?eGlLdmVjK2lkNE5wek93U2x4Q2t4Nng5bUExUTlKUk9mVll2a3M0c0dBU3p5?=
 =?utf-8?B?bTZyNDE2NklNYmV4a2dUTnpBUWxvZmdrWTBiYzlaSDJ3MEJvd28vUHY1NUtq?=
 =?utf-8?B?RFhla1gxYnNsVHQ2dG1HdzdFZUk4YUJ0S2lPMVRCQXduK1pFT2FGdkVwdVBG?=
 =?utf-8?B?WVB0c2pNUmI3ZE1jYnFBQis5Vjc1bjJHemszUnVPdUpIckxPSStBUE1lZlFt?=
 =?utf-8?B?M0t4TEpmUkRFKzRBUVRIRFdqSlhIR3orMERsMkhTSmI5WExvRGxnenlsZi9j?=
 =?utf-8?B?eGdRRUNubjZWOVBoNEVNL1NvbTBnMzQ4dHRQZDZxV0xsTnl5a0dndTNiVjVw?=
 =?utf-8?B?di9NV3d0S0dKRW1lMjRTdU5rZktBVUZIUFZkRHA1OTkwK3V4U0x1QngrY3hO?=
 =?utf-8?Q?UABf5cTOCKacf59he8ikZIm2FyJFFGot?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU9tOU1OeGRNWXVaOEhhdDNFdmh0VXBtNG5MVVphcmh1UThQWUNtdmdwOUVu?=
 =?utf-8?B?SHcyMGxpakxUYkxuZERYWXJSb2h1YTFZS1RqRjVWeTJNbWFRcm9od1J3TkVU?=
 =?utf-8?B?NmlPOUdPTDkvcXJkVzNYRFpEenlxM0JMZWRkWHNWdFZPY2NIVk9YK3dSUkdS?=
 =?utf-8?B?SG1IMDlWeVJhbU9hQ1psa0VPT2pVWFE2ZGtlZW0zcTNZUUh4WTBJbXJobnNH?=
 =?utf-8?B?MjRZaFJIaHhIazJQWGxrTGJHeCtEUzQyZENFVHlZbnNXVFZ1WU5ZY3lXM2ND?=
 =?utf-8?B?UFFPblVsUDY3NXVyTWhxazcrZEtNS081NWxRem9NaWkwRkNZS2d1U1dyc2JG?=
 =?utf-8?B?dmd5WnB4MDNzeXJiREwwcndOOXJyK0pjeDR1SmxsUDRGYnhvOTFCY253TVlK?=
 =?utf-8?B?U1JYakQ5d2lvR1NLUVJuS3h5RHQ2S1BqZkJ3NnR4SmR5dmd1Q3FDeDV3ZVlh?=
 =?utf-8?B?NFRKSlE3Nnk2ZTJlVEttU3ZGZVNLUm8wRGJ2dVgzK2dWWXREN3BZRVJEbGdE?=
 =?utf-8?B?cXkrOHhKdkZvc0RqeE5OMEdQREJUWENnU2RNZGczQ0t2Y29KbnpCTmNDYmxp?=
 =?utf-8?B?Rm5YVW1seHl6YkcrMGE1SFRpOEMwQ3FDSTBvdUFaNDhaNWFXdHNsU1JyV01N?=
 =?utf-8?B?cUpyY243QzhEK3pZVlo2UEx1U0gvSDlRcWVhU3pibGZFaTMyWFEweW5DTVhj?=
 =?utf-8?B?SjJMZyswa21QUnFrNFVEcWZsd2swSDN5NGllWVhOT0h2cnZXeG9kcXJkcCtN?=
 =?utf-8?B?WVFUQ21ubDZsNis5eGJhMiswM2s0bGxhKzd6cythQnhZT3l6SUVxZUJVOXJZ?=
 =?utf-8?B?aVBrSXVvSVlNMm0yelZUenNyc1k0R1lHbk5pT2FTbHNWUlh6R29hbkt6UUVv?=
 =?utf-8?B?M09QSFpzTmtXais5b1I2MXk0V3BqeWp1R1V2L2tRRkhMak01QUg3UlNJTENt?=
 =?utf-8?B?c2t0dVFYeXVrOVp0N3d0bWRuZ3huRmdBaWorMEJDclo3bmZYdVk2d0RtMjNi?=
 =?utf-8?B?dzFnVGRlR1NvdDRXMkY0dEhNN2R6ak5xTm9YVTB6aXhMM01kbTRmazdLKzVR?=
 =?utf-8?B?SDc3S1NpeHh0L3VkbXd0MWl0Z0VDdFJscmZTQkxwOXlpemxTenE0aVdtbjI1?=
 =?utf-8?B?Sm1BZDNXMHhQZTlLTmREYnd6NlliZlN5MkJNK0trVUZ0MUtIakNONWEzYW53?=
 =?utf-8?B?cVlMT3Vac0RaNGZhTWFFbGxua2EyeFBQODhOeTJRVnRNUVVxNDZ2dzZPL1Fz?=
 =?utf-8?B?WWZORlVCN3JSWllIVm81UkE2a0pQdEd0SEkrVlcyS1J2c05rS3NIcmVvNTFK?=
 =?utf-8?B?VFlhZitBeTd5QjhjbGxwVyt6ZW4xenJPUXkyYmNMVFozcDhNbzJtOU1uNzg5?=
 =?utf-8?B?dzdUNG5hV3IwM1c1NjZoT3I5THlZQ0VXVFBob01vNnZSVVRlU1JsNDJKMWtJ?=
 =?utf-8?B?cWNaZmhiU3pYdDR6bHlGNEJ5b2ZTV1NhYm9NRjAzY01Jc00yYmRkSzJkbVgy?=
 =?utf-8?B?SThld0txRFlCSHoxRCt4aml3d1MrV3pva1cxeXlOeFYrUTRDaEhNYVZOak5l?=
 =?utf-8?B?TXJsYUVzUW9aT3dCMXZUR0hmckM0RDNvYlVKMUFjQ2Npa0hVNWZQU0J6cUE0?=
 =?utf-8?B?VkI3eG9WOHN4VFVHeDZLTTZuanVpYndqdjlwUXI4S3diOGhBck14dDg3TFBl?=
 =?utf-8?B?c3ZZME5RN0tDRDk3QVI3VDJvVFF5R3ZhN1pNNzFya2tpeFRCZ0tabnlxSWJo?=
 =?utf-8?B?bmk0UzVPcXJMaVF1YThaU0ZOM2l2Rkc3Qnhva3RRMHZ0c0t1NjVNNHRmOFF1?=
 =?utf-8?B?NUQ2RFhaWFF6d0JpL2NCbEwvTVRHZndyZWhGQ2ZXSWtPYTlNV0JIcGxFVk8v?=
 =?utf-8?B?OGFzQzJXL0Z0Ri9XT3N4YTZveWNBSWZ3cXN4cDNacy8wMm5WQXRUL0twL2RN?=
 =?utf-8?B?L3N4MEVJWkFFeUhNUlE0Ymc0Qk1tRXlZYS8wdnB6R0ZOVnVZMU1TcTdIRG9K?=
 =?utf-8?B?Q21xSURERGZWNXhPUmZ6bDhLbWlHWVFBNm9FbWVQWTJkLzBrZEFETjYzSmx2?=
 =?utf-8?B?WVFVU2tJcHNwNmcweTcyWlhzcmZSVlhEVnJMMVVIZUVQSTFQMlBaQXB1Z2U2?=
 =?utf-8?Q?SJcY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d73d2-3aee-439a-99ff-08dd47085832
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 23:45:32.1406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqPOABUP4cgroknF6OZL9v9uivLNsVAlUIrbllp8DJ2Ke0TaUZPdSAABWZM5bfVA0O1TZ+Q+9pYOBhyoNJMiVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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

W1B1YmxpY10NCg0KRnJvbTogQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4N
ClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDI1IDQ6NTcgUE0NClRvOiBTYWtobm92aXRj
aCwgRWxlbmEgKEVsZW4pIDxFbGVuYS5TYWtobm92aXRjaEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkth
c2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGRybS9hbWRn
cHU6IERvbid0IG1vZGlmeSBncmFjZV9wZXJpb2QgaW4gaGVscGVyIGZ1bmN0aW9uDQoNCg0KT24g
MS8xNC8yMDI1IDE6NTIgUE0sIEVsZW5hIFNha2hub3ZpdGNoIHdyb3RlOg0KRnJvbTogSGFyaXNo
IEthc2l2aXN3YW5hdGhhbiBtYWlsdG86SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tDQoN
CmJ1aWxkX2dyYWNlX3BlcmlvZF9wYWNrZXRfaW5mbyBpcyBhc2ljIGhlbHBlciBmdW5jdGlvbiB0
aGF0IGZldGNoZXMgdGhlDQpjb3JyZWN0IGZvcm1hdC4gSXQgaXMgdGhlIHJlc3BvbnNpYmlsaXR5
IG9mIHRoZSBjYWxsZXIgdG8gdmFsaWRhdGUgdGhlDQp2YWx1ZS4NCmJ1dCB3aGF0IGlzIGh1cnQg
dG8gdmFsaWQgaXQgYXQgYXNpYyBmdW5jdGlvbj8gZWFjaCBhc2ljIG1heSBoYXMgaXRzIG93biBy
ZXF1aXJlbWVudCBvbiBncmFjZV9wZXJpb2QsIHNvIGhhcyBpdHMgb3duIGNoZWNraW5nLg0KDQpb
SEtdOiAgYnVpbGRfZ3JhY2VfcGVyaW9kX3BhY2tldF9pbmZvIGlzIGEgaGVscGVyIGZ1bmN0aW9u
IHRvIGJ1aWxkIHRoZSBwYWNrZXQgYW5kIHRoYXQgc2hvdWxkIGJlIGl0LiBJdCBuZWVkIG5vdCBj
aGVjayBvciB1cGRhdGUgd2hhdCB2YWx1ZSBnb2VzIGluc2lkZSB0aGUgcGFja2V0Lg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBIYXJpc2ggS2FzaXZpc3dhbmF0aGFuIG1haWx0bzpIYXJpc2guS2FzaXZpc3dh
bmF0aGFuQGFtZC5jb20NClNpZ25lZC1vZmYtYnk6IEVsZW5hIFNha2hub3ZpdGNoIG1haWx0bzpF
bGVuYS5TYWtobm92aXRjaEBhbWQuY29tDQotLS0NCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmRfZ2Z4X3YxMC5jIHwgMTggKysrKysrLS0tLS0tLS0tLS0tDQogLi4uL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jICB8IDE3ICsrKysrKy0tLS0tLS0t
LS0tDQogLi4uL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdjkuYyB8IDEy
ICsrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dmeF92MTAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ2Z4X3YxMC5jDQppbmRleCA2MjE3NmQ2MDdiZWYuLjhlNzJkY2ZmODg2NyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3YxMC5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92MTAu
Yw0KQEAgLTEwMjksMTggKzEwMjksMTIgQEAgdm9pZCBrZ2RfZ2Z4X3YxMF9idWlsZF9ncmFjZV9w
ZXJpb2RfcGFja2V0X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogew0KICAgICAg
ICAqcmVnX2RhdGEgPSB3YWl0X3RpbWVzOw0KDQotICAgICAgIC8qDQotICAgICAgICAqIFRoZSBD
UCBjYW5ub250IGhhbmRsZSBhIDAgZ3JhY2UgcGVyaW9kIGlucHV0IGFuZCB3aWxsIHJlc3VsdCBp
bg0KLSAgICAgICAgKiBhbiBpbmZpbml0ZSBncmFjZSBwZXJpb2QgYmVpbmcgc2V0IHNvIHNldCB0
byAxIHRvIHByZXZlbnQgdGhpcy4NCi0gICAgICAgICovDQotICAgICAgIGlmIChncmFjZV9wZXJp
b2QgPT0gMCkNCi0gICAgICAgICAgICAgICBncmFjZV9wZXJpb2QgPSAxOw0KLQ0KLSAgICAgICAq
cmVnX2RhdGEgPSBSRUdfU0VUX0ZJRUxEKCpyZWdfZGF0YSwNCi0gICAgICAgICAgICAgICAgICAg
ICAgIENQX0lRX1dBSVRfVElNRTIsDQotICAgICAgICAgICAgICAgICAgICAgICBTQ0hfV0FWRSwN
Ci0gICAgICAgICAgICAgICAgICAgICAgIGdyYWNlX3BlcmlvZCk7DQotDQorICAgICAgIGlmIChn
cmFjZV9wZXJpb2QpIHsNCisgICAgICAgICAgICAgICAqcmVnX2RhdGEgPSBSRUdfU0VUX0ZJRUxE
KCpyZWdfZGF0YSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BfSVFfV0FJVF9U
SU1FMiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0NIX1dBVkUsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdyYWNlX3BlcmlvZCk7DQorICAgICAgIH0NCiAgICAg
ICAgKnJlZ19vZmZzZXQgPSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbUNQX0lRX1dBSVRfVElN
RTIpOw0KIH0NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ2Z4X3Y5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dmeF92OS5jDQppbmRleCA0NDE1NjgxNjNlMjAuLjA0Yzg2YTIyOWEyMyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCkBA
IC0xMDg1LDE3ICsxMDg1LDEyIEBAIHZvaWQga2dkX2dmeF92OV9idWlsZF9ncmFjZV9wZXJpb2Rf
cGFja2V0X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogew0KICAgICAgICAqcmVn
X2RhdGEgPSB3YWl0X3RpbWVzOw0KDQotICAgICAgIC8qDQotICAgICAgICAqIFRoZSBDUCBjYW5u
b3QgaGFuZGxlIGEgMCBncmFjZSBwZXJpb2QgaW5wdXQgYW5kIHdpbGwgcmVzdWx0IGluDQotICAg
ICAgICAqIGFuIGluZmluaXRlIGdyYWNlIHBlcmlvZCBiZWluZyBzZXQgc28gc2V0IHRvIDEgdG8g
cHJldmVudCB0aGlzLg0KLSAgICAgICAgKi8NCi0gICAgICAgaWYgKGdyYWNlX3BlcmlvZCA9PSAw
KQ0KLSAgICAgICAgICAgICAgIGdyYWNlX3BlcmlvZCA9IDE7DQotDQotICAgICAgICpyZWdfZGF0
YSA9IFJFR19TRVRfRklFTEQoKnJlZ19kYXRhLA0KLSAgICAgICAgICAgICAgICAgICAgICAgQ1Bf
SVFfV0FJVF9USU1FMiwNCi0gICAgICAgICAgICAgICAgICAgICAgIFNDSF9XQVZFLA0KLSAgICAg
ICAgICAgICAgICAgICAgICAgZ3JhY2VfcGVyaW9kKTsNCisgICAgICAgaWYgKGdyYWNlX3Blcmlv
ZCkgew0KKyAgICAgICAgICAgICAgICpyZWdfZGF0YSA9IFJFR19TRVRfRklFTEQoKnJlZ19kYXRh
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUF9JUV9XQUlUX1RJTUUyLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTQ0hfV0FWRSwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ3JhY2VfcGVyaW9kKTsNCisgICAgICAgfQ0KDQogICAgICAgICpyZWdf
b2Zmc2V0ID0gU09DMTVfUkVHX09GRlNFVChHQywgMCwgbW1DUF9JUV9XQUlUX1RJTUUyKTsNCiB9
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5h
Z2VyX3Y5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJf
djkuYw0KaW5kZXggZmRlMjEyMjQyMTI5Li5hZGM3ZjdjNzhhMTggMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdjkuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5hZ2VyX3Y5LmMNCkBAIC0zMDYs
NiArMzA2LDE4IEBAIHN0YXRpYyBpbnQgcG1fc2V0X2dyYWNlX3BlcmlvZF92OShzdHJ1Y3QgcGFj
a2V0X21hbmFnZXIgKnBtLA0KICAgICAgICB1aW50MzJfdCByZWdfb2Zmc2V0ID0gMDsNCiAgICAg
ICAgdWludDMyX3QgcmVnX2RhdGEgPSAwOw0KDQorICAgICAgIC8qDQorICAgICAgICAqIFRoZSBD
UCBjYW5ub3QgaGFuZGxlIGEgMCBncmFjZSBwZXJpb2QgaW5wdXQgYW5kIHdpbGwgcmVzdWx0IGlu
DQorICAgICAgICAqIGFuIGluZmluaXRlIGdyYWNlIHBlcmlvZCBiZWluZyBzZXQgc28gc2V0IHRv
IDEgdG8gcHJldmVudCB0aGlzLg0KKyAgICAgICAgKi8NCisgICAgICAgaWYgKCFncmFjZV9wZXJp
b2QpIHsNCisgICAgICAgICAgICAgICBwcl9kZWJ1ZygiSW52YWxpZCBncmFjZV9wZXJpb2QuIFNl
dHRpbmcgZGVmYXVsdCB2YWx1ZSAweCV4XG4iLA0KKyAgICAgICAgICAgICAgICAgICAgICAgIHBt
LT5kcW0tPndhaXRfdGltZXMpOw0KKyAgICAgICAgICAgICAgIGlmIChXQVJOX09OKChwbS0+ZHFt
LT53YWl0X3RpbWVzICYgQ1BfSVFfV0FJVF9USU1FMl9fU0NIX1dBVkVfTUFTSykNCisgICAgICAg
ICAgICAgICAgICAgICAgID09IDApKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQpzaG91bGQgc2V0IGdyYWNlX3BlcmlvZCB0byAxIGhlcmU/DQpbSEtdOiAgUHJldmlv
dXNseSBncmFjZV9wZXJpb2Q9PTEgd2FzIGNob3NlbiByYW5kb21seSB0byBndWFyZCBhZ2FpbnN0
IGludmFsaWQgdmFsdWUgMC4gSW5zdGVhZCBvZiB0aGF0IGJldHRlciB0byBzZXQgaXQgdG8gZGVm
YXVsdCB2YWx1ZS4NCg0KDQpSZWdhcmRzDQpYaWFvZ2FuZw0KDQorICAgICAgIH0NCisNCiAgICAg
ICAgaWYgKGdyYWNlX3BlcmlvZCA9PSBTRVRfQVNJQ19PUFRJTUlaRURfR1JBQ0VfUEVSSU9EKSB7
DQogICAgICAgICAgICAgICAgLyogU2V0IENXU1IgZ3JhY2UgcGVyaW9kIHRvIDF4MTAwMCBjeWNs
ZSBmb3IgR0ZYOS40LjMgQVBVICovDQogICAgICAgICAgICAgICAgaWYgKGFtZGdwdV9lbXVfbW9k
ZSA9PSAwICYmIGRxbS0+ZGV2LT5hZGV2LT5nbWMuaXNfYXBwX2FwdSAmJg0K
