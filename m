Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF164C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93D6206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SFyWQtLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93D6206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6E06FA42;
	Fri, 24 Jan 2020 12:09:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC626FA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 12:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0koMLoDww32eL5D/oNZAJkzA+UpJno4n0iQ3dADgJjNJKtWL4Evs49pWkNKZ7j+uA/QC7Qq1ALKGkyoXB9vZD4qAJIUpHP1liI2UZHEkVp2uMGzdFYZuIQEIlpQrT1ump4+DeJdp8Hv87YL+sLnJMSuZVikCxfX4mCUj9mSqmdg7IkVaofzPU8dqeC0d+4w73Fp30c7JXy6TgquLBQI+VBTCrOBRiim78xcMD38ASU9C/oUABRyJVAqxmCWaIAMDF+VkV/y6c9Wga0cxvNDGJvT7WE2qEqCVj/XODw7v2f+UGSxHsDc4mNLLvedHDC2rdno+jW1raEDXSbStub6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnWRyOtuntawZ+L95ikwyM7uLKjy76vGOB6eyj6AVpM=;
 b=P6y+qmufEjkAK7DN/WV6Aeuq/NpUHmKYiZEwo2mTOSFrRWIGyRzV8uvibkbPMWpHQxB3Dp5zUNq/PmRsfWvmNxw49aNAJ9CpDgHzedZIBlMniXANKQJ9u1HQxY92gc0eBlNW1TeNUzzJfy4nrrsJXuHW2xEXabOR+hUEYRPkbCAlPLTcJIH7PQdiRnNV2jZwANWXnHhHhMUv14MI/AHmehuh3DST2IX7ELmjTXZ5y6QucmaQwpjeASWGzI7lSmJ4B6kmphbQ72b85npWJddlQFtfznb9y0YwTRrR1yRdZoizhyDoukjw7FGASAXO6IQ1j+sUo1pHuwXv6PIc1/5bQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnWRyOtuntawZ+L95ikwyM7uLKjy76vGOB6eyj6AVpM=;
 b=SFyWQtLs8FHnwGeeRIddqBOxBlJB23Yd6yBPmmeCa7BXZRHmePi5zwvoNYZQwY301rZ5SfrlBzkvJ3ExONkTzbCXKjuQAa1RTarGlvDuFekucdP1JUh/lQy7pe0SqEBAJQezhgRO9CSwF01Lc3xVM/szv4OuRDNfqmqlNerByEQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1755.namprd12.prod.outlook.com (10.175.85.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Fri, 24 Jan 2020 12:09:48 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 12:09:48 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bc9b30e6-1ecb-574f-8712-446091cca580@amd.com>
Date: Fri, 24 Jan 2020 13:09:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200124115311.8037-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:208:122::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:208:122::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Fri, 24 Jan 2020 12:09:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 355f8425-7361-4702-fe13-08d7a0c64eb6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:|DM5PR12MB1755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1755AB33C4515DABDFFD7507830E0@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(4326008)(6666004)(186003)(66556008)(66476007)(16526019)(66946007)(8676002)(52116002)(8936002)(81156014)(81166006)(316002)(5660300002)(31686004)(2616005)(31696002)(6486002)(86362001)(30864003)(2906002)(478600001)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1755;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmMg9NO/E4GvWay0W4KY+P07+pFZQZHK+GvZTyTbMMXxik88T6d9QYKn687KxRGKU+77CizgWUWrBOm39pKwDyHkhUTZNkdyHQbw9G4xoCsqPXLXBNn23iB31z2csQkld2BofFCuuuZ3f9dzamcF05qjDC/ESBCgX6nKCZ+CFRGgNc+tI4ZDBYYjFodweBCrhDgug40QISUW1vBwuX4rOac0+P3XixMjvvn83KembOTgWyrhGwi3jctbLegsCcaFC/QIoZSauE9MhSethgStH7UDvp+OCLuzp2FzIOzgY05jVUM8VElBSHgUj9+r09uAjKXCS6oTKeF9FkNbDGkwQ05gz4QtFpI7jLwXqQbNScuwVzMJfIa3D9c/UrcD3h9j73QoPNj/V3yHnIlzPSii2ZTX/X70U0VpXXG9c3o/1IJ3WjFId1JXnOQclrNb+Qzu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355f8425-7361-4702-fe13-08d7a0c64eb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 12:09:48.5616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tycCSlX6PYEE+H0llt1zuclTMTkG1UWWno1lnA5aLKHqwLvmdeLt85JUqGuKy+O/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.01.20 um 12:53 schrieb Nirmoy Das:
> Currently we pre-allocate entities and fences for all the HW IPs on
> context creation and some of which are might never be used.
>
> This patch tries to resolve entity/fences wastage by creating entity
> only when needed.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 244 +++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   2 +-
>   2 files changed, 135 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 05c2af61e7de..73f7615df8c1 100644
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
> @@ -68,64 +61,44 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
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
> +	struct drm_gpu_scheduler **scheds;
> +	struct drm_gpu_scheduler *sched;
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
> -
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
> +	if (!ctx->entities[hw_ip]) {
> +		ctx->entities[hw_ip] = kcalloc(amdgpu_ctx_num_entities[hw_ip],
> +					       sizeof(struct amdgpu_ctx_entity *),
> +					       GFP_KERNEL);
> +		if (!ctx->entities[hw_ip])
> +			return  -ENOMEM;

That's complete overkill, just statically allocate the array in the 
amdgpu_ctx structure.

The maximum instance should be 4 IIRC, so something like "struct 
amdgpu_ctx_entity *entities[AMDGPU_HW_IP_NUM][4];" so a maximum of 288 
bytes used.

Only alternative I see would be to allocate the array behind the 
structure, see dma_resv_list_alloc() for an example on how to do this. 
But I don't think that this is worth it.

Christian.

>   	}
> -	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
> -		ctx->entities[i] = ctx->entities[i - 1] +
> -			amdgpu_ctx_num_entities[i - 1];
>   
> -	kref_init(&ctx->refcount);
> -	spin_lock_init(&ctx->ring_lock);
> -	mutex_init(&ctx->lock);
> +	ctx->entities[hw_ip][ring] = kcalloc(1, sizeof(struct amdgpu_ctx_entity),
> +					     GFP_KERNEL);
> +	if (!ctx->entities[hw_ip][ring]) {
> +		r = -ENOMEM;
> +		goto error_free_entity;
> +	}
>   
> -	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
> -	ctx->reset_counter_query = ctx->reset_counter;
> -	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> -	ctx->init_priority = priority;
> -	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> +	entity = ctx->entities[hw_ip][ring];
>   
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		struct drm_gpu_scheduler **scheds;
> -		struct drm_gpu_scheduler *sched;
> -		unsigned num_scheds = 0;
> +	entity->sequence = 1;
> +	entity->fences = kcalloc(amdgpu_sched_jobs,
> +				 sizeof(struct dma_fence*), GFP_KERNEL);
> +	if (!entity->fences) {
> +		r = -ENOMEM;
> +		goto error_free_entity;
> +	}
>   
> -		switch (i) {
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;
> +	switch (hw_ip) {
>   		case AMDGPU_HW_IP_GFX:
>   			sched = &adev->gfx.gfx_ring[0].sched;
>   			scheds = &sched;
> @@ -166,57 +139,85 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
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
> +	r = drm_sched_entity_init(&ctx->entities[hw_ip][ring]->entity,
> +				  priority, scheds,
> +				  num_scheds, &ctx->guilty);
> +	if (r)
> +		goto error_free_entity;
> +
>   	return 0;
>   
> -error_cleanup_entities:
> -	for (i = 0; i < num_entities; ++i)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +error_free_entity:
> +	kfree(ctx->entities[hw_ip][ring]);
> +	return r;
> +}
>   
> -error_cleanup_memory:
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +			   enum drm_sched_priority priority,
> +			   struct drm_file *filp,
> +			   struct amdgpu_ctx *ctx)
> +{
> +	int r;
>   
> -		kfree(entity->fences);
> -		entity->fences = NULL;
> -	}
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
>   
> -	kfree(ctx->entities[0]);
> -	ctx->entities[0] = NULL;
> -	return r;
>   }
>   
>   static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_device *adev = ctx->adev;
> -	unsigned i, j;
> +	unsigned i, j, k;
>   
>   	if (!adev)
>   		return;
>   
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct amdgpu_ctx_entity *entity;
> +
> +			if (!ctx->entities[i] || !ctx->entities[i][j])
> +				continue;
> +
> +			entity = ctx->entities[i][j];
> +			if (!entity->fences)
> +				continue;
>   
> -		for (j = 0; j < amdgpu_sched_jobs; ++j)
> -			dma_fence_put(entity->fences[j]);
> +			for (k = 0; k < amdgpu_sched_jobs; ++k)
> +				dma_fence_put(entity->fences[k]);
>   
> -		kfree(entity->fences);
> +			kfree(entity->fences);
> +			entity->fences = NULL;
> +
> +			kfree(entity);
> +			ctx->entities[i][j] = NULL;
> +		}
> +
> +		kfree(ctx->entities[i];
> +		ctx->entities[i] = NULL;
>   	}
>   
> -	kfree(ctx->entities[0]);
>   	mutex_destroy(&ctx->lock);
> -
>   	kfree(ctx);
>   }
>   
> @@ -239,7 +240,11 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   		return -EINVAL;
>   	}
>   
> -	*entity = &ctx->entities[hw_ip][ring].entity;
> +	if ((ctx->entities[hw_ip] == NULL) || (ctx->entities[hw_ip][ring] == NULL))
> +		amdgpu_ctx_init_entity(ctx, hw_ip, ring);
> +
> +
> +	*entity = &ctx->entities[hw_ip][ring]->entity;
>   	return 0;
>   }
>   
> @@ -279,14 +284,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
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
> +			if (!ctx->entities[i] || !ctx->entities[i][j])
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
> @@ -516,19 +524,23 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
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
> +			if (!ctx->entities[i] || !ctx->entities[i][j])
> +				continue;
>   
> -		drm_sched_entity_set_priority(entity, ctx_prio);
> +			entity = &ctx->entities[i][j]->entity;
> +			drm_sched_entity_set_priority(entity, ctx_prio);
> +		}
>   	}
>   }
>   
> @@ -564,20 +576,24 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
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
> +				if (!ctx->entities[i] || !ctx->entities[i][j])
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
> @@ -586,10 +602,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
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
> @@ -599,8 +614,17 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   			continue;
>   		}
>   
> -		for (i = 0; i < num_entities; i++)
> -			drm_sched_entity_fini(&ctx->entities[0][i].entity);
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
> +
> +				if (!ctx->entities[i] || !ctx->entities[i][j])
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
> index a6cd9d4b078c..ca9363e71df5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -42,7 +42,7 @@ struct amdgpu_ctx {
>   	unsigned			reset_counter_query;
>   	uint32_t			vram_lost_counter;
>   	spinlock_t			ring_lock;
> -	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
> +	struct amdgpu_ctx_entity	**entities[AMDGPU_HW_IP_NUM];
>   	bool				preamble_presented;
>   	enum drm_sched_priority		init_priority;
>   	enum drm_sched_priority		override_priority;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
