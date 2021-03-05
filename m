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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A59AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B236A601FC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B236A601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697336EB42;
	Fri,  5 Mar 2021 15:16:43 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E586EB42
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:16:41 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id d20so2289371qkc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kLSfKbetnavKw0Q+b+3kX6ZMHf+PLu0VoGe55RJZLIg=;
 b=B6mMcjtc+Rqk0eK7iqJPlHg166PuXK5IYpR1ELuBEBNa307SHdXxIn/QWlSINz/4Ll
 PwyC1FQds5ozyzhIsgaN58u3Xd2WzHFbBNVAvqc6S79fxTY/zqzVSEMLw6j1MkY9uW6c
 DdOO9Puej6yQqt+Jpogksp3L4UKELoxJb3Qrc+bn+cpkuEjS/LGa8cmy2IUoxNnCoNyr
 0OP8R2JWvJybf0QVKuMYwaWMBgJhnyOhdlaRW42QLbKwM0t4O7x6H6LAKUHSj0sQhFdU
 LNW4M42S+ka/mqXoZBY/eO9KymGed72MCYuvUjSbp+Jdt8hel5OIycGnvJ9NBTmzibRe
 5jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kLSfKbetnavKw0Q+b+3kX6ZMHf+PLu0VoGe55RJZLIg=;
 b=pfSNK0ttQpDE9ZMKoJ0Oo+u5N/ZAFK+mNROH3BNbqyAMC12RS+mBc5s2EblxqdyEsB
 U7Py8YwP6bYYx2b5PS4Sj9H6sBhLOgqrGefsHNwBcAS4t4o2vd8LwKTgG9fCKp2V4KS0
 IMjsqxMRwOCNJp94iEVYWSQHzu1JI2xrSAQreNUQLdkfjivD5gSr0u9lVLs0n5ZqHBjh
 EKf6P2FMso8cmBYHb3V2xA/gSquaxQRQd9u1dBHO1W8K1ZVVLzCQBT47K6w/Y5yp3px5
 zQeQfpYiASYChogcdp9/AVX2oAd9uIzXs75w18tjj4ZcQbXBlueRSe8p7rBFKu1rih7E
 gEUA==
X-Gm-Message-State: AOAM532rU3f0fBAgiwmktDdaqVWRbARjeo9Mm38Eu7c/v0ydiWYLNS+V
 HqK3GyCI5dtsFaj3yoFJWRDFSXaOVm4WTQ==
X-Google-Smtp-Source: ABdhPJxLP2aBAQN+1HUPs+V8bgubuWuly6JPhw/z40o/QuK/pwkeeyCZwq8caicG6UQGb0U3feOqzQ==
X-Received: by 2002:a05:620a:13ec:: with SMTP id
 h12mr9262195qkl.460.1614957400888; 
 Fri, 05 Mar 2021 07:16:40 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id s126sm1906590qkf.62.2021.03.05.07.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 07:16:40 -0800 (PST)
Subject: Re: [PATCH 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f4ac0fe7-5af7-4fff-34ae-2ebb0260bc0e@gmail.com>
Date: Fri, 5 Mar 2021 16:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305143532.5936-2-nirmoy.das@amd.com>
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
> Implement a new struct amdgpu_bo_user as subclass of
> struct amdgpu_bo and a function to created amdgpu_bo_user
> bo with a flag to identify the owner.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 12 ++++++++++
>   2 files changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 745393472564..355d01ebce51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -699,6 +699,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @ubo_ptr: pointer to the buffer object pointer
> + *
> + * Create a BO to be used by user application;
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_bo_create_user(struct amdgpu_device *adev,
> +		     struct amdgpu_bo_param *bp,
> +		     struct amdgpu_bo_user **ubo_ptr)
> +{
> +	struct amdgpu_bo *bo_ptr;
> +	int r;
> +
> +	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
> +	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
> +	if (r)
> +		return r;
> +
> +	*ubo_ptr = (struct amdgpu_bo_user *)bo_ptr;

Maybe use container_of here instead. Even better would be a helper to 
upcast a amdgpu_bo pointer into a amdgpu_bo_user pointer.

Christian.

> +	return r;
> +}
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 848dc0a017dd..cbb881afe6da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -114,6 +114,15 @@ struct amdgpu_bo {
>   	struct kgd_mem                  *kfd_bo;
>   };
>   
> +struct amdgpu_bo_user {
> +	struct amdgpu_bo		bo;
> +	u64				tiling_flags;
> +	u64				metadata_flags;
> +	void				*metadata;
> +	u32				metadata_size;
> +
> +};
> +
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>   {
>   	return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -257,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size, uint32_t domain,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> +int amdgpu_bo_create_user(struct amdgpu_device *adev,
> +		     struct amdgpu_bo_param *bp,
> +		     struct amdgpu_bo_user **ubo_ptr);
>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   			   void **cpu_addr);
>   int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
