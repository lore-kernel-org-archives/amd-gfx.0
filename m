Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6F1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 17:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D87C113642;
	Tue, 17 May 2022 17:49:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADB0113642
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 17:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IusMEttbxP9dmJur/8IHIIuQBGGcSaEDoWbtYP3tMOxHLCr/twVKdsBfM9AlHjnYQcWyNffcWI089XVFcQ2KsEAp/EV3UmQm2UBzqjrY5vWvc/e8ArKWAFlYKutggHSLdMlLwTBQG2IvxkF1L0EbWhdXb81H9DjGYCV15Z3Pf39x6+9vfFrMKabK8OjAxOiOVMD80jXf5cxnLv2+4KkhR0qqArRznIGcYfEi9pBqAA8wv3iRZv2GlZf9vLyIyts0m8g3mbRbeVWkdXzjP/8kjMuE0/iFx/mw535QmVLwGklZZWmbsSaG+qXt5D/pwlB/IcU1Bd6sAG4ihA+ca2unCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhRHm2jNLSyEed1zLdawvxn87tEc+PZT9yg/uiqc4HU=;
 b=J0dVMTjnpNsZckOAEWQsb0YMxvYhjRLrpfSFi8NoG2QV0tpZWFzzzE9doSal0WLra9txISyGdc/forg4IE7yuWUJZ3OQSQPKE5hKwHlTM78ajL0shlvWdEOvSDJDGtUJeDvtT5Y9kU52cwzYpYL3SwoXVEYrMsl+aaPg7v48Tispan6Tly9qpLRfN8qdYPfydpHb/lJp7RBI1zZqv0x9nesUnIx5PPU6vAxXmT2FPDhJI3WAJTGcoEndp8Igz/FNZHAsw0Q8JIygUcwEOlgxfhMsk3ZymnfgVXe4NyV0IRwPDYKtzyyDiHtCojrbtvgqA8dmSDXqIdwoSTP5X2StWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhRHm2jNLSyEed1zLdawvxn87tEc+PZT9yg/uiqc4HU=;
 b=BgUJ4322XnsG9LezpVPW1D/l3NSQCphQU7FfD8677ogP+oy2PZCxaIRF7w645PlsRJ2iu8G1rfims5Olnc/YIsdcOlXcLvFtR0Z3ovYg+Wj1qe8GXDOaP91jA4L5e46vKHhLe0quWfdi+SwPBZHlTVl9F7ZBf/B0tM3LJKxBxnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM6PR12MB3052.namprd12.prod.outlook.com (2603:10b6:5:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 17:49:41 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::2593:37d4:fc8e:1958]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::2593:37d4:fc8e:1958%7]) with mapi id 15.20.5227.023; Tue, 17 May 2022
 17:49:41 +0000
Message-ID: <64105476-4ef8-2678-e928-ffd7b4c392a1@amd.com>
Date: Tue, 17 May 2022 19:49:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v5
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com
References: <20220517103646.1553-1-christian.koenig@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220517103646.1553-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:203:90::23) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b12cce1-d390-495d-2167-08da382d9e41
X-MS-TrafficTypeDiagnostic: DM6PR12MB3052:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB305219B97CC433C52D0B8F48F2CE9@DM6PR12MB3052.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/D0+o0yioDFBOxdwj9P6oeTVFQIbf8kESXVYEwBCA1ZGMgz+d0ikAo3/sSXwrXIC0cZ/9ZHeW6xDR6QL8RVTPzOIlUlUbDxGoLhuM1PM0uqHJvV57eWuyS4fYB95kv4ECtv+cjk7Vn6aYHugda2zaR7WH7MeNiBiZqPUl+O05jrU72+fn9Vb4NnzdC56l/xSDkcnaa7W3WoWKu5rP4NA0W9ggSkZaRxIVSPDuPh/UrUOMivo5Gy5ImRlpVWRqok8EZMt10ScCrm0WeANS/rVtNoX6Tq04MMniCLulE1S5W73L72OkXJaOFayqSXHU4+NdYbMYpgk1EtWdFq+VQi5qlnaDjf2NduvPXnGjIdaQB7bbOSxaPKQuIO4EuAhYX6jhzKxctvtoSzIL+CWByqwHBn3LkGkE6Ux2oQNM3QJsESZi+MMf0yi/2Ne4oorbpekyrEenKVtXUuXXN2cWZGQgAgvC1PJ6k5xbKTD+ObBcEj+rlWt0BD9uidK4iYujlmJme0BztaxnBzrdVbmqcCAVacmmHeylfjH0sdSzUxTdTv5BlggSXHJ39HHesGarldRnmVcUQR2TfBHDwYW5vh5v1Qz0fV5MWG0RglK9LMuFmp3gkFxXpFghnKeY1ZaVsbFSpdCAoOzpC8xGvyrI+gmM05qLeaG11/G4BScG98iB2lm2AZuumNiE1ThZiGKGf9gzoUQqa5NywXuNvqPQa2SRVUD4kUP0i9gxyOdr8bUbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(186003)(6636002)(6666004)(6506007)(508600001)(53546011)(66574015)(26005)(6512007)(6486002)(36756003)(316002)(2616005)(2906002)(31696002)(31686004)(86362001)(30864003)(5660300002)(38100700002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEM2cXpydllDWFBxUllOWkpMR2lkbUc1ZGNuTTdUd0k2TlVPdHhSZ25QZ21M?=
 =?utf-8?B?L0ZJOWwyM0dIWG9sYjhqZXUrcEZsKzd6eDFkRjVLckg2NnlLL1ZZcFFWN3JM?=
 =?utf-8?B?eFo4Tk5QeURqb1BxZXBRc2ZndVhQQU1TUTVxTEFnSGNiTTBxZDZIMnRISFE0?=
 =?utf-8?B?V0lhQloxNGRmU3I2di8wdkhqNzNDdGxpZjBtV1EwbmNrRXhEVTFRVDVHWThm?=
 =?utf-8?B?ckFYcXlvQk5laG9hSXNaaVB2UTVhd0NsZWd0cGwwTG5Sa2o4aGVhTlRyRGpC?=
 =?utf-8?B?djJlQ2MxOFgwUGxTZDZ1dCszUHJqeFhJS0V6bUU5ZGU0MnlRSnNWdTIyT3ly?=
 =?utf-8?B?NlIwOU1qZkZyd1dtNng5VHdLUzNVaC8rZ0h1WlJwQUpYeFFsTXc2eUxnbTND?=
 =?utf-8?B?bjg4akZPNTVPU3N2NlVhUTlBYis5azhINzh3eVBURUR1T1d6dWZLblBEekR0?=
 =?utf-8?B?dkFNRHgzZDRkZEtwbE1hRzVncE4rc1R3ZXdpNlcxT2xHczhSdjNuRk1DSWYx?=
 =?utf-8?B?OGdvZ2VHSEdpRFQ2MHQvVFlwOHFaOGZVTnV5NHVGY3dZVFYrWDdtTk1FdlI5?=
 =?utf-8?B?UkRWcDYya3NoSnJQWVhTTHVQRDdsdW5XdkJvSGZGK3FnZngzQ01oSzBndS85?=
 =?utf-8?B?T3B4dGVSY1pVM09YUi8zam0yUjV2d1RselBpWGc4MFdBek5UVlRuOHFPQ1ls?=
 =?utf-8?B?UmxoUW1uSmlnNXo4UWxjaWROL1NQRmVtMERnTktQQ1NZZDQwbWNPNnhmVC9F?=
 =?utf-8?B?NWhzWTJOTy9Cck44d1B0OFJrRE44V1dmS3UrdEFkYldjRzJKUFFuZExVbXNl?=
 =?utf-8?B?bVBSWW1TMy9XcHJJaWJ3bE94WGlLS0ZxSkJ4U2w3OW15NFY3aWdua1MvQXNt?=
 =?utf-8?B?cDZkNEs1R1NuUE5TZWcycThSeUNxVnhzMkszZUlGVHFXWjBQa3h5M3A2WlNj?=
 =?utf-8?B?ODFZTlFNTkJaaE9VeVNqUEM2WGZtRDR0b3NWMy9qN1dxa0x3Q2hDRWIxc1Fr?=
 =?utf-8?B?TnY5a2Z4ZXlsQTdlNEJsZG03UE9lVmJhSEFsaU1qa05RQkJWNzNrdFpjTE8y?=
 =?utf-8?B?eEdId2N6a0FqMk1VMFhGVTRJQWNlbE1Jcmk2elZIVHhmak56UzltLzB1cVNt?=
 =?utf-8?B?a2tncTloaVk2bnVnc2dPSW5naGJQK0tkY2FZUXU1WlI0anBiTkpvVE9PSmdH?=
 =?utf-8?B?OXpuQnJNK2JYZGZWTDRicFVJaUpnU0RlUDZuS3VoSjZEUk9UUzRjei9qMUhr?=
 =?utf-8?B?K1RLKzIrOUh6Ull2NmlNK2pHWVUvQUc0d1JEMTQ1NnE0R0FSMGIxSDZXYUkr?=
 =?utf-8?B?bDkySTJ1OGl5Rzl6VlovMXdLWUFGbzR4WnBwd2dpRFpqVVVDT3hEMHhFbGJw?=
 =?utf-8?B?MHhIWXhWUVJMNUFObi93OWRUOVBMdlFiNmUyenM3NlpmODVTRU5ZQ2pMQS9M?=
 =?utf-8?B?OS8yMjZJaThKcVkreVpxQ09MRk5Ec3YvbUxGNDVGNTFmd2cwQ3ozLzlyOHI3?=
 =?utf-8?B?V2hPNzl1QnJCQ2JyZmd2a2x6Nzc5RGk0YVBHdi81TTVaOE9ldUhtOHpMSmk2?=
 =?utf-8?B?dis2ck9OTUNRYjNSWC9qYkd3b2cyY09XSTVSbGhzK3VWRDVPTjZvN1NHakJI?=
 =?utf-8?B?a21BQWQwcDFrMFhmK1cxKzFGOHpkWUF4ZngzMUk2K0NNRkFzR2E4S0dSL2sw?=
 =?utf-8?B?TkJvSjR0MkJOL1JaYzRFTS90dWQzS0s0KzhKU1B4dFZCT3pLNmxVWWFMMU1a?=
 =?utf-8?B?VkhzdUx5Wjh6RXdqV3haRXRkZXVGN1l4SkJKRlcvbVI1QUIwUUhkOVFXUnhv?=
 =?utf-8?B?QW04TUpSUnBUTVFDWWJVcUFxblVFOUt6OFI1bDh0VHI1VnJOeEVJWGI3R3Jj?=
 =?utf-8?B?RktESzRIV1gzOUtkVXpPRzVlbHNvQm11TVdoOUlwZWhDYXlTUDhSMkpLM3ov?=
 =?utf-8?B?QTdxNXR0eUJ1emhxMFR4cENSekRsWU01clBDUStDQ3hWZHRNZEx6ZXQ1Rld0?=
 =?utf-8?B?K3NPWjFpUGZQZUlJUlBndkViYTRMa2RmcVNjcURYdFJsMHpzemVTclFKWmk4?=
 =?utf-8?B?ZExJak9kcCtzTFRnbEI2SXBNSkI5T24rTklidk1zK3daUjVBb3ZRS1MwWVo1?=
 =?utf-8?B?WnJPVXg4Q2hBcGt1Zi9RN3BJSlZtL3ZjS3ZEYmlnU0wrMEJZRWgrUTc2YmNy?=
 =?utf-8?B?aytSMUFKaHdNS3J0ck1EcUJjL1FJWEVmV2V3enZram5lVjhVMmd5d0t3UEVP?=
 =?utf-8?B?eFMwR1JSVnNmemtnVkFHdUNURVJBMDc2ZDM1TDRhdlVRV1VxMWRySG1jdGFs?=
 =?utf-8?B?dlVIRXZDZTlXMkdXVS9na1U4SWhtVUZRamlYd2dTTDBpN2lMcjdZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12cce1-d390-495d-2167-08da382d9e41
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:49:40.9535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0hRtmUxC4WcVotMXutTSUwqEFpdVNrTweAhpcS5uQpXFYJ/MBDTurkaSakrMzkr8abbJFUEQUqg3umC2Cq2iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3052
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
Cc: tvrtko.ursulin@linux.intel.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please feel free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

On 5/17/2022 12:36 PM, Christian König wrote:
> Convert fdinfo format to one documented in drm-usage-stats.rst.
> 
> It turned out that the existing implementation was actually completely
> nonsense. The calculated percentages indeed represented the usage of the
> engine, but with varying time slices.
> 
> So 10% usage for application A could mean something completely different
> than 10% usage for application B.
> 
> Completely nuke that and just use the now standardized nanosecond
> interface.
> 
> v2: drop the documentation change for now, nuke percentage calculation
> v3: only account for each hw_ip, move the time_spend to the ctx mgr.
> v4: move general ctx changes into separate patch, rework the fdinfo to
>      ctx_mgr interface so that all usages are calculated at once, drop
>      some unecessary and dangerous refcount dance.
> v5: add one more comment how we calculate the time spend
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 177 +++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  57 +++----
>   3 files changed, 125 insertions(+), 121 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index a5fef5213fc5..a1d5275a2e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -162,17 +162,50 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   	return hw_prio;
>   }
>   
> +/* Calculate the time spend on the hw */
> +static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
> +{
> +	struct drm_sched_fence *s_fence;
> +
> +	if (!fence)
> +		return ns_to_ktime(0);
> +
> +	/* When the fence is not even scheduled it can't have spend time */
> +	s_fence = to_drm_sched_fence(fence);
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
> +		return ns_to_ktime(0);
> +
> +	/* When it is still running account how much already spend */
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
> +		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
> +
> +	return ktime_sub(s_fence->finished.timestamp,
> +			 s_fence->scheduled.timestamp);
> +}
> +
> +static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
> +				      struct amdgpu_ctx_entity *centity)
> +{
> +	ktime_t res = ns_to_ktime(0);
> +	uint32_t i;
> +
> +	spin_lock(&ctx->ring_lock);
> +	for (i = 0; i < amdgpu_sched_jobs; i++) {
> +		res = ktime_add(res, amdgpu_ctx_fence_time(centity->fences[i]));
> +	}
> +	spin_unlock(&ctx->ring_lock);
> +	return res;
> +}
>   
>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   				  const u32 ring)
>   {
> +	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>   	struct amdgpu_device *adev = ctx->mgr->adev;
>   	struct amdgpu_ctx_entity *entity;
> -	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
> -	unsigned num_scheds = 0;
> -	int32_t ctx_prio;
> -	unsigned int hw_prio;
>   	enum drm_sched_priority drm_prio;
> +	unsigned int hw_prio, num_scheds;
> +	int32_t ctx_prio;
>   	int r;
>   
>   	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> @@ -182,6 +215,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   
>   	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
> +	entity->hw_ip = hw_ip;
>   	entity->sequence = 1;
>   	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>   	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
> @@ -220,6 +254,23 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	return r;
>   }
>   
> +static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> +{
> +	ktime_t res = ns_to_ktime(0);
> +	int i;
> +
> +	if (!entity)
> +		return res;
> +
> +	for (i = 0; i < amdgpu_sched_jobs; ++i) {
> +		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
> +		dma_fence_put(entity->fences[i]);
> +	}
> +
> +	kfree(entity);
> +	return res;
> +}
> +
>   static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>   			   struct drm_file *filp, struct amdgpu_ctx *ctx)
>   {
> @@ -245,20 +296,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>   	return 0;
>   }
>   
> -static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> -{
> -
> -	int i;
> -
> -	if (!entity)
> -		return;
> -
> -	for (i = 0; i < amdgpu_sched_jobs; ++i)
> -		dma_fence_put(entity->fences[i]);
> -
> -	kfree(entity);
> -}
> -
>   static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>   					u32 *stable_pstate)
>   {
> @@ -350,8 +387,10 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
> -			amdgpu_ctx_fini_entity(ctx->entities[i][j]);
> -			ctx->entities[i][j] = NULL;
> +			ktime_t spend;
> +
> +			spend = amdgpu_ctx_fini_entity(ctx->entities[i][j]);
> +			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
>   		}
>   	}
>   
> @@ -687,6 +726,9 @@ uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>   	centity->sequence++;
>   	spin_unlock(&ctx->ring_lock);
>   
> +	atomic64_add(ktime_to_ns(amdgpu_ctx_fence_time(other)),
> +		     &ctx->mgr->time_spend[centity->hw_ip]);
> +
>   	dma_fence_put(other);
>   	return seq;
>   }
> @@ -793,9 +835,14 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>   			 struct amdgpu_device *adev)
>   {
> +	unsigned int i;
> +
>   	mgr->adev = adev;
>   	mutex_init(&mgr->lock);
>   	idr_init(&mgr->ctx_handles);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		atomic64_set(&mgr->time_spend[i], 0);
>   }
>   
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
> @@ -871,80 +918,38 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	mutex_destroy(&mgr->lock);
>   }
>   
> -static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx,
> -		struct amdgpu_ctx_entity *centity, ktime_t *total, ktime_t *max)
> -{
> -	ktime_t now, t1;
> -	uint32_t i;
> -
> -	*total = *max = 0;
> -
> -	now = ktime_get();
> -	for (i = 0; i < amdgpu_sched_jobs; i++) {
> -		struct dma_fence *fence;
> -		struct drm_sched_fence *s_fence;
> -
> -		spin_lock(&ctx->ring_lock);
> -		fence = dma_fence_get(centity->fences[i]);
> -		spin_unlock(&ctx->ring_lock);
> -		if (!fence)
> -			continue;
> -		s_fence = to_drm_sched_fence(fence);
> -		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
> -			dma_fence_put(fence);
> -			continue;
> -		}
> -		t1 = s_fence->scheduled.timestamp;
> -		if (!ktime_before(t1, now)) {
> -			dma_fence_put(fence);
> -			continue;
> -		}
> -		if (dma_fence_is_signaled(&s_fence->finished) &&
> -			s_fence->finished.timestamp < now)
> -			*total += ktime_sub(s_fence->finished.timestamp, t1);
> -		else
> -			*total += ktime_sub(now, t1);
> -		t1 = ktime_sub(now, t1);
> -		dma_fence_put(fence);
> -		*max = max(t1, *max);
> -	}
> -}
> -
> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> -		uint32_t idx, uint64_t *elapsed)
> +void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
> +			  ktime_t usage[AMDGPU_HW_IP_NUM])
>   {
> -	struct idr *idp;
>   	struct amdgpu_ctx *ctx;
> +	unsigned int hw_ip, i;
>   	uint32_t id;
> -	struct amdgpu_ctx_entity *centity;
> -	ktime_t total = 0, max = 0;
>   
> -	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> -		return 0;
> -	idp = &mgr->ctx_handles;
> +	/*
> +	 * This is a little bit racy because it can be that a ctx or a fence are
> +	 * destroyed just in the moment we try to account them. But that is ok
> +	 * since exactly that case is explicitely allowed by the interface.
> +	 */
>   	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(idp, ctx, id) {
> -		ktime_t ttotal, tmax;
> +	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> +		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
>   
> -		if (!ctx->entities[hwip][idx])
> -			continue;
> +		usage[hw_ip] = ns_to_ktime(ns);
> +	}
>   
> -		centity = ctx->entities[hwip][idx];
> -		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> +			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
> +				struct amdgpu_ctx_entity *centity;
> +				ktime_t spend;
>   
> -		/* Harmonic mean approximation diverges for very small
> -		 * values. If ratio < 0.01% ignore
> -		 */
> -		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> -			continue;
> -
> -		total = ktime_add(total, ttotal);
> -		max = ktime_after(tmax, max) ? tmax : max;
> +				centity = ctx->entities[hw_ip][i];
> +				if (!centity)
> +					continue;
> +				spend = amdgpu_ctx_entity_time(ctx, centity);
> +				usage[hw_ip] = ktime_add(usage[hw_ip], spend);
> +			}
> +		}
>   	}
> -
>   	mutex_unlock(&mgr->lock);
> -	if (elapsed)
> -		*elapsed = max;
> -
> -	return total;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 3ceebab9c6ea..0fa0e56daf67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -23,16 +23,20 @@
>   #ifndef __AMDGPU_CTX_H__
>   #define __AMDGPU_CTX_H__
>   
> +#include <linux/ktime.h>
> +#include <linux/types.h>
> +
>   #include "amdgpu_ring.h"
>   
>   struct drm_device;
>   struct drm_file;
>   struct amdgpu_fpriv;
> +struct amdgpu_ctx_mgr;
>   
>   #define AMDGPU_MAX_ENTITY_NUM 4
> -#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) ((max) > 16384ULL*(total))
>   
>   struct amdgpu_ctx_entity {
> +	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
>   	struct dma_fence	*fences[];
> @@ -60,6 +64,7 @@ struct amdgpu_ctx_mgr {
>   	struct mutex		lock;
>   	/* protected by lock */
>   	struct idr		ctx_handles;
> +	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
>   };
>   
>   extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
> @@ -89,6 +94,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> -		uint32_t idx, uint64_t *elapsed);
> +void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
> +			  ktime_t usage[AMDGPU_HW_IP_NUM]);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 5a6857c44bb6..4d453845235c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -32,6 +32,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_debugfs.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> @@ -54,26 +55,23 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>   
>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   {
> -	struct amdgpu_fpriv *fpriv;
> -	uint32_t bus, dev, fn, i, domain;
> -	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>   	struct drm_file *file = f->private_data;
>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +	struct amdgpu_fpriv *fpriv = file->driver_priv;
> +
> +	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
> +	ktime_t usage[AMDGPU_HW_IP_NUM];
> +	uint32_t bus, dev, fn, domain;
>   	struct amdgpu_bo *root;
> +	unsigned int hw_ip;
>   	int ret;
>   
> -	ret = amdgpu_file_to_fpriv(f, &fpriv);
> -	if (ret)
> -		return;
>   	bus = adev->pdev->bus->number;
>   	domain = pci_domain_nr(adev->pdev->bus);
>   	dev = PCI_SLOT(adev->pdev->devfn);
>   	fn = PCI_FUNC(adev->pdev->devfn);
>   
> -	root = amdgpu_bo_ref(fpriv->vm.root.bo);
> -	if (!root)
> -		return;
> -
> +	root = fpriv->vm.root.bo;
>   	ret = amdgpu_bo_reserve(root, false);
>   	if (ret) {
>   		DRM_ERROR("Fail to reserve bo\n");
> @@ -81,31 +79,26 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	}
>   	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
>   	amdgpu_bo_unreserve(root);
> -	amdgpu_bo_unref(&root);
>   
> -	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
> -			dev, fn, fpriv->vm.pasid);
> -	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
> -	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
> -	seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> -		uint32_t count = amdgpu_ctx_num_entities[i];
> -		int idx = 0;
> -		uint64_t total = 0, min = 0;
> -		uint32_t perc, frac;
> +	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>   
> -		for (idx = 0; idx < count; idx++) {
> -			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
> -				i, idx, &min);
> -			if ((total == 0) || (min == 0))
> -				continue;
> +	/*
> +	 * ******************************************************************
> +	 * For text output format description please see drm-usage-stats.rst!
> +	 * ******************************************************************
> +	 */
>   
> -			perc = div64_u64(10000 * total, min);
> -			frac = perc % 100;
> +	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
> +	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> +	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
> +	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> +	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
> +	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
> +	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> +		if (!usage[hw_ip])
> +			continue;
>   
> -			seq_printf(m, "%s%d:\t%d.%d%%\n",
> -					amdgpu_ip_name[i],
> -					idx, perc/100, frac);
> -		}
> +		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
> +			   ktime_to_ns(usage[hw_ip]));
>   	}
>   }
