Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F22CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF2410E150;
	Thu, 30 Apr 2026 07:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1Yh/eXX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FA410E150
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 07:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHaCkaX+i9jJh/v/bhKwjFoUvsPrrA9W1ZOfAEly6MwCyOiAIBrr/WLeUP07cH8qyEkvHSWYAMd5cjlEcE6coOdh9cB0MpdzisXg7t4fDtluuRNoxBGk2XWM/MhxBCGuyrJHByIA7vctzBcWN4S+gM12VExnL1piGiZpEGrV3XqhAwOqasqdx0Q0cuAG5F2jz4hku1U2SWiIPe8vPUqGHio6IkU+UBsQbXadf3X22SGmfRo84ZMT1tCV6ewJ7Lxy0NbHoSDSbU+pcJBd+QDm1lM25bqxEyowZny4I/Ev2TjBsavP1pP5TSHFzk5ZV9BDFBLDA6H6rSb541vAgLc/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzX6NA8jNXo2+ABRl38wGoqfKBchcMbleXU6KUGsdLE=;
 b=Q+voygherqaL3WTfwgpUvZOoZ/tzFAG4Zeri+awe9tS2L95NheROYQ/cAcF4az86nkuh8LA8QPYyHcBfbgaeQFnPzZsh70fJenRo+zzXFfSkbgYJjyd0tn0waLFzHkLF2lUIgpGnfQGNdMtHYo39HfOWmygY0NDBWl4cHuIKjTkJjgp4NwZ3pl8d6atPxVUMZEyidubHOvqQhli7qKmpOsU1BF2hrSz/V1wFI1gMS+6LhoTLkvTuAH1mscPbJ0KdcbORal2JCD5Er86KdwPubMp0sployv9kR27qVpGnnLac1UQseMrs1eA5N1tqNiA+kLljAZpTwe5KnP2xPGxPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzX6NA8jNXo2+ABRl38wGoqfKBchcMbleXU6KUGsdLE=;
 b=g1Yh/eXXzPFAJMoIbDfCHeyNK86uuMpR/E5/goPC/+33PT83cVxhZqTjU4Uttq/LfAM+6qSmxlKoF7FNgfH1cfLzuFPoYpJhe989jIvEfFOtfiiTNfJf9LCLjNBkgfEw7rwoyvArdn+FSpVcYWM/xQjW6OCkPY8xRsZEsBaIXZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:19:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:19:29 +0000
Message-ID: <6266086d-15d4-476d-a992-503509032dd7@amd.com>
Date: Thu, 30 Apr 2026 09:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: "John B. Moore" <jbmoore61@gmail.com>, alexdeucher@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260429202042.21718-1-jbmoore61@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260429202042.21718-1-jbmoore61@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0703.namprd03.prod.outlook.com
 (2603:10b6:408:ef::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c88a7d2-d39d-4612-4fa2-08dea688d136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: bMOPZW2Tp0xuNJEciQnu7HRCkvsf6CAy4bJ8gRUI4TBaiJp6JGIi1jg0izWoXLW+iN2LtMzEMlp8VCXjyhLo+VEEuiWLDNCjQHJlHN7CSzIXylCha5FG3LvKOCwWPwhlAPxhZsXoB+TUt9OYQG+4vj37BaROWwmX7Zdo7kf4fYSvQtuH7lW5yvYgxBwW1dFjG4RTODi35jYvfPvfyYcuWCTMCMQAF4OlcYNTQZMQXoeJ79Q11npFdaJPr6ll8EhaQLhFq14I1enq+hnnrQDmBeH3r3YdfrDWVh+VxeEq2CKXE56/9ZPXK5tVmvv1I7Wbe2WWaU6kQRR0bmcgXvELmR9h6QYTafSQIFj2mFuyvoCNqRw+gF3rppMtXH+rDXVtJtOF9qiUKhlFtcPKnI1BLA5l9neSGMPbYc5KV+eeyZTFLAqSGbF1evxtoQHm+e4rfOvtqtuKwoMzQy2bIQdRGtVBy+DBXNarl7lKW1ps7I2bWr7UrGWQJYq2obPBr7Yg8RWQFnxJ+3T6i7L0lhsLj92O/ajN1ipp8irVgAH552mcWk11wrR1HIkqDBiLsORyTVvJQbzozodE5yzUcJ3EbutzJv7r8Ehoc26c16ziR1pcTDq7NcKJsyt+Prbx+duZHBZ/6+lf/nmsa+kxTzdnvSNMkh27qOobNVnRz23kseHWDk2hGTIs8LU01X6hWDptiq6Y+Xzq1kc8gchq/JZCNEc9VT/ptwdS32WV8bqajkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpSMWN4eUxhQ3Bad1VQMnBIUnc0VlZVTHl6bzZPSWNpczM3Q0Q0TS9nWWlF?=
 =?utf-8?B?Y291eGFweDI0VGhLL3hNSXNESFlYelgyMGgrbTBpWDNtSndxWkdneDBJdWRy?=
 =?utf-8?B?ZkhPNVhjeE94OUJ3bHBPaE92V3lCZlVkMWFGVFhMbjhVL2hmV0ZjWGVEK1ZW?=
 =?utf-8?B?QjBWdldMQm1XSVB6NGlvaWdIejYrMEh2OVFOS0J3UzVwSjdYcVBPajNubnFx?=
 =?utf-8?B?MGpjWm1yWmJWdTNGWEszcEJ4cWhXTzhkSmRldnNWNzArbzlDbjR1UVMySHpL?=
 =?utf-8?B?TnN5OG1mcDRwWU1Kdks0MXd0TW16RHVSVGUyT1dWSkJxbVJ0bkhKTWpISTRi?=
 =?utf-8?B?Ump1dk56RTNIS25vSzFBTnFscXRyQ3hja2RhaHRKZWtXVlRWNkRsSW0wMHBn?=
 =?utf-8?B?eUNyNyt4Z0ZacE9ndldRRWE0ZWNkL1Jid1dqME9zZlQweitYMXNWNGtrUGFs?=
 =?utf-8?B?ejlJYVI2U0lVaW13QUVKditsNjdFbFpjVy9VWHFjQnRHRUpQSytyTzY0RWw3?=
 =?utf-8?B?Ykt6ZkRvajdVUDNtM2ZFK3d4ZHl4YUd1LzB5WUJMNk80ckNuRnV6V003WXNs?=
 =?utf-8?B?OGxMU3Z4OXBZTElUU3E3YUpHUzluUUtKelVpSkpOaitJc2NUcWh5aGEycVlX?=
 =?utf-8?B?U3h0dzJGZ2M2U0poQXh1TU1Nb1hQOThRaUZBWk1MMDVwVnhrRVFST3hWOGlD?=
 =?utf-8?B?dGlRZ2lMdWc5NjFRd3d0YklPUGVIVWt4TCt4SUJObGhGQ1hOUVJ3dEFQRS9Y?=
 =?utf-8?B?dVJLanByUnlDUHBsdGZiMkJsUDNFNmxOSDNzQlpKWCtDRjBaNWFSYUdJS2tH?=
 =?utf-8?B?blA5VnJaR1RsOE1PS0dueGxUcW1VaTAzUWlJd0VOOWR4OUVhUUYrZHk5bzh6?=
 =?utf-8?B?THFvZHRvMjRVVFJrbUx3L3NCc1AxV3J0V25hdkFPck9KbFo1WmMzcE9uaXhR?=
 =?utf-8?B?YWdNQWtkNlBPcWUyTXFkRDFkMUNDZFplTXBmbFpmM2RVRTBycWlPVzdXeEZp?=
 =?utf-8?B?WU5zNThTaVN0ZkI5bDBiL09sT3dpQUlHb0xDRDRXcGlvVjdlV3J4d1NmMTVC?=
 =?utf-8?B?bTJMZFlWMkFTVDAwakNySkRBbUY4SlV2N2FEMXp6RXdJbzU4OHU5V05vT2NE?=
 =?utf-8?B?QUNqQjh2THdXVEhpRDN1bGtzdmVpb255M01OVzBjWWRkMTdrcWhWQStranI3?=
 =?utf-8?B?cXgxQ3dnc055YVpQUG5vbnNYRVBPbmNUcjl4VDJuaXlna2krUDhySlBzSzRk?=
 =?utf-8?B?MDlweDNZdzZTNHpyT2c3WUZNamhtMVo3NmhzaHFzTTljbTloekxuYjM2MXd6?=
 =?utf-8?B?SWdRa1pFdXNKbWUwd3BCYzA1TENucE43S0M3UFR0MmVSZmZDWHZkKzcrK3l3?=
 =?utf-8?B?dnNia21BcThXNnVZMk1iOUhVTUVmRTgvdjJud3VZUnFyeWlPakMyYjFSZHlj?=
 =?utf-8?B?aGZhSEMrVUhuWHhhbFZ6WEE1Y2FVdGhCNC9FenQ2SHR5ZlFJRW81UHQrejlm?=
 =?utf-8?B?UXl2U0RSN3BLVHlsVmpSemk3bWlobGhtMm15SDVKc0NLd0NPbWN2TzhPdUhV?=
 =?utf-8?B?L210OW9LNjRtTHVtS0V1ajNlWFQxUjBDdFJETTV0azNvd2ZHd1p2MjhnMHBL?=
 =?utf-8?B?Z1kyQVFONnNuNmhwSDY4ajlINHIvMVB0aFhoSURmVThiV1ZkQ3kvYWd4Vm4w?=
 =?utf-8?B?QkdTbm5rWDBkTkhGOXU3N3RzQUJTcE1ldkhQVW5ObEdzUWdiNjhQckZESUJG?=
 =?utf-8?B?clFjTUdmZGVOZ2lVdjhkS0xQL1FabGhQVUdEWUM5YWJtU2tYT0M4LzdMTFRS?=
 =?utf-8?B?YXY0eTZOejliK25WSytmbnU0Tzd0emxQTG5EWFNEZ0o1WGdOdlJuK08xVlpI?=
 =?utf-8?B?T3lFTVlpaW8rNkxKeGJwQ1Fma3ZEMGRaWVMwbUJBME9saG9lWGVXZ2JGMjQ1?=
 =?utf-8?B?cWhHUU1TcXNNSHRBN25GSm9hdW5ZUVQ1SWdlRDcwWDNGYjRzQWw5UVJDWXp2?=
 =?utf-8?B?ZGVhUWlHZEsyMktFLzdtek5zY1JDZG9aMXNMeitZcWY5cC9MNHo3R3ZjZ045?=
 =?utf-8?B?SkZLVjlMSXc0cmpjMFZUN2pLMXBrV3picmNWVFg4c01sQTBDd0NwRmN5dDU4?=
 =?utf-8?B?ZU1GU3dYQ0EyOHRzaWZjS0FrazF1SEZ5VWl6RUx1TmQ3NDBqY0xTSDhYZXNS?=
 =?utf-8?B?cStLY3Ivc3pIL1VBOU91UnJQTzNsZEp0RWU2RmhXYXZvSDlNM0c2bzJFM0Z0?=
 =?utf-8?B?cW5lRUVxWHNMaUl3cWpjeGVYNVZ2SFB5R2JsWlY1Zm9aS2JzR0FHVGJybzJ4?=
 =?utf-8?Q?kE4MHa97tQyKSdak4q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c88a7d2-d39d-4612-4fa2-08dea688d136
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:19:29.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRwIxPaXEZinCC1hKbvHW6WHRG+PKdBy9398BBw4K646tGqlku+Fj260uCAI6jrW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

On 4/29/26 22:20, John B. Moore wrote:
> Move the duplicated doorbell-based get_wptr/set_wptr functions from
> gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
> helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
> in amdgpu_gfx.c.
> 
> These functions are not HW generation dependent -- the doorbell path is
> identical across all four GFX versions:
> 
>   get: atomic64_read(ring->wptr_cpu_addr)
>   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
> 
> The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG()
> since doorbell is the only supported method on gfx9+ compute rings.
> 
> Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
> wptr access patterns (MMIO registers or wb.wb[] offsets).
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: John Moore <jbmoore61@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
>  6 files changed, 58 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 77578ecc6..9e9c5cb81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>  #endif
>  }
>  
> +/**
> + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings using doorbells
> + * @ring: amdgpu_ring pointer
> + *
> + * Read the write pointer from the doorbell-mapped writeback address.
> + * This is HW-agnostic and shared across GFX generations that use
> + * doorbell-based compute queue management.
> + */
> +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
> +{
> +	/* XXX check if swapping is necessary on BE */
> +	if (ring->use_doorbell)
> +		return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);

That should probably be readq() instead of this horrible and not portable cast to atomic64_t.

Alternatively we could just normally read the pointer with a memory barrier since this is just system memory.

> +
> +	WARN_ON_ONCE(1);

Pre-requisite/error checking first please.

Make that a if (WARN_ON(!ring->use_doorbell)) return.

And please don't use WARN_ON_ONCE() that is just to reduce the amount of warnings printed into the logs on real HW errors.

On functional coding errors like this one here it doesn't make sense and is often overlooked.

> +	return 0;
> +}
> +
> +/**
> + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings using doorbells
> + * @ring: amdgpu_ring pointer
> + *
> + * Write the write pointer to the doorbell-mapped writeback address and
> + * ring the doorbell.  This is HW-agnostic and shared across GFX
> + * generations that use doorbell-based compute queue management.
> + */
> +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	/* XXX check if swapping is necessary on BE */
> +	if (ring->use_doorbell) {
> +		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);

Same here the case to atomic64_t is extremely questionable.

Regards,
Christian.

> +		WDOORBELL64(ring->doorbell_index, ring->wptr);
> +	} else {
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 585cc8e81..27f6beafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
>  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
>  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>  
> +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
> +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
> +
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1893ceeeb..4c0272cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  	return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>  
> -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	u64 wptr;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell)
> -		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	else
> -		BUG();
> -	return wptr;
> -}
> -
> -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -
> -	if (ring->use_doorbell) {
> -		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -			     ring->wptr);
> -		WDOORBELL64(ring->doorbell_index, ring->wptr);
> -	} else {
> -		BUG(); /* only DOORBELL method supported on gfx10 now */
> -	}
> -}
> -
>  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		20 + /* gfx_v10_0_ring_emit_gds_switch */
>  		7 + /* gfx_v10_0_ring_emit_hdp_flush */
> @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		20 + /* gfx_v10_0_ring_emit_gds_switch */
>  		7 + /* gfx_v10_0_ring_emit_hdp_flush */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 427975b5a..404604f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  	return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>  
> -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	u64 wptr;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell)
> -		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	else
> -		BUG();
> -	return wptr;
> -}
> -
> -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell) {
> -		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -			     ring->wptr);
> -		WDOORBELL64(ring->doorbell_index, ring->wptr);
> -	} else {
> -		BUG(); /* only DOORBELL method supported on gfx11 now */
> -	}
> -}
> -
>  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		5 + /* update_spm_vmid */
>  		20 + /* gfx_v11_0_ring_emit_gds_switch */
> @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		20 + /* gfx_v11_0_ring_emit_gds_switch */
>  		7 + /* gfx_v11_0_ring_emit_hdp_flush */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 79ea1af36..7ba436444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  	return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>  
> -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	u64 wptr;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell)
> -		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	else
> -		BUG();
> -	return wptr;
> -}
> -
> -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell) {
> -		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -			     ring->wptr);
> -		WDOORBELL64(ring->doorbell_index, ring->wptr);
> -	} else {
> -		BUG(); /* only DOORBELL method supported on gfx12 now */
> -	}
> -}
> -
>  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		7 + /* gfx_v12_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		7 + /* gfx_v12_0_ring_emit_hdp_flush */
>  		5 + /*hdp invalidate */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 8249135d7..798f94bca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  	return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
>  }
>  
> -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	u64 wptr;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell) {
> -		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	} else {
> -		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, "
> -			  "only doorbell method supported on gfx9\n",
> -			  ring->name);
> -		wptr = 0;
> -	}
> -	return wptr;
> -}
> -
> -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -
> -	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell) {
> -		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
> -		WDOORBELL64(ring->doorbell_index, ring->wptr);
> -	} else {
> -		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, "
> -			  "only doorbell method supported on gfx9\n",
> -			  ring->name);
> -	}
> -}
> -
>  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>  					 u64 seq, unsigned int flags)
>  {
> @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
> @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>  	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>  	.support_64bit_ptrs = true,
>  	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
> -	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
> -	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
> +	.get_wptr = amdgpu_gfx_get_wptr_compute,
> +	.set_wptr = amdgpu_gfx_set_wptr_compute,
>  	.emit_frame_size =
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */

