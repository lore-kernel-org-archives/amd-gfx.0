Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A82FCC9A6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B7810E224;
	Tue, 10 Mar 2026 08:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+mz46+M";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A915510E224
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 08:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx2KyZtqqVP5Ye1HJGoG/VBxD0btnC6sgXsjB68IGntCrRCpiyVkvffDjxwrxY/bWwXVpSgNfVqRVs9R90NvM5r0YxwUJOgaN5p2ZV3ywpSZlVcQuWYzdCgBx3jmiCUBu/z2d5/PftVXGkRZ0zebzua2/uHyW+OiiLtyd3c0/IZHP69fY971RF66DPmkNl1h8i6j6GfFrViomU3djhGFbBI86g8ME2EizzReSuZfBV+vFuNH3y15WGchJjUhIAWQEshpjGxzX5MFDY7TbLBSWxXIb/4U19d9gtNujVd3SBOduh1bub6BrS3YI1SuE0gGHObhAtAAwHqIDvlAYVCjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4QeEHrBMb/ayB6arHrnKHPekWLhjwUQ/DzKU91lphI=;
 b=CvM/msrpgXge2AHHUBR18Jfka02w8s3DgbKQ3GTMemUmx+4EjyB/917Sb2/f7kLJ37KHBiGnvY75jBGOWUxoACTvqQf/xWEWH0Ds/KFCe4LOONr99Z2k0NvfKr0hzAYHpkBBx/fRLm3aaElEdMoxeo5d6O71Cl5QFLua/u3cuAD3aDig8hZy6jSrsR39QvVg3Csj4HO07wN+2uQoa1ON/xfJUz2RKvc8A8YTLNMFey3GSOEosK4u7CrDkJBX7r4GjHO2jYpC9mho+hy8Ac6gwyZPLD5A4MVHQXDo3MgLci2dHHUFBAkmxFKRQQXWYA0kci/GAW+e3bTE0rQz6qIYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4QeEHrBMb/ayB6arHrnKHPekWLhjwUQ/DzKU91lphI=;
 b=D+mz46+MIu6yvCK6Z3qkhx2fALbwDeUiHuGJbJnvbjWmqLPYQeoBsAWrUdZh8MTn94GUE6aRqwaOdSeV7Wa4/EE9f6iN1pGvv68VAwznme5bm3YNZ61m0HeXd530WgBIp4lIOxgciaVqiIlctj2opvMVTEFN6ogW/lxFC7TPTVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 08:21:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:21:47 +0000
Message-ID: <92a288f6-26c9-4b74-ba11-3b4d6a94ca4c@amd.com>
Date: Tue, 10 Mar 2026 09:21:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under lock
 context
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260310070252.3217741-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260310070252.3217741-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e49929e-1ff1-4917-165c-08de7e7e121c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 6kwfRGfupetdh4d8mHjRiPeVp9cE/cnmmHaj5paq/g4Uq2mTrtG+rVOZkqA2el4J+Cffz5CJ2ARSSwAG/hBiv1ZoLK1TsbYnPo07p4E9AYm24t8OiwBXNx81PrHgzKWRdbmumIKvNsVgebaTKkm8s+q0CA730UHrXX5SZzvb+Qw8WiME0Z98zxEOEFGZUQP7jkrVmkA8cmsH1wJyZtVAU4yHuKalQH2Ks95ZwDTFwKBlPxqgtCrclzYhZiM2z7UL6k5qnj8+L6exWiFCzVjITVjvOyXTieyVr3nYdzFgZPw+5CpfXfD8sAJHoVfB1Yd2rp/U8Ly5rbSIOq4jEFVtUPPgM9/Kw3OgXjm0/TNRQ/88moW7zTepBbzrlta2VKzLeIg0+dRydHKv5couJmlCHbdxkfDbnIM3ml3uMyeqdioOwi70z1yx3Kw/6sgZHOff8oAzlwJ+5xMmZ4BW1bcKbGZuJz6lbCKAeEEIjypWZs5AUEPRPno7ErFT9MtRuszGfmTZz5an6lDgQTeDOX3KhlDYDT309oUsClRwqTx/VKapkDjr42Wcx04eDyNDZUwtt5EBv11AXTeULdlIiGPbk60aqh4OZR9SIexwdyo09CuBZoDQ1wlWNeJTlt7paj6uvVkdUjcvs0V/WrAIrPKky0RtZQ7tBWz4WJCyaZMPugqNrAqj4lN2ur6LJ9lOvbl41GxaZ9UenugrOnmJnkk+7FWmh8oO9iqHyoa5lBevffM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlXNTA3YWowYVRrMUVQdGdSMnVCTGd5ZDlzcXYrYzlMZGlHaTJuSENuV2Fq?=
 =?utf-8?B?Vzk5NWNjQys5RnFQU3RFL0VmRi93NWRXZE5uUEJLREpLZXZQZ0wwTlBHN2ho?=
 =?utf-8?B?bDBGNXBsUU5XMm9SSkFueHJ5azM4MjZoRGFVcVZFL0N3dWJhM1BPZktDVkJp?=
 =?utf-8?B?bHFid2xYTEpiRmRlTVZwN2VsRVdlR3dxUGFlYnNObXpxZ3NyK1RVR0JoU0dS?=
 =?utf-8?B?VU5MWVRIWCtnbEFiK0VVNVF0YUNOZ3YxTGttT2IvekJic1llNzQwNkhTa1ZP?=
 =?utf-8?B?QXl2bm5IY2prZkwveXl4UDh2Z2x1d2xhZEZkdlp6RStOMC8xYU4vTXB1alBr?=
 =?utf-8?B?aSszVUg1dkFBWjRaUzB4VVBmNkI1ckRXLy9tSDNRMDJzRDFvaE04UGJ1TXVt?=
 =?utf-8?B?OTB4VXdRN3Z0ajFMbDZvU2hPUkJRbFRBMlhNK01RZWtUK2EwVWJMbFRRL1ZX?=
 =?utf-8?B?ZzNoZjBHck5DODg1WHAvdTBKTnB4YnpmSmJYZGc0M05KYjFWZU1nWUFRREoz?=
 =?utf-8?B?OVZ2U0ppeWc0alllNW9vaXlrUzdnVlI1VWRTeUhYMm0yL1c2U0ZteDVzRVVD?=
 =?utf-8?B?TXVjYjhnSitTZ3lZbDB0T3A1aE85Yzkzd2JmSFBXUnlJQU1OZGlxN0xFKzBm?=
 =?utf-8?B?enVTN1lkblpiZXdmaTVyYnBqeEZkNDZldHZPNGVWbEFkQVkzdTJsRUpYTDlE?=
 =?utf-8?B?bHF5ZEtDakxkMG9nZGR1elN5c3hydFo0d2V5aE4xNFJvV09HaFc0Z1hlV0lv?=
 =?utf-8?B?bmdUOG5kS2J1UjIxY01hNVVzdi9zdzBmWHhweE9pMUdYTzN1S3BIeENmdG40?=
 =?utf-8?B?SHE5SERiOThhS1M5RFc4dWdvSGhJTnpnZy80YXBNK2hkQzFXbEhnL1ArVjFi?=
 =?utf-8?B?bkJXMW5nZUdUOTNPTDZvS0h6Z0dsWUNseHloem1qOVQwbW9LYk9iOFZZZ1dy?=
 =?utf-8?B?a0ZhNDhvd3hmR1BRRHgrbnBMakluOVlSNE5BakMzWjlpdEw0V2s3eS91bENM?=
 =?utf-8?B?OEx1UHg2VTV4N2dDRVJQdXRjemVFWXdOOHNLQTcvYmJONU5wZEJsRG5HaXhV?=
 =?utf-8?B?Q0hROVQxS3lUMDBhNllobDFMUHh6QWg1aGMySk9WUGc5bnhOWWY0NXRiRENT?=
 =?utf-8?B?eHRDcmZ0MHUydkxVZEg5ZndZeDd0ZVgzTkdnKzBHUWhadWVJK1k0eUNGVzZo?=
 =?utf-8?B?bjZMK28zQ0Y5S1o2RDlORk1vTWhGUFhqT1d0cmlLTkhkcjU0Q1UzSkgyNE1l?=
 =?utf-8?B?VFRSRE9RQmZ4ekt1KzVwZU1BRVdvb0JKVVpCMkh4aExlQ3oxVStQbkJ4TTVa?=
 =?utf-8?B?SlVQakdTYkhpREEvMVRkemxya2N0TGhkNXZ5anNqbFhLVXNSZGhlYjJqMXla?=
 =?utf-8?B?Zkg2bXJUY3BjTmxhU21nWGdsdFh2RFRyS0Fudm12eGt1TDg5cWh6eGdDM3A3?=
 =?utf-8?B?Umo2dHN6dXZoUnZCUVdIZHMweFVObDRtZHEwSkt2Z1VWc3JPYW5pN3Q1ci9p?=
 =?utf-8?B?NHExazhJM0tqS1ZtZm1zU3gyeE5BWEZHZURYNEJyVHgzR3M3dkRsZk04U3hJ?=
 =?utf-8?B?emZKTHhRNEJqcU4rTlA4MnZHRnYweUFYWTVSeVJrc1JTR3ZkL1hRYXZNZ0Fk?=
 =?utf-8?B?V0ZaQ20xcmI2N1htVitOWDdNVk51aXFuT3djbTNKNE9qdVVJWTh3OUhzK0Rr?=
 =?utf-8?B?bmN3d2lWTjVkbGJtTTM2SHpONldPYkhOblAxR3FKQWFLa3c0Ykxpc3dueUYw?=
 =?utf-8?B?aXpCL0ZoY1dhTk5uR0QxQ2Q1eUFJMklzNDdxZkZKQThvbFMvdWVPd09FWDdF?=
 =?utf-8?B?d0dtd1U4cXRUSm9sV3hQempEUDYyOHNPQWFzZ3BKOUtQNXNVcDRNRjBTdnJa?=
 =?utf-8?B?blVvOXkyRGFuL1ZuSUErN3JaL0JFeWJOL2xJdUpLVXhXQzJzUlBySHJXTWhl?=
 =?utf-8?B?OHNuSU50UHkrdktKc3lLemFWa1RNSXQ4TlZUSUhrYlpBaVd2S1JuNnlzaXpE?=
 =?utf-8?B?MGpGWEYvaDN3OTBPcjRMZmQ2T0xnYVYzY2dIQndIRnFIUlVTNnV2N3RHQ1JI?=
 =?utf-8?B?ZVhTc2lCNVJuTjVvK0htNkpVa0xrdWJVbU9WWTZ6MkZQRklwSEpGSTZ3QlFM?=
 =?utf-8?B?aWs4RS9yWHUxNzlZZkRUTGtqakdpd05tRTdnRis4RXJDeVVhRWVDM293WTJk?=
 =?utf-8?B?cDE0K3R3cVNadTI1MVVLMXd3R0xFYy9teFV6Y05ZN3BhYjBUbXA0ZzlMbkpH?=
 =?utf-8?B?RmRUaU5Gb0NFc3lrd2x4QSs0UEprMmUzbk5TSVB0bmhXMDZhYkFOUG1mT0li?=
 =?utf-8?Q?U1UUH7YxJP9PRnj5Pr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e49929e-1ff1-4917-165c-08de7e7e121c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:21:46.9560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6OwTZWEbgRAVol2X6LVxmLcFuJajvdUl4x5tv6jkit8GXznu4BwWGPSjtoHn76B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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

On 3/10/26 08:02, Prike Liang wrote:
> In the userq fence gather and emit IOCTL path we acquire BO locks
> (via drm_exec/dma_resv_lock)before calling drm_syncobj_find_fence().
> This causes drm_syncobj_find_fence() to complain because it is entered
> with locks held while the WAIT_FOR_SUBMIT flag is set in the calling context.
> 
> However, the userq userspace path does not rely on DRM_IOCTL_SYNCOBJ_WAIT to
> wait on fences that are dependencies of userq submissions.

That's not correct.

> All waiting is
> handled separately, so the WAIT_FOR_SUBMIT flag is effectively unused for
> this IOCTL.
> 
> Therefore, we simply clear the WAIT_FOR_SUBMIT flag for this path. This avoids
> the lockdep / drm_syncobj_find_fence() warning about being called under a locked
> context, and has no functional impact on userq behavior since DRM_IOCTL_SYNCOBJ_WAIT
> is not part of the userq synchronization model.

That doesn't event remotely work.

See the patches I've send out a month ago or so for the correct fix.

Regards,
Christian.


> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..7a309b0130d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -708,7 +708,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			for (i = 0; i < num_points; i++) {
>  				r = drm_syncobj_find_fence(filp, timeline_handles[i],
>  							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   0,
>  							   &fence);
>  				if (r)
>  					goto exec_fini;
> @@ -726,7 +726,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  
>  			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>  						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   0,
>  						   &fence);
>  			if (r)
>  				goto exec_fini;
> @@ -818,7 +818,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			for (i = 0; i < num_points; i++) {
>  				r = drm_syncobj_find_fence(filp, timeline_handles[i],
>  							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   0,
>  							   &fence);
>  				if (r)
>  					goto free_fences;
> @@ -844,7 +844,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  
>  			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>  						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   0,
>  						   &fence);
>  			if (r)
>  				goto free_fences;

