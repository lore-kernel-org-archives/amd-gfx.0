Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B8C282C6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 01:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B7B10E193;
	Tue,  4 Mar 2025 01:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1f+14nrU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D3810E193
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 01:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7Vlep96IWl5gog2rV4rdgQ2kMeTeijGjFBvrYTmUR0FYtCVmYP1Cr97J/9tRBiTl3ceL6G+3sro+Hhs3/xO2aqozw5E7taTdSz+X3oIJ5Xrb07da27PcgehXO0p9lnJLDJl5/2V8e3wsXCOFwfA6flk0djirfBajcvQo+JKN1KnwJqDY8/40eYWp6ViUH3QfT4vFNC73J2WomOScyTyAUJ+XRChq3FNTHGcNwfRN+64hHgxpRlE/RlIXu5/FoGO5cEJoNqOzoEprcveoiy1JdOSHQK9JKJ2noAR2dDCmmztCgw0V5+/qdnvAtkIvKO2MHrSc3wsO/gAgxcTNanElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGp0CDP4VQKz2SG1pa3Xnl9rXWFQr2TytJ0zXAQC1KY=;
 b=NwBr/uLkytWob/CXXO8NjDXpyj31nnud2Bg6JFCgXgXzE1r5YI5boFZswDLrkHUeCh6lWOtG+ouMXZmbV/LBjSHD3jFmwFI7PDVxV2ZrPabWZyVoxfYFs/B8AnfexfEzcBT0D/l32v7AToP0kWuGPCtgbHHCPnNmCsa1VmNMe6eziCP/Wlvm0Ql5r0xSkQzXFWPT/Gg1Hpt0sI1SWtUPEtECIMh97GMOuty02gC0iXXaL2K7mjY139XhnjjDhpN5HpHZOpaQADQ1qoVkzFhDOoZU2E3zTu5a4JWUy/A0QoPwAulxe9UnSkyBgEin/+dWfzjiT++UHubBD5TmbgeneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGp0CDP4VQKz2SG1pa3Xnl9rXWFQr2TytJ0zXAQC1KY=;
 b=1f+14nrUZQDWdcNNpjV6QtdU+TPhFwgEqU97NoVQmmQPNR4lAi4Tl1hSS6/C9P+sfqINHsVojylMSYP2uInR/MHdLktq3SXxUDzGf8+pv/pDemi0sl0rF1Ylc5436WmKL0NgGH5RYSBKY4xmBYmGjPux9YPwzrzUnNJfaXVhRPQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Tue, 4 Mar 2025 01:40:39 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:40:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
Thread-Topic: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
Thread-Index: AQHbihqaKLNfKHbIfEeZOLQ5gvKEArNhT7uQgABKyoCAAJ1C4A==
Date: Tue, 4 Mar 2025 01:40:39 +0000
Message-ID: <DS7PR12MB60056F0EB24F281B4BF8F7A3FBC82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
 <20250228195411.2530147-5-alexander.deucher@amd.com>
 <DS7PR12MB6005AF0B4E9BC29C3D9E9E9BFBC92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_MMQxNt11vQrL3UwbyUKeM-UAFDPb0+z=Aat6nMnR+H9w@mail.gmail.com>
In-Reply-To: <CADnq5_MMQxNt11vQrL3UwbyUKeM-UAFDPb0+z=Aat6nMnR+H9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c9213dca-977c-4590-af97-c4c82693917f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-04T01:37:50Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB8440:EE_
x-ms-office365-filtering-correlation-id: a06a5bec-2066-4503-150a-08dd5abd91a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXY3MDVRbHRaRXRnS3lERGV1OXN1N2llWnJFbjN4aWxiNFNLb25HN0Z1OG9X?=
 =?utf-8?B?TUp1bkM5RHZxRTJSd3crVkdySzUxVWZXVUx0OStKK1hXVk5OeGJVMkhmMWZs?=
 =?utf-8?B?aWNwV2laK3lZc1g0SWhMMUxBRmM4bGdjZUdPYkluU1BmU1JScFpsMEYwWDBj?=
 =?utf-8?B?Y2JNZjZXK1RtTzQ1YzR0ZURvaDhybTVRLy85TjFMb2kzU3JzVjdoWEFkL2tX?=
 =?utf-8?B?aTJVK0gvRmRSU2pMaGJuM2JGanM1TTI3VkFFLzFZRUhwSzZEYmVPbFQwcHY5?=
 =?utf-8?B?UlNDVnp1dkp1VnZJendURndBZG0wNHkrTUV6dC9UNjBkK1VoZFNoRU9Hc0Y0?=
 =?utf-8?B?T2NOZUtBRzR2cldIMHJOeitSTUdSTGN1UHRwL1Q1NHVGeFBsL0YxTUw3NkJ1?=
 =?utf-8?B?SlVlRjFPSndEaXJaSXFNYzZHTWhEWVVyVU1ER3pnL0kzTC8zV3gwMjlMeUpY?=
 =?utf-8?B?NWl2S2thRzJPamJ0cDJSM2s2MGc1alB6K2J1Qk96Q3ZvcFVMcmoralZxM3gx?=
 =?utf-8?B?Z0ErUjlIRGtUbW15SXhtWVJ5bnJXZHpON003YXFseVo3UWpjSSt5NGlzbVVE?=
 =?utf-8?B?WDYzVEo1dlJhNkQ3eHlmbU9NQUxpby9QMVJKZjdOMUc1VzZVNG8vUUdZMG80?=
 =?utf-8?B?YlNLQklJalFZNnpEWEVjdU5CdTFVUDAyNkZRTjFNclBSY242Y3p3QVNHRGV6?=
 =?utf-8?B?WXVBQkV6OXFadjJZSnE3SHhibGhoQVhLSmhkbVh3Y0R2VytZcWtKRmxGQ1E0?=
 =?utf-8?B?MjRzUlJKUnNPV1JFbVhMbU1pWFVVenVpNmFCYmJhbHZ2MVR2NGwrTnhEWWlO?=
 =?utf-8?B?YnRCdk4ybjF1bFo3SlhTbmY2L3hhV2ZhdFFTNUpCWVM3TjM3SHZXbVN3S3BI?=
 =?utf-8?B?R1gzbmFuTUNzSXpuNEVXRjJ0TUNUUkNrSFhMMUE5Snd2VUE1ckFlUlpwdHc0?=
 =?utf-8?B?MFR6MWxBaXN0cEFZK081Qkc2OERaUzI2TVc5eFhtYVM4WU52WlAwcGtwZ1Mr?=
 =?utf-8?B?c1p4VDM0anY3WWFsNk5JZmtrWDRiZXljMXExMGtiUHBlMUVtUW83S0FrV0Zt?=
 =?utf-8?B?K0d6dm54eSthOE9zVVJvQkhjT2E2V2hqK2x5RUtFYmFqTWtWOWo4NVV3c0RW?=
 =?utf-8?B?aGZyNTR1OEo0WS84U2RFR1NNRlhMWkxSYWFQbE9HRVRLMU1EUUZ4RkhXN2NN?=
 =?utf-8?B?Smw0RVZIaEhXTXVlTEdKQUxzNmJLYWlBUHo2U1dsMlpxRkJ1RHR6Wm40Ty92?=
 =?utf-8?B?SGZUNGFGZXVzQlhvcm9nWG1iK3piR1ZQdkdLU3V5akluV3NXTW1rTHVJam9I?=
 =?utf-8?B?U0xDSmlVZEZhaE9oWWlwcHVoQ2ExWk0wc1NmdzFVYy9pZnZJeDJrQWtoOW90?=
 =?utf-8?B?Y1h5UVk4ME1oTUlzbmZWbm40RTVDeFQ4MVlFSFlUVU1Mbk9DWHhpcnhtUFhX?=
 =?utf-8?B?VzNLb2E0M0V1dkJwbnRuV2R1dG1HRXFWNG1hbXdZbGlSMDZUYm90bkNJMkRM?=
 =?utf-8?B?R1lMUURHeE1jcGp6dlliMis2c1l3S0ZrSEhQMmVDR0RTSHpHUkhGYTluMUto?=
 =?utf-8?B?bGJKK3JKRDZPZzVqTzBwNFhuNFFqckZrVXJXbFJpNmczVzIyWGNHRUdMcVRX?=
 =?utf-8?B?Rk55UjVqUFR3TTdKSzVxbGNsdFVaOTdQcE0rNElnaG54aFpxZVJrSmE2UGxL?=
 =?utf-8?B?SkZJK2JJbEJkVmtMZzNENkwxOXhRcWJ4U1dLdm1yU1dwYlcrZys3MWR1bmtq?=
 =?utf-8?B?S0tJdkF4aWpnQXcvZVVOVjhxUXYyTk1OSDZSOUxmWTRSUEdhZURndjMxQk1V?=
 =?utf-8?B?SXhkWXpkakJUVHMvaVZaT2FqY054TnI4S3JKWVdzaCtmU01KaVpxS3Z1VEtM?=
 =?utf-8?B?dmpDem1tN01DYmhzOVBqN0pGbE1zL2sxSVJMcXVrbnZOZ0pDajQxZ1d5ZjFk?=
 =?utf-8?Q?wSEcCmjyG3vrJsQuo2bFGnsKKcuwifaf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di91eW05R2JkTEdQR25meVlBZ20rSHRKRDVSUkczTGN6WUhabGR1SGRTaHNy?=
 =?utf-8?B?UDFZWUQreFl1L0tYWWJxcEFBNUpPNWY5VFRIZW5pdWZzOERyZHZWRFpyQ0Z5?=
 =?utf-8?B?WGFCTkllSUEzYkZLVlc4c0R6bDd0WFFZMnMzUHA0WHdGSnkyU0ZaVDNQZTJZ?=
 =?utf-8?B?S295Y3NqdERhR2luQnlzNzhOK1RBcnArcUVHOUs2V0Nyb0pjbjc1MVVXM2pz?=
 =?utf-8?B?VUF3SlJYRzJjQzJmQU95eGZETzBmdTFQQ0dIRTN4Y0tIcTczbU9LRUFnSi9k?=
 =?utf-8?B?ZEMyOVhSODJhYk9BUnYrVkZqcVNRL1BNdUhia0ppeVp6eVg3SzRVT09IcDc2?=
 =?utf-8?B?T1F3bVZKSTd0WjhBUGw2SlZIK0pNS2l3UFpESUVxSk1vK2dweUY0MEtGYUtm?=
 =?utf-8?B?YWQ0ako3RG0zOHQ5VG1QaGJOTUx2MEFvS0dQVDJUNWo5b3UwV1Y4aW5GbnZ5?=
 =?utf-8?B?b0ZCUHpKQ0czVU1ZbzZlNDQwZzhpMmJscHpnc3RLalpwMFVNY1FKeFhFOHlR?=
 =?utf-8?B?RkQxZE1zV2E4cmhZeXYwSVB1M2hqNjBCbkx5NGc5Y3dGT2JkV1Qzc2RPWmt5?=
 =?utf-8?B?WFNrVUFCNWY1dk9FRnFvMmFOU1pBTlpMSzljS0VrNmh6NTIrOUR1eVdDZVR0?=
 =?utf-8?B?Nm5KWGV4ZXlMRUVoNHRSaCtDWTZJdU5FZHd6WTVXcko5RTZaOEhuZjZmeWtL?=
 =?utf-8?B?MzNPSmkzcGUxWE0rVEc1ZUhzSmxZeUM1QldLSzYvRGk2S09LN0ZZNDJsWjIy?=
 =?utf-8?B?NzhnWnpTdzAzR01zeko3VnJsSXcwbkhXalhHdm5yQlFyUURlRWVLVnczZHA5?=
 =?utf-8?B?c2pjWDBLNkdrOU9wT2VjaW94LzBTanNCMy95ZHFPRWZiSmVEVENRSXNyMlQz?=
 =?utf-8?B?eWMrenRteURyeitiQmNHY01wZ2V4WTJVT1lRQXdpVUZYcFIzS3d3MGZ5OCtw?=
 =?utf-8?B?Umw0bWZhSmxNNGprbHJ5cUlkMEZ6ZmNLdzF4NllNMW9XbkpmRTZDZUdwV0lk?=
 =?utf-8?B?UjZXYUtWSlM4L2c4WjdWTjFQenFiZ0MvOTRMTWxvTjdsQkxDK3ppVUprUDZO?=
 =?utf-8?B?bTAyaGZkc3hKYngzSmx3Wmc4ZGQxTWorTlFKUnZ6Tk9MT3hxbHFhQWU3QzRJ?=
 =?utf-8?B?dng4YUg4VjFjWWUyQkZVRnJ1VFcvdGN5NDMxbVZtQ2VFcEZvdjBoeFU1cmQ0?=
 =?utf-8?B?MWo1a2puMm1oKys3ZnNlOWtDa1ZRby9XYjJNbkVmOFhUa0c3V0JrNWMrWGJO?=
 =?utf-8?B?L2g2NVF0ZDhXYk1hK0VYYVNNNU1yS3pJVzNWdnp3V05UaS92aWdORTlYMnVC?=
 =?utf-8?B?cWZ2dlNDMDd0YUQ5YzhwS1Y2WGwxSmFYTVZSRjNjZmZ0Zlg0WUZYNUI4RWZ3?=
 =?utf-8?B?dnYxVmgzWWFwS0t4alNxa2lWTmxLMmlROVJUa0dpSkRLSTFlSk14dXp6Z1RL?=
 =?utf-8?B?dFlQT0pDUzNVVk5IN09jNmVkeEZZZ0pxelEzTmEvQnBRS1V5Y1p0ZU9ydzY0?=
 =?utf-8?B?UVJNbEJYQWJkeHRSbzlWVGU1RjYrRG5kcmt0d1MxSjFwNGlxT2JuVWswV3pP?=
 =?utf-8?B?R2ZFcUF4Q2QwS3pwZ3FINmF6eFNSUnhWNlZ0bWpySlZDU2RjUzFaL0QvQndW?=
 =?utf-8?B?eFpWU3JNdHdDMWtiVGtpUnd4YXZUVVJTSmQ0MFJKclZFSjFXVXJ1QzNDdlVp?=
 =?utf-8?B?dzhjaGFuRlZxOWg3R0pyOEtHVld5OU94N0FjUTBYNFBzUG9JWklnNjQ0dVJS?=
 =?utf-8?B?MEFTbUVjQ0F3Y0xVYTdNR3JtQkIwYWtxN2MvY0lGbzZyT3R5dmZNSFFpOXBy?=
 =?utf-8?B?RjFkNjNRS3N0WnJXenUxL0NaSzAxLzVkRGUyVWVHTE9qaXpGRis3YmtBNGxQ?=
 =?utf-8?B?SU1iZFQ4TnFudFJQUzFLUzFiV1BNSmlJWjJjWHl3b2lhbEN0dmYxVGIyNTY4?=
 =?utf-8?B?djBvUlZhMnZLR2NNVlFIRmt5bytwTSsvSWJjcHprY0xlT2d6TTJEY0dWb0Fj?=
 =?utf-8?B?TUU2MXJ6Q0NNTmxpV25lRkhUYTNsVWpnczRReVN1UVFNR1NnTjZibGRmN3pP?=
 =?utf-8?B?K0pNdmtXeHFLOEo0VERreUhCaVRpbGljOW9WSy8rN2JlQ1VJM2RUbDJhc1FB?=
 =?utf-8?Q?ImJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06a5bec-2066-4503-150a-08dd5abd91a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:40:39.5478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHwWEnO1Lbxm9NIMdLxBNV2OTT1jksnyOJVQJf8A6zEinO3K2+xfw9Guk6ZklDyL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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

W1B1YmxpY10NCg0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBEZXVjaGVyDQo+IFNlbnQ6IFR1ZXNkYXks
IE1hcmNoIDQsIDIwMjUgMTI6MTUgQU0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdA
YW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDUvNV0gZHJtL2FtZGdwdS91c2VycTogcmVtb3ZlIEJST0tFTiBmcm9tIGNvbmZpZw0K
Pg0KPiBPbiBNb24sIE1hciAzLCAyMDI1IGF0IDc6MDnigK9BTSBMaWFuZywgUHJpa2UgPFByaWtl
LkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IFF1ZXN0
aW9uOiBXaHkgdXNlIHRoZSBDT05GSUdfRFJNX0FNREdQVV9OQVZJM1hfVVNFUlEgdG8gZ3VhcmQg
YWxsDQo+IHRoZSB2YXJpb3VzIEdGWCB1c2VyIG1vZGUgcXVldWUgZW5hYmxlbWVudCBwYXRocz8g
SXQgc2VlbXMgbW9yZSBnZW5lcmljIGFuZA0KPiByZWFzb25hYmxlIHRvIHVzZSB0aGUgY29uZmln
IG5hbWUgQ09ORklHX0RSTV9BTURHUFVfTkFWSTNYX1VTRVJRLg0KPiA+DQo+DQo+IEkgYXNzdW1l
IHlvdSBtZWFuIHNvbWV0aGluZyBtb3JlIGdlbmVyaWMgbGlrZQ0KPiBDT05GSUdfRFJNX0FNREdQ
VV9VU0VSUT8NCj4gIEF0IHRoaXMgcG9pbnQgaXQgd291bGQgbWFrZSBtb3JlIHNlbnNlLCBidXQg
YXQgdGhlIHRpbWUgaXQgd2FzIGFkZGVkIHRoZXJlIHdhcw0KPiBvbmx5IGdmeDExIHN1cHBvcnQu
ICBXZSBjb3VsZCBjaGFuZ2UgaXQsIGJ1dCBhdCB0aGlzIHBvaW50LCBJJ2QgYmUgbW9yZSBpbmNs
aW5lZCB0bw0KPiBqdXN0IHJlbW92ZSBpdC4NCj4NClllcywgaXQncyBhIHR5cG8sIGFuZCBJIG1l
YW4gd2UgbWF5IG5lZWQgdG8gY2hhbmdlIHRoZSB1c2VycSBjb25maWcgbGFiZWwgdG8gQ09ORklH
X0RSTV9BTURHUFVfVVNFUlEgbGF0ZXIuDQoNClRoYW5rcywNClByaWtlDQoNCj4gPiBFeGNlcHQg
Zm9yIHRoYXQgcXVlc3Rpb24sIHRoZSBzZXJpZXMgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IFByaWtl
IExpYW5nDQo+IDxQcmlrZS5MaWFuZ0BhbWQuY29tPiAuDQo+DQo+IFRoYW5rcy4NCj4NCj4gQWxl
eA0KPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+ID4gPiBBbGV4IERldWNo
ZXINCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxLCAyMDI1IDM6NTQgQU0NCj4gPiA+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCA1
LzVdIGRybS9hbWRncHUvdXNlcnE6IHJlbW92ZSBCUk9LRU4gZnJvbSBjb25maWcNCj4gPiA+DQo+
ID4gPiBUaGlzIGNhbiBiZSBlbmFibGVkIG5vdy4gIFdlIGhhdmUgdGhlIGZpcm13YXJlIGNoZWNr
cyBpbiBwbGFjZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9LY29uZmlnIHwgMSAtDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvS2NvbmZpZw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9LY29uZmln
DQo+ID4gPiBpbmRleCBhNjE0MzIwMTE0Nzk2Li4yM2MwMTRkYTBmMzI0IDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvS2NvbmZpZw0KPiA+ID4gQEAgLTk4LDcgKzk4LDYgQEAg
Y29uZmlnIERSTV9BTURHUFVfV0VSUk9SICBjb25maWcNCj4gPiA+IERSTV9BTURHUFVfTkFWSTNY
X1VTRVJRDQo+ID4gPiAgICAgICBib29sICJFbmFibGUgYW1kZ3B1IHVzZXJtb2RlIHF1ZXVlcyIN
Cj4gPiA+ICAgICAgIGRlcGVuZHMgb24gRFJNX0FNREdQVQ0KPiA+ID4gLSAgICAgZGVwZW5kcyBv
biBCUk9LRU4NCj4gPiA+ICAgICAgIGRlZmF1bHQgbg0KPiA+ID4gICAgICAgaGVscA0KPiA+ID4g
ICAgICAgICBDaG9vc2UgdGhpcyBvcHRpb24gdG8gZW5hYmxlIEdGWCB1c2VybW9kZSBxdWV1ZSBz
dXBwb3J0IGZvcg0KPiA+ID4gR0ZYL1NETUEvQ29tcHV0ZQ0KPiA+ID4gLS0NCj4gPiA+IDIuNDgu
MQ0KPiA+DQo=
