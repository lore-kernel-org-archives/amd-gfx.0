Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CBC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3109420838
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JrqGBgop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3109420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF186E3F4;
	Fri, 24 Jan 2020 15:31:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891986E3F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 15:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORO3AR5KWPwEQKelCgoEtupeUnZbgcc4Dis9QfXmEQFUlFvzo9x9Lx/naaOYmxqiDZq03GMFSDkrCZ8HgFGK40vJuloH1IdGBBvDlx6/J2dC6pgFgphVkiGiABFkh9c24W1h2sE6Gy07qYoSyCmXhetwLb4/orWQFdwTRl7DMgD0AApEAKYwgJPujieo6WM1qL28nQulV9NvoAkOttbG25WJINn/GuecWBS3cShs2MlFX6xur7v74l1esZDrgKubzWlVoSAfp7Y2hPS/P4nx0vEBqYxB3x6X5GkxJDdwqcj8rzlLxAb66CZE40YWh0c/er87xrD9gLtQi0sCNsuMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1hwd2y2NrXOhCFDCMvJ33Ou23fct84/SfnnvEVzZTY=;
 b=Smxl336U8bddndFCEyFXJKAeXkGho0/wGNlD9YCA1OGoPGb9qYogt7L0yKRnG2nopsr7OfxmZ5zpQjKPOlU4EsdpEElfMKhVqV9YAc94nxsg7LAVLneNYi87FGKXy8ZXGHZCBeSqRhk8oaijswbYxBIMF+5eIhQwuq1pHZqoNlzFHkKQMsS0P5BAmVd74a2HlOHuHlUNlumHPEpFOKloJOfnoyYKTOWdwRr1vJqXUuNYlK6yKUyxratLzoHf7c97DuIIUazxz2AkN8EQQCKuw8ayRA1UOJOcOYYVemuqx42iAjXoie4/QzcIqWTl18fUNjfPzA3AWIyoMjfvqFRo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1hwd2y2NrXOhCFDCMvJ33Ou23fct84/SfnnvEVzZTY=;
 b=JrqGBgopUY/dkscsQSree9yMW6V8N3Kyjo2FW146BfE1mlC+R+9q96BRGqo4AZwCNtpYQ0cEFZQliiHyZTGoTv5f7l9HQqUENrZ8oWqJ6ucsHXPTmetnL2x+VqwSxa1s2NYqnjcfGSZlFJqMQsaKO4vlds5fOtVwGNUtpyUKwgo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from MWHPR12MB1710.namprd12.prod.outlook.com (10.175.56.16) by
 MWHPR12MB1565.namprd12.prod.outlook.com (10.172.53.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Fri, 24 Jan 2020 15:31:08 +0000
Received: from MWHPR12MB1710.namprd12.prod.outlook.com
 ([fe80::1980:e91a:a256:269b]) by MWHPR12MB1710.namprd12.prod.outlook.com
 ([fe80::1980:e91a:a256:269b%8]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 15:31:07 +0000
Subject: Re: [PATCH V2] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <20200124151541.3429-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a9dd4057-d663-39fe-17e1-26b93a9aa77a@amd.com>
Date: Fri, 24 Jan 2020 16:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200124151541.3429-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To MWHPR12MB1710.namprd12.prod.outlook.com
 (2603:10b6:300:114::16)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Fri, 24 Jan 2020 15:31:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a81d440-4366-4369-20c8-08d7a0e26e76
X-MS-TrafficTypeDiagnostic: MWHPR12MB1565:|MWHPR12MB1565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1565E78F57979BF65241BECC830E0@MWHPR12MB1565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(8936002)(16526019)(66946007)(186003)(6666004)(4326008)(52116002)(2616005)(86362001)(316002)(478600001)(31696002)(5660300002)(8676002)(66556008)(30864003)(66476007)(81156014)(31686004)(36756003)(2906002)(6486002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1565;
 H:MWHPR12MB1710.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vM5UGMH1HB228xj5f43sHMVbJmoUcQVYIZrWgmp0r7xLTWC6Zk7UTftaXYyjx/BYmnUqA0yFTpDIYmdjSWHILDTkWzA3c57kaW5YzgcRuQc///+UZ1IqFJDtCr8koReJkAUFvAZKwzLEoXvi22sl4KtJEY04hMs3VFh9WsdX/gfS9CfD2Vgu40pZb3fQvR+cyqyWiWrzxJF30hlOYqrpL/+ztc8o+FJEi8iwYKh0yPI4Inu9MJmpJ75M71+MtWSJ7PhNE8WxzAKJ6/ATQOQ7DN7hplJK8K2CkXqCFAyNpB2PC3aUP7y98ZNzPl4KC+7JR8dgV8zC18R4YO/jM5taNyUrYv625b7PBCb4Qp+/QEi0/vRrwoVG3lcAqKXguchTCeQoSti6X1rO3tP1pzWVpGC3+CzR7NAyhHeM840tEQmdLeW9rEtbx02KlzRysVxH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a81d440-4366-4369-20c8-08d7a0e26e76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 15:31:07.5521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0f/41MD+hWkZ1tcoylct4f62cFO5aI+SGz9I2WXHm0nsdVptbxf47hFefYqbwGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1565
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

Am 24.01.20 um 16:15 schrieb Nirmoy Das:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 231 ++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   6 +-
>   2 files changed, 122 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 05c2af61e7de..d246ae9fe0eb 100644
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
> @@ -68,64 +61,26 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
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
> +	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
> +			 GFP_KERNEL);
> +	if (!entity)
> +		return  -ENOMEM;
>
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
> +	entity->sequence = 1;
>
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
> +	ctx->entities[hw_ip][ring] = entity;
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;
> +	switch (hw_ip) {
>   		case AMDGPU_HW_IP_GFX:
>   			sched = &adev->gfx.gfx_ring[0].sched;
>   			scheds = &sched;
> @@ -166,63 +121,87 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
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

You also need to reset ctx->entities[hw_ip][ring] to NULL here.

Even better would be to use kfree(entity) and only assign 
ctx->entities[hw_ip][ring] to entity when everything worked as expected.

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

Maybe just use AMDGPU_MAX_ENTITY_NUM here.

> +			struct amdgpu_ctx_entity *entity;
> +
> +			if (!ctx->entities[i] || !ctx->entities[i][j])
> +				continue;
>
> -		for (j = 0; j < amdgpu_sched_jobs; ++j)
> -			dma_fence_put(entity->fences[j]);
> +			entity = ctx->entities[i][j];
> +			if (!entity->fences)
> +				continue;

Well that won't work, since entity->fences is now embedded into the 
structure. I think you can just drop the "if".

>
> -		kfree(entity->fences);
> +			for (k = 0; k < amdgpu_sched_jobs; ++k)
> +				dma_fence_put(entity->fences[k]);
> +
> +			kfree(entity);

Maybe move that into a amdgpu_ctx_fini_entity function.

Regards,
Christian.

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
> @@ -239,7 +218,14 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
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
> --
> 2.24.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
