Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE577C2D0CE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 00:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE192253D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 00:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PhvfBVGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE192253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E596EE7E;
	Wed, 22 Jan 2020 00:07:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DFE6EE76
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 00:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNxx4WKaIZcyXxXW/8VyDMoLilDnnlW5/Za5qgGWnqvHOvaAjQwXU9eDyd3IjEnE+GlPZWkp1OI2hywqOMk8TElVdayLtp0eKxXobOz6Szegt6/2DUBnngFXyyQPS02MUb7x6TklISQxflIs+25nAumn1MeOiQoXy45U2b/gPLfe91itYr0SS4SrHn5JBdrwo6CECKVsXlTKTM32qfbnGPRXgkn3zCPIVSTiZn4Qkg4MaV4T2i7C42C/Y1OXlJWg9YO2ouJTQvL/QjyiUVyrwljtT8nRU6YWut4AnWtC1MOcdmJS4iv2iaf0bxx0v/C3Oesm3L/hXYM9s4/y2pGeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhohDcKIBbaNbN4Dz6q+mJ+tnDroUbAxyZN694tyjic=;
 b=ZuVzrXyvENZVHf2Fza8cwSBveow/O8eP9gmp0IVYpzzlmiXc+AwoXn+NTLc7X26e9DxkfWTFHrhX3pa5UeXWKroryQCKXNCtkFkLsVtxDf+F5aEp2di+oJFKwsMxHmf6jCftfGf0QXWmh3Usk6bt/ymycoXRQ0EeA0Z/6m99/xkdvDgpX+zk+rJA9EVDbmEABlmEH5qDQsy/CnRjAYYaIGDOCruDyGBFwg3x6e6EqhF8e2AEvWtsMvRtIoUN0mVeoYBH4sgMHab2ZeBBFSAJgX6hYmLRkYLdQG+weGUe0CF57XIT7YVylrR2Zb4oE86fv/lcQzXS3lBMYsLfOWfeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhohDcKIBbaNbN4Dz6q+mJ+tnDroUbAxyZN694tyjic=;
 b=PhvfBVGgc0ibjyLx4GB6KSI+ZRJFy8J1iIPPRH5CD5UjqQ49stCz56W7+w8b94cdXWmVn6aTGfp3ir17yxq97LXAvm9QVlfnE9bPxbU8V3TnMTMiK5aSpDAnX/RdAYI7Y0enwSFBnnxplTmUI1QS5sKZ7cijvAmFAWcmPEoDIUI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3131.namprd12.prod.outlook.com (20.178.31.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 00:07:04 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 00:07:04 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
 <20200121165002.3709-2-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <50c72f0a-bc2d-3467-0312-edb0bb858fb4@amd.com>
Date: Tue, 21 Jan 2020 19:07:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200121165002.3709-2-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 00:07:04 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83a35977-054b-403f-9172-08d79ecf031a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:|DM6PR12MB3131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31313E76D71B1B4FC7514B63990C0@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(81156014)(6506007)(316002)(53546011)(31696002)(36756003)(5660300002)(8676002)(52116002)(86362001)(478600001)(26005)(81166006)(66946007)(66476007)(66556008)(6512007)(2906002)(4326008)(16526019)(186003)(31686004)(6486002)(8936002)(2616005)(44832011)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3131;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMx5YbHmCjNjRYTnITssUfLquGUYMn2j2iYSAUtlBKIa4rKgRZY+93+jDXpuxAGV6bHsSnftU1wpmeOSxl7RZ/8ffiHzuQnUqREa6rcKOOx1PN/0Bomf5pV1Ks0T/tmdccdD5tf4uuMl0YwtqMs5flJ7BF3H9c1+OUEThG6VclH8qI0O0JpHlXZ3xadKE/eW+cuoAzOy/i83oW1qHHEfTFgjv7mSFkblQTOyym5phRlmx8qRjre9cUwA+DcUNppSdXb5NNnOWDKlhsiUZPj9O3F4uTCkAzvrwWTM7GFX4svBnhA5wPseRLvaupLyPiPNB9Om1ygAHDcsRfPercILw7ost5WnmmayBsbEdDY/JWjo0aTXKKW1aKI/T4jvs1LoRvgIjG6WNDIsM2hYy1W3Cds28aNr9+B0bjg9yaojX0djpy30a+20b3Zeqv96QTCH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a35977-054b-403f-9172-08d79ecf031a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 00:07:04.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ09VeboMokmTKlD16EIDA1LUKDfQOEAikwHmszuc+eoyRmNaziZPnLfEgBTuac/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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
> Currently we pre-allocate entities and fences for all the HW IPs on
> context creation and some of which are might never be used.
> 
> This patch tries to resolve entity/fences wastage by creating entities
> for a HW IP only when it is required.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 163 +++++++++++++-----------
>  1 file changed, 92 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 91638a2a5163..43f1266b1b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -58,64 +58,37 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>  	return -EACCES;
>  }
>  
> -static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> -			   struct drm_file *filp,
> -			   struct amdgpu_ctx *ctx)
> +static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip)

I believe we can set "hw_ip" to "const u32 hw_ip", to protect it
from accidential changes.

>  {
> -	unsigned i, j;
> -	int r;
> +	struct amdgpu_device *adev = ctx->adev;
> +	struct drm_gpu_scheduler **scheds;
> +	struct drm_gpu_scheduler *sched;
> +	unsigned num_scheds = 0;
> +	enum drm_sched_priority priority;
> +	int j, r;
>  
> -	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> -		return -EINVAL;
> +	ctx->entities[hw_ip] = kcalloc(amdgpu_ctx_num_entities[hw_ip],
> +			sizeof(struct amdgpu_ctx_entity), GFP_KERNEL);
>  
> -	r = amdgpu_ctx_priority_permit(filp, priority);
> -	if (r)
> -		return r;
> +	if (!ctx->entities[hw_ip])
> +		return  -ENOMEM;

There seem to be two spaces here.

>  
> -	memset(ctx, 0, sizeof(*ctx));
> -	ctx->adev = adev;
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
>  
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
> -				   sizeof(struct amdgpu_ctx_entity),
> -				   GFP_KERNEL);
> +		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
>  
> -		if (!ctx->entities[0]) {
> -			r =  -ENOMEM;
> -			goto error_cleanup_entity_memory;
> +		entity->sequence = 1;
> +		entity->fences = kcalloc(amdgpu_sched_jobs,
> +				sizeof(struct dma_fence*), GFP_KERNEL);

The indent here seems wrong...

> +		if (!entity->fences) {
> +			r = -ENOMEM;
> +			goto error_cleanup_memory;
>  		}
>  	}
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -
> -			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
> -
> -			entity->sequence = 1;
> -			entity->fences = kcalloc(amdgpu_sched_jobs,
> -					 sizeof(struct dma_fence*), GFP_KERNEL);
> -			if (!entity->fences) {
> -				r = -ENOMEM;
> -				goto error_cleanup_memory;
> -			}
> -		}
>  
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
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;

You don't need parenthesis around the relational equality operator used here.
It has higher precedence than the ternary conditional, in which it is embedded.

> +	switch (hw_ip) {
>  		case AMDGPU_HW_IP_GFX:
>  			sched = &adev->gfx.gfx_ring[0].sched;
>  			scheds = &sched;
> @@ -156,12 +129,12 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  			scheds = adev->jpeg.jpeg_sched;
>  			num_scheds =  adev->jpeg.num_jpeg_sched;
>  			break;
> -		}
> +	}
>  
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
> -						  priority, scheds,
> -						  num_scheds, &ctx->guilty);
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
> +		r = drm_sched_entity_init(&ctx->entities[hw_ip][j].entity,
> +				priority, scheds,
> +				num_scheds, &ctx->guilty);

The indent here seems off...

>  		if (r)
>  			goto error_cleanup_entities;
>  	}
> @@ -169,28 +142,54 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  error_cleanup_entities:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j)
> +		drm_sched_entity_destroy(&ctx->entities[hw_ip][j].entity);
>  
>  error_cleanup_memory:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
> +		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
>  
> -			kfree(entity->fences);
> -			entity->fences = NULL;
> -		}
> -
> -error_cleanup_entity_memory:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		kfree(ctx->entities[i]);
> -		ctx->entities[i] = NULL;
> +		kfree(entity->fences);
> +		entity->fences = NULL;
>  	}
>  
> +	kfree(ctx->entities[hw_ip]);
> +	ctx->entities[hw_ip] = NULL;
> +
>  	return r;
>  }
>  
> +static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +			   enum drm_sched_priority priority,
> +			   struct drm_file *filp,
> +			   struct amdgpu_ctx *ctx)

The indent of the argument list here seems off...

> +{
> +	int r;
> +
> +	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> +		return -EINVAL;

This shouldn't be possible since it is an enum...
But why not do this check in "amdgpu_ctx_priority_permit()"
which is introduced by this patchset and used in the imediately
following line?

Or perhaps fix up amdgpu_to_sched_priority() where it is massaged
from the ioctl argument which is an integer.

On a side note: I noticed that the enum drm_sched_priority
has no DRM_SCHED_PRIORITY_NONE.

I've found value in setting the first value of an enum to
"_NONE" (unless zero actually has a meaning as set by HW/etc., anyway).
Enum drm_sched_priority starts with "_MIN" and "_LOW" which
are both set to the same (zero) value.

So having DRM_SCHED_PRIORITY_NONE, could be used to denote
that no priority was given and any is fine, or to mean
that if the priority was given out of range, set it to "none",
to mean pick any.

> +
> +	r = amdgpu_ctx_priority_permit(filp, priority);
> +	if (r)
> +		return r;
> +
> +	memset(ctx, 0, sizeof(*ctx));
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
>  static void amdgpu_ctx_fini(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> @@ -201,10 +200,18 @@ static void amdgpu_ctx_fini(struct kref *ref)
>  		return;
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
>  		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
> +			struct amdgpu_ctx_entity *entity;
> +
> +			if (!ctx->entities[i])
> +				continue;
> +
> +			entity = &ctx->entities[i][j];
> +			if (!entity->fences)
> +				continue;
>  
> -			for (k = 0; k < amdgpu_sched_jobs; ++k)
> +			for (k = 0; k < amdgpu_sched_jobs; ++k) {
>  				dma_fence_put(entity->fences[k]);
> +			}

LKCS: A single non-compound statement as the body of a loop, doesn't
warrant braces. So you can leave this is it was.

>  
>  			kfree(entity->fences);
>  		}
> @@ -237,6 +244,11 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>  		return -EINVAL;
>  	}
>  
> +	if (ctx->entities[hw_ip] == NULL) {
> +		amdgpu_ctx_init_entity(ctx, hw_ip);
> +	}

No need for braces.

> +
> +
>  	*entity = &ctx->entities[hw_ip][ring].entity;
>  	return 0;
>  }
> @@ -281,8 +293,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>  
>  	ctx = container_of(ref, struct amdgpu_ctx, refcount);
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			if (!ctx->entities[i])
> +				continue;
>  			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
> +		}
>  
>  	amdgpu_ctx_fini(ref);
>  }
> @@ -573,6 +588,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  				struct drm_sched_entity *entity;
>  
> +				if (!ctx->entities[i])
> +					continue;
> +
>  				entity = &ctx->entities[i][j].entity;
>  				timeout = drm_sched_entity_flush(entity, timeout);
>  		}
> @@ -598,6 +616,9 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  				struct drm_sched_entity *entity;
>  
> +				if (!ctx->entities[i])
> +					continue;
> +
>  				entity = &ctx->entities[i][j].entity;
>  				drm_sched_entity_fini(entity);
>  			}
> 

I think these changes are good and in the right direction.

Regards,
Luben
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
