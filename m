Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD9C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD172469D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GJK/vQNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD172469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C696E9A1;
	Fri, 28 Feb 2020 04:00:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502796E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 04:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHwR+ipl8D+ypq9lPbeJYfb/q4gHeVTs7LrQTP2vRsnPkdOTXrPSUyA2e413bAwcAaax0Y8NsRaBVFD83cHs16p5Uhw7J7zzv3E8O1ABRWqnyuzGKDZHD7RsvcDjRZv9TwLvW55yetQKvykrudHalsSPkkLZBj1b2zPQLObUiJOpaHm5+OmnnxpHHCwHs4uwnWXE6H99BfoTlsMMYot5K+ZIDlaARyt+BtHtGNyMGaCJVMFXMTOwMixq5W20Z+XOBWbH1qkRptXw7gDV8QuUQQsXONhENrLcTfdGE2b3oumiBc+gkKvZZF9z2sqKCqCNhmghuto9d1irmOO1Jjh6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sCYJy9UgJ8Ef9/Ds7IGN3cOxYzxPQgUqrwesf8VEDA=;
 b=eLp/vKMKnVGWZVNNvbaxBjSVnyoTxfFSpqkze9l1YuJRVv+ek19/1aOUb2PK3LeP/xyyGpMOzYYlos3eYH49DGhUyz7nJxJh3eX79zNBRNjDK+/j3s/2C0Pc/LTOtEgz39kQjUmdvjsuJnHHN3iQc68mI+A+Vgnt8clS87gy/buDysLM3H+lQ87UALAfOaac/XrEaSs27JN72qBHCGziYYxx1/trc5XChBIgm1u9Sl8MsXujozi+EWTFzWpiLIXxytsKhReLJrV8gmolM/2XYBApYTvirV8k/unPmE6Tw5Vr97mtuJ3DD6UkhN1mN1UCmM52xIsfqClryZqrK7sSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sCYJy9UgJ8Ef9/Ds7IGN3cOxYzxPQgUqrwesf8VEDA=;
 b=GJK/vQNbXr1MZzxy8Wf6EOQCgBFauvUrUlqjbN1tvjwl+ZaGv6J2Y6CEe/JKxoE1Ju4C+5071XaqNxRUeG9HI8kPaxGpVlK7O1P4yDQCC+RfEXaPSVxpQ42E+P9OFTuQKlVD4pELJ2YhBaU2CORTDd70GvG7k8P5HM+/ElRzQv0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 04:00:06 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 04:00:06 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2f3903a0-2b82-9a62-d307-d02568b57784@amd.com>
Date: Thu, 27 Feb 2020 23:00:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200226203730.4621-3-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 04:00:06 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84d36079-d3eb-4dd2-9786-08d7bc02b277
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:|DM6PR12MB3194:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3194A80B0980FB9A8710AAD399E80@DM6PR12MB3194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(81156014)(5660300002)(186003)(26005)(53546011)(478600001)(16526019)(316002)(6506007)(66476007)(8936002)(2906002)(81166006)(66556008)(956004)(8676002)(44832011)(4326008)(6512007)(31686004)(66946007)(86362001)(36756003)(6486002)(31696002)(52116002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3194;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZ8OZv/IJbosu9CmGivmv8GSdsEC3dxqX53mTUs4P6PXQt9OsVwPphDM5R8YS85FqvUnvxoYdF6VKr2uPB7Oe4hwUctmSAdNcdlyAq3xVSBdwnCJCu4tAYyv1UbefJXC/gEs4y8tB8qvMurkHDA+2waOr7XyBKUkChwJI+ZZO7tDvo2VeBa0OXICd2it5FiH12twjb34j+1A/9aHPSU8QxGl4h19ucoSH9F6I2TsFiHfZ0bHuEx/niAy6j0KjGR0cTsoOOWyEwCWNWMiYgic1azhFq186Ncb/HOuhebUwVzc5tGFWWQHHu14jFcbld6q63OYRWupRwMAViwMon+CtRV+1HhKn47/Zbx1kvDs9lMmChrcBiWz9+Gybc7EsQuULwZouDx1nZrRrbzW55sqIXzYMfuarS9KY0TvZaWl7/7Kyq/6zxygd0a2bsHm4gy+
X-MS-Exchange-AntiSpam-MessageData: vXAV8gtsevH5UG/36aibp6MJzLN4MKL5s2ECmFUytOpy35URc+gABplx0DW0lE2Os/qfh4IVBHYvGV4pLwB9GeTPT5uE8B0NiIB8oejBEGHfski92PYdrEmq3lx9rLkf4nA1V1jPJMCC46xInUWgWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d36079-d3eb-4dd2-9786-08d7bc02b277
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 04:00:06.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm3cbl78JJS4YuGuH6sQYlAbCS0O/IqcNSlu4paDbCE+WUJtCqUzvXiaK3Alfm0U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-26 3:37 p.m., Nirmoy Das wrote:
> We were changing compute ring priority while rings were being used
> before every job submission which is not recommended. This patch
> recreates entity with higher/normal priority sched list when user
> changes ctx's priority.
> 
> high/normal priority sched list are generated from set of high/normal
> priority compute queues. When there are no high priority hw queues then
> it fall backs to software priority.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 58 ++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  4 ++
>  5 files changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f397ff97b4e4..8304d0c87899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>  	struct drm_sched_entity *entity = p->entity;
>  	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>  	struct amdgpu_bo_list_entry *e;
>  	struct amdgpu_job *job;
>  	uint64_t seq;
> @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	priority = job->base.s_priority;
>  	drm_sched_entity_push_job(&job->base, entity);
>  
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>  	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>  
>  	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 94a6c42f29ea..ea4dc57d2237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -85,8 +85,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>  			num_scheds = 1;
>  			break;
>  		case AMDGPU_HW_IP_COMPUTE:
> -			scheds = adev->gfx.compute_sched;
> -			num_scheds = adev->gfx.num_compute_sched;
> +			if (priority <= DRM_SCHED_PRIORITY_NORMAL) {
> +				scheds = adev->gfx.compute_sched;
> +				num_scheds = adev->gfx.num_compute_sched;
> +			} else {
> +				scheds = adev->gfx.compute_sched_high;
> +				num_scheds = adev->gfx.num_compute_sched_high;
> +			}

Why more if-conditionals?

If you initialize a map of DRM_SCHED_PRIORITY_MAX of type then you can simply do:

scheds = adev->gfx.map[priority];

So, part of your array would contain normal and the rest high.

Also, I don't think you should introduce yet another
compute_sched[] array. All this should be folded into
a single array containing both normal and high.

Also consider changing to this:

enum drm_sched_priority {
	DRM_SCHED_PRIORITY_UNSET,
--------DRM_SCHED_PRIORITY_INVALID,--------<--- remove
	DRM_SCHED_PRIORITY_MIN,
	DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,
	DRM_SCHED_PRIORITY_NORMAL,
	DRM_SCHED_PRIORITY_HIGH_SW,
	DRM_SCHED_PRIORITY_HIGH_HW,
	DRM_SCHED_PRIORITY_KERNEL,
	DRM_SCHED_PRIORITY_MAX,
};

We should never have an "invalid priority", just ignored priority. :-)
Second, having 0 as UNSET gives you easy priority when you set
map[0] = normal_priority, as memory usually comes memset to 0.
IOW, you'd not need to check against UNSET, and simply use
the default [0] which you'd set to normal priority.

>  			break;
>  		case AMDGPU_HW_IP_DMA:
>  			scheds = adev->sdma.sdma_sched;
> @@ -502,6 +507,24 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>  	return fence;
>  }
>  
> +static void amdgpu_ctx_hw_priority_override(struct amdgpu_ctx *ctx,
> +					    const u32 hw_ip,
> +					    enum drm_sched_priority priority)
> +{
> +	int i;
> +
> +	for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
> +		if (!ctx->entities[hw_ip][i])
> +			continue;
> +
> +		/* TODO what happens with prev scheduled jobs */
> +		drm_sched_entity_destroy(&ctx->entities[hw_ip][i]->entity);
> +		amdgpu_ctx_fini_entity(ctx->entities[hw_ip][i]);
> +
> +		amdgpu_ctx_init_entity(ctx, AMDGPU_HW_IP_COMPUTE, i);
> +
> +	}
> +}
>  void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  				  enum drm_sched_priority priority)
>  {
> @@ -515,12 +538,18 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  			struct drm_sched_entity *entity;
> +			struct amdgpu_ring *ring;
>  
>  			if (!ctx->entities[i][j])
>  				continue;
>  
>  			entity = &ctx->entities[i][j]->entity;
> -			drm_sched_entity_set_priority(entity, ctx_prio);
> +			ring = to_amdgpu_ring(entity->rq->sched);
> +
> +			if (ring->funcs->init_priority)
> +				amdgpu_ctx_hw_priority_override(ctx, i, priority);
> +			else
> +				drm_sched_entity_set_priority(entity, ctx_prio);

Why more if-conditionals?
Could we not have a map?

>  		}
>  	}
>  }
> @@ -630,6 +659,7 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  
>  void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>  {
> +	enum drm_sched_priority priority;
>  	int i, j;
>  
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> @@ -638,8 +668,26 @@ void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>  	}
>  
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
> -		adev->gfx.num_compute_sched++;
> +		priority = adev->gfx.compute_ring[i].priority;
> +		if (priority <= DRM_SCHED_PRIORITY_NORMAL) {
> +			adev->gfx.compute_sched[i] =
> +				&adev->gfx.compute_ring[i].sched;
> +			adev->gfx.num_compute_sched++;
> +		} else {
> +			adev->gfx.compute_sched_high[i] =
> +				&adev->gfx.compute_ring[i].sched;
> +			adev->gfx.num_compute_sched_high++;
> +		}
> +	}

I think it would be better to use a map for this
as opposed to if-conditional.

> +
> +	/* if there are no high prio compute queue then mirror with normal
> +	 * priority so amdgpu_ctx_init_entity() works as expected */
> +	if (!adev->gfx.num_compute_sched_high) {
> +		for (i = 0; i < adev->gfx.num_compute_sched; i++) {
> +			adev->gfx.compute_sched_high[i] =
> +			       adev->gfx.compute_sched[i];
> +		}
> +		adev->gfx.num_compute_sched_high = adev->gfx.num_compute_sched;
>  	}
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ca17ffb01301..d58d748e3a56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -279,7 +279,9 @@ struct amdgpu_gfx {
>  	unsigned			num_gfx_rings;
>  	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
>  	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> +	struct drm_gpu_scheduler	*compute_sched_high[AMDGPU_MAX_COMPUTE_RINGS];
>  	uint32_t			num_compute_sched;
> +	uint32_t			num_compute_sched_high;
>  	unsigned			num_compute_rings;
>  	struct amdgpu_irq_src		eop_irq;
>  	struct amdgpu_irq_src		priv_reg_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d42be880a236..4981e443a884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
>  
>  	drm_sched_job_cleanup(s_job);
>  
> -	amdgpu_ring_priority_put(ring, s_job->s_priority);
>  	dma_fence_put(job->fence);
>  	amdgpu_sync_free(&job->sync);
>  	amdgpu_sync_free(&job->sched_sync);
> @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>  		      void *owner, struct dma_fence **f)
>  {
>  	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>  	int r;
>  
>  	if (!f)
> @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>  	priority = job->base.s_priority;
>  	drm_sched_entity_push_job(&job->base, entity);
>  
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 18e11b0fdc3e..4501ae7afb2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -326,6 +326,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  
>  	ring->max_dw = max_dw;
>  	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> +	    ring->funcs->init_priority)
> +		ring->funcs->init_priority(ring);
> +

Why not add "init_priority" to all and just call it here unconditionally?

Regards,
Luben

>  	mutex_init(&ring->priority_mutex);
>  
>  	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
