Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47244EEB569
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 19:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F8010E14E;
	Fri,  8 Sep 2023 19:30:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197F510E1A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 19:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEN1fDVFO+6NMU7nPqZI5++SeSLU1uXwWhOaNECOvG87DmCjZA5DM0f5U0qQyKxAebLeLWGCDOtdwvuskg6FQXfRmh9cBQR6feW8P4uuMccD0u+YGL0FUcSsG0ZQOridJ/1N6JW3HewVusJkC9HgTkevPmMpPNK/8rkc7PL7D1FbscUSx+9/Ehv2HP7mKvLgrqHuhSU+D9GnZpcrIQZvrKg60JStHStWZnp59E3EsKwdWcp3vvvBHWGykcybGeMYn7iIBolEcTx7mTRo5FWlaR1uDgNnHu0T9nkgmF//Pm+GS3VjdnOA+4TvWz9on0Fy/76cS5TAOZuC8BfIMQ2y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8aSOFnrGm4N4hdUL7orbkHyAH5m5P/ELGwk9jVc8BU=;
 b=l5prmMrgcScCy3qUASGgMWTCZt/EwiElAGan4kHg/cR+PJFj/Fv2Z4ilYSXtOMRRU7kEf8OfOT4ELU6SGbDYq/VJ5WF9p1eLaDgE0HW0u1h60WvcscTfD2NC/MFnbgbJ2gSgdWXscGjlt2Osy0IX2QwD4B5KnqUaQpaJThHe2jNwoto6O4uJY+x5GeF7LNGYVkq6mqtzKuWOSqcqQdWPZvy6RFRIKUnzy0/7ewE0JF5nJqgXW3RCPFYSu+cAWVQc71MDvwdGnSPbzYoRfuduQeb+JKAAhdWvhn9+6Uy4yYfsEYZFZZJ/fOI0g5fIvH3tqZRZi21l3mWP6/XbHGlIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8aSOFnrGm4N4hdUL7orbkHyAH5m5P/ELGwk9jVc8BU=;
 b=TvvlTv+dxWJm6JkZ9C5TVDKfRW19oMxTzc8ce84/7pDp3XaR/R+o1iaUQ4YTJmWakIU3XksuxolxflblXwjPZwEO3sHkgBmnN/SIZQAeBfSD7l4ktfwPUq79vAhOp4df0D79X82QHkcGkbg4sxKGM8+ZMwoN7EyxkqBp913Qlmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 19:30:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 19:30:33 +0000
Message-ID: <bd980fec-3844-1338-7ef1-20c41481e33d@amd.com>
Date: Fri, 8 Sep 2023 15:30:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-3-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ad3a83-62c4-4f92-d4d2-08dbb0a21200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFWSAeZceFxapSp0IhT7/SJEjKJnLntP8laWEMMVPYxWyt+5dwSCLKl66HOZOucZpASOVFVBfhZiSGSGsoTtY1l5mZ1olIbeB2j8wfe6Oi+WPwGO9455tdhZHtQEfXp/5oGTBEFBmZVH/4AKPfidbMmKkht1O9xZz6rrAJ1k+SdIgbP2DuwAoj2Wgw6C4lbHACHfBigLXF6gsUATnpIhRqvce+dFi0fOhY1daglJz5UAWqDcNapqozc+Uw/YBHYnr2Ogui0FFzoHGc275cKW/U8zPslmfu2QDXEd7GFGROdH0DVurHz55DHZ/OL3gfg4Q4aUDDuKmIav5c7AHl9QPQJwfWNyRv4n9gEFWJ96ZZdJPIJOWR9zsYzXQZcYW0TZSJ3+A7YvU/rWr4/zBoKEF8uU+ppAlWppDM5EgxeclNcYXEQGHm/bI04PzePtizpPzQhVMoEAkRZlNNlVr9J7ppyUK6uyYO8gu3+D3Uth8e2P0sfHDLTd2e1C3wY2yTIg4JDek0ROv+Z6SQcg4jl6ImGGFhRqYxHhkeSPLnUB78BqKQScickRIoErY+jRkl7J/ISFYetHwNw+9n4FqMHR9AH9qupN2MCwYV0gWpMPX3I87wpjhwn/TVUpEJrjVtQSE+Nm6dd62zCUy0KhilE5Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(66946007)(66556008)(44832011)(5660300002)(4326008)(6486002)(8936002)(8676002)(6506007)(41300700001)(66476007)(316002)(30864003)(31686004)(2906002)(478600001)(53546011)(36916002)(6512007)(2616005)(26005)(66574015)(83380400001)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllCSzl1Wk1YOTFvMzN5NGw5bmRnS0dyYk1mdUpyeXU0c1JaMUVGaE1peE52?=
 =?utf-8?B?WVMyc1VDQXowbVNqbWVJSTlCeitRMjFOM1NiTDJDanB4N3ZYVnEwUFlqVXJk?=
 =?utf-8?B?Q2MvcjArM3hTUnZxbXpqWTJzSlp4bkhOenp1WVc5Z3c3YkRuWkJJT3BlWWE2?=
 =?utf-8?B?NlVaQk04YmlNT3JlZ3BVbHRHNzBma0xaQ1JBRkIxZXREelVBMHJzTGo2T2RZ?=
 =?utf-8?B?NDdlbHZ0b01kUEk1emUwaUY4WndLeXV4TmtPeXB6N1VIVmJWWU84UTN0ZlVl?=
 =?utf-8?B?OUEyNUVaQnpuMk5OUFpjZmZSZzZRU1RHSVRxN2Y4MWdxREFkcXdpMkFlaEhx?=
 =?utf-8?B?VzE3VnBlQ0kvY1Z4VTViQWJ0ZTd2TGlva0lQRkZpbk5NdktLcXA4ajVKeXRq?=
 =?utf-8?B?cWxpVW81czlhb1JpRkp1QlpmM25KdlEwRXZJV0h3YzhtdEJDNjhoU3UyMVdZ?=
 =?utf-8?B?eDVMeEh0NEV5ZWRkYzdXS09qOTAzcUhQakpqU25sREsxWmxtaVlOZVhzWDBY?=
 =?utf-8?B?elFzaWZxQXhyZjErYW1XZWJBWDhsM2ZqTUhPeEE4ZWM2YnRSMndkSFhLSjZT?=
 =?utf-8?B?N3Vob2lxNFJrbUhnR1FmNzdjZElBZ3Y2Mk5HM0lVaElpNFpGamprbmx2SWd5?=
 =?utf-8?B?NXg4MmZGYWdmdjlKWFlxQnR6TElDbjRiUE5UQkhsdmhWWXVXeXJvdzRHTUpk?=
 =?utf-8?B?bkxQT0FwdHNrOHU3Mm1IY1BYU2s0UGc4Nlk5SHRPNjlBNytEU1g0anV6K1BB?=
 =?utf-8?B?bDdtT2p5Rk40cHhJT0lxYWVMcmhQTm9sZkF2VU9NdUNYRFRHc0w5YzVTL2dD?=
 =?utf-8?B?bzFhK2lLSzdlQnFvRituRld2S0xhV0VTaFdaSGF1SUozNWtIRFBaYm82Zmdl?=
 =?utf-8?B?d3BXNE16QWY0U0hPTk14OEV5K1NubWFkczZLYUpjT3AwMGJpWGNSS3hBdXNJ?=
 =?utf-8?B?eXZKNXhWZXF5cDBjSzBNYTVmeGlLUnNpMU5OS2F1MmlKOFhxcXAzbk0vTWUr?=
 =?utf-8?B?M0lHbWYxQzVNVmdldGs4eDlXbHA0YVJFM0Vnak1vZkFNU2wzM3ZRZmNzMURj?=
 =?utf-8?B?SzdXSE00KzFQcGtmcE02OWJQR3J5emxjODZmLzJTVEg0bkp2SXVBSkpjV0J0?=
 =?utf-8?B?SHFuNS9BNEg2bnF0SlVKNUwyZWs1M09HTjdHWUE4ZFd0MWpXaHRPRE05cnNh?=
 =?utf-8?B?c2ZDZlBCYWRuanMrc2c5ckdIKzFXbXZXYmcxdjVPWHRSZUhBUVBmdUJDTVJO?=
 =?utf-8?B?Yytocm5aTmZSUjB4RktqbS9LcGdUK0h5YUdHVDJ5T3NLRmdwR2pFMEptZHBz?=
 =?utf-8?B?UlA2L2FFcngvMk9vTGxrakhaR1pBbW9zUDNmay8vK0grWUhzTGZLZkc4TkhY?=
 =?utf-8?B?QkRJbnZ0VDZTMzhqY1NxUjhsendBSkM2TVZZZXFhVWdZc3NjVEpTcG1iSmFy?=
 =?utf-8?B?anFkQ0NuVjVRdHo0clhlcWdoVW5xa2kxaXk4bkM3QU9zbHRmZ2xrcC9GN3NX?=
 =?utf-8?B?NUI1dTAweitLaEU1QnhVNnpEeXpueERsVzhYRExveFEwQ2VMQTFkSFZ0Nk5S?=
 =?utf-8?B?VFRZcmEvS1psNEJGWTZOc3M4WEFUd0d5WnhnTTRtME5rTE40ZFc1alBtMEZ1?=
 =?utf-8?B?YU45K2dRcnhCWXhZeFNnUm1ZM3hHVlc5Z2ZjVCtpNUtDbjBQUmFqdlBNbjcw?=
 =?utf-8?B?Y2paQ08xbzhtZWpXWjgvWlRZTTQxdnQxdWxzRm1vOERoOFBzdGpKYVNCZktC?=
 =?utf-8?B?TEdOWUpqZkF3Nkx5WTMzYjVlY1F1Y2tpUTZ0UzZvN0Z0ZmRST3ArSUVwZ0dI?=
 =?utf-8?B?RUdUdTgzZ3d4aFk0ZjNOc0I5MmFpdVp2L1NlOURjYWZQazdzcVZWamdPRUR0?=
 =?utf-8?B?bWdWMjQwc3picnVMRDRHVHhFbElRU3pBMjVKdG1KQjRvRGRpTlRpTzJEN0o2?=
 =?utf-8?B?OVBHRVVacEVRUVpjRjdkdW5QcVd6RnR1dDcxRnZTcXZMRVFPVFhKcXFucmFV?=
 =?utf-8?B?SFdxcW1EcGtOa3cxbTh1UXNJSXlyV0wxL2hONGU4NmRkcHRTU3FxQ3VxTVox?=
 =?utf-8?B?WXVVTzZpTHk0dE9NY2FsY0ZvVXEyUjhqZFNvOFI4elhqRElaNzdVckFiRlNv?=
 =?utf-8?Q?g3L9X7UgDNHpJF9JtrmtJfivz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ad3a83-62c4-4f92-d4d2-08dbb0a21200
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 19:30:33.7783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycmwqQrsASRHLmIdyuHbx9ZwBthTV/NfSWXTK7xdKOFNzVg0rujXyUikK4zNZD7cHMOSxh3OYCKrW27PBKr2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-05 02:04, Christian König wrote:
> Move the SDMA workaround necessary for Navi 1x into a higher layer.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 159 ++++++-----------------
>   4 files changed, 97 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d78bd9732543..857051093900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -575,6 +575,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> +			      uint32_t vmhub, uint32_t flush_type)
> +{
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	int r;
> +
> +	if (!hub->sdma_invalidation_workaround || vmid ||

The "|| vmid" part of the condition is new. AFAICT, the workaround was 
applied to all VMIDs before this patch. Is this change intentional?

Regards,
   Felix


> +	    !adev->mman.buffer_funcs_enabled ||
> +	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
> +	    !ring->sched.ready) {
> +		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
> +						   flush_type);
> +		return;
> +	}
> +
> +	/* The SDMA on Navi 1x has a bug which can theoretically result in memory
> +	 * corruption if an invalidation happens at the same time as an VA
> +	 * translation. Avoid this by doing the invalidation from the SDMA
> +	 * itself at least for GART.
> +	 */
> +	mutex_lock(&adev->mman.gtt_window_lock);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
> +				     AMDGPU_FENCE_OWNER_UNDEFINED,
> +				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     &job);
> +	if (r)
> +		goto error_alloc;
> +
> +	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	job->vm_needs_flush = true;
> +	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
> +	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +	fence = amdgpu_job_submit(job);
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +
> +	dma_fence_wait(fence, false);
> +	dma_fence_put(fence);
> +
> +	return;
> +
> +error_alloc:
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +}
> +
>   /**
>    * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>    * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index fdc25cd559b6..9e7df2f69123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -117,6 +117,8 @@ struct amdgpu_vmhub {
>   
>   	uint32_t	vm_contexts_disable;
>   
> +	bool		sdma_invalidation_workaround;
> +
>   	const struct amdgpu_vmhub_funcs *vmhub_funcs;
>   };
>   
> @@ -335,7 +337,6 @@ struct amdgpu_gmc {
>   	u64 noretry_flags;
>   };
>   
> -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
>   #define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) \
>   	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
>   	((adev), (pasid), (type), (allhub), (inst)))
> @@ -401,6 +402,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> +			      uint32_t vmhub, uint32_t flush_type);
>   
>   extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>   extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index a041c6c970e1..8521c45e8f38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -471,6 +471,9 @@ static void gfxhub_v2_0_init(struct amdgpu_device *adev)
>   		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
>   
> +	/* TODO: This is only needed on some Navi 1x revisions */
> +	hub->sdma_invalidation_workaround = true;
> +
>   	hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index fa87a85e1017..1f70c57bcd69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -230,20 +230,49 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
>    * by the amdgpu vm/hsa code.
>    */
>   
> -static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
> -				   unsigned int vmhub, uint32_t flush_type)
> +/**
> + * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
> + *
> + * @adev: amdgpu_device pointer
> + * @vmid: vm instance to flush
> + * @vmhub: vmhub type
> + * @flush_type: the flush type
> + *
> + * Flush the TLB for the requested page table.
> + */
> +static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> +					uint32_t vmhub, uint32_t flush_type)
>   {
>   	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>   	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
> -	u32 tmp;
>   	/* Use register 17 for GART */
>   	const unsigned int eng = 17;
> -	unsigned int i;
>   	unsigned char hub_ip = 0;
> +	u32 sem, req, ack;
> +	unsigned int i;
> +	u32 tmp;
>   
> -	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
> -		   GC_HWIP : MMHUB_HWIP;
> +	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
> +	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +	/* flush hdp cache */
> +	adev->hdp.funcs->flush_hdp(adev, NULL);
> +
> +	/* For SRIOV run time, driver shouldn't access the register through MMIO
> +	 * Directly use kiq to do the vm invalidation instead
> +	 */
> +	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
> +	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> +	    down_read_trylock(&adev->reset_domain->sem)) {
> +		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> +				1 << vmid);
> +		up_read(&adev->reset_domain->sem);
> +		return;
> +	}
> +
> +	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
>   
>   	spin_lock(&adev->gmc.invalidate_lock);
>   	/*
> @@ -257,9 +286,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   	if (use_semaphore) {
>   		for (i = 0; i < adev->usec_timeout; i++) {
>   			/* a read return value of 1 means semaphore acuqire */
> -			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -					 hub->eng_distance * eng, hub_ip);
> -
> +			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -269,9 +296,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
>   	}
>   
> -	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
> -			  hub->eng_distance * eng,
> -			  inv_req, hub_ip);
> +	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to be cleared
> @@ -279,14 +304,11 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if ((vmhub == AMDGPU_GFXHUB(0)) &&
>   	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
> -		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
> -				  hub->eng_distance * eng, hub_ip);
> +		RREG32_RLC_NO_KIQ(req, hub_ip);
>   
>   	/* Wait for ACK with a delay.*/
>   	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
> -				  hub->eng_distance * eng, hub_ip);
> -
> +		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
>   		tmp &= 1 << vmid;
>   		if (tmp)
>   			break;
> @@ -296,109 +318,12 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>   	if (use_semaphore)
> -		/*
> -		 * add semaphore release after invalidation,
> -		 * write with 0 means semaphore release
> -		 */
> -		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -				  hub->eng_distance * eng, 0, hub_ip);
> +		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
>   
>   	spin_unlock(&adev->gmc.invalidate_lock);
>   
> -	if (i < adev->usec_timeout)
> -		return;
> -
> -	DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
> -}
> -
> -/**
> - * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
> - *
> - * @adev: amdgpu_device pointer
> - * @vmid: vm instance to flush
> - * @vmhub: vmhub type
> - * @flush_type: the flush type
> - *
> - * Flush the TLB for the requested page table.
> - */
> -static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> -					uint32_t vmhub, uint32_t flush_type)
> -{
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> -	struct dma_fence *fence;
> -	struct amdgpu_job *job;
> -
> -	int r;
> -
> -	/* flush hdp cache */
> -	adev->hdp.funcs->flush_hdp(adev, NULL);
> -
> -	/* For SRIOV run time, driver shouldn't access the register through MMIO
> -	 * Directly use kiq to do the vm invalidation instead
> -	 */
> -	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
> -	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -	    down_read_trylock(&adev->reset_domain->sem)) {
> -		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> -		const unsigned int eng = 17;
> -		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
> -		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> -
> -		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -				1 << vmid);
> -
> -		up_read(&adev->reset_domain->sem);
> -		return;
> -	}
> -
> -	mutex_lock(&adev->mman.gtt_window_lock);
> -
> -	if (vmhub == AMDGPU_MMHUB0(0)) {
> -		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
> -		mutex_unlock(&adev->mman.gtt_window_lock);
> -		return;
> -	}
> -
> -	BUG_ON(vmhub != AMDGPU_GFXHUB(0));
> -
> -	if (!adev->mman.buffer_funcs_enabled ||
> -	    !adev->ib_pool_ready ||
> -	    amdgpu_in_reset(adev) ||
> -	    ring->sched.ready == false) {
> -		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
> -		mutex_unlock(&adev->mman.gtt_window_lock);
> -		return;
> -	}
> -
> -	/* The SDMA on Navi has a bug which can theoretically result in memory
> -	 * corruption if an invalidation happens at the same time as an VA
> -	 * translation. Avoid this by doing the invalidation from the SDMA
> -	 * itself.
> -	 */
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED,
> -				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -				     &job);
> -	if (r)
> -		goto error_alloc;
> -
> -	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> -	job->vm_needs_flush = true;
> -	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
> -	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -	fence = amdgpu_job_submit(job);
> -
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> -
> -	dma_fence_wait(fence, false);
> -	dma_fence_put(fence);
> -
> -	return;
> -
> -error_alloc:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> -	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +	if (i >= adev->usec_timeout)
> +		DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>   }
>   
>   /**
