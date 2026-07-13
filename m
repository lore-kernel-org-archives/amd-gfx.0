Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7EBC44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61A510E85F;
	Mon, 13 Jul 2026 08:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PlbZXuae";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA4110E85F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 08:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDd1iPWYDacYE9OtQWDqqQtKtQntJCbgm+ktGOfGpq31w+P1XMultH9CRGAHFVxCgjsz5JWMoxhfEZcqAdhuNXaWhQxjfiimcWg9qf3ofeK6ikb8A4Ut50PVbbniDXrb2pw8EqQWh+zv43zmy2gSx3nSJorIfdUjm7XX8bEn/PWs1K3zzbV+FxJZyVebu4beGXXAwevJ0NsooNmnl/hKDyZqFBjp4Kco1HKTFu8xbc3XQOonNQIZD3zcKtgum1ISdJkDhdr0wcjg1uqIgIAqzx4ic8FDql+tiKkhnClNmhqOkDxSjg4Iqt3MPrNeMZ8TmG5n5KgxzaA3Nbo7GR1S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAx8v+T/1Ow9uqnCDWx++kDjowPrHHgZLvMn/D7+rp8=;
 b=kEgXWKr3PxPdPF8T3QiHsNWJmRXb5Bqu/AHlUEeyGY3aB6WXpyLR0Ue6Gs3hj9uTCJvQDvEbGpzVp9JbDr8U5k2heRiA1Y+B9mrvlsW7BUnhhHtqfZZja+LC7Lg0lcdhDMnOEK5uxsIWp7JmvBA9BOnXskmaTTyycndJlLZILTDzKtYc8GprNqBNthnyzQpf6BUpbhiIqVJ+pnTCjfP139Nl8elesMa4Cd72H1Ti3IUUvXLQfclzGDYrGVxuJVtjyDObSefXMm5iDhMad8VM9Su78gob0oo+MydLHyKJc++wyVEQ34KAVjy+SnweTFfbxVF0sBUF1cuambMJIHSc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAx8v+T/1Ow9uqnCDWx++kDjowPrHHgZLvMn/D7+rp8=;
 b=PlbZXuae/RU7Ni21t7QU0HsyrmgrY907zRf2AN6TIfvTcg31m8/TACpAiaN7GcgZeg99m7kLezKjSUJDa7i88eDuQDJaocOzoKa5a0kQyASFvojX+HSbnj0BAyAohJwVAYonCvNot7lNjCLWAylnqUcLWtpddDB/j/Q3I7ch+PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:43:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:43:33 +0000
Message-ID: <64f99e9e-ea1a-4b40-aa0d-b325833bcd57@amd.com>
Date: Mon, 13 Jul 2026 10:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/ttm: Consider concurrent VM flushes for
 buffer entities
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260711115000.40655-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260711115000.40655-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fbf452-a1ee-4882-b51e-08dee0bad22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gdACGIhazSQg1e/1va5YKyt7WXLCFe79FVrEsNOjsiUHbmPcW2GeQYkT4IFOeFOoO5L8474g/EAeZexS562xi8b5s7yMdApxvr3zND+dLdiP5vGAt+wywgy24JH1+XBS4ZxdeD+8sK5XBXgwjiDBUZPTvhWjVaJh+wtEZ2ZNThHI9j/cVGkif4WTkJztZYSpvq3bZG7cTesoqM4uPlbX/TbCm2OcyGQfVDuhlvWxalZv6tdkbaBW0pfsBhDcblL6NptZAOEkh9tOIouiWZXxfLqLfGtDPZGuVUoGFM5U7Dn5rFgMDyAy1WXOaRn+dPEi72qFmKI4X/qJyA6Vt2Qixxtp61Uz8ezCcysmyt3vDWhdGqC+LbAi6EJZAGJTXe9+VvlbZmjg/iT3PmtLhxJOj+XosKJRzOM643nTDyBsS/zeqXO6IQ+ah+YkX0uVyWKf54Xq5H6daYwMpAwRkrbpzk88EDGzMB1CYwYwhG7P/YjZj/b+qZxz6NRp6qtFPKoaoF2B09Aw0NdDaUTvRoMoqf2b6t1idu8319rVlzqxl/Xou5DPjjWhI0rfSqQ73Rvfd0/QOoPlb9A0pl8tbgYPkQRo9TbiMV07ezR/i5Nrf96HVhby7ebcmmOJqoiXqVfWlGt5rJ9Lrd/zRbpB83A/VpJJzljqsURBuOUt91RK/IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJDMCt1ZTZDWDVkOEw1aWtyemhUNldrdGxRT3JZWHFrT2ZocFJmeFJGVnZ3?=
 =?utf-8?B?QjF2bmRIUXQ0Rit6dTMrSUU5RG9tOWpzZUs0ZkZ0RGVzZjhQeUZDeWdkSi8y?=
 =?utf-8?B?TnpkNjJaUUJkSVk2VEZVL0Y3Nkpqb2g1c05PeXFhL0tORVBDazhBYmttK0Qr?=
 =?utf-8?B?bE5aOFpoNTg3VHNOMFkwMk4zbnlSQzVrZUVqT2d6d2RQZnhVMVA5SzFZTzh3?=
 =?utf-8?B?WFFCWlhQWVZlbGJYWGoxY20vald1bTA3NHNoWldxTzRhaUQxRFBlb2tteGNk?=
 =?utf-8?B?Um0xMDdMbEQ1ckI1R01jSjRna3A4V2hqbTJMTnNzOWpQc0haZThFYmZqbm1p?=
 =?utf-8?B?VW5wcHJ0WG54dHY5ODVZZmVzZkxEZjBzNXIrK3U4R3JLeFR4ZlJ6TEdFN0pm?=
 =?utf-8?B?NVRKUDI4T1QxYjV5RUdSdUgxeit0Tm9jUHduK1N5TndRNS9BcGVrdzdadVFW?=
 =?utf-8?B?VjY4aHJzL29pRThxZU5ueFU4ZVNKNndwRDdDYTY3VHkyTHdxWThLdGk5cEVW?=
 =?utf-8?B?em9taXlMKzZsT3dOcjEzTzZXZVR0R2crS3NpZXluRTNIYlNKSDRwRm00b1RT?=
 =?utf-8?B?VWVUT2dqNlVrUGozWXFwMlZHaWZIVmlpS0JwVERaeEIvVUdEOHlPMGtTZXpv?=
 =?utf-8?B?Y2R2bCtGdmxCS0k3a1U0bnRHM2pEZXY4bVJyRGN0L0Fmb1VkTmRrb1MrL1dp?=
 =?utf-8?B?TXkvZHlRakFDVFZIdHJLNGgvcU84NEppSlZKUHFVaEJLYXZDdmtINjc1RUZC?=
 =?utf-8?B?cDJ4QTROcGlLTGZIQXFENHNnU2hVRVZpbEJYSGtIRnRGcXNGYTZicUE0b1hv?=
 =?utf-8?B?bnh6bUtSdEx1VlVYa1N3NkZsNEdQR29nRVBHNCtPUitMWkJwOEQ5Myt3M1Vk?=
 =?utf-8?B?MHlWVkVodEdtSTFKb3BBNjlWQk0xVTVJTDRKaHNxREhGclR5RXhIR2d0c0hN?=
 =?utf-8?B?RVE5dXBxMHcvR0NoL3I5R3J0bFY2R2NBNlM3SzZiZ2ZjMkZNQmJVUFYrL0sr?=
 =?utf-8?B?UzlHQXdnd3h3Z0VpQ3ZySjkvT0o4dXg1R29QMU14ekRac2dRYlB0Y29TZ2oy?=
 =?utf-8?B?bk1CVUVpdHZ2Z3kwYjVoaVkrMWZKTzN5SEpueWNUVFdhT2lEbEtWYm00bGgx?=
 =?utf-8?B?cG5aTm5QSXA5L0ZpNW9lS05wRitOejNCMHM2ZlFrQXlPOTBLNDZJa2NyUmpL?=
 =?utf-8?B?SWh2VFd2SGJSZ1A4MmlzQjlKNHRxVWtrdVlDa1VaUFZNS0ZTVWM4SG1FZEhD?=
 =?utf-8?B?WmlrOUV0MlRmNUZMSFBib29IZWRIeVFjSHoyMUl0SnM4R0ZCTXBiMGpTTlF2?=
 =?utf-8?B?NU5DMTJkbmtWY1ZYM2RPQWtlbHBBN2JPTnZkSTVLWERQdGdKbTRvb3RiODRu?=
 =?utf-8?B?dkJ1VVMwWlBpcG8yT3k5N0pCdzd4T2VpQWlIY3NtTzBwc25ScENCaFhwSHNJ?=
 =?utf-8?B?RlE1QXBGWS9JMmsrTWdWS2hQZnRaWDhEUnVOdi9MbDYyUTY1OXU2bzMvZWZw?=
 =?utf-8?B?bkVTNitQNk1CZXhKdU1MZ0ZETldoOUp2TFpHdzF5OVpjVXRSU3ViQ0pnUHFX?=
 =?utf-8?B?OUFlWUszWjRUdUxPSUsva05iMERYRDZqRDhSUDVhdWJGWTRKd2wrczRQMzli?=
 =?utf-8?B?c0ljKzJlUGVTYWhKNFZISkFuRFBGMHcyU3ZkZEZ2dUU4MUU4cHFFRmFqVS90?=
 =?utf-8?B?ZTFUTEd5YUlmU2grU3pCNUs1NSt5WndMK0s0TjRGczdvK20zc0xTYUNJaUZn?=
 =?utf-8?B?blNXRFN3T3gzazRkM3hNd25BRzFSd2dYT0N3UWZTYWVFQUFJNDBuN1JOK3FC?=
 =?utf-8?B?SXpTNHNkVHAvTldnUUFPQkFseUx5VEJZK3FreENqNnNaaHlHblVZQWgwdDR0?=
 =?utf-8?B?Z2lMd2JKaFZqU0tQeEtQSFFYTDZRc2pjVGVnMFVZWFdaS0lVTkxYOURTL25x?=
 =?utf-8?B?ckQ5RzhxT1B5ZnNHOGNtUGpYR29ydThPWmUzL3BYUVFSbFdzSHlObm9YSXhp?=
 =?utf-8?B?cDBCMDBXNUpVZHJ0Q3pGbmhmZ0w2K2xyTi9UbDBzUU5jc25KQWJPNmZsMk5T?=
 =?utf-8?B?NS8vOWhoR2NOMG5rbng5Nk9VREVpMEZ0N3ROZDUxd2RNUVlSdW44SEQ5SldG?=
 =?utf-8?B?U0FhTjlYNFIvemI3SHZjN0NDOHFycmhjRHZ4ekZPUSswWG11WHdSTjNFTE9x?=
 =?utf-8?B?eUR2WGRGU1h4b280TndORWNadDhqd1VpdmpPdTN3YThXVmVpSFNPakQzZTNH?=
 =?utf-8?B?aTdzemo0U0t6OGRyaFF4V0xhSkZIMWZDVmxzTGVJYy9GMXdpT1ovQldIdDdQ?=
 =?utf-8?Q?RRhbkJ2QW6IlsgQj3F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fbf452-a1ee-4882-b51e-08dee0bad22a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:43:33.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtej9BGZyK56J89Mzt9FrSvtL1j77mFkQ8JkqyraYmIsW4aySVhpuQfiNdQhh7F1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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

On 7/11/26 13:49, Timur Kristóf wrote:
> Allow using multiple SDMA schedulers only on GPUs where
> we are allowed to do concurrent VM flushes.
> This consideration is necessary because all GART windows
> are mapped in VMID 0 (the kernel VMID) so each buffer
> entity would flush VMID 0 concurrently.
> 
> Practically this means that we can't use multiple SDMA
> engines for TTM on GFX6-8 and Navi 1x.
> 
> Fixes: 01c836788b37 ("drm/amdgpu: pass all the sdma scheds to amdgpu_mman")
> Fixes: e4029f7a9474 ("drm/amdgpu: only use working sdma schedulers for ttm")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

I'm not sure if that is actually fixing anything, but better safe than sorry.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 74ada995bd8e..9eb55df6e692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2685,12 +2685,22 @@ void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>  		return;
>  	}
>  
> -	/* Navi1x's workaround requires us to limit to a single SDMA sched
> -	 * for ttm.
> -	 */
>  	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
> -		1 : n;
> +
> +	/*
> +	 * Allow using multiple SDMA schedulers only on GPUs where
> +	 * we are allowed to do concurrent VM flushes.
> +	 * This consideration is necessary because all GART windows
> +	 * are mapped in VMID 0 (the kernel VMID) so each buffer
> +	 * entity would flush VMID 0 concurrently.
> +	 *
> +	 * Also consider the SDMA invalidation workaround on
> +	 * Navi 1x GPUs, which also prevents us from using
> +	 * multiple SDMA engines on VMID 0 at the same time.
> +	 */
> +	adev->mman.num_buffer_funcs_scheds =
> +		(adev->vm_manager.concurrent_flush &&
> +		 !hub->sdma_invalidation_workaround) ? n : 1;
>  }
>  
>  #if defined(CONFIG_DEBUG_FS)

