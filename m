Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF9C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423B920739
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zQ6uCx3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1396E9F2;
	Wed, 11 Mar 2020 20:00:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D046E9F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6CTU5vM5OzQho6+Nt/6WNMIX6nwPz16lKCMS/O/u1TT+tVF/Hp7znx6oh4xdnF40qRuXy+DWzVI+pDxFTdvPrCD80D2Lu9JxG8SMHc7TVRawv2mZuuNZGLk0OAYXV4GFmWxzmc6Uttxy5i0iu3ultl04Yi1qSO0gGVHxObR0x37AKt2TisxURtYN1pRyYLCgmQ9he1FGobzP2aocoHoOlqsJ2KOu1uueIa+X1p2ha/VqmvrfFZDOLl0MuADJhgVCf1ylJZEbyC4exV1ze0P5f49cDuOt3mM6SZmBZ7rojQpXxy2VfwMZnl9yRs2KVy92Ue4wNyphzQNj6PbDT8DCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWMh3ahv4SesqGmJhPrSAuLJYM1lZ6RbQ7outCNO6i0=;
 b=VuhRx7vU3v+58LV0+upZpIY10ZUNlUGnN6MCxr33/e6QA3IXjjRIFHjVzQNBXmsITw++gXEwmW2GGYDeTaN8FpNmoCnfOGp5xDJ7dXW+G++UaB5xfojHDuy76NF/+n9sCRBePuLk0C646EaMnB1GiU1rlY7Ja+lizQ7Fbe+PUc5XMDzMra+69TIkzAg0/kw9duwDqK0ty21SdZ6aNW4a7c7RFBNO3Q2nLwyTHiGnNjvkqMgvKBMlUp+sVUYoRgRweaAz4WMHLrzWUQvMQxpK68FlPz/Xwv2QHdfTuYOLGqrugngeCOmvIB2G28IX4F7O9CaNSN8tHkeZcCLsxvk4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWMh3ahv4SesqGmJhPrSAuLJYM1lZ6RbQ7outCNO6i0=;
 b=zQ6uCx3JeJRwZTFY9C84c2Do+NY6evLXNP54vC/oqIGrghS9XnkQ71wzfcjv4jIybqAka5ix873KwgvL+rNFQicH9R1w6umfjidaX157Xcxq0lf612prJo5NIaaODV3XjNfj9BjOMazQFn89VIKa1aJZ6y0gK2j6n9l5h9VkCtQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1182.namprd12.prod.outlook.com (2603:10b6:300:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:00:07 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:00:06 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: 20200311195759.49332-1-nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
References: <20200311200032.50502-1-nirmoy.das@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <4fc782f4-8274-f69a-e4f8-8b087511a94d@amd.com>
Date: Wed, 11 Mar 2020 16:00:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200311200032.50502-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:00:05 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 324cc94a-521d-4dfb-214e-08d7c5f6cba6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1182:|MWHPR12MB1182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB11823433E5EDFA99C400A0C6EAFC0@MWHPR12MB1182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(52116002)(2906002)(186003)(16526019)(316002)(4326008)(81166006)(478600001)(81156014)(31686004)(8676002)(2616005)(26005)(956004)(66476007)(66946007)(66556008)(16576012)(5660300002)(53546011)(86362001)(6486002)(36756003)(8936002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1182;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhWhExI5W1OkCXr8neFE/oLQrD2kLtNqeEhmCQ68JYJOX71WeO+vdQDdtrHjpAHaxAv/cuj5yZ9Jco4QTmfv02PVP2JZEdFxLTyMHiXDNJJGVwzORYI8cIp3zq/ZTQGShx493yLHyz8/AMx3hGobWqSyfhyu+5f8wbsLxQALwqLQKNnvB6OPtSStMsEoLuNkgYEjUEN1901lKi8rPjh/bZkV0kuFAATmWLtloPnKnBg9i/Xa6OzMj38XeFbgC8e3RZ/1qM4FdomEJMQP1B3RlxowtI9ZxThXKTdDXAOWoAc1RCMgB2o0IugCWEtce3fQgbn5l0eb2TIYan+qLp/VZfC5Mkp1tfRkPqhPZ8iCIFiXaaGGGlq2SzXgoO9qh3Mdg+Wafe4ROieH4q/PwxlYKei0VNAO3EaaYWw3U4X/+vydMhlw15OKnPDdjLyz/C6n
X-MS-Exchange-AntiSpam-MessageData: 0HS6OOHK1IZsVdjopQe+1qGPEmi5156fWZe9kgFh9jeTvMe3mFnzm0O1S+6flGZwYdSPiGQdx9EAplDPp89nJ9Z62mM1xyqSU3yrGBeFyiglmyQbar9PEI8vjCZ/oSJW/8yL9p5fmisuu9okgaWB0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324cc94a-521d-4dfb-214e-08d7c5f6cba6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:00:06.8302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taVn3adDqLqSX84xHjluilOI9ayK1DKnVueNPV+F3ME9nOWHJ5a3yuLls8HKoesSprbooYCctg+OjmgX8Fg+WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1182
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/11/20 4:00 PM, Nirmoy Das wrote:
> VCN HW  doesn't support dynamic load balance on multiple
> instances for a context. This patch modifies entity's
> sched_list to a sched_list consist of only one drm scheduler.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 ++
>   8 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 8304d0c87899..db0eef19c636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1203,6 +1203,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   			    union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
>   	struct drm_sched_entity *entity = p->entity;
>   	enum drm_sched_priority priority;
>   	struct amdgpu_bo_list_entry *e;
> @@ -1257,6 +1258,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
> +	if (ring->funcs->no_gpu_sched_loadbalance)
> +		amdgpu_ctx_disable_gpu_sched_load_balance(entity);
> +


Why this needs to be done each time a job is submitted and not once in 
drm_sched_entity_init (same foramdgpu_job_submit bellow ?)

Andrey


>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fa575bdc03c8..1127e8f77721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -559,6 +559,19 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   	}
>   }
>   
> +/**
> + * amdgpu_ctx_disable_gpu_sched_load_balance - disable gpu_sched's load balancer
> + * @entity: entity on which load balancer will be disabled
> + */
> +void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity)
> +{
> +	struct drm_gpu_scheduler **scheds = &entity->rq->sched;
> +
> +	/* disable gpu_sched's job load balancer by assigning only one */
> +	/* drm scheduler to the entity */
> +	drm_sched_entity_modify_sched(entity, scheds, 1);
> +}
> +
>   int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   			       struct drm_sched_entity *entity)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index de490f183af2..3a2f900b8000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -90,5 +90,6 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>   
>   void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
>   
> +void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4981e443a884..64dad7ba74da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -140,6 +140,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f)
>   {
> +	struct amdgpu_ring *ring = to_amdgpu_ring(entity->rq->sched);
>   	enum drm_sched_priority priority;
>   	int r;
>   
> @@ -154,6 +155,8 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   	amdgpu_job_free_resources(job);
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
> +	if (ring->funcs->no_gpu_sched_loadbalance)
> +		amdgpu_ctx_disable_gpu_sched_load_balance(entity);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 448c76cbf3ed..f78fe1a6912b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -115,6 +115,7 @@ struct amdgpu_ring_funcs {
>   	u32			nop;
>   	bool			support_64bit_ptrs;
>   	bool			no_user_fence;
> +	bool			no_gpu_sched_loadbalance;
>   	unsigned		vmhub;
>   	unsigned		extra_dw;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 71f61afdc655..749ccdb5fbfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1871,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> @@ -1905,6 +1906,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f2745fd1ddb3..c48423b54bc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1954,6 +1954,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
> @@ -1984,6 +1985,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> +	.no_gpu_sched_loadbalance = true,
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 9b22e2b55132..1cc8e1420fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1478,6 +1478,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
> @@ -1577,6 +1578,7 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
>   static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> +	.no_gpu_sched_loadbalance = true,
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
