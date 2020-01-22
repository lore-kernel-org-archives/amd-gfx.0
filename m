Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244BAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE97A21734
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwuQxapn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE97A21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D126F4C9;
	Wed, 22 Jan 2020 11:40:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3057B6F4C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 11:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BggUn9eDvzLQfWbE83VQqYZeneS7Pbww04JU0skBVdHTGvS8tJwYGcNZK4IcFqg+HIcOXINRYvEZN8VlLnHLeOgSM6FrMIj9IcwxZ7FDf5ZiUY64s2BeJNPB3we6dkhK6+CTCfBUjJNqsUfv3crh3QwZ7ylIVaI2SwVU10knksuIL6wEhI44Kz+0Ek8t3cOw1B+MX0Iqp5PLyHkUcOYZbMqBwJEBQ6zdsKV2Sm7RAKWUhSD6y/ibnVibIchn4m1Ozc/3P2eXMahx+cq61rCyRcyyLqrmvIR5Vqplo8y3T4Nz13YAnZUkol2l5pvg6T48AH5S+hJcmPZABlZGkhVkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iL7mEOgamy15l+4c6jkpuq0dETPnua5lJZ/81e8co8=;
 b=fSdPeZdTbGmVyKZ2fK8mq3izzI+Ovk2vjrNJuWuwLVDT3Yuzj7aV7zwHuXGNBsHd46a5fLua7sIi2ECNoCjNAT+hHf4e6pG9ZXt9EnSHqtnWXFKSfpqIuMeTEh8VNlREDjfONvJkoEX+j2MSE6OTbMTziQc23oTzPWNtDzx6Wa6psGOhA05ZTFzUW6sO29AKJQKJ15blvPUdNZjp6vQlFtQSrAXUZB6BibqGlKik2s6GDlYR3dfL6e+5lhk/gFMlpAM7kzwdAejH7Vvv2MhcWpnV4l7rcJoZvFPu8kssjP1sBM+zeVfYTWF78KZTT94wm3vcgAxmM5XZ3nLIXs3GQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iL7mEOgamy15l+4c6jkpuq0dETPnua5lJZ/81e8co8=;
 b=qwuQxapnH1pb48Oo6pZiNbO3UV9+wdKNTC0wH8d6GZ17xsRso2mE22QMdHYwUJNqyr1US5psO3gH/9VWbMs6e/BELtX69NjGR1IIB1idwUv5hEOzAx6NzEadml5i06aDg5xjCjxCH/FsNv/zzRtNS6HGlLYo7wWlhAe5Ht/MAzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1243.namprd12.prod.outlook.com (10.168.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 11:40:01 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 11:40:01 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200122093306.16737-1-nirmoy.das@amd.com>
 <20200122093306.16737-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02056911-7742-c518-7e12-5b56c149cdee@amd.com>
Date: Wed, 22 Jan 2020 12:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200122093306.16737-2-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:200:42::39) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0029.eurprd07.prod.outlook.com (2603:10a6:200:42::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.11 via Frontend
 Transport; Wed, 22 Jan 2020 11:39:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 170f17e7-eeec-4c75-4bc7-08d79f2fd08c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:|DM5PR12MB1243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB124305FE8DA5F82F5387CD97830C0@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(31686004)(478600001)(2616005)(16526019)(186003)(52116002)(4326008)(31696002)(66476007)(66556008)(86362001)(66946007)(6486002)(5660300002)(6666004)(2906002)(316002)(8936002)(8676002)(81166006)(81156014)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1243;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0T7NADBiuFeJvtFUOq5aFNd06L2GJ7KuOBnbZnyeFQGeWkGoUzWOBBGx2hqwxk9NuIf12EVlDhBmE4bUiv4fFNpsIyLF8RD+quv1zsb6HV+vLhrZBvr6m87cHo0cMDUT0bwwmbhOYxcboSg38Pr0F6ojjT6YuwYWQVrdoiLdy/bkRV2VZ3zjjSrb1rO7bQraFB/Cbqp3qnTamc8NZDjN3bQstkVAQcyxhDm5s4Q6mJCX88qPoi0f+D4WNPwXHxaeL1xFlmLkvE7RaFBcRgYaoYXj6H8xoygheZze+xB3EMF3AyIOT9gtfz5TfinXlgSI3Ff+FWAN4KxIw6U6qMg7zB/x8+CelRSy/qSQPCvZhHxLlTeZzN0SL+upKjOKrliEYSxeYhD5bu1fR++hVSoG2gjQ7y9ixhXWpL+zzCozWWVbG0UgVOo172H1jLDXQSa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170f17e7-eeec-4c75-4bc7-08d79f2fd08c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 11:40:01.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NKOweV9triFUc36OsOk9BrUYBS3hA6EoeU0cnvppf3gvf36Xe2SaHADJNGvm0Z2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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

Am 22.01.20 um 10:33 schrieb Nirmoy Das:
> Currently we pre-allocate entities and fences for all the HW IPs on
> context creation and some of which are might never be used.
>
> This patch tries to resolve entity/fences wastage by creating entities
> for a HW IP only when it is required.
>
> v2: consolidated priority checking at amdgpu_ctx_priority_permit()

Well that is not really what I had in mind. See almost all applications 
use only the first instance of a hw_ip.

So what we should probably do allocate entities on demand instead of 
whole hw_ips.

Do you know what I mean?

Regards,
Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 160 +++++++++++++-----------
>   1 file changed, 87 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eecbd68db986..d704e1bebb1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -45,6 +45,9 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   				      enum drm_sched_priority priority)
>   {
> +	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> +		return -EINVAL;
> +
>   	/* NORMAL and below are accessible by everyone */
>   	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>   		return 0;
> @@ -58,65 +61,37 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
>   
> -static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> -			   struct drm_file *filp,
> -			   struct amdgpu_ctx *ctx)
> +static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip)
>   {
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
> +				       sizeof(struct amdgpu_ctx_entity), GFP_KERNEL);
>   
> -	r = amdgpu_ctx_priority_permit(filp, priority);
> -	if (r)
> -		return r;
> +	if (!ctx->entities[hw_ip])
> +		return  -ENOMEM;
>   
> -	memset(ctx, 0, sizeof(*ctx));
> -	ctx->adev = adev;
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
>   
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
> -					   sizeof(struct amdgpu_ctx_entity),
> -					   GFP_KERNEL);
> +		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
>   
> -		if (!ctx->entities[0]) {
> -			r =  -ENOMEM;
> -			goto error_cleanup_entity_memory;
> +		entity->sequence = 1;
> +		entity->fences = kcalloc(amdgpu_sched_jobs,
> +					 sizeof(struct dma_fence*), GFP_KERNEL);
> +		if (!entity->fences) {
> +			r = -ENOMEM;
> +			goto error_cleanup_memory;
>   		}
>   	}
>   
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
> -
> -			entity->sequence = 1;
> -			entity->fences = kcalloc(amdgpu_sched_jobs,
> -						 sizeof(struct dma_fence*), GFP_KERNEL);
> -			if (!entity->fences) {
> -				r = -ENOMEM;
> -				goto error_cleanup_memory;
> -			}
> -		}
> -	}
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
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;
> +	switch (hw_ip) {
>   		case AMDGPU_HW_IP_GFX:
>   			sched = &adev->gfx.gfx_ring[0].sched;
>   			scheds = &sched;
> @@ -157,12 +132,12 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   			scheds = adev->jpeg.jpeg_sched;
>   			num_scheds =  adev->jpeg.num_jpeg_sched;
>   			break;
> -		}
> +	}
>   
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
> -						  priority, scheds,
> -						  num_scheds, &ctx->guilty);
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
> +		r = drm_sched_entity_init(&ctx->entities[hw_ip][j].entity,
> +					  priority, scheds,
> +					  num_scheds, &ctx->guilty);
>   		if (r)
>   			goto error_cleanup_entities;
>   	}
> @@ -170,30 +145,51 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	return 0;
>   
>   error_cleanup_entities:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
> -	}
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j)
> +		drm_sched_entity_destroy(&ctx->entities[hw_ip][j].entity);
>   
>   error_cleanup_memory:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
> +	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
> +		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
>   
> -			kfree(entity->fences);
> -			entity->fences = NULL;
> -		}
> +		kfree(entity->fences);
> +		entity->fences = NULL;
>   	}
>   
> -error_cleanup_entity_memory:
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		kfree(ctx->entities[i]);
> -		ctx->entities[i] = NULL;
> -	}
> +	kfree(ctx->entities[hw_ip]);
> +	ctx->entities[hw_ip] = NULL;
>   
>   	return r;
>   }
>   
> +static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +			   enum drm_sched_priority priority,
> +			   struct drm_file *filp,
> +			   struct amdgpu_ctx *ctx)
> +{
> +	int r;
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
>   static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> @@ -204,7 +200,14 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   		return;
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
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
>   			for (k = 0; k < amdgpu_sched_jobs; ++k)
>   				dma_fence_put(entity->fences[k]);
> @@ -241,6 +244,9 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   		return -EINVAL;
>   	}
>   
> +	if (ctx->entities[hw_ip] == NULL)
> +		amdgpu_ctx_init_entity(ctx, hw_ip);
> +
>   	*entity = &ctx->entities[hw_ip][ring].entity;
>   	return 0;
>   }
> @@ -285,8 +291,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>   
>   	ctx = container_of(ref, struct amdgpu_ctx, refcount);
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			if (!ctx->entities[i])
> +				continue;
>   			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
> +		}
>   	}
>   
>   	amdgpu_ctx_fini(ref);
> @@ -579,6 +588,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>   			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>   				struct drm_sched_entity *entity;
>   
> +				if (!ctx->entities[i])
> +					continue;
> +
>   				entity = &ctx->entities[i][j].entity;
>   				timeout = drm_sched_entity_flush(entity, timeout);
>   			}
> @@ -601,11 +613,13 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   			DRM_ERROR("ctx %p is still alive\n", ctx);
>   			continue;
>   		}
> -
>   		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>   				struct drm_sched_entity *entity;
>   
> +				if (!ctx->entities[i])
> +					continue;
> +
>   				entity = &ctx->entities[i][j].entity;
>   				drm_sched_entity_fini(entity);
>   			}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
