Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76246C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365E1610A3
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365E1610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B0F898EE;
	Tue, 15 Jun 2021 10:48:52 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA94898EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:48:52 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id ba2so48685474edb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=l+yxVdLx8ZhlrmcZW3EUnogEHMOBLwmaBhKjehUF8vA=;
 b=TvdFbh1RGyPUNT4+M/eAYpvNzVdy1sNDT5yBYShVCQl4XvTq6gZFfN9E5NGzT5oEVr
 D+y1GbA9XZDq1U7AYil6eSMD0XYXsZzBBFq+cySRFrXEMn1UMQD8cLTnSb4IbV8ke5t6
 nkSm/XeKnk8+XuPNCQRvDZbeW5hGwGjsclKJ0CgBiOnW1LUZNmVQsDVX/xintYeZZXfu
 7LXwpnKrA6EVBY9JVgaWQ6oBKEM/02eUoUP323hTbViBrQg8rGmo/mWUQBgIw75jClv7
 QyZxPRdoiWJLIX1w4pgHFjJarkbBR+G18jlf3qOdaKl+/Lh3a/EPvhZUSecgxuO7zvG4
 7gqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=l+yxVdLx8ZhlrmcZW3EUnogEHMOBLwmaBhKjehUF8vA=;
 b=hDRfV2WqdY18MQnGbSA9M4HaMB6G5gmOCv9CJ36moVvwDYPfjSbQzrYWzMZisAhCgj
 WWqOx1lPC2Jf6oK5O8lNwqLfD9oZn4j5Pj7XTHGBusgYyBkdHuOcz2PAE/fvxjKEhcRy
 bMPS+1oFRlRtrw9C36QKCBnf3/4WC2pZEFHzzX1Ko/fKKzl/j83pZdSwTS7ZTJafwjnW
 Y5ywOra7XVo4FfenJkTK2HDPjzKSb/aNTT2gMwZs0RaGZpGiwqwHezzfkklwYSeD+9O4
 dIRWfvsVi4YRfgurVIXA5lXDfb/iMT1s5TEcbfBj8O+aXhpwK43FH/N3Stxhw7NhbPNu
 iODg==
X-Gm-Message-State: AOAM533dH9QpH2FKjHxTQ0dYpCdtHXHdM5b4LTQCe1QAlfj0QACimqKf
 0opKEuWC8whpRdh+Bb35n5TdyNQZfj8=
X-Google-Smtp-Source: ABdhPJxJsSi6auXRPuDbx1/4/hR9MNFd8ythtrOK1+daGmCLuUbQo+VyBXi1+httkhaVn1bzUkinMA==
X-Received: by 2002:a05:6402:1911:: with SMTP id
 e17mr22358474edz.62.1623754131007; 
 Tue, 15 Jun 2021 03:48:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c?
 ([2a02:908:1252:fb60:f438:4e93:3853:400c])
 by smtp.gmail.com with ESMTPSA id s2sm7712908edt.53.2021.06.15.03.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 03:48:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210615092400.5023-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <88296228-0a02-6078-3a0c-85beaec35c5b@gmail.com>
Date: Tue, 15 Jun 2021 12:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615092400.5023-1-nirmoy.das@amd.com>
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 15.06.21 um 11:23 schrieb Nirmoy Das:
> Make provision to pass different ttm BO destroy callback
> while creating a amdgpu_bo.
>
> v2: remove whitespace.
>      call amdgpu_bo_destroy_base() at the end for cleaner code.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
>   2 files changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9092ac12a270..8473d153650f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -73,11 +73,9 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
>   	}
>   }
>
> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +static void amdgpu_bo_destroy_base(struct ttm_buffer_object *tbo)

I think you don't even need to rename the function.

>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> -	struct amdgpu_bo_user *ubo;
>
>   	if (bo->tbo.pin_count > 0)
>   		amdgpu_bo_subtract_pin_size(bo);
> @@ -87,20 +85,38 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	if (bo->tbo.base.import_attach)
>   		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
>   	drm_gem_object_release(&bo->tbo.base);
> +	amdgpu_bo_unref(&bo->parent);
> +	kvfree(bo);
> +}
> +
> +static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +	amdgpu_bo_destroy_base(tbo);
> +}

Nor has that wrapper here.

Apart from that looks good to me.

Christian.

> +
> +static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_user *ubo;
> +
> +	ubo = to_amdgpu_bo_user(bo);
> +	kfree(ubo->metadata);
> +	amdgpu_bo_destroy_base(tbo);
> +}
> +
> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +
>   	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
>   	if (!list_empty(&bo->shadow_list)) {
>   		mutex_lock(&adev->shadow_list_lock);
>   		list_del_init(&bo->shadow_list);
>   		mutex_unlock(&adev->shadow_list_lock);
>   	}
> -	amdgpu_bo_unref(&bo->parent);
> -
> -	if (bo->tbo.type != ttm_bo_type_kernel) {
> -		ubo = to_amdgpu_bo_user(bo);
> -		kfree(ubo->metadata);
> -	}
>
> -	kvfree(bo);
> +	amdgpu_bo_destroy_base(tbo);
>   }
>
>   /**
> @@ -115,8 +131,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>    */
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>   {
> -	if (bo->destroy == &amdgpu_bo_destroy)
> +	if (bo->destroy == &amdgpu_bo_destroy ||
> +	    bo->destroy == &amdgpu_bo_user_destroy ||
> +	    bo->destroy == &amdgpu_bo_vm_destroy)
>   		return true;
> +
>   	return false;
>   }
>
> @@ -592,9 +611,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (bp->type == ttm_bo_type_kernel)
>   		bo->tbo.priority = 1;
>
> +	if (!bp->destroy)
> +		bp->destroy = &amdgpu_bo_destroy;
> +
>   	r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
>   				 &bo->placement, page_align, &ctx,  NULL,
> -				 bp->resv, &amdgpu_bo_destroy);
> +				 bp->resv, bp->destroy);
>   	if (unlikely(r != 0))
>   		return r;
>
> @@ -658,6 +680,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   	int r;
>
>   	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
> +	bp->destroy = &amdgpu_bo_user_destroy;
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
> @@ -689,6 +712,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   	 * num of amdgpu_vm_pt entries.
>   	 */
>   	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +	bp->destroy = &amdgpu_bo_vm_destroy;
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index e36b84516b4e..a8c702634e1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -55,7 +55,8 @@ struct amdgpu_bo_param {
>   	u64				flags;
>   	enum ttm_bo_type		type;
>   	bool				no_wait_gpu;
> -	struct dma_resv	*resv;
> +	struct dma_resv			*resv;
> +	void				(*destroy)(struct ttm_buffer_object *bo);
>   };
>
>   /* bo virtual addresses in a vm */
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
