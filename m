Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F2C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 06:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9DE10F48D;
	Wed, 17 Apr 2024 06:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otpA4yis";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F7C10F48D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5THPkvT528KSwFJ09FUuUIiuGAXMVZJDJWzawm5Vxl26rvvhwog9Y74iAvOZthQb6Qi8OIskEYAcbDcZnOuFoamqENAMw6iY4zXuupkaLM0ztQkKdJyiZKbVdk2/IWk6WAcGAQ5NZI3k/QDbLlXurCfHaaoufb35UJShZ8Hxnq15VLVwg0rUWLkzizVT9h8fVCzP6M1SJw4h+E839nEovj70XNP/Kznzkk2at1aw7d7kN2vKL7s1TG9cE9I2LXhczs3wyXcjSaQAufkFrA2vj29Af4yRISVNUVhxGViqfod15J0zEMyAx112RmLyYsoC408ugY6elT+JXqE//SArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kbz2ixYjdTEqg/I3aN+It1z8PDqK85pdsRoQPLv8a8=;
 b=RhWfhB/Zu1jPcLKrO6wDVqoQYtNui8UVd+8c/hllRvXBB8VwIeGdgT8fX2TnMFuxznavibXU/7QCjt1X/m3ddufUL7xqUKA0V23ASIYNPR64oR1xoXp+gSf0Demecf0KqLrFZ+srv3WTpOkMsyXDRJvIzeN9UOMIR/k+XtU83HQKAic8OSNSNrwWITCdXY9+YQoHVzzLmeYmqL8oLbcSjsITuREm9YAQm3MxBqs8AImmwxQTn/jELfSwHiItlsRffLv5Qvly5KQtS6d2K4Ojh9oI4jfBRZsn8kmUeL9TV5EEHprTxKdbVGaCMrNXEKGqaqdcJKCnVbheOUp+wrPkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kbz2ixYjdTEqg/I3aN+It1z8PDqK85pdsRoQPLv8a8=;
 b=otpA4yis3kUjKMLhtOX/m5tY6wVkkCylVXidZ3Q+8UR72JGSW/G/Rxeg1hcWvSKhEqns2/391fv80pOjxs6udL12bquF9IthxWVeYAF9gPLSmD7KWGK+MuV2o3AgHqVPkEG6yS3zUOEN4olgK3vL7eC0JtQnIt4klBdvKz7xrAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:49:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:49:14 +0000
Message-ID: <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
Date: Wed, 17 Apr 2024 08:49:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4640b253-9ef6-452d-afe3-08dc5eaa7e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf4+B0s1xl01T/0oDEasrKsqUSokqwc4/J2tzzNBaE8o2FV3+y77/Lx89bKfpgViavTdVnQNWBVm/udqowfEeQMjI7GjMljVg5FCqkrOho0pADy8bSwGoYh/Z5zG68ap+Yuww9fhpmN0QprNtp/zyiCNUhD1w2SAyND7xoYIC/QguVKMCBSRG5IZKJlCnqFyME9IDFvABOHlRmkvU9rM81i6Tk+CJr9EY6W/LsfNohMluDOZKXEPq9661XrBQrx/9eAfRaFJoTv1/G3pw5WL++YAUI8gs3HD0m2oedQd7Tz/538cfSmxWyoqRn+ihEp55BgegpZTGs+xUpP9gKwEC+DKBviN6tvNHH6JUqw3geM5UwNzm+z2hvZ7wIn2Sq0WQ5LnaPke9Xqng410jMz3g0fAmsYwIuYqKsHs3KQkvlV6cbFqliaFZ48weD1/dR5wjWRibJn6ezUuVjNQQdsbfUpVLI/xizzZ1qQ1jjEYC66+YUE9dXIuMtS083gMxoxxf7+QHSYQCB340W+owvekvq3ArKE4PhUqZKtOT/xVx3RXvob205M4XrsSUaxGt2kgjKKl/B2yKz9J/Y3BBlTyhCnacMQnzqZe73zsxrfsHJ6sLxlqekbi6NzNSgSiwEg7NYBQwblfnNFvO0/7VJfUup2s3eH23iMJvO44yb06bYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzE0dVBTT1JGSUZGUkJtUjJicGFaUnFuMlpTWDhGUlQ3Umc1NVV2RGp2MElk?=
 =?utf-8?B?MmdVVFQ1NE5WK1g3NEpqZzd6bWhsUHRvS1ZSd09hUzJlcTBkQW9Fdi80bXM2?=
 =?utf-8?B?YTJTVGMveHRQMFdTcFB2M09rL1FFdUFLWkxGaXVOUlFEZ015aCs1emN5RFFy?=
 =?utf-8?B?R05ycDFxb1pQVXdET3pNRkVKY0Zsd01janVKdVpvRDI1czRmMzJwWFg2Tklk?=
 =?utf-8?B?N2VBMzEvcGswZW9QemhSVTREVEpWQituZzlSLy96cS9SNWc0M0xMcE9qcWlJ?=
 =?utf-8?B?b09adjBZcHdPa0RNNXMySGpuWnQxdHNiNWZPTVpiQytpMlZUdUM4Zk1XM01Y?=
 =?utf-8?B?VFJ1TEI2TTNyVjdvcEgyVXBQMThTbTZ0VkR1M3lmbDdtdittRUNleklreDdz?=
 =?utf-8?B?OXV1WTZtbW95UzRuSU00RWNiaDliVU5XdHlSK0Y0LzNyZnIzRzNpWW42emVz?=
 =?utf-8?B?SWxLeDhPRlFSZ0pRMGx5NVFEMEJ5VG9NcVBCSWdCWEJVZTBHbktmbURoZlQ1?=
 =?utf-8?B?YjRJUVZlQ3RJRE83dUFTV3hzWmZhclU5V25lenBkOHFGZEgwbDhHYWQ2UUpN?=
 =?utf-8?B?ekZ4K2RYb3NIS0E3T1huZ1VURDY0OENsa2dCaFlYNENRdU9FZ2twUFdQb0FT?=
 =?utf-8?B?cjRVYWZabFd0VVhKNWJHQlo4cDA0bFJ3akgrOXp3cDJqUlBGektPR2FvdVJE?=
 =?utf-8?B?c2NIb2tYbTFITm5mK2FWdENMN1hVbllkUUpSWmh6S0piRTdUOFlHcXQ0NGdz?=
 =?utf-8?B?KzI0bFRtRDJaMG9neTFyL2dNb3NzeGF4Y0pFTDVpQnZMMUdDaWVzQ0xoUWtT?=
 =?utf-8?B?WUNpNGcwZU1mdXpjNGZhM08zYXR1K0RrcUw1YmhBV3ZEVHBzZmdUSmtTdXNn?=
 =?utf-8?B?OUZFdGVudWZvb0VLV3ZveFRaSkVsTWdLbUM2ZktGRFZPUHA0NFVWemRHMzVF?=
 =?utf-8?B?RDdoYjZoUGNSMHNma2pvRnlESXo2OEZuQjhvUzdLZkVpdVBIUVNQMXY4U3ha?=
 =?utf-8?B?Z2RVc2tLRHFqNm90VzloamgrUEJiN1pwVFpTUzh0bjJKdnF5VzRsYUlUSGxq?=
 =?utf-8?B?QmNwV09EMnQ5UnZrVkkxUTVid0RSVHVaOVlpYjZuaWlNcFRPTExscm1Ddno5?=
 =?utf-8?B?alI5dThQeWVyWFpwNzVSMWxJNzVjMXkzeVEzQzFjL0NKOFlMNmNUY1lsVzBs?=
 =?utf-8?B?dEUybkNoSTg5TkxMMXBwUUNuemdNZW8wcGdLcWU1SVhSSHpYb296M2sweGVC?=
 =?utf-8?B?Nm40UTFkczd3b0pYWDE3SWZUUnNNM2t5Vnk5T2JhZmtlckZNOGcvdmhqaE02?=
 =?utf-8?B?cjJlTzBFRHkxL0JXaEx1RzhsTkh1WGFXU0xoeGdwcGgvdkNkRFk5dUVxNFhB?=
 =?utf-8?B?MGR2UGVISEhiWnNKaFhxbHUyYnV3ZmNxSnB4UFpsNHY5eXZMUEQ0NURxcWYz?=
 =?utf-8?B?TjhHd21xSVpuSk9EREd4U1hEN1k2Z2tFaTZ4dldpVGJaSFJkN1FvWWhiekZZ?=
 =?utf-8?B?M2p1T2paWkFBYXZZNHZHbmRZNlFnUklTWW1PNzc0Mk1nUC9TUGJqQjB4TVRa?=
 =?utf-8?B?MTc0UnlGeE96UkNhZDFPRGVEejdPZ0g5S3hOdXkyWWpVYWlReTFHZURubUhP?=
 =?utf-8?B?aSs1VjBveTRMaEJuZTc1bm9TSU5VL2hydk9pWlVMd21URytmODYrU0VQM0Va?=
 =?utf-8?B?NEZkWFRWSHNDRVdIVzhicERkRW5SY3VjSTZRZXpMbmJCN1ZDd2RWejhMMEMx?=
 =?utf-8?B?ZGphUU5lUHR2ZmwyL0hDQ3FPSEpHSVlhTDM1VXpFdGxCVlBSd1cwTWZvd1lm?=
 =?utf-8?B?aXJHRHRXVStBSTRqL25yWmpIbkl3NWNWWWZMcldZa1JERHVNNlM0VWZlYm1l?=
 =?utf-8?B?dUpFVlJjenpxSmNUR1NaaEp6WjZtMno0anpidW9qMVhzTllLL0M1Rm1hY1Uw?=
 =?utf-8?B?UEVyaS83WUhOMGZwbUtkdVljWmpTNytXWVpkRS9mb1RCbVNHQ1RTOFJGSS9E?=
 =?utf-8?B?NjhmQzJYQTNqMEthNzVJYnRHK2VIRG1tVENKOVhWR01Rc3JEZ2xEUmRwK3FC?=
 =?utf-8?B?TXUwSTJrWm00ZWozeGd6Z1dyVTc2dWwvMWI2VWlIRHdmUzE0MlBrYnZoelJi?=
 =?utf-8?Q?4TJfXZoyM9pAb3dv/WdnyARgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4640b253-9ef6-452d-afe3-08dc5eaa7e76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 06:49:14.0158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRIS9Fd/FD0TRO7OkFiS6FBuIagMaGl/ERlQXiJINwUcwPK37V0SKRfmifTwjIHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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

Am 17.04.24 um 08:21 schrieb Arunpravin Paneer Selvam:
> Now we have two flags for contiguous VRAM buffer allocation.
> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
> buffer's placement function.
>
> This patch will change the default behaviour of the two flags.
>
> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
> - This means contiguous is not mandatory.
> - we will try to allocate the contiguous buffer. Say if the
>    allocation fails, we fallback to allocate the individual pages.
>
> When we setTTM_PL_FLAG_CONTIGUOUS
> - This means contiguous allocation is mandatory.
> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>    and check this flag in the vram manager file.
> - if this is set, we should allocate the buffer pages contiguously.
>    the allocation fails, we return -ENOSPC.
>
> v2:
>    - keep the mem_flags and bo->flags check as is(Christian)
>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>      amdgpu_bo_pin_restricted function placement range iteration
>      loop(Christian)
>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>      (Christian)
>    - Keep the kernel BO allocation as is(Christain)
>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>      RDMA cannot work with scattered VRAM pages(Philip)
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
>   2 files changed, 50 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8bc79924d171..caaef7b1df49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -153,8 +153,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
> -		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> +		if (abo->tbo.type == ttm_bo_type_kernel &&
> +		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +
>   		c++;
>   	}
>   
> @@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   		if (!bo->placements[i].lpfn ||
>   		    (lpfn && lpfn < bo->placements[i].lpfn))
>   			bo->placements[i].lpfn = lpfn;
> +
> +		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> +		    bo->placements[i].mem_type == TTM_PL_VRAM)
> +			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   	}
>   
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

Nice work, up till here that looks exactly right as far as I can see.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 8db880244324..4be8b091099a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -88,6 +88,29 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
>   	return size;
>   }
>   
> +static inline unsigned long
> +amdgpu_vram_mgr_calculate_pages_per_block(struct ttm_buffer_object *tbo,
> +					  const struct ttm_place *place,
> +					  unsigned long bo_flags)
> +{
> +	unsigned long pages_per_block;
> +
> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
> +		pages_per_block = ~0ul;

If I understand it correctly this here enforces the allocation of a 
contiguous buffer in the way that it says we should have only one giant 
page for the whole BO.

> +	} else {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		pages_per_block = HPAGE_PMD_NR;
> +#else
> +		/* default to 2MB */
> +		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
> +#endif
> +		pages_per_block = max_t(uint32_t, pages_per_block,
> +					tbo->page_alignment);
> +	}
> +
> +	return pages_per_block;
> +}
> +
>   /**
>    * DOC: mem_info_vram_total
>    *
> @@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>   	struct amdgpu_device *adev = to_amdgpu_device(mgr);
>   	u64 vis_usage = 0, max_bytes, min_block_size;
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	struct amdgpu_vram_mgr_resource *vres;
>   	u64 size, remaining_size, lpfn, fpfn;
> +	unsigned long bo_flags = bo->flags;
>   	struct drm_buddy *mm = &mgr->mm;
>   	struct drm_buddy_block *block;
>   	unsigned long pages_per_block;
> @@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (tbo->type != ttm_bo_type_kernel)
>   		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
> -		pages_per_block = ~0ul;
> -	} else {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		pages_per_block = HPAGE_PMD_NR;
> -#else
> -		/* default to 2MB */
> -		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
> -#endif
> -		pages_per_block = max_t(uint32_t, pages_per_block,
> -					tbo->page_alignment);
> -	}
> +	pages_per_block =
> +		amdgpu_vram_mgr_calculate_pages_per_block(tbo, place,
> +							  bo_flags);
>   
>   	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>   	if (!vres)
> @@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;

And this here just optimizes it in the way that it says try harder to 
make it look contiguous.

Question is if that also works with pages_per_block of 2MiB or does that 
only kick in when pages_per_block is maximal?

>   
>   	if (fpfn || lpfn != mgr->mm.size)
> @@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   					   min_block_size,
>   					   &vres->blocks,
>   					   vres->flags);
> -		if (unlikely(r))
> +		if (unlikely(r)) {
> +			if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> +			    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
> +				/* Fallback to non contiguous allocation */
> +				vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
> +				bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;

Well I would say that this is a rather hacky implementation and should 
be avoided if possible.

> +
> +				pages_per_block =
> +					amdgpu_vram_mgr_calculate_pages_per_block(tbo,
> +										  place,
> +										  bo_flags);

Rather move the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS handling out of 
amdgpu_vram_mgr_calculate_pages_per_block().

Regards,
Christian.

> +				continue;
> +			}
>   			goto error_free_blocks;
> +		}
>   
>   		if (size > remaining_size)
>   			remaining_size = 0;

