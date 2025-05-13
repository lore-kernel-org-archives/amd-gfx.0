Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEEBC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 12:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763EE10E593;
	Tue, 13 May 2025 12:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="daQ5rqyU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D02810E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 12:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKmj0oUXiXRUnZL/1v6ZL1Ga8aQ7y6yJ9M3QZ9xhS7Q2wOHRSkBEHUWBWvRInJk20ly/DPIuNb4ZVfiW35uyA65iVpjGwRojjnFv5ovgIz0mxSEk0O5roNbajY8w9gx8UbJiSLMpRhikbGWxmtgoltq4ZpIxAUrmWGgbSuqXIKvCkSoe+ONOW+0HzTplbaSQ7gQZQALRRgj7egd0ItaIz+44+JQRSYvVT/UJOljhdA6Xo7PRyZaaBSTqkIKkDcAfET9WIlnyVVmptfaFxIrSNTufGFwu6nrg8z83MQ1RHhOsqgeqYc0HOo6dm4nvxQRM+/UGILr47epWmZnQGoJ/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+9CWoNmqo9hn0Bg+l2AIGuW0xUIsZNpXXboP5JrSMk=;
 b=GvvdmTy+vGPhLhkJTe8cBvxMM6gXkC27YGzikCpZ+lVYmYqutnHzePuIoqikFdkUJzae/boZhgftImRSaBxnE2B/CmiKRuNDGnYaa9fgsWspMkEVAKaeBag+cmaBtpANk4jlMdmNHdiNQcU7ZE3N6xvUBErwp401abdq5e/JvJE3DTTeyrNQqx9N+OTVFhRouArHMrGieOgpP9OQTuvjPFWmCCYhZqXJAEYJqw/SrGrMMJpX9Rqhgg8lHtGMc5RNKoLGlS3s8jjF2YpIvuFh6mpbe8geauW7qCk2sUWAgO19Vrl7kkC2hSR/2zoY5JdAxelGhVrjcXnFagMuFbAaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+9CWoNmqo9hn0Bg+l2AIGuW0xUIsZNpXXboP5JrSMk=;
 b=daQ5rqyU6us9YL+rOqHiyjxoE1AAvYUNdCMByl3OdUIJ+OvlAbC1Hkgk/P3UQ5MDzWQtJDXlhUVgBJVM4O6gKizFAMeB4HP9wSzVB5CfQPhwIKcDnvzvjf8PLca+Y2kIYzMht8T3b9WAaouSrsZuBuw4YeX1KUO0vZFEYqN8M5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 12:26:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:26:14 +0000
Message-ID: <102c9e7a-9d78-4802-b5ee-222bce86c48e@amd.com>
Date: Tue, 13 May 2025 17:56:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add debugfs for spirom IFWI dump
To: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking.Zhang@amd.com,
 Likun.Gao@amd.com, amd-gfx@lists.freedesktop.org
References: <20250513091348.57701-1-shiwu.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250513091348.57701-1-shiwu.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: ac51fe4e-306e-49ca-16e7-08dd921959f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUl4bjlXc3BKVnVJZDduZjM3RHlwNDlIb1JsR2p3TnUwRUUzRHR2eUpqdVpU?=
 =?utf-8?B?VkR5MW9GSkRkSE5lTXZ1dVZkYktxSGVlNXlHUFY3ekdtTG5QbHlxaWZGRlJJ?=
 =?utf-8?B?dWpiVDNSVFFxaTlBaHB2dldSdkJKY0sydGNZVTdqU3c4Z1dEc05Rb0x1bVI5?=
 =?utf-8?B?NGpwVGEvVEF4VDRhUm1jZTkyekFNb0gzd0dxWkY4a1ZMQ2d6NjR3b2RsbnRq?=
 =?utf-8?B?UmxITGQxMTh5ZDVvaWlwbFNlQVVYaEdSOGlmcmp2RTRIVTUvcWtHNndHSms4?=
 =?utf-8?B?SXdyUWQ4cGhnekFXMmozS3IvbzhxcDVNU0pCdVgvVjNDRy9BbkIxTWJCczho?=
 =?utf-8?B?Y3dTMVNZOWRkS0VJbGt0UnI1c1F4YmtBTUwwYldsWmNhWW81USs5SjRTeHhH?=
 =?utf-8?B?THJhdGFqamo3MG5vaHlkVWo0UHRwUVlvYUc4eWVsbzBhMk5lUkp3UEtRMHlY?=
 =?utf-8?B?cHorVnZ0RFlNUTBhVFZOMnl2Y0NBM2FNamx2V0IzOXRrTUZ0VmZZTmlnZE5i?=
 =?utf-8?B?RFBGU0J0OFVXL01jbWdCTS85ZjFoeUdpNXhTbElXSWhpR3dlc2krSXdCWGlI?=
 =?utf-8?B?eWtmc3Y5c0Nid213WW13VjBlM2czNnlOUzRFc1N4Y0ZBc3UzMTlZdFU2akUw?=
 =?utf-8?B?bEFvZmdvU0ZyVGQ5YlFZV2NUK3lzSHFJRkxtZFU4aURnV1JES0Q2ekJQOUhy?=
 =?utf-8?B?VnhJUWtBWUR1RnNneklCcXRQcloya3J0bFRUYUJoMFZ5UzNnbHE2RVpVMlZ4?=
 =?utf-8?B?eEE5YUlUQTMxcitwem90WTY3cWd2eS9VSVBmOFE0WDhsVEFpcFVsMnBUVGFG?=
 =?utf-8?B?MDZ3WFdzamZPdkQ1aFppaktXTTVnNXA2dnpPZ1R5YWc5dzRxcisvWjQ3SFNI?=
 =?utf-8?B?Mk1sWHUvd3NZdVhLY3JMc1lpTUVqZWJpdmZsSUhCQmFiYXlMQ1BPc2Z5NEVa?=
 =?utf-8?B?WWtaSzBOdWNvWkEwMjRnc2dpOWhnaFEyU3V5RmNBa0JwclJBbUlCZnRWYWFs?=
 =?utf-8?B?RXdIZU01eHRjTGlac3FLbDRHZWExaGo4U0l6WUU4N1pHMWpmTm1rdTVxR2d0?=
 =?utf-8?B?RkYrYWovU25Ycjg3eUVTS0hJM0NrWjY5VXpPS0JQbWpacWR4azlhZVJicVpZ?=
 =?utf-8?B?WENCN0xDVVcvYlpiVlN0QndQUGFrNTUwZTZaZXdubFhqdXRyOEl3eDA0S2oz?=
 =?utf-8?B?OVhFS3V2RG5na3BNN29yRDNPZnhTY0NCMFI3YjROdzNiQnNscUV0anYrQkpi?=
 =?utf-8?B?M3dFWkFKdk5uNVhEaXFGaUFaTmU1d3J3bE10UGViNDVZOFNNbDdzR2VHYWNE?=
 =?utf-8?B?N2RtQWc2dmpBbWlRNWRPMUhmZS9lNlNzeGt0dGxsYjl4dHgzZlNFMUMrUkFG?=
 =?utf-8?B?WEl0dWdmMWhjY0dSNkYyaG1Tb2JtK2pxYi9BQ1VUQUYyaGtpN1NwaEpCZWIz?=
 =?utf-8?B?R1VQdGFKV25KN1FtcHdzZDBjUnpHRkFXVkJvZkFNYXVIZE9IWDlKd2o0M2Ix?=
 =?utf-8?B?NnRBY0hPZmdIbkQvV1NGaWlHS0dYQ1cyVkFvMHI2eHhlMk1pTU5lT1ZGNk5v?=
 =?utf-8?B?OThlNDQyaUp5SmZ4czNjYy9DNkwramYzcDcwV2EvQkJGVGY0VDRYVUMxQVpC?=
 =?utf-8?B?YVF1RS8zcW5FM3U2alg2dGI5MjZrL01ob01xa3N0QlBqMm9iM2laQmJIUGJx?=
 =?utf-8?B?UmsrY1ZSRUk2ZmJjaUQvNHMwTjZWMExoRm5pUjJLaU0yanlJblhjQi9XQmZq?=
 =?utf-8?B?NjdPS3ZVSFNJSWM0a3ZPZUpsUE5RZXhkQk51MXRMdkxPV1dFbnVjdjFSdklY?=
 =?utf-8?B?THNycFlGbDdFT3g5YnIwSTMwcjI3MFRQMStmQ0hLVUxYYkFtUUc1cDRHV1BC?=
 =?utf-8?B?d1IvTS9SbzJDTzNvM0g0VU9ncnJJUDEyTHJ0M0xyTDJOQ0FkbmtETjBSQ3Fa?=
 =?utf-8?Q?b89MFfI1umc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NSWkErYVQ1aktuUFZwOEVsTjdxL0hEYU1ZYUE1N1hCSkdyQlBYSytKb2hM?=
 =?utf-8?B?Q3RjTFZ2am9obENNUVBMRkMvTFRuYXQ3djhoNGxVQ0paSVV2ejhFZjBuQk5S?=
 =?utf-8?B?a2J6UlZGdkJ6NWpxbnBJbFZ5dEdnTGdiaHhmYkVvaW1YMDBTcFh6S2NjcmJ6?=
 =?utf-8?B?elRRLzFPUk9MMGViV3g4QndKK3k2bS9VMVFITkxjYndwZGxiVTU3VzJUWC8v?=
 =?utf-8?B?R25zUWEwc1pnd0dCbVBiRWtyVHhjMS9ic29oMjlySzZyeDBKQm44N1VWakV1?=
 =?utf-8?B?SE43blRua0pjek9xcWxIZTlGSG1QRm5DSmlqakEvYi9PYWozbGd0QVRzSG5m?=
 =?utf-8?B?Y0pSQ1lvT0tsSHg1ai9jbGtMNzhxU3pnMW1GZDBoNXlCV0p0am5VMnZJNUJZ?=
 =?utf-8?B?NTZIRFJpeVJqNTlOUGIwQ1dZVUtPNVpHdTdSRUNPUjQ1MTZqTzYvSGhiWDln?=
 =?utf-8?B?cmpIamNhZDZnb1RLcUFmMkM3d21zS2ZBZkl4aDV6MHJTVFB0L1NGcXdsVDRo?=
 =?utf-8?B?Tmp2VU45NEZTSzB6Yk9ZTUluNlpOTURUUENuSU5rbng2Z3NGNTRDSmkrSCsv?=
 =?utf-8?B?RCtnbXR0azgxWFZJWHRnY0R4TVFyTDdQQUN2emFzU2gzZVc2U2FiTHpMS1VO?=
 =?utf-8?B?cFFYb29UQVFKWTY0eGZycExxOHBBdmpIbmlmY2tDd2ozUXB0VUlKc3F5QmdV?=
 =?utf-8?B?Ri9OQzJPNXFZS1NtVStKQkROVkY0RUd5d0ZmRG1pQXJDR1BuZStzZGVkWVNW?=
 =?utf-8?B?SCs4dm1rYjFoL0pERnhaQ2czNmhLdndDa1dvUnI3NVhVck93K0tsV2V3NjZ0?=
 =?utf-8?B?dE81S09oeEdPVXNLdWxWMDVEYzRwbFBBQjJPdVIwZ01NWDRPOEFVa24veHFV?=
 =?utf-8?B?dzc5YUVpd0F3dnNFNE9NeURCWmdneXBKRGNTbEFDRThwNEUyTTdSdFdRUXJL?=
 =?utf-8?B?MVJGUjlmM2VEditNK2xzZElaSnN0VWVSSjRYeUVHSTZmaGlqY1lPUjNjTWQ5?=
 =?utf-8?B?V2VpaWFHR3VxUE1CcldJem1wbnp6NWpDU3EyRTdnTkJhR3RKLytoWWhnamo0?=
 =?utf-8?B?ZG14bHp5alhiS3JhTFo4LzZVV1dpbGdONTdlcnRIQTlZOUlGeEtROXJGWTlG?=
 =?utf-8?B?M3QxaEdUTWlGY05MblhrbkxuV3lsSDk1dVRFai9LUGpSMWZuZWYwUTFSOG9k?=
 =?utf-8?B?bU0zZWlQU2dOM2NzcGx5M05ENWJpSVNCWnlJRTJWK2hkallmMlNvc3ZsWkJv?=
 =?utf-8?B?bmc4VUVYbWhCQkdSMm91UkV4TmVWa1FPaEtPaGN4NDVaRVdyKzJOMEwxK0VS?=
 =?utf-8?B?M083T0Z3L3hGSmJHM0xYZGtCSFA1QUxJcXpCbGJGSlFUaUpnTWR5TytHalJZ?=
 =?utf-8?B?ZVMvVDQrcEdQOG5MUmE0bk1GL1RoUThtUkM5cE93VnVrWUI3aXcrMi9HSmZN?=
 =?utf-8?B?eVpzN0NTbW8xZUpnM2hpem05KzlERjl6aGpEamVZUHBVSjZlVW0xRTlCVkdC?=
 =?utf-8?B?QkpaYWkwcVhkSjdHNTRZRGIvVVhMMExzMWFkN0MzWmZrYkZ3cGZYNUl0ZU5O?=
 =?utf-8?B?b3NDVGh0S0N4cS9wMGZ0TkJGcDI4ZW5ZcGM4dmJ2ajl0TE5IT3VBVnZ2RFhO?=
 =?utf-8?B?Y2NQNDB5YTVHckttUnpoTSt4eUE5TG40WXV2dklmc25kMmcwWnZ3NTdnY01x?=
 =?utf-8?B?UVlIRWlEcXlsU1pWZXk1ekI0RHU2dkZyVnQ0ZXlpdGJyTWlibHRaTFlJcEpF?=
 =?utf-8?B?M0RYTnhZYmhXRnhWdEE3RzFXLzl0VmszalBOejl3N2c1QU1DZFRsVk9wbzQz?=
 =?utf-8?B?R0lTejB1ZjliTFpLOHZkNnJVMlFyN1Rod0czTkVoNUxzUDJKdDdPTC9uN0Ry?=
 =?utf-8?B?TUNoZkJteWhLYjBlUHRaRG8vdlpVd3Z6bmltUzRpZkZiNWNYTnFiYUdjbzJD?=
 =?utf-8?B?TmtNRnZGc09RbjlrTzlVODZtckZzT2dPak5JRGw0KzA1K2xSckU4SDhML0Zn?=
 =?utf-8?B?d0ZDTHZJeTFpNW1oZE8zc2w4N1BmWTZvRDNacndxOHdrb2YvN2NiUlRoR2tr?=
 =?utf-8?B?SkRqRG13T3l2TXJHdzlVanZyRy80elRWWFArVHFMdlIwa2hMcFNoNnVGUXFr?=
 =?utf-8?Q?zhJCryuNpIanX2ZcDI8FPPQoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac51fe4e-306e-49ca-16e7-08dd921959f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:26:14.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwXf0sUM8GaaCyditl3NUMGyWX5cHlqiSKn+lOAPjaM3qrbCEIA/DDytHAVXX0VN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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



On 5/13/2025 2:43 PM, Shiwu Zhang wrote:
> Expose the debugfs file node for user space to dump the IFWI image
> on spirom.
> 
> For one transaction between PSP and host, it will read out the
> images on both active and inactive partitions so a buffer with two
> times the size of maximum IFWI image (currently 16MByte) is needed.
> 
> v2: move the vbios gfl macros to the common header and rename the
>     bo triplet struct to spirom_bo for this specfic usage (Hawking)
> 
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  46 +++++++--
>  4 files changed, 170 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4835123c99f3..bfa3b1519d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  	amdgpu_rap_debugfs_init(adev);
>  	amdgpu_securedisplay_debugfs_init(adev);
>  	amdgpu_fw_attestation_debugfs_init(adev);
> +	amdgpu_psp_debugfs_init(adev);
>  
>  	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>  			    &amdgpu_evict_vram_fops);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6f9bcffda875..3a27ce75f80c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
>  	.is_visible = amdgpu_flash_attr_is_visible,
>  };
>  
> +#if defined(CONFIG_DEBUG_FS)
> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet;
> +	int ret;
> +
> +	/* serialize the open() file calling */
> +	if (!mutex_trylock(&adev->psp.mutex))
> +		return -EBUSY;
> +
> +	/*
> +	 * make sure only one userpace process is alive for dumping so that
> +	 * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consumed.
> +	 * let's say the case where one process try opening the file while
> +	 * another one has proceeded to read or release. In this way, eliminate
> +	 * the use of mutex for read() or release() callback as well.
> +	 */
> +	if (adev->psp.spirom_dump_trip) {
> +		mutex_unlock(&adev->psp.mutex);
> +		return -EBUSY;
> +	}
> +
> +	bo_triplet = kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
> +	if (!bo_triplet) {
> +		mutex_unlock(&adev->psp.mutex);
> +		return -ENOMEM;
> +	}
> +
> +	ret = amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2,
> +					AMDGPU_GPU_PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&bo_triplet->bo,
> +					&bo_triplet->mc_addr,
> +					&bo_triplet->cpu_addr);
> +	if (ret)
> +		goto rel_trip;
> +
> +	ret = psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> +	if (ret)
> +		goto rel_bo;
> +

Is it really needed to allocate and send the command each time on file
open? Can't this be cached, or is it because of the 32MB size needed?

> +	adev->psp.spirom_dump_trip = bo_triplet;
> +	mutex_unlock(&adev->psp.mutex);
> +	return 0;
> +rel_bo:
> +	amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +			      &bo_triplet->cpu_addr);
> +rel_trip:
> +	kfree(bo_triplet);
> +	mutex_unlock(&adev->psp.mutex);
> +	dev_err(adev->dev, "Trying IFWI dump fails, err = %d\n", ret);
> +	return ret;
> +}
> +
> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user *buf, size_t size,
> +				loff_t *pos)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
> +
> +	if (!bo_triplet)
> +		return -EINVAL;
> +
> +	return simple_read_from_buffer(buf,
> +				       size,
> +				       pos, bo_triplet->cpu_addr,
> +				       AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +}
> +
> +static int psp_read_spirom_debugfs_release(struct inode *inode, struct file *filp)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
> +
> +	if (bo_triplet) {
> +		amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +				      &bo_triplet->cpu_addr);
> +		kfree(bo_triplet);
> +	}
> +
> +	adev->psp.spirom_dump_trip = NULL;
> +	return 0;
> +}
> +
> +static const struct file_operations psp_dump_spirom_debugfs_ops = {
> +	.owner = THIS_MODULE,
> +	.open = psp_read_spirom_debugfs_open,
> +	.read = psp_read_spirom_debugfs_read,
> +	.release = psp_read_spirom_debugfs_release,
> +	.llseek = default_llseek,
> +};
> +#endif
> +
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +
> +	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
> +				adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +#endif
> +}
> +
>  const struct amd_ip_funcs psp_ip_funcs = {
>  	.name = "psp",
>  	.early_init = psp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3876ac57ce62..089b6ae48329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -39,6 +39,18 @@
>  #define PSP_TMR_ALIGNMENT	0x100000
>  #define PSP_FW_NAME_LEN		0x24
>  
> +/* VBIOS gfl defines */
> +#define MBOX_READY_MASK 0x80000000
> +#define MBOX_STATUS_MASK 0x0000FFFF
> +#define MBOX_COMMAND_MASK 0x00FF0000
> +#define MBOX_READY_FLAG 0x80000000
> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
> +#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
> +#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11

To be consistent with ADDR commands, better name this as
C2PMSG_CMD_SPI_GET_ROM_IMAGE

> +
>  extern const struct attribute_group amdgpu_flash_attr_group;
>  
>  enum psp_shared_mem_size {
> @@ -138,6 +150,7 @@ struct psp_funcs {
>  	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>  	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>  	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
> +	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>  	int (*vbflash_stat)(struct psp_context *psp);
>  	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>  	bool (*get_ras_capability)(struct psp_context *psp);
> @@ -322,6 +335,14 @@ struct psp_runtime_scpm_entry {
>  	enum psp_runtime_scpm_authentication scpm_status;
>  };
>  
> +#if defined(CONFIG_DEBUG_FS)
> +struct spirom_bo {
> +	struct amdgpu_bo *bo;
> +	uint64_t mc_addr;
> +	void *cpu_addr;
> +};
> +#endif
> +
>  struct psp_context {
>  	struct amdgpu_device		*adev;
>  	struct psp_ring			km_ring;
> @@ -409,6 +430,9 @@ struct psp_context {
>  	char				*vbflash_tmp_buf;
>  	size_t				vbflash_image_size;
>  	bool				vbflash_done;
> +#if defined(CONFIG_DEBUG_FS)
> +	struct spirom_bo *spirom_dump_trip;
> +#endif
>  };
>  
>  struct amdgpu_psp_funcs {
> @@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
>  	((psp)->funcs->update_spirom ? \
>  	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>  
> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> +	((psp)->funcs->dump_spirom ? \
> +	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> +
>  #define psp_vbflash_status(psp) \
>  	((psp)->funcs->vbflash_stat ? \
>  	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
> @@ -578,6 +606,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
>  bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
>  int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>  				   enum psp_reg_prog_id id);
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>  
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 17f1ccd8bd53..99ff0bfd9d4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>  /* Retry times for vmbx ready wait */
>  #define PSP_VMBX_POLLING_LIMIT 3000
>  
> -/* VBIOS gfl defines */
> -#define MBOX_READY_MASK 0x80000000
> -#define MBOX_STATUS_MASK 0x0000FFFF
> -#define MBOX_COMMAND_MASK 0x00FF0000
> -#define MBOX_READY_FLAG 0x80000000
> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
> -#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> -
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>  
> @@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
>  	/* Ring the doorbell */
>  	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>  
> -	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> +	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> +	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>  		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>  						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>  	else
> @@ -766,6 +758,39 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
>  	return 0;
>  }
>  
> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> +				   uint64_t fw_pri_mc_addr)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	int ret;
> +
> +	/* Confirm PSP is ready to start */
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
> +			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
> +	if (ret) {
> +		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
> +		return ret;
> +	}
> +
> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> +	if (ret)
> +		return ret;
> +
> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> +	if (ret)
> +		return ret;
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);

Returning directly from here will do.

Thanks,
Lijo

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int psp_v13_0_vbflash_status(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
> @@ -898,6 +923,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
>  	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
>  	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
>  	.update_spirom = psp_v13_0_update_spirom,
> +	.dump_spirom = psp_v13_0_dump_spirom,
>  	.vbflash_stat = psp_v13_0_vbflash_status,
>  	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
>  	.get_ras_capability = psp_v13_0_get_ras_capability,

