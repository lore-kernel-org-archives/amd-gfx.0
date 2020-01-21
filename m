Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A94C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 23:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F06524125
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 23:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Y7sqGlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F06524125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231E56EDEB;
	Tue, 21 Jan 2020 23:34:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D1B6EDEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 23:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXjwE7YK3j9kk5LUKSYSjw7FKZSpGrzyvvKCpGINyn0uNW/VmxuVBgGVzK9hqazCfjZC6kuGXikGLYxb6vgBKYlLlC/hutcdAfkvkK5ug+eTQg8c/5i1XH/ETc+0v5PZ5WV4o1Ydr8kmBFDKR2RItS5KgJ0cBqzyf+GjIweOJ1Simnh3XxRdbw8j5FAAuFNRuA05qCaaiNz3whX9jHy806xKDNh2+LkqLk01wIdG9OfuzJI8DOjBpA9UlR9D0ufBv9lDhvxnxKpVQt6VsExvY7Etca82VbgZoVHfsU5HI08kRnjZGVuq4xlpDhbS9GqhyqbqPZJSL6zNVXv3ADxHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8QbZRWPEh7TEpFNmH33j2nFaPCItqetbrT34SZSxpI=;
 b=iQWSu3ee8a8rsYY4E9xrElWM54IknDSpJ2mQxrqQu4J4Tx5RU6BGpWXTZDwn8Qwb56ykDVzdJqu6668WMFIcZxlFxXeHD/1jG4v2Y1kr8zvfDcdGwVKfl23qzmFRfbLvYa3kwXpgd92xUoMrYnwRC/+F5t7EypXCUMtF58BTbcXZ5aqlcAur841vRIiz0mCDA7FcvJe20FKrVWEcx2DTClTM3W2Is5TXhmNTHR3kta3uqNNpN2fJ3ISSL1kRrKKerYzTW6qglVM4r43BfArhNy8GfLd0Mp2OruQV/04JQpZ1fkBOIkd8p3ZOvNU4hmE0neDrjLK1QcJWRwUpyaSMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8QbZRWPEh7TEpFNmH33j2nFaPCItqetbrT34SZSxpI=;
 b=1Y7sqGlb6B0xX1L/HH9/kUsSEORpCrxjo0121bJVLlk1l/6GSbysiNWd8SHKvkhhy0lI6EIfq4ye1PzY17yeMSfwg/D8SF24UHOln7rvuP3o64xNlmkd3C3QeYmcyXoCrqJshyCzrnKLknn6QCVG6HJ4pZt40xUrATC6z2lNUpk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3017.namprd12.prod.outlook.com (20.178.199.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 23:34:51 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 23:34:50 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: individualize amdgpu entity allocation
 per HW IP
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3d159a30-f7f5-a4f7-b63a-26b9f5df0ec2@amd.com>
Date: Tue, 21 Jan 2020 18:34:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200121165002.3709-1-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::36) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 23:34:50 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50b1c9da-9c06-4838-47ff-08d79eca827f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:|DM6PR12MB3017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30177358AEB3842F390E6A73990D0@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(36756003)(8676002)(6512007)(478600001)(66556008)(66476007)(5660300002)(8936002)(31696002)(26005)(81156014)(86362001)(186003)(6506007)(53546011)(81166006)(16526019)(52116002)(2906002)(2616005)(44832011)(31686004)(6486002)(956004)(316002)(66946007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3017;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfsJsu2fVk2cpUcBpEyQfNEqbVhwnJLeBGfoBzUojhaqedTdmfWklwgU+iw20mrMbEGxDDvVn3x65VY28fRks94ZEWZYHM3nr/pl/wi3ZP6/ai7gFNXAxJhrzMgJCBYIceTkPy5EBA/H5T2gGDGxj9RlMMowOX/H8P9WUk2w0FZW7NTz075f8y/zB2saMNajZogFHYfyZ6fSCh2fvXOl7eSNveoI2TMyLmClO6QaVy8Kboe0FmNFgxEEoIXiVzW4U4lG158hOznuk43SXOKNjXsq/tdqv9006yT8sKXxkazvTJCQfucgnNJkZ/psQNeD96xPKNMyrstb7gMPMglwgFqFIrQYifBbG2KK1gq+hdudR7AXuJ/5Uhc9mBzx7Sx2Pe9M3aLWith9z8bTdEWifPF3yFyFU9gNNhgDi9nvjoSmOsdbyOwhg44wXTHzxNkv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b1c9da-9c06-4838-47ff-08d79eca827f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 23:34:50.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGnfYlIqOLzxNwy0BXmD9ttlzXJ6ArWP/M3AN9RHClB8K/D8SqgoEuaB2L7t5NKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-21 11:50 a.m., Nirmoy Das wrote:
> Do not allocate all the entity at once. This is required for
> dynamic amdgpu_ctx_entity creation.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 130 ++++++++++++------------
>  1 file changed, 65 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 05c2af61e7de..91638a2a5163 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -42,16 +42,6 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>  	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
>  };
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
>  static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>  				      enum drm_sched_priority priority)
>  {
> @@ -73,7 +63,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  			   struct drm_file *filp,
>  			   struct amdgpu_ctx *ctx)
>  {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>  	unsigned i, j;
>  	int r;
>  
> @@ -87,28 +76,29 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  	memset(ctx, 0, sizeof(*ctx));
>  	ctx->adev = adev;
>  
> -
> -	ctx->entities[0] = kcalloc(num_entities,
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
>  				   sizeof(struct amdgpu_ctx_entity),
>  				   GFP_KERNEL);

Are these lines indented to the agument list column? They seem
that they are not...

> -	if (!ctx->entities[0])
> -		return -ENOMEM;
>  
> +		if (!ctx->entities[0]) {
> +			r =  -ENOMEM;
> +			goto error_cleanup_entity_memory;
> +		}
> +	}

Brake the paragraphs with an empty line, here.

> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {

Please use a brace for the outer for-loop, the i-counter.
This style leaves the ending row/column
empty for two levels of indentation.

>  
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
>  
> -		entity->sequence = 1;
> -		entity->fences = kcalloc(amdgpu_sched_jobs,
> +			entity->sequence = 1;
> +			entity->fences = kcalloc(amdgpu_sched_jobs,
>  					 sizeof(struct dma_fence*), GFP_KERNEL);

The indentation of sizeof(... seems incorrect.

> -		if (!entity->fences) {
> -			r = -ENOMEM;
> -			goto error_cleanup_memory;
> +			if (!entity->fences) {
> +				r = -ENOMEM;
> +				goto error_cleanup_memory;
> +			}
>  		}
> -	}

This brace would stay...

> -	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
> -		ctx->entities[i] = ctx->entities[i - 1] +
> -			amdgpu_ctx_num_entities[i - 1];
>  
>  	kref_init(&ctx->refcount);
>  	spin_lock_init(&ctx->ring_lock);
> @@ -179,44 +169,52 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  error_cleanup_entities:

Notice this label sits after the "return 0;", so it really
is an "unroll" and "free" operation.

> -	for (i = 0; i < num_entities; ++i)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> +			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
>  
>  error_cleanup_memory:
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)

Add the brace back in for completeness and style.

> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
>  
> -		kfree(entity->fences);
> -		entity->fences = NULL;
> +			kfree(entity->fences);
> +			entity->fences = NULL;
> +		}
> +
> +error_cleanup_entity_memory:

"cleanup" refers to something spilled, or something to be collected.
(Or winning in a wagered game of chance.) Also at "module_exit", maybe.

The kernel has traditionally used "unroll" and "free" for this. Now, since
you're unrolling the loop (notice that it sits after the "return 0;"), then
you can backtrack and name it like this:

Error_unroll_free1:
	for ( ; i >= 0; i--)
		free(my_array[i]);

> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		kfree(ctx->entities[i]);
> +		ctx->entities[i] = NULL;
>  	}
>  
> -	kfree(ctx->entities[0]);
> -	ctx->entities[0] = NULL;
>  	return r;
>  }
>  
>  static void amdgpu_ctx_fini(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>  	struct amdgpu_device *adev = ctx->adev;
> -	unsigned i, j;
> +	unsigned i, j, k;
>  
>  	if (!adev)
>  		return;
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
>  
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +			for (k = 0; k < amdgpu_sched_jobs; ++k)
> +				dma_fence_put(entity->fences[k]);
>  
> -		for (j = 0; j < amdgpu_sched_jobs; ++j)
> -			dma_fence_put(entity->fences[j]);
> +			kfree(entity->fences);
> +		}
>  
> -		kfree(entity->fences);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		kfree(ctx->entities[i]);
> +		ctx->entities[i] = NULL;
>  	}
>  
> -	kfree(ctx->entities[0]);
>  	mutex_destroy(&ctx->lock);
> -
>  	kfree(ctx);
>  }
>  
> @@ -279,14 +277,12 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  static void amdgpu_ctx_do_release(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx;
> -	unsigned num_entities;
> -	u32 i;
> +	u32 i, j;
>  
>  	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -
> -	num_entities = amdgpu_ctx_total_num_entities();
> -	for (i = 0; i < num_entities; i++)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> +			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
>  
>  	amdgpu_ctx_fini(ref);
>  }
> @@ -516,20 +512,21 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>  void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  				  enum drm_sched_priority priority)
>  {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>  	enum drm_sched_priority ctx_prio;
> -	unsigned i;
> +	unsigned i, j;
>  
>  	ctx->override_priority = priority;
>  
>  	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>  			ctx->init_priority : ctx->override_priority;
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)

Brace.

> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  
> -	for (i = 0; i < num_entities; i++) {
> -		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
> +			struct drm_sched_entity *entity =
> +				&ctx->entities[i][j].entity;
>  
> -		drm_sched_entity_set_priority(entity, ctx_prio);
> -	}
> +			drm_sched_entity_set_priority(entity, ctx_prio);
> +		}
	} ;-)
>  }
>  
>  int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
> @@ -564,20 +561,20 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
>  
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>  	struct amdgpu_ctx *ctx;
>  	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>  
>  	idp = &mgr->ctx_handles;
>  
>  	mutex_lock(&mgr->lock);
>  	idr_for_each_entry(idp, ctx, id) {
> -		for (i = 0; i < num_entities; i++) {
> -			struct drm_sched_entity *entity;
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)

Brace.

> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
>  
> -			entity = &ctx->entities[0][i].entity;
> -			timeout = drm_sched_entity_flush(entity, timeout);
> +				entity = &ctx->entities[i][j].entity;
> +				timeout = drm_sched_entity_flush(entity, timeout);
>  		}
>  	}
>  	mutex_unlock(&mgr->lock);
> @@ -586,10 +583,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  
>  void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>  	struct amdgpu_ctx *ctx;
>  	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>  
>  	idp = &mgr->ctx_handles;
>  
> @@ -598,9 +594,13 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
>  			continue;
>  		}
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)

Brace.

> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
>  
> -		for (i = 0; i < num_entities; i++)
> -			drm_sched_entity_fini(&ctx->entities[0][i].entity);
> +				entity = &ctx->entities[i][j].entity;
> +				drm_sched_entity_fini(entity);
> +			}
>  	}
>  }
>  
> 

Regards,
Luben
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
