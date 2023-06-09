Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E7C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 13:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4715110E009;
	Fri,  9 Jun 2023 13:33:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B3F10E009
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 13:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI/it600ACvd6cck8RNUKZNWnJwt0ZdHiIF6AVn+nQsJatIJ7ToF+gIjZ67Vh00oqdk42D9tq5ZQ9CHyj1oZqwvgRn+5un/koTGf1xL8SBKHnnUm0GMDYXOfEDz7GLE6fW870NLLw7KU8qG0Igca1pbscWwVL6iGQiOkYw1I98r+pD89klJfMZg7YckxJSdwzaWTIdZ36rlLZBy2biGliTUSClbbqqSiI1r6A32jGqK4aVtGTYSYNxHkC8QpNpiEJ8BT6zf1Iq2GvPQ+GiTIZ/8ZAESXga+KbZ3EYXWbYG7j0DR6c12VHYyZNJmg8tDGSXGhrnn2/8oP1AfE17X0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeKJv1iDJhXQIvWB9kCvgZ9L+bxugBFYII/SUYVnv04=;
 b=JADTOlIF7OVFpjvGaNQW7YGnWsjej2Fnaxi3OL6kp0rXmSwa0zcH4MxZx+NodCiwk2MaBcmR3/gi4/831LT927TA7Vd9NVgGCKpcWX6lBe4RqJ4Jkz8VkoMuJnteGMVL+s4svFc5czMeWr49JOnTKPXRZwUcMn82wzScbMMqy/z8Mh0Q3dC1Tss/np+xkQDCa2xsmOWbZ5QC+VPsfDttHbHRyZLNkV7mFksxv/swYwVgnhzFlIIX0dbkd20rkn9/EZfu36tt2HJ+R8ZnEVImhTMstosQL2G0B6BjeItRRivldif5HALFDGwlbcEvVXnn/3uiuXGjwNJ+dhKW3r6Y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeKJv1iDJhXQIvWB9kCvgZ9L+bxugBFYII/SUYVnv04=;
 b=dwOMCdLlaHgAVAbGpYtu/7S6g7jhMgwdH/2YCrF6u0hbiLpgeelvOPDb/pbl4JOsaeIwUZ8/lfL5btXEXwjxASsvGZb1AntuUnxbA/2dBda36hKKX67nAqnRLF769lO/m+TwjYFDhgZ3OlfoMYHv05hfgH6WcySER46e7Hrhw5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 13:32:57 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6%4]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 13:32:57 +0000
Message-ID: <3633a37c-f9d5-c797-72a5-7ab584277ab3@amd.com>
Date: Fri, 9 Jun 2023 09:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230609100257.900-1-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230609100257.900-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b763dd-ef47-41f7-4b5e-08db68ee097d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xifUx5aHtNqzMkYIwmYSad20KdkC4WeB5ElBk+WzRbGqnRTyHMaze4ptNFl9RRVyU1Bb1yCHuH7U0NLgceaGlVOYx/aM2Oo+ZZsWWzsCtK2InXxEcX2cgvaPtlILX5vaTrrwHm2t+YfRvN/Qjhyvb1eBW0b+jKCmEL2NtVFzSf1f4OPHK5zptCAid37oX8EkoyBquCZmsMA2YjiAHiGg14UEYiwHvcRf6jyeAFdZttWrF5gBkQHnbxhvnirlYlLQ1Lo/Mavq3GChzjz0X+2he4TJe7s5r4H7xyQD33gdzd7t9IKyOwP/wtjDtTDG3PH1oJGl6LMmNDdz5+5SUOiviT3dhY10au+eCBd1yOxmayUmogf4PcFI8hu8C7ZRteV6WNDAz755M6GVMfuIE9ABDfuh34J21up7Yp5RKSOGp/cZ83TQCdN8mLZJcwoJTEsFXzQxw0QDN75V73vr3xLho9Quj+VHbukQLP0iQrRRAzhT044D0E9zD94rPph/ivYa5vO3aZ+n7Tqo/YkjGFB8m/QV1kKmD4bnR+qekNLFgdv2goyQBdknP0fHBOwLGe8oQFrwlaNB7spIm0SoaVQTk9yGgoEJ5EMWDIciSS0M7n3gMdSFZ6JKLfVRqNnrp/38hB5JVf1FBk0T2EQkWe3U1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(2616005)(478600001)(6666004)(66946007)(38100700002)(316002)(41300700001)(4326008)(8676002)(66556008)(8936002)(66476007)(6486002)(83380400001)(186003)(6506007)(53546011)(6512007)(26005)(5660300002)(2906002)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEZYdm12NVZrZU1kMG5DbzA3Zyt5V0dvMXJHTFlQZGhuZ2RCZHJCczhtellu?=
 =?utf-8?B?bHRnTVIwY2lXQW9jd0wwZTdlcDFLRWlUcFRqS0JQbStMbWNuZTVKZzdLQkR3?=
 =?utf-8?B?OXZSMjFhc1RPZlhRR2JwNnNTMEpRQlEzc1F0Q2FEbUhneHdKK1I2WlVIQzFV?=
 =?utf-8?B?TkliTGcydTV5MTVvTnNPYVFJNVk0dFRvNlk3NGYvOGFrSkZsa1FQU2ppN2JL?=
 =?utf-8?B?U1Z4SGFvWDRzM1RQRzFXbEdja0xKc21RenRKQndxT2t2OWVuSHFqMVYrZzNa?=
 =?utf-8?B?R2EzSWxTMXh0S1Jmdm1pWDhtYkZZUVdHcmdmZ2dTOWNwL0JmMGxxUVh3TGFz?=
 =?utf-8?B?UkZmbG9NbStTRTUzOHRGcy9IcitRSHNPY2o2TVFOeUJHRGdudWUzZUVtNnVm?=
 =?utf-8?B?QURzcnNEWFVqYUhHeHY5dXpRVkJBZk1pSUFWa0xtL1JkUHMzQnI2aFQrc2Uv?=
 =?utf-8?B?SU9WN0tCYmhUNThQYWdWckN3WmdBcVVmdG51WktxSGJ5NjdiUzRuY2lJWGNI?=
 =?utf-8?B?a0p2VVBWUlNmb055QkRIaHZWaVJldEM3cHQzdVZuOWZzVjhiTnN5NW96dXp4?=
 =?utf-8?B?SGVZMUVPKzg3NUVuSHd2YXVYMXc5VDg2bXhyRlR3b1JmS3JCTjVSMmJaWDJO?=
 =?utf-8?B?VmQ1ek5uVTNUamV1SU5QbHpJa2lrVU1nVXJaNExPekpydkVJMDJja1lGSnNi?=
 =?utf-8?B?eXRXR2tOOG83cnVkS1ltMitCMDRSd0ZTb3FPTjdHQ0p4bkpEQjVIWjlhWjNJ?=
 =?utf-8?B?bWlzSnFFdVNUMk5MZ2hYMUg1b3hxbzBkV1BhUjNvb1hiS3UyVmZYa3B1R2Q0?=
 =?utf-8?B?TFA0MktIazJySkVtNSsraWw4ZW9FSHlVV2RWVUpWei9HS1dxWEs2NCt5TWps?=
 =?utf-8?B?VmNkUVIxQVViWEpURFM0UkdVTmNMTXBXZS9FTUxldTlvMkVxWXh0dVpobThV?=
 =?utf-8?B?S0ZvZGRMQXJnZlpkZGVYUTJqTC9IN2VXN3RWNHZ6eVRqUmhtcnhxRk0rQTgv?=
 =?utf-8?B?TmxIRnc5azBRQ1FaOVR0NjFrVVdMZkdLa21ZTlZtOFlqOXowc3FVdkNxWUcz?=
 =?utf-8?B?S3dWbTR3TTc2alpsMmRQNHNoa29scExWUUgzbWxXUWdERGJRR01PT0JXdU41?=
 =?utf-8?B?QnI5dnFMRVRHM25aWHhIM1hsRVFoMGFnYTVnUEhnTTJpc0ozaVFkNUxodlJw?=
 =?utf-8?B?NE1aRVhreUlzQ1l6VlNEOE8xc3JISFQzQzI3NGtJM3lWZ1RlZjJVZ0ZrM0Nr?=
 =?utf-8?B?cFdEUDhxdDdRZXRYVUY3T3libmZUZVVRRURIUjdjTm85ZFF6TkFmcjExVzhE?=
 =?utf-8?B?aGVNcFZ2RTlxK0pVUk9WRGgxYS9ET1RzanA1NGZIcjQ1d3F0UEVXclVta3h2?=
 =?utf-8?B?dlpva0V2ZzNyRXVaMVF1cHNkcGtPc1hRcDFoSFRwbXFURDQ0cmg0d0ZweEVH?=
 =?utf-8?B?WXMvRUdFeEZoQ29vY1pNenRNZEliQWl5TmNhUk9CaWVMOVpKazdTS0pENDJY?=
 =?utf-8?B?MUppcjhwUTVTR2hnMDhVd0JOdUg0VGpicGo0M3RQZThDZFNRUzAxNENLVXVT?=
 =?utf-8?B?VnA2VDZsNFV4NDFZZ0U5WTFEczl3c0dCWndpK0UzM0NraUpHN0ozcGVvdUJ0?=
 =?utf-8?B?TFgwSWtVeXl2dWU3dEFXaDRsRHJsRUVwWVFETVVyTXNhWG9TZnV5MFZJV3E1?=
 =?utf-8?B?cDdISGU3ckQrWFhkMk56Y2h2bTE5cU4xUWVDbGdGNUF1QVdYRXRCVlhSME5j?=
 =?utf-8?B?WU5WRSttVXh2Z21RL2NYbFkrZTRyVkFIQ1FXUklPR2RDQ01LdUViaXAyUmpp?=
 =?utf-8?B?WFI4SGU5ck9yN2MvMzVidFk2SDY3OHU2N08wOFY5cVgrb05hY21VZFN2UExY?=
 =?utf-8?B?TFZTbEhBU0ZxWWVtMng5Z3g4ZDhLUjlHVEYvTVdhcU1oeDNTbUJ2YTdoekZG?=
 =?utf-8?B?ZDRzYVFUMUhUVnBXNTg1M1FpVHM3Q3pybkVFSE04aWFwaTJuMEpLZE9xdmV6?=
 =?utf-8?B?VmQvYVVFR0NTdmxtTkZtOE1kWGcrM01QRml1ZTFBZVJWUUFEdzA4dktrdnQw?=
 =?utf-8?B?OUtDQVpzbE13YjUxNjAxT2h1dkcwbzVrU2JPOU53R25zUzgxVExET0lpWjg5?=
 =?utf-8?Q?OBUc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b763dd-ef47-41f7-4b5e-08db68ee097d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 13:32:57.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlCR166R33J+44mHb2bh+QgO6Uw0yjm+Jl2L5RLms8UW3NagbHU/h/5G4exbkvae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
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
Cc: felix.kuehling@amd.com, Amaranath.Somalapuram@amd.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-09 06:02, Shashank Sharma wrote:
> This RFC patch moves the code to flush TLB using SDMA ring to
> a different place like a separate function. The idea is that
> KFD/KGD code should be able to flush GPU TLB using SDMA if they
> want to.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
>   3 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 231ca06bc9c7..20a5dad32bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -30,6 +30,47 @@
>   /* SDMA CSA reside in the 3rd page of CSA */
>   #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>   
> +/**
> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
> + *
> + * @adev: amdgpu device pointer
> + *
> + * return: returns dma fence which must be put by caller
> + *
> + * The SDMA on Navi has a bug which can theoretically result in memory
> + * corruption if an invalidation happens at the same time as an VA
> + * translation. Avoid this by doing the invalidation from the SDMA
> + * itself.
> + */
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev)
> +{
> +	int r;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +
> +	mutex_lock(&adev->mman.gtt_window_lock);

gtt_window_lock is for GART copy buffer/window sharing, here we use copy 
ring but don't use copy buffer, and ring ib sa and job submit has 
spinlock, so I think gtt_window_lock is not needed.

gtt_window_lock should be removed from gmc_v10_0_flush_gpu_tlb too.

Regards,

Philip

> +	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
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
> +
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	return fence;
> +
> +error_alloc:
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	return NULL;
> +}
> +
>   /*
>    * GPU SDMA IP block helpers function.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index fc8528812598..c895948f6e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ab2556ca984e..0bfaee00a838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -52,6 +52,7 @@
>   #include "athub_v2_1.h"
>   
>   #include "amdgpu_reset.h"
> +#include "amdgpu_sdma.h"
>   
>   #if 0
>   static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
> @@ -333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   {
>   	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>   	struct dma_fence *fence;
> -	struct amdgpu_job *job;
> -
> -	int r;
>   
>   	/* flush hdp cache */
>   	adev->hdp.funcs->flush_hdp(adev, NULL);
> @@ -378,34 +376,16 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		return;
>   	}
>   
> -	/* The SDMA on Navi has a bug which can theoretically result in memory
> -	 * corruption if an invalidation happens at the same time as an VA
> -	 * translation. Avoid this by doing the invalidation from the SDMA
> -	 * itself.
> -	 */
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
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
>   	mutex_unlock(&adev->mman.gtt_window_lock);
>   
> -	dma_fence_wait(fence, false);
> -	dma_fence_put(fence);
> -
> -	return;
> +	fence = amdgpu_sdma_flush_tlb(adev);
> +	if (fence) {
> +		dma_fence_wait(fence, false);
> +		dma_fence_put(fence);
> +		return;
> +	}
>   
> -error_alloc:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> -	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +	DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>   }
>   
>   /**
