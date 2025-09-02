Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB83CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9423A10E5AD;
	Tue,  2 Sep 2025 06:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47STMCFM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7178F10E5AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiKu9olRKqcv/mQElIQtPtnWPTj+FHiiwZXGKtEguBENHuCPZuy3kR0EkAPclVVsipacUfG5L2Qh+Mtj2qQzWEIFkWIN3mAIqzMs+LS2bjbwjIZpTXhNG4a1/QBlGr/m9e12V4fKToZVQZg3hI1sDqunpt0qlYC34Wd4gEdWgHtmMhYAPDrRm4Xy1ssHwcAuPyocB5BWJZWOTIbotY1dEddJSDMIsv6NhvFYNfR7b4K9JC4gkiOAVUc5+Ec9gS5PYHIBw/htaxdS4GonQpo0IYQ1WcrYlHPHjzkB3Lp0Z/tT+qs/g1okFgVkfb6rjlpFUsza9ZeJ43+5H6UF/L/L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxumNPm7debd2/KSvQL53fKtF4qZD/gHoOzm6xEhYzU=;
 b=AD3AJq3Zfs7gWwHWam9wkxX9kdvD3Q11eWFvSTS9iwvFd3f5Hed1E3kwBt1g6a8wp8QTxg57kd5IXhqxqXUwmzTCI1zAyXkS6DvhFu3J0XoT/1sOBN9ZW2E8BsEGbc7ZyAVHnMaZB+mpseNveMXLczmA1IokYYeOmhy9yRLcmdzP8czwrcCInKq8/7fVHM6+hCzESw8862eDinOA7HeUn7ntyVu3IjA9IIQpb7P/12C5CQrVu+uFZChqnbJe8WeYpls/ghOwSLRjvifPKVIehaG3Mv/7DfYrG2fw45QUybOe67NgGJGd0sCGF/aI/scum8vqN/5CSr+/0OTCqiUNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxumNPm7debd2/KSvQL53fKtF4qZD/gHoOzm6xEhYzU=;
 b=47STMCFMqP2mM7pVXQgYJJ/aorH/MzEnbgv87QHoUIYcFpK4GvlRmMbLmPPjpOGh6llLsVIZmu1wDkyerieETCG5PI0GnuEwourEtMcaneTTxrO4Ld/4S+jzKktfffeLt8sDm7sTEhPoGvNAp+GxsHCCIQ4ZwRLPZ5RB0eeh2DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 06:41:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:41:12 +0000
Message-ID: <cb030737-e602-4bdd-aef2-cb5fc79ee2ca@amd.com>
Date: Tue, 2 Sep 2025 08:41:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix allocating extra dwords for rings
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250901100012.439155-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 29397773-1099-4173-5d13-08dde9ebb532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JvQXJ2SHZzb2FsYnpWOFNuVWJCWUUvWUZmOFp6ZW9RK1J6SnJpdGUzRDRx?=
 =?utf-8?B?enFTNzFOTjZLR2pCZzZDWGwvaFVaKzlOdVB6U3BRdkd3d1VsaWpJdGtyUFRx?=
 =?utf-8?B?LzVXdDRTeVI4N0JhN21HQXYvK3lHdkJwbVJEVWFYZGV4YUpRcmtpeUFBeGVy?=
 =?utf-8?B?MmdxMitGZTlHMUlmOVpmaVBEbTdHb1R0Q0dLOU5xaCtKTmxVNzk5L1k3VExw?=
 =?utf-8?B?cTlxb0dURVEwMzFBeW1OZUZmMlQ1VVUrS2tKaElEK05GWUw5M3dlb0NwSDFJ?=
 =?utf-8?B?Mko1NDVBcnlMTjM1NlZURDM1d0dtWW9WZys3MkdReGF3RUFFK3BybTlKL0tu?=
 =?utf-8?B?RjFNVllRV1VxaXptcm4zd0VOWWZGVEJHNmNXYWRZOEFINHhON2Jwa3U4d2ts?=
 =?utf-8?B?ZzhkMTUwdzd6aGFFZEZrbitSd01ibGRoN0JmdklnOUc1UDdwL3NaTXVZbGov?=
 =?utf-8?B?bisxc01SWDJaUGJ2bXFMTlBRWFFobzQ5TDJSbnQyd3htK2IyUjFpOGp5ajE5?=
 =?utf-8?B?N090L0xUVjlQc3lZdXpXZHNDVXRNWEkwQ2pkQ3hrbzRJSFgvdFE0NjJCb0ox?=
 =?utf-8?B?NGJWYWh2YUxPbE03M2VSb1NWUmlMbm41emM0MmRzdGdSS1YvR1dndzZUYlkw?=
 =?utf-8?B?VzBLZkNINm4rbGhvNFYvSkk0U1NrZHcyWGZWci9iVGVrS011QVhkbnEvWlQ1?=
 =?utf-8?B?RFFscXh5RkpGMXRUWWFBK1FyVTFQRmcwVzBLSGtKdUtuY1ZqRWNheUgvbjQ0?=
 =?utf-8?B?bjNsNkUrbWJvQXdQaVZCeWNOMFQ4TzVTRXh0U1ZrYUhSZmowb2VwZFBLQ1cy?=
 =?utf-8?B?eGI2MTJPZ1ljSXVOTE9aYUpRUldDdG4xVTBZSndxR1FzSldjWGZxK2wyRkMv?=
 =?utf-8?B?Z2VKZklhT3ovMEIwbVhmNWwzRmNCSUFDRTc5NU5ibVh5cnRoQ292eks2WnMw?=
 =?utf-8?B?UFB5cEY3KytpNG5FU3pVNEtQa1RnS0pPRG5OWXl1bXhWb0VncEh2R3NuVVBo?=
 =?utf-8?B?S2tqWHFjOXJxUmlCYWRhOFhYYzRJVVZsVS9WTnVvSGdUWTUyWFRud3VvKzhI?=
 =?utf-8?B?NDNkZXNOUFZUYTd0TXRDSVVQc21XOVpia0MwWmUyZm9zditEd3crYWE1eUtR?=
 =?utf-8?B?SkU2V3hWWXB1b05XSlppcFpCK1FLci9xQkZNNmtyU2JjV2QveGxMNVQxMmcx?=
 =?utf-8?B?dmZqelpOL0hQV3Fib1FOR2h2bTBpT05ld3VhRkpjdStOL0M1Y3g1RThhZXBE?=
 =?utf-8?B?K0VCRzJ0SDlDclVBMS9GVlJKN1NJMFRxdXRyUnZYeUVvZlpFbVVCR2hLOC9G?=
 =?utf-8?B?MGNSYjBta0pQVStxN0lOb3NOUjBHSWhtaXZ3a0l3YjlnSWU2T3VqNU11ZjYy?=
 =?utf-8?B?b1crTmJrVDdVN0RpdXNFWm9qWktVeHVpUDdIb2kwRTRITmkzUFZ3SW1MNDlD?=
 =?utf-8?B?R2Fqb1h1OGNZeWhMcFE3VTByS05ZOW0vV1BTb1B6alR5L21SUkI3VytCS2M5?=
 =?utf-8?B?WEpZWnJDRm9oc2JWeVBUT29RcnlIdnFQU244QU5MS1VXNC9hNVI1cWpad1hv?=
 =?utf-8?B?K0JMZFJHS01FMEVXOWU1OEFwOTJpdnVpV0wvMU10bXBzUXFKV0lyZEVBUlcy?=
 =?utf-8?B?SkJhU3NTb1dzK01lMGFPa3Roc0NnTzBRcEQzMmQ0K3ZrS1poRVJzR3pXZVd2?=
 =?utf-8?B?YVZsUXk0R3ZFTktXK0FNbXNrbnV5MHJUT0VxTCsxOWJya0c4SlBoS3dDa1VB?=
 =?utf-8?B?MlBGM1k3ZXdGOFBpT1hJb0hyQUlyRmhBNmNrbXlLZ2tYMXlhOGUycCtLZlE2?=
 =?utf-8?B?WVpUYTNzdGIwM0lPUHMrcERlVlJsNEhFNHZiSlRqTGlLczlIeVpzVGhOSHdu?=
 =?utf-8?B?OG9wMU5JSDRqejBnN25JRlhwSG9ib29MV1l6R2xMUjJ2OUlhNWU0by9SZkd1?=
 =?utf-8?Q?7Jgs2Fhns38=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDlwUzVKdDhtdnhreWlHR0VkamNHNzBIbXZTcTM1VzgyclI5b2p3OHNlQmlp?=
 =?utf-8?B?OU9PSWU1d0pWNTF0TW05YjRFV0FHN2d6Z1JMMi83UE90Z3RhYmY4QXRNRkFl?=
 =?utf-8?B?MDYxU2FscEVHeFpybVNwMUYrUlFOMml4QTVlSCtrWkRlU21UZ2pwVUxpVE51?=
 =?utf-8?B?eG05QmFWUWFPNUU0UmVCR0sxNkozeGZRNHFSMUtxeDVndldwRDJUblg2d0l1?=
 =?utf-8?B?MTlYRndvR0VVbFVTaUEvYng0cDA1ekkyT3E2TjM4T2JYa3R3aXhWMlMwK2k4?=
 =?utf-8?B?NksvZGN3NStsRzFXWURVb2d3OVVCeXVLL2tXS3FlNS9IQzhnR3hFcjVyb0Y4?=
 =?utf-8?B?clVVVnBEOEZIbmJ5aWV6L0RkMHN3U0lWV1BtbzlWZGVrQk1KRm54RnRRd0Rk?=
 =?utf-8?B?RGVJUEV3c1cxWUxuOWZ6UXNlZ2FJVG13VDZXcnA2U1BGOXFUeE5uUkQ1b2E0?=
 =?utf-8?B?Rm8rU1BnMHlLdXFuU1RET2VDVitnK1pTRDlHNlhaZ1c0L2Q0OFR3Z083MXhz?=
 =?utf-8?B?cHY5WXV5ZzRWNlIrZGROQmp6T1ZkTitjWHN1TjNueUIzVHFXQy93REk5dGNX?=
 =?utf-8?B?QzZVTG5uek9sRDFlN3RmdkRyUFl4dlBWSXcrYm9CcUZ1aUduWmxKa2kwc3Zp?=
 =?utf-8?B?c0VUZUN2Y1ZRVmRTcDNIQ2lCZEQ5aFdjS3FPVk9xQzBkRHh5Uzh4eDVaS3R5?=
 =?utf-8?B?emtVbEZENGJaMjFmUEJJSXNtbXlJTGVaQXgweC9XeVNyVFFuSUFJSzlBMGpp?=
 =?utf-8?B?M3U0c0tQTW5qYjVmekFyUk9PM0ppNjMxdGp6SkVGdW41UXIyamRzcUxIaGpT?=
 =?utf-8?B?b0U4cHdONnkyMFRBQnBsR0tUcnFERC81cUo1RjVyalBvdlFOS1Z2RHJmaVBr?=
 =?utf-8?B?NHd4dDQ3K0VWVktEL1NraHYzSVNJVlgrVHdJUUZCN1V4WVlRYWtLOE4xQkpW?=
 =?utf-8?B?cjJidmdmWW5oQnBYSVdIQllZWWNXTnlud0pWY2U0QWxzOTNjTkJKd0FpM1l2?=
 =?utf-8?B?TW5aNC9GK3k0dlhMdWc5Ry9POEozTVRNVjBjcWMxWUlKMkRUS3pJd1lIM1RV?=
 =?utf-8?B?UEpvQUhKZG4zSjZkQ1dRYjRJM2pjcE5UVTlWdGxWS0NaQTV2djFjYVVoSGVy?=
 =?utf-8?B?ZlpqeWtTQTFqdzZjOWhmU0dUK242aVdmSFFOTTczMzgvSW9EOStYSDl5ZEVQ?=
 =?utf-8?B?cFlJWDMyOTAvM2pvcDNiMEU2b09DNWxubXcwQUpPWEdVWk5ETGw0YTFOYWJI?=
 =?utf-8?B?a0h3UnQvM2lmekxrNVd0N3h2dE1wQ3ZwVlhmMG9ZbnFqc0lqcEYrUmlQcCs0?=
 =?utf-8?B?NXFaS1VlRTRKdVBKYTgzNXNFM2ZjUHY4RDdJc0YyQTFiUGtrOFhJYWRIWEJ2?=
 =?utf-8?B?Wlk4SkdCVEtxNWxUUzRVWVBFVGtPZlBsNmtPbzdJZGRmQ1ZpRTUyTVphVUJH?=
 =?utf-8?B?ZURjUWpsZ3lpSzlzWkpocTFsOVIxREh6djZ4OVYramNJMmtGRjVVT1IybzZY?=
 =?utf-8?B?WTR5ajJtMFhQR0sxT0YyMjgxNDQ2QVU2VHhRRWxQeVR6ZWF5aldONEV5RzlQ?=
 =?utf-8?B?aTBkMmxnZXM4NnhjRmNQL1cvYnNuNW5oZ256UVlwaXM5SUFndkdVSElJTzlO?=
 =?utf-8?B?RExxL2dvdlpvL2dVSWsxdEVnbU5obGFFdlVlSTZ1Vk9vbHhsaFBtNWk3dUtJ?=
 =?utf-8?B?RlZLQXZic0YzZUhtd3llcjRqeTRCMEZ1YXRvKzBmUHRDZUphRm5OQ3FJTWd6?=
 =?utf-8?B?VmdHRDVxYTI5T2N3L3BnYlFjNmczNXBqRVVWWlpzYjROYWdPOFp3N0d1aHk3?=
 =?utf-8?B?TFB2dTB3a3VyQW9oS0t4K3JsWmVaTlFTL3JRZ2xwYzhJSzhmaGJOR1BFMzlN?=
 =?utf-8?B?N0lXems2VURvUXZnNlFvV1ZrWU9sdnJCZjdYT3Mza01CMHE3Q1BnTmppbVVO?=
 =?utf-8?B?TFVqdjRMNWtPcWhNdWdENmVLTG16dkFydExNTk8wMEJUa0M3dE1WMnlpdTlH?=
 =?utf-8?B?dEtVbkppbEgyU1NFSnVwT2NXUnN2Z1JBTTQ4QmhSamtiWWpORGtWVUdleU9E?=
 =?utf-8?B?NVluT0hIY1RCRTl2aENDd1hDTG1VdndKd3QzZnpFSVVHVTd0aFRoRTQvb1VI?=
 =?utf-8?Q?P1vzp1A3/Jl+yh5M2kAMQAYVg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29397773-1099-4173-5d13-08dde9ebb532
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:41:12.6494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0TvIZUe+VxyD5x1V1+Ij86JMgBOEH8kYu6o943fVdex8tm1+kUHkMtFCtQyITWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

On 01.09.25 12:00, Timur Kristóf wrote:
> The amdgpu_bo_create_kernel function takes a byte count,
> so we need to multiply the extra dword count by four.
> (The ring_size is already in bytes so that one is correct here.)

Good catch, it just doesn't make a difference in practice since everything is rounded up to 4k anyway.

But I'm really wondering if we shouldn't replace the extra_dw with extra_bytes instead.

It should only be used by some multimedia engines anyway.

Regards,
Christian.

> 
> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..13f0f0209cbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
> -		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_GTT,
> -					    &ring->ring_obj,
> -					    &ring->gpu_addr,
> -					    (void **)&ring->ring);
> +		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw * 4,
> +						PAGE_SIZE,
> +						AMDGPU_GEM_DOMAIN_GTT,
> +						&ring->ring_obj,
> +						&ring->gpu_addr,
> +						(void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
>  			kvfree(ring->ring_backup);

