Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C1EC1EB0
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4496F10E895;
	Thu,  5 Feb 2026 13:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="QF42yuTB";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE90A10E894
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 13:02:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso9724675e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770296564; x=1770901364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B273J8mq/eRiT7sq4lAflQ3qzIop25H32ZSh0bGP58o=;
 b=QF42yuTBako+z64U94H7Ve1EjeUFNhQ2oA8gUGhk9OnL22ti8LsZOg9NFLV4UgzC93
 +cTvOaY2SxhDyNV5B2NVad2/jJQ8DExGad2Bu7CIZCOPRbfhyht65eg7gDB7RqkG4G0t
 atHn/MYYa+MU4M9TzmZDmEwJwx0cYh3hld/W3K5CrQrstyq7ZEA9kgiPfNEcMyeT3u90
 jzqr9F0uMhmCKJk5wK4/ztyDuBUnJeyK+GFwn+VIIuqpvB5B60YviD7F13+AON+QANie
 RIS9JzujnQV7yLyr4OTmcdolt5WmmeOXhFE3CDt/3yelmrf1L6DTdxsCsN46kTTTzanJ
 OpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770296564; x=1770901364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B273J8mq/eRiT7sq4lAflQ3qzIop25H32ZSh0bGP58o=;
 b=RcMHWAqT5VKYD9hUg/6JrOxlMUayV8OZwDU67hu9WD/dHs0zpEymjNctam+L0h43al
 HQUPgnIch25H7Dt5ZplKHivkbjiFmT+ZqazvK97zJI+BP/tCDHrE2MkDizXdG9AgFpNf
 6lV0t5OVkxbCqeCvq4/JTQAGf01C7adXVmonWnGSkLwVLDOeRFp9sZHb5cUqkQzNO38K
 4PSu98mAv34WGtUO5XV9lARs7c4+JHSwcxxNd9Js/GFq/dX/EeRP5BFcjg7jABFn3dPJ
 3EmNP20plbCGgHbkNGRy6VJWGDDAlIf4GMn1yVJR635yV0I0lYKRvL9rtQFDgz8KfkP2
 2c0g==
X-Gm-Message-State: AOJu0YyLacqCvd758d9mtvso5H+STMMssoiYiXJg8X2R7VrrkEjNc2Nu
 lGViv8xBsaKTZzH6WYiLFECLOSXMAtKXpHiRAROEyBcbebFekdNoTMMlj78B7O8otIw=
X-Gm-Gg: AZuq6aKYm2uDFWpMSp6d03U7r+2NRPF7Zks0vcV0SeCVs75diM5PqHA6Reew1Zm+VD2
 yITHWvDlEsCY7wKRiPaPgfz1LhOhdjesyLnXagFoO74l/CbYjjBZaoOKlw7ZofJPFhZtot9T3fh
 ZFBDHIhWEcLrcAkgDHwfGX3QmRt73UycWxTkizje47sS3c/91TV57foJ4zd0lYlCF8XJPhUCfRV
 aN9gQ2KUerXV1hmpw19e7nCJpQRN2wM4aIBok6+sBfWu9dEU4NdgyYFolZ0ZmcWfWuu9FzZtRVJ
 nye9Z9z8qCufQFlNe7QIKjqIgcbJXhSKz0ukvTzheYRO8HQRTuPlNkJ50q79sgdAjfa767WUE3z
 9K/uGjVpkF2BvzBc2fXt+EWIev2D6/cBznvx6ZHHu8kCSf9TtyMQKEO6115D1yKWq2peqGfPBpO
 +f+rhQPx7hP5zG73PM4PjiYZpXTS5KsUqm
X-Received: by 2002:a05:600c:630a:b0:480:3a72:5238 with SMTP id
 5b1f17b1804b1-4830e98ad35mr99405125e9.30.1770296563670; 
 Thu, 05 Feb 2026 05:02:43 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618064844sm13759145f8f.42.2026.02.05.05.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 05:02:43 -0800 (PST)
Message-ID: <c6744661-1e2b-4e28-9418-6e10acf8e367@ursulin.net>
Date: Thu, 5 Feb 2026 13:02:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
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


On 05/02/2026 12:13, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() can allocate the output array and take
> references on GEM objects before it fails.
> 
> If an error happens part-way through, callers previously had to clean up
> partially created results themselves. This relied on subtle and
> undocumented behavior and was easy to get wrong.
> 
> Make drm_gem_objects_lookup() clean up on failure. The function now
> drops any references it already took, frees the array, and sets
> *objs_out to NULL before returning an error.
> 
> On success, behavior is unchanged. Existing callers remain correct and
> their error cleanup paths simply do nothing when *objs_out is NULL.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/drm_gem.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a1a9c828938b..862c9b2b9c0c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -775,19 +775,21 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>    * For a single handle lookup, use drm_gem_object_lookup().
>    *
>    * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need to be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop the references with
> + * drm_gem_object_put() and free the array with kvfree().
>    *
> + * On failure, *@objs_out is set to NULL and no further action is required.
>    */
>   int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>   			   int count, struct drm_gem_object ***objs_out)
>   {
>   	struct drm_device *dev = filp->minor->dev;
>   	struct drm_gem_object **objs;
> -	u32 *handles;
> -	int ret;
> +	u32 *handles = NULL;
> +	int ret, i;
>   
> +	*objs_out = NULL;
>   	if (!count)
>   		return 0;
>   
> @@ -796,25 +798,34 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>   	if (!objs)
>   		return -ENOMEM;
>   
> -	*objs_out = objs;
> -
>   	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
>   	if (!handles) {
>   		ret = -ENOMEM;
> -		goto out;
> +		goto err_put_free;
>   	}
>   
>   	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>   		ret = -EFAULT;
>   		drm_dbg_core(dev, "Failed to copy in GEM handles\n");

I think this patch is possibly against the AMD staging branch? You will 
either need to rebase on top of drm-tip, or AMD staging needs to catch 
up with 6.19-rc1. Because in there I have replaced the above with 
vmemdup_array_user().

Otherwise I agree with what Christian said, that it would be nice to get 
rid of the __GFP_ZERO requirement and handle it in objects_lookup().

In the meantime I have again went through all the callers and it seems 
they will all handle not having to do the cleanup just fine.

Hm, another interesting question if we maybe want to add a cleanup 
helper so the callers do not have to know that they have to use kvfree? 
All of them have their own loops so that would also nicely consolidate.

void drm_gem_objects_cleanup(struct drm_gem_object **objs_out, int 
count) ? drm_gem_objects_lookup_free? drm_gem_objects_lookup_cleanup (!)?

Regards,

Tvrtko

> -		goto out;
> +		goto err_put_free;
>   	}
>   
>   	ret = objects_lookup(filp, handles, count, objs);
> -out:
> +	if (ret)
> +		goto err_put_free;
> +
>   	kvfree(handles);
> -	return ret;
> +	*objs_out = objs;
> +	return 0;
> +
> +err_put_free:
> +	kvfree(handles);
> +
> +	for (i = 0; i < count; i++)
> +		drm_gem_object_put(objs[i]);
>   
> +	kvfree(objs);
> +	return ret;
>   }
>   EXPORT_SYMBOL(drm_gem_objects_lookup);
>   

