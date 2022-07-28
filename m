Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F4C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CE310E050;
	Thu, 28 Jul 2022 18:37:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867AD10E3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP4UR7NpNyemxjJAiLjVUA6HR6LntjmogLzIlr/cOXsGWlYZuuv+eEp9rf2RxNSkRikmqlc4AU6v4T7R5CZY9keaIm+cn0d4qAspUgOcbNzdAhkheMNwLEs0cJG/JDNJvsWnmsNDAMQUKiJNOgOw5tCQDnqq25D7pd52G4q5XOq2mUL/3r1w9e/ndozAw+ANMznoC9Tjkbpw6bMJ+Ld+dd3Uq6qMPf4Pmr4CwV6D1CfNPEAVyPcXYGtIbQ7ZN0dPKy9D0aTwUzeFJIrhOLmH2ZCtEHYutRezJvNe3v0LzPs9YXqYGc4bA8PBpKdGXChOUSf9zSp5jvQXWzsPlWj8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIDLGJRjmFGhI4KNvrR1bvc5HavbjZst4dnFYK2zjbU=;
 b=l5Xddw48wL+YLXZryrgkSE6DGpdqPAlVHviAqGZp74J+2PwoCOkfEbiRBBMPzYsnXQGfmsIVBm0vueKj8tqkGGq07BIXlEQUp53G/B4tlOZHAVQYyFDCBwgVVefESJgAb4o52SfMEeAyIwFBoooQsm8Rt5Q5Xy2V68gdfQ5hAVtB/p8LdEQC169eIv4tn68Pi4GWdq2L1LAmbUy5gmpSIzmqNMmBZDELEpQlWJJyDE5tYHoEO2WErjjn7GZYsR0TyfMzsx//oeIhXRikQBKJvIGLB4p8JX9Ie5hfeRkuEcmP+QEGAkzikE3J5P2sc3s8sFhyN8rLWX7OVoteJubLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIDLGJRjmFGhI4KNvrR1bvc5HavbjZst4dnFYK2zjbU=;
 b=ZJ7630lwcnWmTw4KjHkEhtJS3kpD70/tEDUacO/itlDVENFRyPnzYeV7cmMY/J4twk1HZaWiYNDDl7Oe1CuNGwHxgVJE/RfhOs+QcFKaW2pn1r423G4XsKIA+18ST2X57BrKH0eqjNVHldnJlterE87a6K1x8v5yCbATod/Mnbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 18:37:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 18:37:25 +0000
Message-ID: <ef855d58-e224-5f84-f247-00ac8b2aca46@amd.com>
Date: Thu, 28 Jul 2022 14:37:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/6] drm/amdgpu: reduce reset time
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
 <20220728103027.27255-6-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220728103027.27255-6-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52b6ce2-3184-4a45-fc87-08da70c83787
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmaJveBhVmR0N1zZ3fGcjq16tnhxRjxzvrnej4XF3cCkVRHr8ao7S6T2Znse7yJPg758uKyhHvJ9/plKNmlzUeN6ZCL31+sS7vcf7b/sbUNS6BIEuQ4F2ABxinqQXPceo3nnd/aaJcUHWoe5GY8rQ9yjBI8AFAnP5/2U/8OQs4+UTvZdDGesPzyWj6kC7v1MsWows62ywAKZkFYwU+BwqCzE8dPIEzkU+Ex4k9wAWSEG7UM8jdwejaw04bdMDfD+0jOSH2PtIie0VWn/RTXXVPk0pZb2tl/Ihbh7oSyDpjaE0LnpCgsLmcUm+EXBs1jopNgb6T++wpCb86LtfxvVbl3R9gQAk1nzXcSJ8e9hoROfXK7Zp6QuxtEEm3o76BRYLRKrhJC/IgsT4o1trmf5MSQuGikuDkcMIWSQ7k25I6S3YCZurza7kSIr71QBcitelLdvJs2h38MRxGp/t+cmWaecHhVmbP9yjH2Qxxp7C2KAhIcHuhXoSzZO/tZSy3Xwyb+vpDyzxdv57wwYPgypzeJpZPsqDCnDNlWT1YZm4DYiRzbfJ8tscHk2eDT6cjH3AV1RBOhBq9DTRuBpgBoN+WFNl/6mJX071AX/uL+8Q98jNv6eshoz+7HKfrQUxnflP0f9/caZcyqHtiS4wzjebBpuylCsF+FNughhYbBDbI2IiRq87EVdzYNZ237V8xaEXKj/bC0Sv624GlpxdxtQiENutQGlaTYBbv6NsBkTvONlKVcuyHcKRONK5FArFEOphONQgBkCbJRElHrW6nS4Rx3qWTeGLR+2JH8bffUi307peeo/WM61E4B70r68of3FCy3ML7JmsrJrzqWx1u636A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(66946007)(83380400001)(316002)(31686004)(36756003)(38100700002)(186003)(53546011)(6506007)(31696002)(2906002)(66476007)(6512007)(86362001)(8676002)(2616005)(8936002)(4326008)(5660300002)(6486002)(478600001)(66556008)(44832011)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHltNnhNQ3JkVmNIU0JHKzZ4allFSFY2NThDbyswalo2TDZBWHpoUmxJbXcr?=
 =?utf-8?B?Q2hYRlhyZnEzdjJ1TUhJWUFkdDZZR0R3cExjRWtWWCt2U0ZoZ0VHcU9FL1A4?=
 =?utf-8?B?MU53SXAyK1RZaHY5MkFSb3RMYmxXUDRKYkdocFB0QXh5bXV0UXdTaVZEYTdK?=
 =?utf-8?B?aW1jVHYrTHVLcmhQb3lXRWI3SXBDV0dOTldqRm44cGtibEhkNHJlSlFyamlh?=
 =?utf-8?B?UVZjL2VWbGZ0RjBJWW9IeXFSWW1kMm9VZHJTVG9ZNFZ4dmxqeUQ4TVl2K1dY?=
 =?utf-8?B?RHg5dTBzU21QeWV6Q1JOK3RUQTlmTjIrQXNEbEpNQm9hZFRBVkQzU3lWSHhx?=
 =?utf-8?B?Vy9EaUNWaEM5N3NFNjB2VU1qZ2c4U3o5M21FWEl6Skh1UlkvcnJyYkpyd1Js?=
 =?utf-8?B?b1NRaDRlVUI5NDRYenMvYWVDY3pmdlVwWENPQTl1MitoRmpMM3ZzYjV1OHk4?=
 =?utf-8?B?SlhUeXZkYkpIVVBJcVZySlkrYm1RdXhMY2FmNExnYlc1NXJrbDdRb2ZvbFZE?=
 =?utf-8?B?TmV0TlNyQ2d0TFI3emtqYjhiT1JYcks0emJzUjRmcWJpUUJYZkxwbHBtSTJB?=
 =?utf-8?B?ZXlOYisxU0VGejFTL3pOcmdOZGpsZzUrK25YcWJ6bTd4ZU9FYnpXc25pdWVD?=
 =?utf-8?B?MGpDZ2M4R3VaRFpMRW1lS2oxN01hOStzYkZGUnpmcjF4V1NFc0tpSm8zK2Fv?=
 =?utf-8?B?ZnVyZ0R0M2pZMzZ5N0ZERVFtalhCOENLNEpLSHpjejhVSld6N05FVFJIK1Zj?=
 =?utf-8?B?NTI4bnBJK0trRURhVEtwNGNoN25Jb2xmN3EyZkNYY2QxZHc2OGJaSm9zS1Zh?=
 =?utf-8?B?RFR3UnFPNVA3RW5xdTk2c3VId3hpblZpekdHdHBLbW5hYTlpVC95VlRSUnVE?=
 =?utf-8?B?cDhyTllFQzZRblEySFA0Ylp3WnBiSWZza2ViTGNvaEsrRXVFbDV5MDdER3U2?=
 =?utf-8?B?MDNPZnBNWmdGNlRTT2VQRGxNc3N3dzRWR3VKNFdSaG5KL0J1ZGdnRlRxeGYw?=
 =?utf-8?B?Zlo4eDF6QXFVTDdvVWFYYWsxMHZFZkplNVpQWjB1aVB5dzN0emZndTVwVmQz?=
 =?utf-8?B?RndKaU9weG1FTFpja3JIYTVmTUxuUHNvSEdINjJFVXlQN29FR2lBd1I2bk5x?=
 =?utf-8?B?THNORWR3MUdxaVEwd1B6ZUlhamtwV0NES0s4NFRadUtwakRVSUpvMHRDdnhq?=
 =?utf-8?B?SnFYb25WZlMzdDBleTBiL3JNZmYzZlpTYjJqWnZFbUx1b2ltS2lhWUtlSWx2?=
 =?utf-8?B?UWprVTRHNmxjT0JZejZMWFFoWWVHNU91ZnJ6WVFJbFVFanQwcm9xOXgrUlRo?=
 =?utf-8?B?Mm9xOTdjQVJZbks5VktsVkJxbHFCTlU2aWI3aFFjcWRiZHYwaGhzdmtueldQ?=
 =?utf-8?B?WW0yYXpZbEtDWkUvQkxGdXNwN004QUJ0VUYyVDA3akJDaDVoRk5Bci9SVTFI?=
 =?utf-8?B?Tk4vYjQ1a0JOTGUveVVLYUNLd0hJc0RQWjRXTXp0emVoNnByNWYwV2NiTjgv?=
 =?utf-8?B?UTIzd2NPcUdYQVN4L0tDcnFNR2RKSmpUMGdzbVhuT003eVFISTVQVWUzUWUr?=
 =?utf-8?B?Yy9GcEptY0ZreUV2cTRVSHRZNlR4cGwwZkJWMFRvcVhJa2JKTGlRMzV6MVBC?=
 =?utf-8?B?VWJQSGowd2RGUFlsNm9CbjEwY0JoaitWMmNFeUlja2crRjgrUFFHUDNveHdK?=
 =?utf-8?B?YjZxSnZDTVFBVzk1aG85MWl4S1JwNVlVQ08wWWk2Sm5sRnJ2b3MxWVVtZnFX?=
 =?utf-8?B?R3dMd2dLSjA2QUFIdEVzRHB4ZUdobDEvd20zQ05QV1E0aTBPNytOTE1JUkdI?=
 =?utf-8?B?S3dOYmM3bEM5M25UeCtUK2NVbkZ3OUJTMlFYa2N6VkduYk9jUzdkcG9KM3dW?=
 =?utf-8?B?TnBDVHdHUmxTSHpQSXFuTVJiWjRZQWdWaWVBSUVaSEJyS3B2R285Tm0wOGNu?=
 =?utf-8?B?ekg5V1F5TDJ5Y283UUFtY2x1UC9oUkxPQUZuR3I5RDAvcGRHZnpqNUdsOWtq?=
 =?utf-8?B?cXJIS3ZSY0RvTjRmS2VlTmtKSFEwaGFtMVh6dVhuL0lDRHdUN0MrSDZUR3Rw?=
 =?utf-8?B?YTlyVk9XTlpNMUo1bDcvWWRJSXk0MVdnVW40MjJGT3A5K0tBSHBqUjRLSjl1?=
 =?utf-8?B?cUNHZkVrRU5SVE12WlZyTklKK0dDKzZqWFpMVHN0dzI2YU5hRmZZTHpUUzNl?=
 =?utf-8?Q?rHCXlcWw//I1wh5N+qWDFMQ/L0uyUcfT8hyp+Xak+8X3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52b6ce2-3184-4a45-fc87-08da70c83787
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 18:37:25.5494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yro4bITJGK69EuJrYnhn4nAhpQxFVZKTJgcIIzMP5zins+W06wHfePZo8wYu47izh4ZQViDfK/5sHp8LB/t8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-28 06:30, Victor Zhao wrote:
> In multi container use case, reset time is important, so skip ring
> tests and cp halt wait during ip suspending for reset as they are
> going to fail and cost more time on reset
>
> v2: add a hang flag to indicate the reset comes from a job timeout,
> skip ring test and cp halt wait in this case
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 11 +++++++++--
>   5 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 222d3d7ea076..c735a17c6afb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   
>   /* delay 0.1 second to enable gfx off feature */
>   #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> @@ -477,7 +478,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>   					   RESET_QUEUES, 0, 0);
>   
> -	if (adev->gfx.kiq.ring.sched.ready)
> +	if (adev->gfx.kiq.ring.sched.ready && !(amdgpu_in_reset(adev) && adev->reset_domain->hang))


I think it's enough to look at adev->reset_domain->hang and you can drop 
the amdgpu_in_reset check.

>   		r = amdgpu_ring_test_helper(kiq_ring);
>   	spin_unlock(&adev->gfx.kiq.ring_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 6c3e7290153f..bb40880a557f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -49,6 +49,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	}
>   
>   	memset(&ti, 0, sizeof(struct amdgpu_task_info));
> +	adev->reset_domain->hang = true;
>   
>   	if (amdgpu_gpu_recovery &&
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
> @@ -83,6 +84,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	}
>   
>   exit:
> +	adev->reset_domain->hang = false;
>   	drm_dev_exit(idx);
>   	return DRM_GPU_SCHED_STAT_NOMINAL;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 9da5ead50c90..b828fe773f50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -155,6 +155,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
>   	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
> +	reset_domain->hang = false;
>   
>   	return reset_domain;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index cc4b2eeb24cf..29e324add552 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -84,6 +84,7 @@ struct amdgpu_reset_domain {
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
>   	atomic_t reset_res;
> +	bool hang;
>   };
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fafbad3cf08d..a384e04d916c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_psp.h"
> +#include "amdgpu_reset.h"
>   #include "nv.h"
>   #include "nvd.h"
>   
> @@ -5971,6 +5972,9 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>   	}
>   
> +	if ((amdgpu_in_reset(adev) && adev->reset_domain->hang) && !enable)
> +		return 0;
> +


Same as above


>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>   			break;
> @@ -7569,8 +7573,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
>   					   PREEMPT_QUEUES, 0, 0);
> -
> -	return amdgpu_ring_test_helper(kiq_ring);
> +	if (!(amdgpu_in_reset(adev) && adev->reset_domain->hang))


Same as above

Andrey


> +		return amdgpu_ring_test_helper(kiq_ring);
> +	else
> +		return 0;
>   }
>   #endif
>   
> @@ -7610,6 +7616,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>   
>   		return 0;
>   	}
> +
>   	gfx_v10_0_cp_enable(adev, false);
>   	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
>   
