Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686CAEB64DB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 10:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594E010E43C;
	Wed, 14 Jun 2023 10:38:43 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C7E10E43F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 10:38:26 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5193c97ecbbso406519a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686739105; x=1689331105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=93fbJ3dxKTpDp411p+8u24KVkC132jl3dQCpwK/KMeo=;
 b=bid4e96GovQQPLRZFAZSWMWRxgTsQ2Up+LISGZ3DEA8Zm8n6jVZorxHGzrI0OOS1dv
 khxXEJWbNFIrCfK+XBpSzQltd9lXfQSYZo2TJdrllEpSvSwViXP5SX0OhM/LWjqsuCoT
 RpyFtZbmTFJuFJ4v3Co+xehucNZxmqQe9TsiXBLzFNy1js6er/AsU5ledINrAurJIjmR
 Qk7iz04vk2n6wqdnVaHf0de4cyQiTeJwZikJd9ux5WOs0djJbNCY5g4hSwOnW1FjFsJV
 +LvmmIbNprgt0dizVdKO19/yZyWAt6Y7S8E4SwZJnHob7apxTPaGuD/6oki9TvKbsdx1
 /qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686739105; x=1689331105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93fbJ3dxKTpDp411p+8u24KVkC132jl3dQCpwK/KMeo=;
 b=Wc94uLpkBBQmksWpDgqLJVMfVklDy25NdVCnt5mpMPEHXjom21z0iciNaK+gnwudln
 2vb/Uii12uminRpZX/kcf9BahTtBgP8nJphv3EFeD5yGDhclL1/LPEfSLyYnHQkXqRaK
 kb0a2BOqE30aLbZabWo0qSQ8CGi5M6v22GLQzKIdS8dSjMvGsXjExgD6jGkeYWTg+LUH
 i7EqdBvH5uKcTqynlKj1GnR9ISju+Sc2qfdHNDFFiDAOqtXMc/WcVTMIfQmtVY4tnc+U
 tpAQINh2o4RHEeY/gW2huiU6i+0bcUpM9e+WCxH/wBS/lSvxhi3bZG0gLCj+FeyThhb1
 sdWg==
X-Gm-Message-State: AC+VfDzPkKs2sHZifaJ1g2jGkBLOh3F2bgVuZl6dfjEXsYaYJC2TjxUZ
 V07HYnz9h6t5av0vu1+6ckE=
X-Google-Smtp-Source: ACHHUZ4jA8qwHs1H71Khj5BsdbUk3AJsmUBCVCD0zKn2JBmS4nimNJDraffe1AmuLbHBG0wIlpqeUg==
X-Received: by 2002:a05:6402:5155:b0:514:7a67:44dc with SMTP id
 n21-20020a056402515500b005147a6744dcmr8590511edd.19.1686739104490; 
 Wed, 14 Jun 2023 03:38:24 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15d8:6300:fc64:4eb1:dfe9:8133?
 ([2a00:e180:15d8:6300:fc64:4eb1:dfe9:8133])
 by smtp.gmail.com with ESMTPSA id
 x22-20020aa7cd96000000b0050bca43ff55sm7649383edv.68.2023.06.14.03.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 03:38:21 -0700 (PDT)
Message-ID: <851ebfd9-bad6-8a11-5f73-44b183d2cb36@gmail.com>
Date: Wed, 14 Jun 2023 12:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Implement new dummy vram manager
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230509220144.474723-1-alexander.deucher@amd.com>
 <20230509220144.474723-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230509220144.474723-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.05.23 um 00:01 schrieb Alex Deucher:
> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> This adds dummy vram manager to support ASICs that do not have a
> dedicated or carvedout vram domain.

Well that doesn't seem to make much sense. Why we should have that?

Christian.

>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 67 ++++++++++++++++++--
>   1 file changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 43d6a9d6a538..89d35d194f2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -370,6 +370,45 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>   	return ret;
>   }
>   
> +static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
> +				  struct drm_printer *printer)
> +{
> +	DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
> +}
> +
> +static bool amdgpu_dummy_vram_mgr_compatible(struct ttm_resource_manager *man,
> +				       struct ttm_resource *res,
> +				       const struct ttm_place *place,
> +				       size_t size)
> +{
> +	DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
> +	return false;
> +}
> +
> +static bool amdgpu_dummy_vram_mgr_intersects(struct ttm_resource_manager *man,
> +				       struct ttm_resource *res,
> +				       const struct ttm_place *place,
> +				       size_t size)
> +{
> +	DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
> +	return true;
> +}
> +
> +static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager *man,
> +				struct ttm_resource *res)
> +{
> +	DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
> +}
> +
> +static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
> +			       struct ttm_buffer_object *tbo,
> +			       const struct ttm_place *place,
> +			       struct ttm_resource **res)
> +{
> +	DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
> +	return -ENOSPC;
> +}
> +
>   /**
>    * amdgpu_vram_mgr_new - allocate new ranges
>    *
> @@ -817,6 +856,14 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   	mutex_unlock(&mgr->lock);
>   }
>   
> +static const struct ttm_resource_manager_func amdgpu_dummy_vram_mgr_func = {
> +	.alloc	= amdgpu_dummy_vram_mgr_new,
> +	.free	= amdgpu_dummy_vram_mgr_del,
> +	.intersects = amdgpu_dummy_vram_mgr_intersects,
> +	.compatible = amdgpu_dummy_vram_mgr_compatible,
> +	.debug	= amdgpu_dummy_vram_mgr_debug
> +};
> +
>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
>   	.alloc	= amdgpu_vram_mgr_new,
>   	.free	= amdgpu_vram_mgr_del,
> @@ -841,17 +888,22 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   	ttm_resource_manager_init(man, &adev->mman.bdev,
>   				  adev->gmc.real_vram_size);
>   
> -	man->func = &amdgpu_vram_mgr_func;
> -
> -	err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> -	if (err)
> -		return err;
> -
>   	mutex_init(&mgr->lock);
>   	INIT_LIST_HEAD(&mgr->reservations_pending);
>   	INIT_LIST_HEAD(&mgr->reserved_pages);
>   	mgr->default_page_size = PAGE_SIZE;
>   
> +	if (!adev->gmc.is_app_apu) {
> +		man->func = &amdgpu_vram_mgr_func;
> +
> +		err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> +		if (err)
> +			return err;
> +	} else {
> +		man->func = &amdgpu_dummy_vram_mgr_func;
> +		DRM_INFO("Setup dummy vram mgr\n");
> +	}
> +
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>   	ttm_resource_manager_set_used(man, true);
>   	return 0;
> @@ -886,7 +938,8 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>   		drm_buddy_free_list(&mgr->mm, &rsv->allocated);
>   		kfree(rsv);
>   	}
> -	drm_buddy_fini(&mgr->mm);
> +	if (!adev->gmc.is_app_apu)
> +		drm_buddy_fini(&mgr->mm);
>   	mutex_unlock(&mgr->lock);
>   
>   	ttm_resource_manager_cleanup(man);

