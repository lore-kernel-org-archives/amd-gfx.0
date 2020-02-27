Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FEDC4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7996B24670
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Oa6uijny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7996B24670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5306E593;
	Thu, 27 Feb 2020 10:08:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226766E593
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 10:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2s1kCSNhGYz0EOfNncqj10mISB/hHji27dDPVPKU8ZTNFbKojAi+ru542vHOkzX6pK6U33DATeymCajmfjTR48RLuSD8G/WgrUpxAOsjwAe/ZQHF5/aEbfxJhNdEhPeDvzCsC9Qj2Tsg/mnvg3xyJqe2R5SdU4jyblxjMMBdULcFsWqpgnqEGzp9cgjprWo021pP5x+m5P/xcGbd3YxOk5ZDAlV73I+/jJnvDyc+IEIU3e1LIHNv5nWC1C5XjEcGu2L1EkaKg+RxLbP2C9OHnQaDC7N8tLxNl6FE10bsq5mTwZeCckCP/RWGP7bpELsKtreikNlbxCEpe0i9/TyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf6Z7eWFx57kMjakGEFoFuI+kIGh3OnlrDQhxXKXpEY=;
 b=DqbHuOZtWjnNUHqaFVL8b+re8rhyAH/V+8tgU1+5S2PwXl8R7jN+38HAO3hQ++m53VUoz8/eJ+pGBMWo2rA6dylU8b6mpQGTfxuSZlXaM+PLgYARPmOyq1mK8EgIHv1ss8bd6Aabm7WnPq0hAogxw7HlpjJMhakX+2y/j+6e0DCa0oZ0f/A8VHIXc6GXZhmi7I7tVA7X/SXNDSl+uFlENBQgKMnyDSpLlaLKp6Ri5jLyjU192CbXMA2v+BmS9gbU/Ei/wSCU2eQXFUD+QJasQ9Uae1FUe3hp2PInJmT0bOpZ9h51HzJJoFgSY0j7nBXAgirIYOXW1mJ6XZHhUKkhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf6Z7eWFx57kMjakGEFoFuI+kIGh3OnlrDQhxXKXpEY=;
 b=Oa6uijnyg9HSDcs0scJMesq/RpRVypRDQzvBztIILzjbO3+5v55m/HkTaOLPfoosrFLBHVtmUsv0SP8XyaHNbMYoHRDHLO6rCTGrp0zi9ol/fp0vaPjt8KfvuT4FQSqRzZ2jFctObLhC5cF/2a1BmNA11NQO5V13bNnowTT2gjk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1849.namprd12.prod.outlook.com (2603:10b6:3:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 10:08:26 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Thu, 27 Feb
 2020 10:08:26 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
Date: Thu, 27 Feb 2020 11:08:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200226203730.4621-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:205:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Thu, 27 Feb 2020 10:08:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dc02bb1-0b18-4758-f134-08d7bb6cfc88
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18492A173D123817ADAA242D83EB0@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(31686004)(6666004)(2906002)(4326008)(478600001)(86362001)(316002)(52116002)(36756003)(66946007)(66556008)(81156014)(31696002)(66476007)(16526019)(8936002)(5660300002)(6486002)(2616005)(8676002)(186003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsxXAUxnPh5BBwmfwz/4YXhPXqVK/O46xYfXyYJu4T3CkIJ9Aq34518x3GeWUmxgqUpyKbLejDAr7QikR4llnjkv8fnXHo5cqmFYeTISiM4mIQ0jdsC+5QPpTUBj7oCHiiwNmESEFvXmeHOrD2Ln0qtYYd8VmIcmxTX4EW4po3AyP6VDhH/L42oJgjYk8kaFe91CN6wyCQbgP3+xDHta1kpHz8kd9uTzP6npVn92jslgHlwAXNAILAAx5yk0XtwCNFgcN4LmNSuTqEfbnIMOqb2NjkFth2UppsxCA6LmUCmHfAfmPCqkaTQ0Ds6JdeIokuWLCt9oJzXtI+6eYVKrf/K8mWicjmoF/rEGTYoJoHRrG4Ow5Ub7hbvo/gHxmTcBfXpwTLUo1fLXUVHVt5ZLL7ekbtOIACrTHB1SATRUxSQcVWEBDCgT/AjRSw4F+yAw
X-MS-Exchange-AntiSpam-MessageData: abhYqxII4n+0cN0K7sbKHp89Q5HZoiSqsLYYw7nhlCWNGWwrCz084wrpZJZ078CcSeUOiighRSq+TejjIbBdsst1Ed2Bi78lL5Md9pzesmYbwDc3MLmppW17YAOs1Y3QiYs+Slo1luyhUmlhxU1HU58OkOZ5rJwo5MXcYu1Iwyby06H2RDlmUn6s3Wh3rOGGyOCHo5AIcmR9BdYtVa6FcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc02bb1-0b18-4758-f134-08d7bb6cfc88
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:08:26.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r7WcmVIIlRw4Sw2lpMlbbE2rI3szq20KSfCvPM4T9FvXf4q2glwhyQjZGo7OAoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.02.20 um 21:37 schrieb Nirmoy Das:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 58 ++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  4 ++
>   5 files changed, 59 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f397ff97b4e4..8304d0c87899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>   	struct drm_sched_entity *entity = p->entity;
>   	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>   	struct amdgpu_bo_list_entry *e;
>   	struct amdgpu_job *job;
>   	uint64_t seq;
> @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 94a6c42f29ea..ea4dc57d2237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -85,8 +85,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>   			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_COMPUTE:
> -			scheds = adev->gfx.compute_sched;
> -			num_scheds = adev->gfx.num_compute_sched;
> +			if (priority <= DRM_SCHED_PRIORITY_NORMAL) {
> +				scheds = adev->gfx.compute_sched;
> +				num_scheds = adev->gfx.num_compute_sched;
> +			} else {
> +				scheds = adev->gfx.compute_sched_high;
> +				num_scheds = adev->gfx.num_compute_sched_high;
> +			}
>   			break;
>   		case AMDGPU_HW_IP_DMA:
>   			scheds = adev->sdma.sdma_sched;
> @@ -502,6 +507,24 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   	return fence;
>   }
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

If we do it right, that should be unproblematic.

The entity changes the rq/scheduler it submits stuff to only when it is 
idle, e.g. no jobs on the hardware nor software queue.

So changing the priority when there is still work should be ok because 
it won't take effect until the entity is idle.

Can of course be that userspace then wonders why the new priority 
doesn't take effect. But when you shoot yourself into the foot it is 
supposed to hurt, doesn't it?

> +		drm_sched_entity_destroy(&ctx->entities[hw_ip][i]->entity);
> +		amdgpu_ctx_fini_entity(ctx->entities[hw_ip][i]);
> +
> +		amdgpu_ctx_init_entity(ctx, AMDGPU_HW_IP_COMPUTE, i);

Well, that is most likely NOT the right way of doing it :) Destroying 
the entity with fini and reinit might cause quite a bunch of problems.

Could be that this works as well, but I would rather just assign 
sched_list and num_sched_list.

> +
> +	}
> +}
>   void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   				  enum drm_sched_priority priority)
>   {
> @@ -515,12 +538,18 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>   			struct drm_sched_entity *entity;
> +			struct amdgpu_ring *ring;
>   
>   			if (!ctx->entities[i][j])
>   				continue;
>   
>   			entity = &ctx->entities[i][j]->entity;
> -			drm_sched_entity_set_priority(entity, ctx_prio);
> +			ring = to_amdgpu_ring(entity->rq->sched);
> +
> +			if (ring->funcs->init_priority)

As Alex noted in patch #1 we need to do a bit different, but I'm also 
not 100% sure how.

Maybe ping Alex on this once more or just add a bool to ring->funcs 
indicating that we can do this.

> +				amdgpu_ctx_hw_priority_override(ctx, i, priority);
> +			else
> +				drm_sched_entity_set_priority(entity, ctx_prio);

It might be a good idea to do this anyway, even with the different 
hardware priorities around.

>   		}
>   	}
>   }
> @@ -630,6 +659,7 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   
>   void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>   {
> +	enum drm_sched_priority priority;
>   	int i, j;
>   
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> @@ -638,8 +668,26 @@ void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>   	}
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
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
> +
> +	/* if there are no high prio compute queue then mirror with normal
> +	 * priority so amdgpu_ctx_init_entity() works as expected */
> +	if (!adev->gfx.num_compute_sched_high) {
> +		for (i = 0; i < adev->gfx.num_compute_sched; i++) {
> +			adev->gfx.compute_sched_high[i] =
> +			       adev->gfx.compute_sched[i];
> +		}
> +		adev->gfx.num_compute_sched_high = adev->gfx.num_compute_sched;

It might be a good idea to have this chunk in patch #1 instead.

Regards,
Christian.

>   	}
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ca17ffb01301..d58d748e3a56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -279,7 +279,9 @@ struct amdgpu_gfx {
>   	unsigned			num_gfx_rings;
>   	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
>   	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> +	struct drm_gpu_scheduler	*compute_sched_high[AMDGPU_MAX_COMPUTE_RINGS];
>   	uint32_t			num_compute_sched;
> +	uint32_t			num_compute_sched_high;
>   	unsigned			num_compute_rings;
>   	struct amdgpu_irq_src		eop_irq;
>   	struct amdgpu_irq_src		priv_reg_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d42be880a236..4981e443a884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
>   
>   	drm_sched_job_cleanup(s_job);
>   
> -	amdgpu_ring_priority_put(ring, s_job->s_priority);
>   	dma_fence_put(job->fence);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f)
>   {
>   	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>   	int r;
>   
>   	if (!f)
> @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 18e11b0fdc3e..4501ae7afb2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -326,6 +326,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   
>   	ring->max_dw = max_dw;
>   	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> +	    ring->funcs->init_priority)
> +		ring->funcs->init_priority(ring);
> +
>   	mutex_init(&ring->priority_mutex);
>   
>   	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
