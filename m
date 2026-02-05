Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50020EC1E92
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7D110E1A8;
	Thu,  5 Feb 2026 10:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="PAwgzVBF";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B417210E1A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:28:46 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4362197d174so393937f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770287325; x=1770892125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6upBZK5urTgnfb9xDT6KqTY68jA8PfPT+Q8buhpC8/E=;
 b=PAwgzVBFazsQkw6LZ6XKOju3uwKBQYE+RP4w4dB8qQb3UvK68d4p6rT/2oLbxqAQuJ
 LkeQ51FU3+4EWr8qhUiF9hnc+pqCjiI0R9j7G7hPYSjxIC0mMTjonErhG8H+GOpx0PVo
 1zsniSHfpY87ToNOGvPfDsz2HK+b/Y3YvGwLUDQfEmopAzzG2fFMVAo+j8WDFLSuH+Qq
 /s0ycsuauhWFLA7It1MCFMmiRWlsehe4Ux7NWoTpua4rj+BD8pEXA2F7MGs3kdBqhe4D
 dbre2n62+GxV+EpkrUXQ9FvVRSBMAXmsIGoALGApzCabS0QO1FR70PcCOJv7rF4bci/V
 qBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770287325; x=1770892125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6upBZK5urTgnfb9xDT6KqTY68jA8PfPT+Q8buhpC8/E=;
 b=fbXNxXDnF8logsan3ou5f4TTiavUkVLd4XL+ldYFnTfy92d5oyWYjn6w4gs++ibtT5
 DFIJoyIw9jvl34rD5L5+dA9jOSvq4FKpYS8/EBcMYDPREnwmWw5hGA/jyTxPh6SwG+bX
 6e09BpYYiBldPA+rhKR7h1pUZ6X8kZT2GtbaoXS2BocZllLZej/8iXb99JWWzI6Cn0+G
 iByOrj9GEIAT2WOpi0jVtO2Yr5O1R7tBNlhG2v0JC9ppHG0Lhyku/q7ek7TvgzCotsQm
 Tdm78OYcPwm/zzg4F/MW3gH2MwfFoKtrX/ibbacGridBCgWbG/pdH7mihP1ZK75XJ6yY
 EDpg==
X-Gm-Message-State: AOJu0Yztd9FmgXkfJbY5fBwiHeDDSelYOX0fpI8S4QLb9m00DMKC/FbU
 pu0ha0mb0RYuYogm2oFjLX74HNQQe7dny7TwLn3rco5SvC+8MFZS4Tm9cXWohtULCus=
X-Gm-Gg: AZuq6aJ0myxduOmq1yP2qZI4WCraEwjnatXLZDx2DOpUiFoReOrYl+VwQvjA2T+ivhY
 EHKfav5BxUJgmiFGvDyIsUEVKQaJ+oY2j5RK//IJJql5EOg3Mzm0LLES2wsdQZZlMmCxZ0kQD1N
 02fza8tGiJbI5SsY0+aCsb8OItM+JMijH2SInXAqIIZ07Dyicit9S99MXzrCs4ocNog84uu4NLI
 I2fhg4qJAfVh2xY/i6Zj2dnVCEuIq5QWjZHpVgxWi3Xqf5JIdeag8eKQApbfmVQLhoxrFabiyft
 Pe1v4yx3PkGESWDV5lTPK+HMgIA/FDzXybJc6p2yfTUFEjjbqZzideCqAxYp9jN4MJjxtsj7xUM
 JyY+R5mXvMrMwBjVgD7oi20yyPWGV7dMRw8JYeP3m0i8sWYBM2OkGlSZ5ldsBfyRrLUS9yHPzA7
 dWtr8zaQup0nel1wbtP+etqZomhmQwbmJN
X-Received: by 2002:a05:6000:3104:b0:430:c76b:fadd with SMTP id
 ffacd0b85a97d-4361803097bmr8828426f8f.28.1770287325104; 
 Thu, 05 Feb 2026 02:28:45 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805f25dsm13915768f8f.29.2026.02.05.02.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 02:28:44 -0800 (PST)
Message-ID: <1bbb8a5a-315b-43ce-b021-af7fd1715104@ursulin.net>
Date: Thu, 5 Feb 2026 10:28:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/gem: add drm_gem_objects_lookup_safe() helper
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
 <20260205095957.278704-3-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260205095957.278704-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 05/02/2026 09:59, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() may allocate the output array and acquire
> references on GEM objects before returning an error. This requires
> callers to handle partial cleanup correctly, which is not obvious and
> easy to get wrong.
> 
> Introduce drm_gem_objects_lookup_safe(), a wrapper helper that
> guarantees cleanup on failure. If lookup fails, the helper drops any
> acquired object references, frees the array, and sets the output pointer
> to NULL.
> 
> This provides a safer alternative for new and fragile call sites without
> changing the behavior of drm_gem_objects_lookup() or affecting existing
> callers.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I553551dd1e7aadf1b2a477eaf19ce9c80b2ce2ea
> ---
>   drivers/gpu/drm/drm_gem.c | 48 +++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_gem.h     |  2 ++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 0f8013b9377e..f1d13700a62c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -830,6 +830,54 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>   }
>   EXPORT_SYMBOL(drm_gem_objects_lookup);
>   
> +/**
> + * drm_gem_objects_lookup_safe - look up GEM objects from an array of handles with failure cleanup
> + * @filp: DRM file private data
> + * @bo_handles: user pointer to array of userspace handles
> + * @count: size of handle array
> + * @objs_out: returned pointer to array of drm_gem_object pointers
> + *
> + * Wrapper around drm_gem_objects_lookup() that guarantees cleanup on failure.

Nitpick - maybe the fact that it is a wrapper is not relevant for API 
docs but just say along the lines of "Similiar to 
drm_gem_objects_lookup() but guarantees cleanup on failure." ?

> + *
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop references with
> + * drm_gem_object_put() and free the array with kvfree().
> + *
> + * On failure, this helper will drm_gem_object_put() any successfully looked up
> + * objects, free the array, and set *@objs_out to NULL.

Maybe just say "On failure no further action is required."?

> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
> +				int count, struct drm_gem_object ***objs_out)
> +{
> +	struct drm_gem_object **objs;
> +	int ret, i;
> +
> +	/* Ensure callers never see stale pointers on failure. */
> +	*objs_out = NULL;

This seems redundant since all paths below are either success, *objs_out 
already NULL, or *obj_out set to NULL at the very end?

> +
> +	ret = drm_gem_objects_lookup(filp, bo_handles, count, objs_out);
> +	if (!ret)
> +		return 0;
> +
> +	objs = *objs_out;
> +	if (!objs)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (objs[i])
> +			drm_gem_object_put(objs[i]);

It appears drm_gem_object_put handles the NULL pointer on its own so you 
could remove it if you want.

> +	}
> +
> +	kvfree(objs);
> +	*objs_out = NULL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_objects_lookup_safe);

drm_gem_objects_lookup is EXPORT_SYMBOL and EXPORT_SYMBOL_GPL in general 
seem a minority in DRM. But TBH I am not sure what is the criteria.

Now one higher level question. Could we convert at least one driver to 
the new helper? Both because it is best not to add unused helpers, and 
also because it would be even better to later retire the unsafe version 
altogether.

Since the drivers already have to cope with checking the pointer and 
handles themselves, in order to properly cleanup on failure, perhaps 
making them use the new helper would just work.

Or even better, maybe all callers would cope just fine and the 
_existing_ drm_gem_objects_lookup could be simply made do the cleanup, 
without the need to add a new helper.

Regards,

Tvrtko

> +
>   /**
>    * drm_gem_object_lookup - look up a GEM object from its handle
>    * @filp: DRM file private date
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 8d48d2af2649..7decce2fdef7 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -561,6 +561,8 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
>   
>   int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>   			   int count, struct drm_gem_object ***objs_out);
> +int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
> +				int count, struct drm_gem_object ***objs_out);
>   struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
>   long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
>   				    bool wait_all, unsigned long timeout);

