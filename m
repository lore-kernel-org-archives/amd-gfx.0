Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F316C87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 03:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F0910E10C;
	Wed, 30 Jul 2025 03:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQzxfPaw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EEB10E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 03:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4FWcFH3byOqbP07ihb06cNeFfNk1r44NeYYLh+JgIFwpTiRsjBGQM8MbReqgpTF7zGtmDMMTvWDV2++iJ7h0RjyNrHqVwLgaOA6rzu42NNKMbxnr5IC4jk8wWCnED6NaEGQtNyrxFm++iYtdinVhrZyX/38pW0TssrCDi/kpeIWbCsCW41/hOWoL2dz0s95lkM0zewEjTu/jupkTVEIq7blEyTVDbLY3azwCWuBhYOMFVG4SRTUMQJZ19oJdnVlySbbwD/rugI3ulZFrYmpWciD2up9OSfjIjNfBgjpmkSyERlccGoTGi55qV9+is5m9njjkZOyLQy5ed9glXSz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VGLqDpjFrPYRJQHR0zNdwg4Taf40PLYqdfAj4AhvUw=;
 b=xhv6K9HEZmIKrN7WsAc6KZymy+FseW6wy6thhZbOJLXwGwwYpjbVCZjWrsXhq55Jv/k0haIZWDhoLGEqJuNTzTHXat8okKQwHc5CCx8trmVu2fPk/dfoD9qxi558PhsFH9leeuk33ECP69K/PRqPeFZKv3QkAnSrib6Myriq/BgQgAY8BWnSzqUig2Ybm6EZSwQ31bPwZuPHngTykBfrFWcJaoqxONwlz2CUDQsVVeKz6+m8PJ4Fw9NrO8gkNCrh0qE30mik+m9ftZYMlG7EQwRHjjF0S4eEsqhEokG4f8jvrGWe9nh6eh4uBtxhf9sWY9clujQp5tAnANlL5lYlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VGLqDpjFrPYRJQHR0zNdwg4Taf40PLYqdfAj4AhvUw=;
 b=XQzxfPawHOrLc48A48OIWSRmQSHuBQOJy+c37g212EGkvOvzkdeP3s6bq6Pd/p2DoxFQMDwuFLUsgAcpFA1YkltunoEy9gBonw3HTeChxOan5bZ1JJliWZl9CB7Hg0zJ72n+QjhNy6MIE4z6Ouuw9Vc035pN5gvurBBEXcc8iYg=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 03:39:09 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 03:39:09 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "cao, lin" <lin.cao@amd.com>, "Zhang,
 Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Topic: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Index: AQHb+7EcoCXofQ9OfkW7m4hre0+GirRHQr2ggACbcwCAAIv0sIAAsjqAgADyzgA=
Date: Wed, 30 Jul 2025 03:39:09 +0000
Message-ID: <PH0PR12MB542001F60415848CE4C9EB74E024A@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
 <CADnq5_MBSe2tuczKGwigygErxYUXg=O+H63NcnFnMd_C0qLwpA@mail.gmail.com>
 <PH0PR12MB5420F3163B34DB33AF74B6D9E025A@PH0PR12MB5420.namprd12.prod.outlook.com>
 <CADnq5_O-Nc7JtjxCWOdq9Eqx66n16_a5dgJ2=PO=FSfVduCBWg@mail.gmail.com>
In-Reply-To: <CADnq5_O-Nc7JtjxCWOdq9Eqx66n16_a5dgJ2=PO=FSfVduCBWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-30T03:37:30.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|LV8PR12MB9417:EE_
x-ms-office365-filtering-correlation-id: 1be33461-e1de-4cd7-6ca1-08ddcf1aa483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SkZzVitFT1VqcXlSUHh6eklmYXJSV2xVUjRDSjAwcnByanFDRUFVblhGaG9p?=
 =?utf-8?B?clk3ZTc2dTl6dSt2blc2NGM4ZDV0ZUp3cm5lemxjRkdIbjd5c3V0N1hoenJB?=
 =?utf-8?B?Q2hLK2d5QjZySVgyM1VwNmRUUkI3YzFLLzBLKyt4WTVDcVhHUFM2SlFIdnBw?=
 =?utf-8?B?SWlodFhIejZBOFBHejNzU1Jkdm12NjNoY2lNV0RQV2VhMDR6Ni8wSkwyb25h?=
 =?utf-8?B?aU1xTTluL1psQVlFSWIzdTNjSDFKTGh2RGFxb0tkWEM2Q1JnTzQxTGdrZCtL?=
 =?utf-8?B?RlJHekR4Z1E3OVNPalBXUGJGdG5Td0ZIaWZrRi9WWHFEWEprQVdHSlMzMFcr?=
 =?utf-8?B?RkRJQ2xhNGs5b0V1QTRiamJXSm8vWm52VmdjTzQ2c2dEdFhCNGd3U2JrODZZ?=
 =?utf-8?B?WllxaDRXR0R4eE1QNUlkbG1yWFo0a0JxWXJzOG5WdDdmbEVkNkZScEluUnVC?=
 =?utf-8?B?a0E3SnNhaXBjVGhwVVlPK1M1TGhieU0zV216ZmhaaE4rSm4vWU5UOERSM0tH?=
 =?utf-8?B?VkZCWEpzcXJIMFJCanVEQ201a1hTdHA4VXhIbmRTZW5nbHVsM3VWMmZkUHN6?=
 =?utf-8?B?T3g0R2Y0TUZSNS9TN1Y1bE4xRXA1aDBzZVhYNG1FTHg3Z1lkeUg3VHRJZHlp?=
 =?utf-8?B?TWtyZzNIb01rWnVUMEhFaXNiMS9TcjA2N3lMV1FYL2ZiZTcwb1k0a0Q2ZTFJ?=
 =?utf-8?B?bkNkQnBweVBicThLQW5PUXlxOXp3VFE1SGtlUVlNNDJTSHYrVCtBNVIweWRS?=
 =?utf-8?B?QllqSWJ5MVprQldxV1NQQnZPQ0ZwZVpCTlFqNG1ZTjJydUgvejZhb2lwSElO?=
 =?utf-8?B?V1dmdysvaUVkVXdFaWJHVm5QaUR4ZldJRzg1dlgyK041MURkM0pEdjh1S0ZE?=
 =?utf-8?B?WHVObmk4RTJGVHE2YWE4YjJJcXpBd2Z5RzR5QzIxbHQrMzEyd1AvajBNTmVX?=
 =?utf-8?B?S2twNktiaVRobzRoMHdTRWN0YXVGQ2RrTnFrM3hYbzRubHh4MlVLc3RJRG40?=
 =?utf-8?B?U3ZxNVFJdlM3ejRaaGRxS0puREYvcWNjWVBWMHZIUExtcXJrRGthdU9uRDF6?=
 =?utf-8?B?TVBUQ29iM1MwdmRQbkxLSVBZdWVJQzRKclJSVkk4Smd0NUxrMVY3ZzJIREV5?=
 =?utf-8?B?TTZxUFF6aDhWUWNWMGNJeUpjUzJnNWE0NldLR3NLb0Z6UzNmZWh0S0p2KzJR?=
 =?utf-8?B?UGRtVzR6Y240NUFLNWRBZmRzcjM5MG5hbnJQNjU5ZVcyTGhWWkZObWJsWm10?=
 =?utf-8?B?S1czSm9uNTVyUWFaQTAxUkpsVmYxYjJhYkhkamxZNUpra1hqNG9OYng1OCs5?=
 =?utf-8?B?QjMxMlJid1hGZ2prS0t5SFpWYmdNcXgzaEgrWEl0M2o3N0hQMkxsdTQvWFE2?=
 =?utf-8?B?Qnl0OC9YL05TRE52aUozd3p6Y04zT3RiTjJkck1FeldVTW9ZQ3RYUitDYWs3?=
 =?utf-8?B?U1F1UUxnY3o1Wi8yQ3M4NHhTcThoeXhnWU1FS2I4d1pESW1rUWlQNWR1TTBL?=
 =?utf-8?B?bDUzV3RrZHMyVWw2WlBtRitpZHVQQzk0d1B4NFhrYTRUMkRCckx2c0NxNEcy?=
 =?utf-8?B?SHU2dkpCdC9DNjBDdGFmU1BaWXFEdlBzWDFHbG9zb1ZvclRQelhxVDltaEpj?=
 =?utf-8?B?anpCMjQvUGlIOTVXUFVGbkw2VmdzWUJzbVFVUWJBRjVjd0wvM3JHaVdSUmxZ?=
 =?utf-8?B?V012UnB6OGhVc3Z5N1R5TERweDRSRkRQMGF3NEhHUzc1MG5WRGNFNHVCaVZy?=
 =?utf-8?B?cWF4UEJqR3VySGxaSEx6MjFab0p1ZTJpYXh4RFcvWnQxamN0U3pBYU5SMnc2?=
 =?utf-8?B?N0dGV2NpdDBpQTA4TjByUnM3Ky8vdVhlelVDUGYvSGkwVHU2WjcwZU5qMDNp?=
 =?utf-8?B?Qk8zTTdTVHVJbEFrcDhKMmkrRFF3eWVmLzNYWnVIdnlFWlhhUzZGTVM2cGxr?=
 =?utf-8?B?RE1uaWtFSGpQVFUxY2RMVEYwVXV6OE5wY2R3ckIzbG5OMU1TMUZQUmpHLzFO?=
 =?utf-8?B?MFAvRm44aVRRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T084VXAxejdOUVJvL3JEeTl5OGxIaXV3ZXZMb0ZYQndFZ2RybG5sbjVndUFz?=
 =?utf-8?B?RGpuUU5TUWdmSkw2eDQyOW9sNCs5KzFTam1YZDE4RzVvV3d0Q1N4c1RjUmxk?=
 =?utf-8?B?UlBFR1A4c2xkVXVCdzUvSDh2OWpyRDFSNW42Y3dPVmpOR05OSFFtTWhDcW5s?=
 =?utf-8?B?T2k3QUFFVWFTSjZVQk52VlU5YmJUKzBoVG5Kb1Axb0wwdUtYR2h6SkpWL1F2?=
 =?utf-8?B?VDhIL01lSmZJYnN6YVNhTEx4cnRzV0ZHRVYrK2FENU95c1hsRHdVY0szbnQz?=
 =?utf-8?B?ZHA1cmR1QTU2UVBqT2U2QW5ub0lZWnp1a2hMSmFmWHcxeXF5MUhLcGJLYjdi?=
 =?utf-8?B?MEhxbzd2V1ZOTmQ0dFdScWxNQXh1cVFwT0hlbFhoQVRUMzhoQ1FOeUhQdmFX?=
 =?utf-8?B?UTFzeW9mU3pualhNWkI1S28raXd0M2k4ajc0b250RGpaQXV3cE5WNitwVDc3?=
 =?utf-8?B?ZEw4OWxYOVp6Rk1hR2Z2SmM4ZXd2T0hOUmMxd081N3dMOWhjdmJzUmFNblox?=
 =?utf-8?B?NmtDSytTdHBWcTh0L1lwQ3BTQ0JDbldzK3ROeUNuSTZ3T1BTY1dMam9EdEhw?=
 =?utf-8?B?UUdnWTVXMGZlbDhySmpPYjhTNCs5ekRNeUFiRUVqRlBzU0ZVZUR4b0tUSG56?=
 =?utf-8?B?akEzU3RrdzlQN29iSFQ2NHd4M2EvSDJQYzRSRy9QVU1wNEFrQS9lVVhUNVdN?=
 =?utf-8?B?enFMUnAxUWhkUi9PRHU3WGpHdFlrSWNoeCtFaXd1RWdyTmdORFNvMjJoblRS?=
 =?utf-8?B?WjIxUDRwN1o0NUlxalVyYXZiZnd3Q2NVS0VVbnp3ZVFRcnB1QWVxWm93Sm1q?=
 =?utf-8?B?aU15TGJtSklWS2lYTi80dEg4N1E0MC9UUEo1SjdmV0xDM05xcUhMSXNBeXhx?=
 =?utf-8?B?SVgrR09MTm5uK0ZGWHFSM0RkYzQwaDBGczM1ejRFM1B0ZTZiUUozbHZKRHhs?=
 =?utf-8?B?N0FiRlZQVFVVVjdDZzlzK2lGbmFqNjd6QzQzQVhIeFFVWHF6bFNWSVNlQ0ZR?=
 =?utf-8?B?UE1QNks3VG53dzE1WVRmbmorVTJmNkpHeS85bDdJeEJsOW9nd00rV3dLOTBJ?=
 =?utf-8?B?T0lRaXU4NTZLT21aS3U1N0FlZnVVczhJSVNPRTV2U1FPaGtJUDNhQzNDY0dk?=
 =?utf-8?B?ZjVBWllkczB6RzU4eGV4czIvNHhhUzBFb2U3bWdXdXJ3UXNvMEFubzFCL1dV?=
 =?utf-8?B?SmtHcnhtUGRqcU83VTRyVXB1c2VIakVCdWtwVGFleU9teWdvbXYxWjNxMy9o?=
 =?utf-8?B?Q0FHNjNSZzI4MXYvZVVRekg5elhBQWdmNER3bXd4RWhSZTRZb25Va0JvMXYy?=
 =?utf-8?B?YnhRTUtENkNXa2lhSERtMmI3TnN2ZnJheDh3enpxdERkNEY0dGpIY2tFL1RR?=
 =?utf-8?B?RXZGT2pFeUk0Y1lRamdjYkgvTnBSVzdhTEpqYTlqVFhDcG9haHQ1bVFrbi9X?=
 =?utf-8?B?UXU2NlFIcFE0Q2Q0WXFUbHVKRVRPZmtsZDdhaVRDL2tWaWd5dStTYUFKR00r?=
 =?utf-8?B?eFV3Qm5CVVliOTdodXcxMGR5QzM5U2pqSU93UHpRbWJPenBtbk9UNnphYnNU?=
 =?utf-8?B?SXJYeUtFaExrRE1ENEt5WEpDdVpYdUoxbkpJSGRzNEY5aUpySllOZDRzV1Ey?=
 =?utf-8?B?dFQzTkdwZzdZaGc1QlptWGx6aWRoVFZnT2tWVDZBRElabDIySlFTU252eldE?=
 =?utf-8?B?RmtuWEQ1aGNXODB3Y0dhbE9KYkVqWDgrQzlZT2dISzE1djBGcUQrSEJiS1Ew?=
 =?utf-8?B?SFd0dEJaWWRSNldHVmt5YU5scC9uSktYNDZnMmR1L21MRHNsUlFaOEhGSlB0?=
 =?utf-8?B?UzQrM2F6dXlHSmNwT29hQzVubUN2NHI3U1M1blpqNW1QOVNSTldtQTIza1Bu?=
 =?utf-8?B?aGtISW55Y0dxRklsaEpGYmRKcTlFUkxKTUlaQjNFbDNhSUlOeW1MOEM4Z0RH?=
 =?utf-8?B?aUtIYTl3MGlDa1ByKzBiQkFOQkIyQXlrL25vK2JveG8rQ00rVk5lS25sWmJO?=
 =?utf-8?B?ZGJFNlFianplcy8zeXRjaG11c0FIMTY1Y1V2d3RQdkFSRmxPN0JQODRyWlJK?=
 =?utf-8?B?RmR0L0dPSEh5NTZNT1MxYmpPY2UxRmtuZmRVNEpMQ2lUTUpPU3l0R1E0U0sv?=
 =?utf-8?Q?+npU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be33461-e1de-4cd7-6ca1-08ddcf1aa483
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 03:39:09.2263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvuxKZTTHW62UQtBvmVgk1gJrrck7zQXqrAmjymhhm1VAkDbuY2mLHAOkaNBtny5uYURg79C/YV8AVznB5XEvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBDYW4geW91IGluY2x1ZGUgdGhhdCBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24/DQpTdXJl
LiAgVGhpcyB3aWxsIGJlIHRoZSBmaW5hbCBjb21taXQgbWVzc2FnZS4NCg0KICAgIGRybS9hbWRn
cHU6IFJldGFpbiBqb2ItPnZtIGluIGFtZGdwdV9qb2JfcHJlcGFyZV9qb2INCg0KICAgIFRoZSBm
aWVsZCBqb2ItPnZtIGlzIHVzZWQgaW4gZnVuY3Rpb24gYW1kZ3B1X2pvYl9ydW4gdG8gZ2V0IHRo
ZSBwYWdlDQogICAgdGFibGUgcmUtZ2VuZXJhdGlvbiBjb3VudGVyIGFuZCBkZWNpZGUgd2hldGhl
ciB0aGUgam9iIHNob3VsZCBiZSBza2lwcGVkLg0KDQogICAgU3BlY2lmaWNhbGx5LCBmdW5jdGlv
biBhbWRncHVfdm1fZ2VuZXJhdGlvbiBjaGVja3MgaWYgdGhlIFZNIGlzIHZhbGlkIGZvciB0aGlz
IGpvYiB0byB1c2UuDQogICAgRm9yIGluc3RhbmNlLCBpZiBhIGdmeCBqb2IgZGVwZW5kcyBvbiBh
IGNhbmNlbGxlZCBzZG1hIGpvYiBmcm9tIGVudGl0eSB2bS0+ZGVsYXllZCwNCiAgICB0aGVuIHRo
ZSBnZnggam9iIHNob3VsZCBiZSBza2lwcGVkLg0KDQogICAgU2lnbmVkLW9mZi1ieTogWXVhblNo
YW5nIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+DQogICAgUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KVGhhbmtzDQpSaXZlcg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPg0KU2VudDogVHVlc2RheSwgSnVseSAyOSwgMjAyNSA5OjA4IFBNDQpUbzogWXVhblNoYW5n
IE1hbyAoUml2ZXIpIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+DQpDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBjYW8s
IGxpbiA8bGluLmNhb0BhbWQuY29tPjsgWmhhbmcsIFRpYW50aWFuIChDZWxpbmUpIDxUaWFudGlh
bi5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdToga2VlcCBq
b2ItPnZtIGluIGFtZGdwdV9qb2JfcHJlcGFyZV9qb2INCg0KT24gTW9uLCBKdWwgMjgsIDIwMjUg
YXQgMTA6NDHigK9QTSBZdWFuU2hhbmcgTWFvIChSaXZlcikgPFl1YW5TaGFuZy5NYW9AYW1kLmNv
bT4gd3JvdGU6DQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlz
dHJpYnV0aW9uIE9ubHldDQo+DQo+IEhpIEFsZXhhbmRlcg0KPg0KPiA+IEkgZGlkbid0IHRoaW5r
IHdlIGFjdHVhbGx5IHJlc3VibWl0dGluZyBqb2JzIGFueW1vcmUuICBIb3cgYXJlIHdlIGVuZGlu
ZyB1cCB0cnlpbmcgdG8gcmVzdWJtaXQgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPg0KPiBJdCBpcyBu
b3QgYWJvdXQgcmVzdWJtaXR0aW5nLiBhbWRncHVfdm1fZ2VuZXJhdGlvbiB3aWxsIGNoZWNrIGlm
IHRoZSBWTSBpcyB2YWxpZCBmb3IgdGhpcyBqb2IgdG8gdXNlLiBGb3IgZXhhbXBsZSwgaWYgYSBn
Znggam9iIGRlcGVuZHMgb24gYW4gc2RtYSBqb2IsIHdoaWNoIGlzIGFscmVhZHkgY2FuY2VsbGVk
LCB0aGVuIHRoZSBnZnggam9iIHNob3VsZCBiZSBza2lwcGVkLg0KDQpBaCwgdGhhdCBtYWtlcyBz
ZW5zZS4gIENhbiB5b3UgaW5jbHVkZSB0aGF0IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbj8NCldp
dGggdGhhdCBpbmNsdWRlZCwgdGhlIHBhdGNoIGlzDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IFBlcmhhcHMgdGhlIGRlcGVuZGVuY2ll
cyBiZXR3ZWVuIHRhc2tzIHNob3VsZCBiZSByZXNvbHZlZCBieSB0aGUgZHJtIGluc3RlYWQgb2Yg
YW1kZ3B1Lg0KDQpJZiB3ZSBjYW4gZG8gdGhhdCBvciBjaGVjayB0aGUgZGVwZW5kZW5jaWVzIHZp
YSB0aGUgam9iIGl0c2VsZiB0aGF0IHdvdWxkIGJlIGJldHRlciBpbiB0aGUgbG9uZyB0ZXJtLg0K
DQpBbGV4DQoNCj4NCj4gdWludDY0X3QgYW1kZ3B1X3ZtX2dlbmVyYXRpb24oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdA0KPiBhbWRncHVfdm0gKnZtKSB7DQo+ICAgICAgICAgdWlu
dDY0X3QgcmVzdWx0ID0gKHU2NClhdG9taWNfcmVhZCgmYWRldi0+dnJhbV9sb3N0X2NvdW50ZXIp
DQo+IDw8IDMyOw0KPg0KPiAgICAgICAgIGlmICghdm0pDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gcmVzdWx0Ow0KPg0KPiAgICAgICAgIHJlc3VsdCArPSBsb3dlcl8zMl9iaXRzKHZtLT5nZW5l
cmF0aW9uKTsNCj4gICAgICAgICAvKiBBZGQgb25lIGlmIHRoZSBwYWdlIHRhYmxlcyB3aWxsIGJl
IHJlLWdlbmVyYXRlZCBvbiBuZXh0IENTICovDQo+ICAgICAgICAgaWYgKGRybV9zY2hlZF9lbnRp
dHlfZXJyb3IoJnZtLT5kZWxheWVkKSkNCj4gICAgICAgICAgICAgICAgICsrcmVzdWx0Ow0KPg0K
PiAgICAgICAgIHJldHVybiByZXN1bHQ7DQo+IH0NCj4NCj4gVGhhbmtzDQo+IFJpdmVyDQo+DQo+
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDI5LCAyMDI1IDI6MTAg
QU0NCj4gVG86IFl1YW5TaGFuZyBNYW8gKFJpdmVyKSA8WXVhblNoYW5nLk1hb0BhbWQuY29tPg0K
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBjYW8sIGxpbg0KPiA8bGluLmNhb0BhbWQuY29tPjsgWmhhbmcs
IFRpYW50aWFuIChDZWxpbmUpIDxUaWFudGlhbi5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBrZWVwIGpvYi0+dm0gaW4NCj4gYW1kZ3B1X2pvYl9wcmVw
YXJlX2pvYg0KPg0KPiBPbiBNb24sIEp1bCAyOCwgMjAyNSBhdCA1OjAx4oCvQU0gWXVhblNoYW5n
IE1hbyAoUml2ZXIpIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gW0FN
RCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4g
Pg0KPiA+IEhpIEFsZXhhbmRlcg0KPiA+DQo+ID4gICAgICAgICBTaW5jZSBDaHJpc3RpYW4gaXMg
b24gdmFjYXRpb24uIENvdWxkIHlvdSBoZWxwIHJldmlldyB0aGUgYmVsb3cgcGF0Y2g/DQo+ID4g
ICAgICAgICBJZiBzZXQgam9iLT52bSB0byBudWxsIGluIGFtZGdwdV9qb2JfcHJlcGFyZV9qb2Is
IHRoZSBqb2Igd2hpY2ggc2hvdWxkIGJlIHNraXBwZWQgaW4gYW1kZ3B1X2pvYl9ydW4gd2lsbCBi
ZSBzdWJtaXR0ZWQgdW5leHBlY3RlZGx5Lg0KPg0KPiBJIHRoaW5rIHdlIGNhbiBqdXN0IHJlbW92
ZSB0aGUgYW1kZ3B1X3ZtX2dlbmVyYXRpb24oKSBjaGVjayBpbiBhbWRncHVfam9iX3J1bigpLiAg
SSBkaWRuJ3QgdGhpbmsgd2UgYWN0dWFsbHkgcmVzdWJtaXR0aW5nIGpvYnMgYW55bW9yZS4gIEhv
dyBhcmUgd2UgZW5kaW5nIHVwIHRyeWluZyB0byByZXN1Ym1pdCBpbiB0aGUgZmlyc3QgcGxhY2U/
DQo+DQo+IEFsZXgNCj4NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFJpdmVyDQo+ID4NCj4gPg0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogWXVhblNoYW5nIE1hbyAoUml2
ZXIpIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIz
LCAyMDI1IDU6MDYgUE0NCj4gPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
PiBDYzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFl1YW5T
aGFuZyBNYW8NCj4gPiAoUml2ZXIpIDxZdWFuU2hhbmcuTWFvQGFtZC5jb20+DQo+ID4gU3ViamVj
dDogW1BBVENIXSBkcm0vYW1kZ3B1OiBrZWVwIGpvYi0+dm0gaW4gYW1kZ3B1X2pvYl9wcmVwYXJl
X2pvYg0KPiA+DQo+ID4gam9iLT52bSBpcyB1c2VkIGluIGZ1bmN0aW9uIGFtZGdwdV9qb2JfcnVu
IHRvIGdldCB0aGUgcGFnZQ0KPiA+IHRhYmxlIHJlLWdlbmVyYXRpb24gY291bnRlciBhbmQgZGVj
aWRlIHdoZXRoZXIgdGhlIGpvYiBzaG91bGQgYmUgc2tpcHBlZC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFl1YW5TaGFuZyA8WXVhblNoYW5nLk1hb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgfCA3IC0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBpbmRleCA0NWZlYmRjMmYzNDkuLjE4OTk4
MzQzODE1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9i
LmMNCj4gPiBAQCAtMzYwLDEzICszNjAsNiBAQCBhbWRncHVfam9iX3ByZXBhcmVfam9iKHN0cnVj
dCBkcm1fc2NoZWRfam9iICpzY2hlZF9qb2IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihyaW5nLT5hZGV2LT5kZXYsICJFcnJvciBnZXR0aW5nIFZNIElEICglZClcbiIsIHIp
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gICAgICAgICAg
ICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgICAgLyoNCj4gPiAtICAgICAgICAgICAgICAgICog
VGhlIFZNIHN0cnVjdHVyZSBtaWdodCBiZSByZWxlYXNlZCBhZnRlciB0aGUgVk1JRCBpcw0KPiA+
IC0gICAgICAgICAgICAgICAgKiBhc3NpZ25lZCwgd2UgaGFkIG11bHRpcGxlIHByb2JsZW1zIHdp
dGggcGVvcGxlIHRyeWluZyB0byB1c2UNCj4gPiAtICAgICAgICAgICAgICAgICogdGhlIFZNIHBv
aW50ZXIgc28gYmV0dGVyIHNldCBpdCB0byBOVUxMLg0KPiA+IC0gICAgICAgICAgICAgICAgKi8N
Cj4gPiAtICAgICAgICAgICAgICAgaWYgKCFmZW5jZSkNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBqb2ItPnZtID0gTlVMTDsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZlbmNlOw0K
PiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
