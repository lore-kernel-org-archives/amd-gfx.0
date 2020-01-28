Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5FC33CB3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 10:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408482467B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 10:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ctz2Dcoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408482467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD326ED8D;
	Tue, 28 Jan 2020 10:11:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4BB6ED8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 10:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfwI4H1QP24MNttrSWnWjg0+e910SPbDQ51Ez4+W+1iM15dpaey+TygF9CmPwDheB4unhAi7cWEaaoDEqslPJ4yFcq0OootdbhIZs0upv5xwSTwDKS9Be1vog+W+Z8cXE+nqj7vxp/MTSQSxGlaWZnN0LwWVIe4excA5oRXjHTWodCK/HqYmPF4wQBIgO0tX3izZMO6JRrusnqMuoSZOVg+kFRzCQlwoo4dmAJZWpx2nu+faqDK42FM7jDJ2EcAX7sBIoHaeC0KIC8n9UE1I4SQ0Y90n3b7A2KQ2kpCxO07VMNuXY3V/fpfJmlLbPr2za4hUYa4JKlqMxeQi31ltyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+huuVIEAEAsxE2fjGrl5WRZk8p43O5qrymTzQnYJ8zk=;
 b=JNymulyNjDCCHWEcttXSYicm0PJ189o00S+N4G7DOoUGpGIFHJHW9UQUcda+J3iEhbcQrZNsdbMxQEYj5YclcjEK4Bbpl/K7aPsMusUTumHqnZ0xQh15tAENrjYK5x/1603bsQJtlHIIX35C2IqUwlSgz0/D0K0w8xTT61GGkg+WY/bnyyuWZS/TasBhrcCp5k9Yf70bwZCWzIo8aK9PXB5jAChUdK8kgid2m+tyaKFGarAikxANrUwIwvWO3RDB+t0JMPO4AEif9poSxC505nA8IYPMLWZFkAltPafyrwPg+V5ul3TphadOlJq8n3tdIXfUok2gt8JhIsixqG2yCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+huuVIEAEAsxE2fjGrl5WRZk8p43O5qrymTzQnYJ8zk=;
 b=ctz2DcoeHpDmWzdJhAk9UMRoiDaO91QqEsDf1JdDgM2o5uMPa5h/+PKH3+XhTLYr3tRLBscWTRZ9c9PTz2fzQfAifgL0lGwbo9TDEau+VqiYmFVAuC9wAn7/vzQbnX188Ah+GhXL0doRFgtJRRN6A/JNaMqU6OP4410ydayZJjM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2502.namprd12.prod.outlook.com (52.132.138.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Tue, 28 Jan 2020 10:11:41 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 10:11:40 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <20200124163135.4012-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c309c8f1-ac7a-0c15-18ad-add491214f78@amd.com>
Date: Tue, 28 Jan 2020 11:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200124163135.4012-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0041.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::18) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2c:2200:a989:adcb:9808:964]
 (2003:c5:8f2c:2200:a989:adcb:9808:964) by
 AM0PR06CA0041.eurprd06.prod.outlook.com (2603:10a6:208:aa::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 10:11:39 +0000
X-Originating-IP: [2003:c5:8f2c:2200:a989:adcb:9808:964]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46dcad85-3a8a-4590-6384-08d7a3da77cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:|DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502F953CB55024CD2E012BF8B0A0@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(186003)(66476007)(66556008)(66946007)(31686004)(53546011)(2616005)(52116002)(36756003)(16526019)(31696002)(4326008)(5660300002)(81156014)(81166006)(8676002)(2906002)(6486002)(478600001)(316002)(8936002)(6666004)(30864003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2502;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uxii1X4WEnEtZ/hqHAi0y/dLe/b2uKtc5C7b082Ott5BWYRljgZyChPqgdtbqwngzv7RbGofN3qJDimwcupUjrxBZ06cK5gHSi2opfVFLhABHFWtxbysz2slClogZ5HURPzGRXivRrVyzlHInBTXxZxANGo+xSEmmhTU3EIuTWwEOQH16e8soZHRVv4kVjUm2AbUApKzX/rLo6CpUTyPr2aXXxHpMwoV6JrX+LFTccOE7N/RtcuI7gPfrdapH/2WyTeJTXtdB6EKa7TzcVX7bv0QxBuI3IL3nvLMJadrEe+yHVK8Q2lzVhOTVrYv8Xjwjsl08mp6AaIPSosC0myAHROmbonAxJruRNdss0bsu2uwpJTIXVwrbARA0FeFmk5FTqUSQE9f55gb3Qky6g+Ttkdr+EfkQqb0LcbGg3aa9umpTxrU1Zo+oKPORShx4Mvo
X-MS-Exchange-AntiSpam-MessageData: nkJ9dbqwsO8MBCgmDLLGzhlSX07Ij982sXkUY3SwgdyTgivcIrLVdoIWa5UfxmqMAZGzEaBwaHauA3KuP7N/ZY2wjmknan5TG6JfQ76kTfCah5MSsGAD7Md7k7PMYwGSpAUKPKZYSJKsMfwsMq5qvoC3SYGsyrn3Muos/us06AvXbAp/zbdN9DmAZO1BgBrvCo8Vp1iMNX1JxriAsAes6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dcad85-3a8a-4590-6384-08d7a3da77cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 10:11:40.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdF8vCzqqIdLcdpSk90TX62c4Q/R2bA3IcaHE1zfe14ZeLNTVuTfxWMDvOGUmwUjSPF/l3zgJDRzuJIznNlU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gentle reminder !

On 1/24/20 5:31 PM, Nirmoy Das wrote:
> Currently we pre-allocate entities and fences for all the HW IPs on
> context creation and some of which are might never be used.
>
> This patch tries to resolve entity/fences wastage by creating entity
> only when needed.
>
> v2: allocate memory for entity and fences together
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 235 ++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   6 +-
>   2 files changed, 124 insertions(+), 117 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 05c2af61e7de..94a6c42f29ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -42,19 +42,12 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>   	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
>   };
>   
> -static int amdgpu_ctx_total_num_entities(void)
> -{
> -	unsigned i, num_entities = 0;
> -
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		num_entities += amdgpu_ctx_num_entities[i];
> -
> -	return num_entities;
> -}
> -
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   				      enum drm_sched_priority priority)
>   {
> +	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> +		return -EINVAL;
> +
>   	/* NORMAL and below are accessible by everyone */
>   	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>   		return 0;
> @@ -68,64 +61,24 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
>   
> -static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> -			   struct drm_file *filp,
> -			   struct amdgpu_ctx *ctx)
> +static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
> -	unsigned i, j;
> +	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_ctx_entity *entity;
> +	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
> +	unsigned num_scheds = 0;
> +	enum drm_sched_priority priority;
>   	int r;
>   
> -	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> -		return -EINVAL;
> -
> -	r = amdgpu_ctx_priority_permit(filp, priority);
> -	if (r)
> -		return r;
> -
> -	memset(ctx, 0, sizeof(*ctx));
> -	ctx->adev = adev;
> -
> -
> -	ctx->entities[0] = kcalloc(num_entities,
> -				   sizeof(struct amdgpu_ctx_entity),
> -				   GFP_KERNEL);
> -	if (!ctx->entities[0])
> -		return -ENOMEM;
> -
> +	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
> +			 GFP_KERNEL);
> +	if (!entity)
> +		return  -ENOMEM;
>   
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> -
> -		entity->sequence = 1;
> -		entity->fences = kcalloc(amdgpu_sched_jobs,
> -					 sizeof(struct dma_fence*), GFP_KERNEL);
> -		if (!entity->fences) {
> -			r = -ENOMEM;
> -			goto error_cleanup_memory;
> -		}
> -	}
> -	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
> -		ctx->entities[i] = ctx->entities[i - 1] +
> -			amdgpu_ctx_num_entities[i - 1];
> -
> -	kref_init(&ctx->refcount);
> -	spin_lock_init(&ctx->ring_lock);
> -	mutex_init(&ctx->lock);
> -
> -	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
> -	ctx->reset_counter_query = ctx->reset_counter;
> -	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> -	ctx->init_priority = priority;
> -	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> -
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		struct drm_gpu_scheduler **scheds;
> -		struct drm_gpu_scheduler *sched;
> -		unsigned num_scheds = 0;
> -
> -		switch (i) {
> +	entity->sequence = 1;
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;
> +	switch (hw_ip) {
>   		case AMDGPU_HW_IP_GFX:
>   			sched = &adev->gfx.gfx_ring[0].sched;
>   			scheds = &sched;
> @@ -166,63 +119,90 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   			scheds = adev->jpeg.jpeg_sched;
>   			num_scheds =  adev->jpeg.num_jpeg_sched;
>   			break;
> -		}
> -
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
> -						  priority, scheds,
> -						  num_scheds, &ctx->guilty);
> -		if (r)
> -			goto error_cleanup_entities;
>   	}
>   
> +	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
> +				  &ctx->guilty);
> +	if (r)
> +		goto error_free_entity;
> +
> +	ctx->entities[hw_ip][ring] = entity;
>   	return 0;
>   
> -error_cleanup_entities:
> -	for (i = 0; i < num_entities; ++i)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +error_free_entity:
> +	kfree(entity);
>   
> -error_cleanup_memory:
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +	return r;
> +}
>   
> -		kfree(entity->fences);
> -		entity->fences = NULL;
> -	}
> +static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +			   enum drm_sched_priority priority,
> +			   struct drm_file *filp,
> +			   struct amdgpu_ctx *ctx)
> +{
> +	int r;
>   
> -	kfree(ctx->entities[0]);
> -	ctx->entities[0] = NULL;
> -	return r;
> +	r = amdgpu_ctx_priority_permit(filp, priority);
> +	if (r)
> +		return r;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +
> +	ctx->adev = adev;
> +
> +	kref_init(&ctx->refcount);
> +	spin_lock_init(&ctx->ring_lock);
> +	mutex_init(&ctx->lock);
> +
> +	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
> +	ctx->reset_counter_query = ctx->reset_counter;
> +	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> +	ctx->init_priority = priority;
> +	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> +
> +	return 0;
> +
> +}
> +
> +static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> +{
> +
> +	int i;
> +
> +	if (!entity)
> +		return;
> +
> +	for (i = 0; i < amdgpu_sched_jobs; ++i)
> +		dma_fence_put(entity->fences[i]);
> +
> +	kfree(entity);
>   }
>   
>   static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_device *adev = ctx->adev;
>   	unsigned i, j;
>   
>   	if (!adev)
>   		return;
>   
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> -
> -		for (j = 0; j < amdgpu_sched_jobs; ++j)
> -			dma_fence_put(entity->fences[j]);
> -
> -		kfree(entity->fences);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
> +			amdgpu_ctx_fini_entity(ctx->entities[i][j]);
> +			ctx->entities[i][j] = NULL;
> +		}
>   	}
>   
> -	kfree(ctx->entities[0]);
>   	mutex_destroy(&ctx->lock);
> -
>   	kfree(ctx);
>   }
>   
>   int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   			  u32 ring, struct drm_sched_entity **entity)
>   {
> +	int r;
> +
>   	if (hw_ip >= AMDGPU_HW_IP_NUM) {
>   		DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
>   		return -EINVAL;
> @@ -239,7 +219,13 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   		return -EINVAL;
>   	}
>   
> -	*entity = &ctx->entities[hw_ip][ring].entity;
> +	if (ctx->entities[hw_ip][ring] == NULL) {
> +		r = amdgpu_ctx_init_entity(ctx, hw_ip, ring);
> +		if (r)
> +			return r;
> +	}
> +
> +	*entity = &ctx->entities[hw_ip][ring]->entity;
>   	return 0;
>   }
>   
> @@ -279,14 +265,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>   static void amdgpu_ctx_do_release(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx;
> -	unsigned num_entities;
> -	u32 i;
> +	u32 i, j;
>   
>   	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			if (!ctx->entities[i][j])
> +				continue;
>   
> -	num_entities = amdgpu_ctx_total_num_entities();
> -	for (i = 0; i < num_entities; i++)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
> +		}
> +	}
>   
>   	amdgpu_ctx_fini(ref);
>   }
> @@ -516,19 +505,23 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   				  enum drm_sched_priority priority)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	enum drm_sched_priority ctx_prio;
> -	unsigned i;
> +	unsigned i, j;
>   
>   	ctx->override_priority = priority;
>   
>   	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct drm_sched_entity *entity;
>   
> -	for (i = 0; i < num_entities; i++) {
> -		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
> +			if (!ctx->entities[i][j])
> +				continue;
>   
> -		drm_sched_entity_set_priority(entity, ctx_prio);
> +			entity = &ctx->entities[i][j]->entity;
> +			drm_sched_entity_set_priority(entity, ctx_prio);
> +		}
>   	}
>   }
>   
> @@ -564,20 +557,24 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
>   
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_ctx *ctx;
>   	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>   
>   	idp = &mgr->ctx_handles;
>   
>   	mutex_lock(&mgr->lock);
>   	idr_for_each_entry(idp, ctx, id) {
> -		for (i = 0; i < num_entities; i++) {
> -			struct drm_sched_entity *entity;
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
> +
> +				if (!ctx->entities[i][j])
> +					continue;
>   
> -			entity = &ctx->entities[0][i].entity;
> -			timeout = drm_sched_entity_flush(entity, timeout);
> +				entity = &ctx->entities[i][j]->entity;
> +				timeout = drm_sched_entity_flush(entity, timeout);
> +			}
>   		}
>   	}
>   	mutex_unlock(&mgr->lock);
> @@ -586,10 +583,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>   
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_ctx *ctx;
>   	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>   
>   	idp = &mgr->ctx_handles;
>   
> @@ -599,8 +595,17 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   			continue;
>   		}
>   
> -		for (i = 0; i < num_entities; i++)
> -			drm_sched_entity_fini(&ctx->entities[0][i].entity);
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
> +
> +				if (!ctx->entities[i][j])
> +					continue;
> +
> +				entity = &ctx->entities[i][j]->entity;
> +				drm_sched_entity_fini(entity);
> +			}
> +		}
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index a6cd9d4b078c..de490f183af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -29,10 +29,12 @@ struct drm_device;
>   struct drm_file;
>   struct amdgpu_fpriv;
>   
> +#define AMDGPU_MAX_ENTITY_NUM 4
> +
>   struct amdgpu_ctx_entity {
>   	uint64_t		sequence;
> -	struct dma_fence	**fences;
>   	struct drm_sched_entity	entity;
> +	struct dma_fence	*fences[];
>   };
>   
>   struct amdgpu_ctx {
> @@ -42,7 +44,7 @@ struct amdgpu_ctx {
>   	unsigned			reset_counter_query;
>   	uint32_t			vram_lost_counter;
>   	spinlock_t			ring_lock;
> -	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
> +	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>   	bool				preamble_presented;
>   	enum drm_sched_priority		init_priority;
>   	enum drm_sched_priority		override_priority;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
