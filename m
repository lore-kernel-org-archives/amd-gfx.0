Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00191C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48E7601FC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48E7601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F0D6EB3D;
	Fri,  5 Mar 2021 15:14:27 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307536EB3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:14:26 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id t4so2295009qkp.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rwIyzoKCZA01toTsDPftEaNuitwQWIJ9SkyyxbuwWV0=;
 b=DCDkiwbHF0leOTU2HcO6Cw5k7cFQawOg3zU/PrSjl/zwAhnTjQEkFhVATxzpoKWCAY
 PiJwlhGRsbeU1wuvLsRjs8pd8tZU3sgGTJeedD9lBUkwm+Sr93ob/0QTC22Ec1Wbz423
 iFEonQkjgZ7RdDFbrLRWtVrJgOFOBqp3B2X/DJx8k9ZeFQiq+bysWtQoYm0iOmqHNtV5
 UnloaJcvgH7KcW+KyrScLI7XvJfLkUpghDDsxdoBjwv5coEnQ8ywmbceiHdsj4E63wnF
 HxK8A3SwuVf74l0MMVkOhQn1D1/wDMd//KNwf27Oq1DNPDOOBrn8YyyRdep57ShGYcQg
 tlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rwIyzoKCZA01toTsDPftEaNuitwQWIJ9SkyyxbuwWV0=;
 b=QaYKx++PmYNuWfCoXdwnmgVDuaq9eRYOYDEO5eMlQew0dsS4OCSjnRkwEwV5HbZb9D
 /uvB4kchkYvE9uDsToysZEFEP3LvFAwZu5ITqXIQn2aUtRqqzV5zM3naXBB6mvyAuZ9m
 7cO7GEKfR9MbucCBHW6Q58PzT9u8faoZQ9lavxtzGNhO2iT8HYNuq05YzDYPy5o8iTjD
 r3ZLIjw6qi6EA1UdRJMj7URzY/r2Hi0olN86rkPKUFkz+d5jT3hkAZx1gNUzxVtO4xmA
 QScB8sZUzVMdf1d7hQHsx3gHYTltzZH2RooQSuj9fW9iv9oUH5dqI2hB7DoQ2sVtxJT7
 sQWQ==
X-Gm-Message-State: AOAM5306Syk1S/mSkfPLp9ykgUJtM8GXe600Zd57t+jYV25x8BJsGqGV
 tqofQPBHnI3TBv45WMGFaDUiwAjS3RRJ0A==
X-Google-Smtp-Source: ABdhPJw/ahgRvTIRVmjEkA/ihUlcwfh2VRoBClNiTVqpoEW6t/DxBIGjm23od/TUOSYktSqmSTaGnw==
X-Received: by 2002:a05:620a:1323:: with SMTP id
 p3mr9353472qkj.175.1614957265376; 
 Fri, 05 Mar 2021 07:14:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id s23sm2002562qtn.89.2021.03.05.07.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 07:14:24 -0800 (PST)
Subject: Re: [PATCH 5/5] drm/amdgpu: use metadata members of struct
 amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-5-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d49c8320-06b9-c8cd-2c80-d951ab2b3051@gmail.com>
Date: Fri, 5 Mar 2021 16:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305143532.5936-5-nirmoy.das@amd.com>
Content-Language: en-US
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.03.21 um 15:35 schrieb Nirmoy Das:
> These memebers are only needed for BOs created by amdgpu_gem_object_create(),
> so we can remove these from the base class.

This patch must be squashed together with the previous one or we would 
have a broken driver in between.

Christian.

>
> CC:felix.kuehling@amd.com
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 +++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 --
>   3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c5343a5eecbe..f8c8cbd8ab59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -494,8 +494,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>   		*dma_buf_kgd = (struct kgd_dev *)adev;
>   	if (bo_size)
>   		*bo_size = amdgpu_bo_size(bo);
> -	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
>   	if (metadata_buffer)
>   		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
>   					   metadata_size, &metadata_flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2e5cf46251af..81b2cff42481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_user *ubo;
>   
>   	if (bo->pin_count > 0)
>   		amdgpu_bo_subtract_pin_size(bo);
> @@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	}
>   	amdgpu_bo_unref(&bo->parent);
>   
> -	kfree(bo->metadata);
> +	if (bo->tbo.type == ttm_bo_type_device) {
> +		ubo = container_of((bo), struct amdgpu_bo_user, bo);
> +		kfree(ubo->metadata);
> +	}
> +
>   	kfree(bo);
>   }
>   
> @@ -1230,13 +1235,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>   int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>   			    uint32_t metadata_size, uint64_t flags)
>   {
> +	struct amdgpu_bo_user *ubo;
>   	void *buffer;
>   
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}
> +
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>   	if (!metadata_size) {
> -		if (bo->metadata_size) {
> -			kfree(bo->metadata);
> -			bo->metadata = NULL;
> -			bo->metadata_size = 0;
> +		if (ubo->metadata_size) {
> +			kfree(ubo->metadata);
> +			ubo->metadata = NULL;
> +			ubo->metadata_size = 0;
>   		}
>   		return 0;
>   	}
> @@ -1248,10 +1260,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>   	if (buffer == NULL)
>   		return -ENOMEM;
>   
> -	kfree(bo->metadata);
> -	bo->metadata_flags = flags;
> -	bo->metadata = buffer;
> -	bo->metadata_size = metadata_size;
> +	kfree(ubo->metadata);
> +	ubo->metadata_flags = flags;
> +	ubo->metadata = buffer;
> +	ubo->metadata_size = metadata_size;
>   
>   	return 0;
>   }
> @@ -1275,21 +1287,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   			   size_t buffer_size, uint32_t *metadata_size,
>   			   uint64_t *flags)
>   {
> +	struct amdgpu_bo_user *ubo;
> +
>   	if (!buffer && !metadata_size)
>   		return -EINVAL;
>   
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}
> +
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>   	if (buffer) {
> -		if (buffer_size < bo->metadata_size)
> +		if (buffer_size < ubo->metadata_size)
>   			return -EINVAL;
>   
> -		if (bo->metadata_size)
> -			memcpy(buffer, bo->metadata, bo->metadata_size);
> +		if (ubo->metadata_size)
> +			memcpy(buffer, ubo->metadata, ubo->metadata_size);
>   	}
>   
>   	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
> +		*metadata_size = ubo->metadata_size;
>   	if (flags)
> -		*flags = bo->metadata_flags;
> +		*flags = ubo->metadata_flags;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 6cc38b71f7ca..466081fa2083 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -91,9 +91,6 @@ struct amdgpu_bo {
>   	struct ttm_bo_kmap_obj		kmap;
>   	u64				flags;
>   	unsigned			pin_count;
> -	u64				metadata_flags;
> -	void				*metadata;
> -	u32				metadata_size;
>   	unsigned			prime_shared_count;
>   	/* per VM structure for page tables and with virtual addresses */
>   	struct amdgpu_vm_bo_base	*vm_bo;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
