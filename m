Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C5C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD70601FA
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD70601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B676E2DF;
	Wed,  3 Mar 2021 12:01:17 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3BE6E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 12:01:16 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id m9so1029268edd.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 04:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=sPh6aAtAA/HZVytzbKv6meviyg5e3tl3n/3sElssO8E=;
 b=dmx3JxqggaDXQcn+J2DvFJa7k9EN42sWY0vi8ADx4FgCrAF5RWKc6UXppsDSzTuWej
 QTsHHJfUxD4nrY9jTzG201fKLVDFjRILkKtcgCudmrS+j0c3xsbkwd+RK3G6uP5aKbZb
 7xPL63xwfVKyKymydmEnUUhmACI5NI7eccDT6T1QmRnOL/PksvTB3alZh6CrwjsE0K9j
 tfQXKotDKfkJ2VUZfrWOIjRoO0eOeJFappbLN26zd71G4K1nUJyHJc2rtJgR5twB2mSf
 G18tYBDhfnQL9oHqfA/4lGCAR+iNXBHo47ybz2HF1oNzUy1gvGVd1kKwscG8EAyHDbOf
 pcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sPh6aAtAA/HZVytzbKv6meviyg5e3tl3n/3sElssO8E=;
 b=RJD67s7rNSDEXfgX741P9a9BhhFaTlrDOeenKxbtS2yO2jA/5UMhaz6rkIerJTuqAx
 vu7JghF2zK94gQmS6ofh2g5H3uIcCuCO1DAHmyXIkTKQ7pmlFDUG8B3nGBLSNOHN87eB
 TSEHpAuy29AayRCMfub5gETL8Z2CVX9kjNthbXyz7+Zl4apyk+Ne6OqFVzmCDP7FDtMF
 MGshlrql2nY5Rd3CJlmWvfN1PkZuGlFeE3RPTjtnSIMekHD9dThThyYSC/ikKQ6RRI36
 ILa4avjSno1MGKCEWWRP0E9KEtK5Zcc/BvLDJVnIzzBcjZaeixhb8ht0gMdjwq+icMff
 Dyxw==
X-Gm-Message-State: AOAM530XaJ8kyCGozJ3Sga37c05YXLItvtqywSX9eD7b5JPvGGixC1aR
 ClLQ6i/IJYDKnVXX5d49d+buK7C1U4Fmpg==
X-Google-Smtp-Source: ABdhPJxKFXZ5z0dTbaU6hZdWFJVi0fp/rRg1YlK5h1pMgGJOVyWI8HyY170sH5DMV/eWhXze7vzGaw==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr21035851eds.1.1614772874758; 
 Wed, 03 Mar 2021 04:01:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fea4:8409:66bb:aad2?
 ([2a02:908:1252:fb60:fea4:8409:66bb:aad2])
 by smtp.gmail.com with ESMTPSA id o1sm21622875eds.26.2021.03.03.04.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Mar 2021 04:01:13 -0800 (PST)
Subject: Re: [PATCH v2 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com
References: <20210303092550.110816-1-nirmoy.das@amd.com>
 <20210303092550.110816-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eb637494-e025-8231-94c4-46929bc76644@gmail.com>
Date: Wed, 3 Mar 2021 13:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303092550.110816-2-nirmoy.das@amd.com>
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

Am 03.03.21 um 10:25 schrieb Nirmoy Das:
> Introduce a new flag for amdgpu_bo->flags to identify if
> a BO is created by KFD.
>
> v2: rename AMDGPU_GEM_USER_KFD -> AMDGPU_GEM_CREATE_KFD
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 48 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  2 +-
>   include/uapi/drm/amdgpu_drm.h                 |  5 ++
>   6 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 89d0e4f7c6a8..57798707cd5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1227,7 +1227,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	bp.flags = alloc_flags;
>   	bp.type = bo_type;
>   	bp.resv = NULL;
> -	ret = amdgpu_bo_create(adev, &bp, &bo);
> +	ret = amdgpu_kfd_bo_create(adev, &bp, &bo);
>   	if (ret) {
>   		pr_debug("Failed to create BO on domain %s. ret %d\n",
>   				domain_string(alloc_domain), ret);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8e9b8a6e6ef0..e0ceeb32642c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -234,7 +234,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
>   		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>   		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED))
> +		      AMDGPU_GEM_CREATE_ENCRYPTED |
> +		      AMDGPU_GEM_CREATE_KFD))
>
>   		return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0bd22ed1dacf..1b41b4870c99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -697,6 +697,52 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	return r;
>   }
>
> +/**
> + * amdgpu_kfd_bo_create - create an &amdgpu_bo buffer object with kfd user flag
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @bo_ptr: pointer to the buffer object pointer
> + *
> + * Creates an &amdgpu_bo buffer object; and if requested, also creates a
> + * shadow object.
> + * Shadow object is used to backup the original buffer object, and is always
> + * in GTT.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_kfd_bo_create(struct amdgpu_device *adev,

Please name this amdgpu_bo_create_kfd instead.

> +			 struct amdgpu_bo_param *bp,
> +			 struct amdgpu_bo **bo_ptr)
> +{
> +	u64 flags = bp->flags;
> +	int r;
> +
> +	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	bp->flags = bp->flags | AMDGPU_GEM_CREATE_KFD;
> +	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
> +	if (r)
> +		return r;
> +
> +	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
> +		if (!bp->resv)
> +			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
> +							NULL));
> +
> +		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
> +
> +		if (!bp->resv)
> +			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
> +
> +		if (r)
> +			amdgpu_bo_unref(bo_ptr);
> +	}

I don't think the KFD should ever have a reason to use the shadow buffer 
functionality.

> +
> +	return r;
> +}
> +
> +
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> @@ -1309,7 +1355,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>
>   	abo = ttm_to_amdgpu_bo(bo);
>
> -	if (abo->kfd_bo)
> +	if (abo->flags & AMDGPU_GEM_CREATE_KFD)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>
>   	/* We only remove the fence if the resv has individualized. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8cd96c9330dd..665ee0015f06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -245,6 +245,9 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>   int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_param *bp,
>   		     struct amdgpu_bo **bo_ptr);
> +int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
> +			 struct amdgpu_bo_param *bp,
> +			 struct amdgpu_bo **bo_ptr);
>   int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   			      unsigned long size, int align,
>   			      u32 domain, struct amdgpu_bo **bo_ptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7b2db779f313..030bec382f54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -164,7 +164,7 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
>   	 * Don't verify access for KFD BOs. They don't have a GEM
>   	 * object associated with them.
>   	 */
> -	if (abo->kfd_bo)
> +	if (abo->flags & AMDGPU_GEM_CREATE_KFD)
>   		return 0;
>
>   	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8b832f7458f2..f510e8302228 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -142,6 +142,11 @@ extern "C" {
>    */
>   #define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
>
> +/* Flag that the allocating BO's user is KFD. It should never be used by
> + * user space applications
> + */
> +#define AMDGPU_GEM_CREATE_KFD			(1 << 20)

Why 20? 11 is the next one here.

Christian.

> +
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
>   	__u64 bo_size;
> --
> 2.30.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
