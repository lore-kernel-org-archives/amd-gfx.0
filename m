Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB724C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 12:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E52810E7CC;
	Thu, 26 Oct 2023 12:37:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8C210E7CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 12:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCrdmDJXVP0ZZ6ZYYILCRGzb6GcIVGQ8GXLoXcebYDy7YherXT/d9eR8MZ5Z41vOc+QKp0+Fylrp/gYfxsmu4IVQOkDthyeyPb836EwtvTf5XNWPa/QDxp74B9raRHK2GNk7FpNAys7SkWBiKVqt/+yGR1mpkAjzJS4ogdZEBfEoEN01mi/G5i2+ycJoTUewxt0NS7qJP6ghAi4v1GwqKY0h3QlWZgQ54KSmD3FOrFSskbvq0HVIU4Rm5doOVm1HlBpzHYAHAZskzEdACU7OCB90KjpfYSgLu//LtzHB4qvdL7lm4YWsVvftQ3CxEI+imVuXjeCDrfe/LAuKT/Sh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2+PR6DyBIv2f8slwV25y7g4B2eV1hKnIF2VaN3yQq8=;
 b=gnPf4BpNGH2r0DW17QvRzci1gHWbJsSqlLY7PcmJ2W1lio2+JlfeSDifnQCZgEbcoWugw9cTwBZTd32KLiFubzGif06xh+Ax+lHwiwTQs6O8htcXAqhMBFzN7n0VaNbXlzyLAF73QSLYmLTp1eYVTU1TRBqN6AlCH4hF+NtKPbIK9Q2zmPwDi5+7CuLWRQI2jJ2+nnCVEqrRiESiQZpgUtxjLl+KlB/+TsiI37KdvHLbCXF3StwIV2FLCB5CFCAIsSlE6s7Gp8Aob+0kWMsgIcDLdR4yiuMfL0lrKAJSjvlO2C+iWGPxTNUj1AfquaLv5t5DwCOobr2ObQJ20Pao8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2+PR6DyBIv2f8slwV25y7g4B2eV1hKnIF2VaN3yQq8=;
 b=ouRou49enwnBby5VCIaHUYxUtWJv79jh9ZMvNWtFLqvDFnJQ8GCVNZpUPvGkw/5IiLz3clo9vbcaIoVU+IfshXPKVp3rqeAOGmUAS/mXMb2lUF0ZKqKVGRx968KZgeSjw2s1UJH/rPAGYj/VeKk6vKy0okXu/lxsZsddZeb24qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 12:37:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 12:37:37 +0000
Message-ID: <ab841ec7-71de-4a05-afd3-dcdcfb007384@amd.com>
Date: Thu, 26 Oct 2023 14:37:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/12] drm/amdgpu: introduce userqueue eviction fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010101752.1843-1-shashank.sharma@amd.com>
 <20231010101752.1843-12-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231010101752.1843-12-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: b7167db7-1d5c-4279-33f0-08dbd620563c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2BJJuAJuZWV6YJGcnndeX3hvUy9l63w40O4/212Wqvpa7S8qo3P+RGyG57gOZdaqXd1Z10xCytYCKYfJs3Q+QwRZ3UolVt94H9/MjjSVnRxYSXvxF+q5tT8zNwelA3Te0Wo6RxZcXuKd+MhCEZGTX7vrxL95zjR7OBO5G010IHF9Z473jdT9i4sJ1DHzl3G9hAlUbUbrHhFR9znLKzY3VHHt/Juv4fS0eHJDf9jcXAKHmSt0ZHk5MuxHjZFML27EMwf/cPmN8ZUyX/RpcQpox18Ndqzqg4TJ3TrUHozajd9CqX5BfPrCpX/PtwYqgShyrCm9M+rDDd/NyTxWJSWqT97rn+OOEAGqVOClQcKNEkWtmQJwLwNMqoGPgtd3zkQzmQQvVJfLTvpoQKvwwevEULCoKHdcqUDR2xxXX9jTWA5oefI3w1gWLHzh4A0Yw5bPfKUiIE21s7HoyCh82p9dIx3nxEI4qrscM7bXkVLHuJ2/TEi74Nifv8mN4UDhweHM/pPZoy7Bu7zb2xq+bYMoM9oxk3+2rB1ayYd4kzJ/ZDO5Si1l/8UebGvBb5AtZhG51JOVQ3UJnBWJ2XAeY0Zl8CBEcStTMXmQQNlXfcVavsv7iOhtT3xvhVqmuG0HRtAvSCshGbqAfamlfZAUec8hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(8676002)(8936002)(66899024)(4326008)(6506007)(86362001)(26005)(31696002)(66556008)(54906003)(36756003)(66946007)(6666004)(316002)(6486002)(478600001)(6512007)(38100700002)(83380400001)(2616005)(66476007)(5660300002)(31686004)(2906002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BJRXlsSTNDcmsxVWE5N3lxdTlCN3QwMnN5cGxIaEcwM3FsdWtDSWUwYXhx?=
 =?utf-8?B?UmNCWnM4SVRsUmpiS1F2TWIrdmVMdFpPTFFRd2VOQTgrNUNpdkNiZWQ2WnZE?=
 =?utf-8?B?VTYzZ2p4dUdONGRLRGthdndBU3lrR0lHT2laV2s5TmsvV0hBMXBjMEhYTUlp?=
 =?utf-8?B?enZGblZyZmd5Tng0WVhyd3laZjJrMGZvbXJxWC9OTGlYdTRLejVTTUVnNVl2?=
 =?utf-8?B?UXFrcHAvbE5qQ0N6eXg3ZW1xVERxN09xY3lNNXRTQWYwQVhMRVkvSG5DRFVK?=
 =?utf-8?B?Q2xEeVBNUVVjcVFpby9vdGtHQXlFWFZocFNUcGd6c1IxNWtTanM0Tks5U25G?=
 =?utf-8?B?N0hxMGpUUkdGOVByeklqT1Z4VXNsbzdQVkdqcldqMWYrK0ZlaldEMWUxWHFo?=
 =?utf-8?B?ZEI2ckdNZ2FUOTBWTGVGRW1SK0FHS1FzMDZYRjVCSjdaM1lEem52c0NZa2ZW?=
 =?utf-8?B?Vk83bFd1UklVVWxkWVBLTjRNZittMmRraTB3UjhZZEZnbmh3SzNNSTBiSnk4?=
 =?utf-8?B?c1dyL3lzR1pGNm1Kb1JNOC9wSE5MZGo4dE9LQS95RnNoYUpDbDdiRXFjbnUx?=
 =?utf-8?B?TGJxdkdwRjIyZ2pyZEhoSDNYMUFpUndkdnVPejhQZm16VWR4RkkrdytuR3BF?=
 =?utf-8?B?VWFxNWlGbFBGU1NSVmV2aDgzRk8zN0R4ZG5YTkNBTFptS1dPSFMvZStVM0pp?=
 =?utf-8?B?YlB4dGFBakpFSUVZUndnVVlBaDZoc0JiMTFXK3BpTzJPSFVaQVE3cGhpclZY?=
 =?utf-8?B?azRiZHVUSE92cFZsTUtRQmtrL2hXRUhBWlNqaENpTzNvY0RscUhxbCtybHlk?=
 =?utf-8?B?RTIxeDg3N1hhSG9hdUFVdWc5Mml5WjZteGNmSDBET1FjMFlJUC9uTjhOaHRi?=
 =?utf-8?B?V0sxR3dCQ255K2lRQnptcHdzWnh6VFBKSlVLK25JNGVGd0tRZVJRenpwS1Rx?=
 =?utf-8?B?UUhBL2Q5YzFZd29sNjFyai9sUVFkOFJ1YXVSeDdoN2ovcDZDeDE0aFNVSmx5?=
 =?utf-8?B?dXQvM2k3a3BCSXNnWUQvdTdIMFZRKy9vWTg4Q3VtNUFGOE1TOE15RlJOTXRX?=
 =?utf-8?B?WStRS1dIUHJGaDBBUWxZVXpTYXl0N3VsalovUElKUzBIeDJBa0FkWWlNb0M5?=
 =?utf-8?B?S2hBMEpvM2p0bkp0ODhEcGtpeHVXOW1MWDVVVE9pSHNkYUFRdUI4SE8rTEQ0?=
 =?utf-8?B?UGUyUW9MS3FFa3Z0WXFBT2owN1JuZDNsYUZzRzY4bDIzZnhIWVBZQjIrNXIr?=
 =?utf-8?B?aUdRdExFTDJ5OCtmcFJqVG1OUWIwKzZ4QU5IVklCWjhsdG9MWVpkV0hibjlI?=
 =?utf-8?B?eGdLa2hQU3F3VWs3OHVuVFJaVmt2cUt5WG1IWXlnWnV4Qi9CN215NU9MWTZl?=
 =?utf-8?B?NU9CVVhvUUx5TjJpeHVBamlwUE5GODZsTndkbW82emNxQnhmTGFtenh2Z0N0?=
 =?utf-8?B?K2lHazVpMnVERmVRc0NDZnZXRzJ5SW5pb1pkWjhBYTBvZzFmMDRrbFQ4Wmds?=
 =?utf-8?B?YWtQTThjeGFOYm81Z3M3dWlBZklrRWF1VnVwNFdYNW83SHFUSzQwa2VxYTN6?=
 =?utf-8?B?TGdUY3A4M2Q4dmRrYXI4ZjJHL1RkWGM4Y3p1bTM1KzhhTWk4aFFkV1c5Tzhw?=
 =?utf-8?B?ZE5mbE1QU2R2cmcwUGRnTGVmV01YaEdPMUhhV2o0ZlVYbEEvV1RKV1RWWWVw?=
 =?utf-8?B?WXFrd2R3Ly83NDNoMEZvOEMycmhHcnF5eG9aaVVLWDQrMWdKSTh0YzJKNXRO?=
 =?utf-8?B?bGpGZTFSSGlQMXNhVHRuWThoZjQwRzhaRmowVkg0UlVma2ZVL2pIRmVQdEpq?=
 =?utf-8?B?UDU5WGVnQ0FyR2lSbFkyVDJhUldDdEEyZE1sYzR5SFJ4a2llWGtvNU9GNjVq?=
 =?utf-8?B?c1B0UzIyb2NRN0RYRjFCWUIrbEE5VGdWTmpnczVXN0dRZDdNNEFhNkhIbkU3?=
 =?utf-8?B?aGUyc3BFZnd5N3MvaGUxc01DMkxncWRBMDNRQ0JEUWQ4Uk5SamZLRkN3TXBi?=
 =?utf-8?B?ME53UlZ1SEluazM0YlpjSytpSkZxTFZBQ3RIaWdIQ3ZaSmRMWlNMMWxKT05E?=
 =?utf-8?B?eG1CanR5bUdVSFl4YjV3czVTMXhadmtIQktvZkJoOXBTVWxnNDRWSHVZMHRH?=
 =?utf-8?Q?oTj0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7167db7-1d5c-4279-33f0-08dbd620563c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 12:37:37.8974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBPOLE/+0m1Zl8u4t+nfV52CrTK+ZuK9J61LJ5RiBREiXshmHIgi57T3GGVw6eFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.10.23 um 12:17 schrieb Shashank Sharma:
> This patch adds support for userqueue eviction fences. In general, when
> a process wants to map VRAM memory but TTM can't find enough space, it
> attempts to evict BOs from its LRU list. This fence will prevent the TTM
> manager from evicting the process's BOs from VRAM.

Maybe write that the other way around. The eviction fence unmaps the 
userq when memory management requests it.

>
> The general idea behind this is:
> - Eviction fence is initialized during the uq_mgr init and saved in
>    fpriv->uq_mgr.
> - This fence is attached to every userqueue object (MQD, ctx, doorbell
>    and wptr) in a shared way, during the queue creation.
> - The fence is signaled during the queue destruction.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 82 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  7 ++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 15 ++++
>   3 files changed, 103 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 6bae014b248e..26cdd54acd74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -21,7 +21,7 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> -
> +#include <linux/atomic.h>
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_userqueue.h"
> @@ -45,6 +45,66 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>   	return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static const char *
> +amdgpu_userqueue_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "amdgpu";
> +}
> +
> +static const char *
> +amdgpu_userqueue_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *ef = container_of(f, struct amdgpu_userq_fence, base);
> +
> +	return ef->timeline_name;
> +}
> +
> +static const struct dma_fence_ops amdgpu_userqueue_eviction_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_userqueue_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_userqueue_fence_get_timeline_name,
> +};
> +
> +static void
> +amdgpu_userqueue_init_eviction_fence(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_userq_fence *fence = &uq_mgr->eviction_fence;
> +	atomic_t seq = ATOMIC_INIT(0);
> +
> +	spin_lock_init(&fence->lock);
> +	fence->fence_ctx = dma_fence_context_alloc(1);

Not much of an issue, but that should be per userq_mgr.

> +	fence->seq = seq;

Same here, the seq needs to be in the userq_mgr and not inside the fence 
itself.

> +	get_task_comm(fence->timeline_name, current);
> +	dma_fence_init(&fence->base, &amdgpu_userqueue_eviction_fence_ops,
> +			&fence->lock, fence->fence_ctx,
> +			atomic_inc_return(&fence->seq));
> +}
> +
> +struct dma_fence *
> +amdgpu_userqueue_attach_eviction_fence(struct amdgpu_userq_mgr *uq_mgr,
> +				       struct amdgpu_bo *bo)
> +{
> +	struct dma_fence *ef = &uq_mgr->eviction_fence.base;
> +	struct dma_resv *resv = bo->tbo.base.resv;
> +	int ret;
> +
> +	ret = dma_resv_reserve_fences(resv, 1);

That should usually be done while locking the BO and not later on.

The problem is that when you have multiple BO where to add the fence to 
you can't risk adding it only to some of them.

> +	if (ret) {
> +		dma_fence_wait(ef, false);
> +		return NULL;
> +	}
> +
> +	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_READ);

Please use DMA_RESV_USAGE_BOOKMARK for this.

> +	return dma_fence_get(ef);

Why do you need to return the fence here?

> +}
> +
> +void
> +amdgpu_userqueue_signal_eviction_fence(struct dma_fence *ef)
> +{
> +	dma_fence_signal(ef);
> +	dma_fence_put(ef);
> +}
> +
>   int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
>   				   struct amdgpu_userq_obj *userq_obj,
>   				   int size)
> @@ -88,6 +148,13 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
>   	}
>   
>   	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
> +	userq_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, userq_obj->obj);
> +	if (!userq_obj->ev_fence) {
> +		DRM_ERROR("Failed to attach eviction fence to FW object\n");
> +		r = -EFAULT;
> +		goto unresv;
> +	}
> +

We don't need to keep the ev_fence around here.

>   	amdgpu_bo_unreserve(userq_obj->obj);
>   	memset(userq_obj->cpu_ptr, 0, size);
>   	return 0;
> @@ -103,6 +170,7 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
>   void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   				   struct amdgpu_userq_obj *userq_obj)
>   {
> +	amdgpu_userqueue_signal_eviction_fence(userq_obj->ev_fence);
>   	amdgpu_bo_kunmap(userq_obj->obj);
>   	amdgpu_bo_unref(&userq_obj->obj);
>   }
> @@ -140,11 +208,21 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   		goto unpin_bo;
>   	}
>   
> +	db_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, db_obj->obj);
> +	if (!db_obj->ev_fence) {
> +		DRM_ERROR("[Usermode queues] Failed to attach eviction fence with db_bo\n");
> +		r = -EFAULT;
> +		goto unres_bo;
> +	}
> +
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj, doorbell_offset);
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>   	amdgpu_bo_unreserve(db_obj->obj);
>   	return index;
>   
> +unres_bo:
> +	amdgpu_bo_unreserve(db_obj->obj);
> +
>   unpin_bo:
>   	amdgpu_bo_unpin(db_obj->obj);
>   
> @@ -171,6 +249,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   
>   	amdgpu_bo_unpin(queue->db_obj.obj);
>   	amdgpu_bo_unref(&queue->db_obj.obj);
> +	amdgpu_userqueue_signal_eviction_fence(queue->db_obj.ev_fence);
>   	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   	return 0;
> @@ -278,6 +357,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
>   
> +	amdgpu_userqueue_init_eviction_fence(userq_mgr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 33de65a0d974..e68320b4c689 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6469,6 +6469,12 @@ gfx_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>   		return ret;
>   	}
>   
> +	wptr_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, wptr_obj->obj);

Again you don't need to keep the ev_fence around here. The dma_resv 
object will keep the reference.

Looks like a start, but quite a bunch of stuff to do.

> +	if (!wptr_obj->ev_fence) {
> +		DRM_ERROR("Failed to attach eviction fence to wptr bo\n");
> +		return -EFAULT;
> +	}
> +
>   	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
>   	return 0;
>   }
> @@ -6650,6 +6656,7 @@ static void
>   gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>   {
>   	gfx_v11_0_userq_unmap(uq_mgr, queue);
> +	amdgpu_userqueue_signal_eviction_fence(queue->wptr_obj.ev_fence);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>   }
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index a653e31350c5..f1e3d311ae18 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -33,6 +33,7 @@ struct amdgpu_userq_obj {
>   	void		 *cpu_ptr;
>   	uint64_t	 gpu_addr;
>   	struct amdgpu_bo *obj;
> +	struct dma_fence *ev_fence;
>   };
>   
>   struct amdgpu_usermode_queue {
> @@ -57,11 +58,20 @@ struct amdgpu_userq_funcs {
>   			    struct amdgpu_usermode_queue *uq);
>   };
>   
> +struct amdgpu_userq_fence {
> +	u64		 fence_ctx;
> +	atomic_t	 seq;
> +	spinlock_t	 lock;
> +	struct dma_fence base;
> +	char		 timeline_name[TASK_COMM_LEN];
> +};
> +
>   /* Usermode queues for gfx */
>   struct amdgpu_userq_mgr {
>   	struct idr			userq_idr;
>   	struct mutex			userq_mutex;
>   	struct amdgpu_device		*adev;
> +	struct amdgpu_userq_fence	eviction_fence;
>   };
>   
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> @@ -76,4 +86,9 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
>   
>   void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   				     struct amdgpu_userq_obj *userq_obj);
> +
> +struct dma_fence *amdgpu_userqueue_attach_eviction_fence(struct amdgpu_userq_mgr *uq_mgr,
> +							 struct amdgpu_bo *bo);
> +
> +void amdgpu_userqueue_signal_eviction_fence(struct dma_fence *ef);
>   #endif

