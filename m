Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F2BEC1E86
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3489A10E836;
	Thu,  5 Feb 2026 10:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="otK/mxls";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05C410E836
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:14:20 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-43591b55727so672477f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770286459; x=1770891259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qv5KHcfq5S30T0y+CRGFGcHNUvWId5NpRiJLoLwW/Xg=;
 b=otK/mxlsnLPnOUxF1eYFIPy33tSUTqdOXFtMid29ckOH6+HZStISRx2h8uuS665SNG
 5ERa02ppzQ6GDxJ6Wrsig+A8pVXqclnbiuooKB3qqMmTj0lwSme2VCtiHwz6I5/zm1xs
 Lq+FkCrEgp7pSp2QirqpJZ1557p6eSlwqVhbH48cm5qNeBI6I4PPwZWKJzs7YSN9trvQ
 HdJ1g38qbQKgS45wfcc9/0pAizCgOcQJ1mQOQekKdySF8bY1wQyjtQD9CkOwXEqYGCHE
 4gNPudXrrNIljw2UVNQS5J+Z1xCdiJmqFPGlepX3EFotqwIf3UGRED+wxig0r/EAWnjO
 LxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286459; x=1770891259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qv5KHcfq5S30T0y+CRGFGcHNUvWId5NpRiJLoLwW/Xg=;
 b=bIABos6TZSHXf5ecwBfQHhuCI4WxMOaAgiwwzqw9ln7m2lKXTRZm0MHAgdd4iI26dA
 FrT/pRiwVdoPrJ0//LGXsJojF92aq6Z7YDgs2LvMmWIlMnpIRygkFbDxihXXCQ8C/Nyn
 kPWI+5KkaIJJoYhN2FAfh6dbMPTUSiXEvag2kcpI0mxuFBGyMX7Xkjp5A0QC1mcU9Xuv
 +iHKI8oxmELcMAGAZYHyJqdQUNdubWhF5g1FVQs6ALtT9MpQbk6YvZsr013qPC/1FofL
 /YLUgvu6wT0aWwJRtpBNYH5lVWlmoeHZthpy8IdoyXyc0992mQMZ+OFDyPE/LxqNVYVB
 odRw==
X-Gm-Message-State: AOJu0YzFSQvyS2p2yNoz6j3M8h7mj8dtiOs0rFfCnUFRUopNAUFvNse5
 iLYiIUfOx+3wdF9m8SyUqMQ3szHMKRtdljgb6hUT877BlwkKUF15DckJDjwxJNDjs3Q=
X-Gm-Gg: AZuq6aKWI1cPW2iueXJ4Cqcda/EaVbOUaZdljzgYaZ4eECSm9v+RyCTgT8NPSxryJel
 UKPWGTD12yVqpbXKWWgmz+gYjGn+3MFZ1I3EvxcGNPeOMwf0CkHCJGHmIo86XkDCaZEcP4KOk7a
 GZanZkfu66gmW+oqoQ61oa2lGKpaRLBetinYv8EYlRl0VIjgZ55+MJrpCPhwlrU776hN7kX1V6r
 Fq+j6sjLSHsHQv+t+B5pAeIeyfjNAQPxnqJFZZy5ewnDSwibDyTpqYpltgxBPaASp7EHgigjjeV
 XwF5LBKZ+X1RVVfPFVqcXgrAj2alb17kQmPg6jiw2Gk5HAwBO9PjnKs38WkSVc2IW78cgUEOxZH
 rNGbIQ5qieoHqcAXWFQLUdrIxm3VSZBYjG38ql2CZe+zfWkDsIzhjLN7zfhp/M6l6lDPbBIkfYb
 gG2iDtrNbyZVkKF78u7urs6EeMkmfV2ZOY
X-Received: by 2002:a05:6000:4013:b0:435:9770:9ec8 with SMTP id
 ffacd0b85a97d-43618056b94mr8962629f8f.32.1770286459436; 
 Thu, 05 Feb 2026 02:14:19 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38ec5sm13661516f8f.14.2026.02.05.02.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 02:14:19 -0800 (PST)
Message-ID: <3ce5fa45-380f-48d8-877a-4d2d5f3d5643@ursulin.net>
Date: Thu, 5 Feb 2026 10:14:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/gem: Document drm_gem_objects_lookup() failure
 semantics
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
 <20260205095957.278704-2-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260205095957.278704-2-srinivasan.shanmugam@amd.com>
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
> drm_gem_objects_lookup() allocates the output array and may acquire
> references on GEM objects before returning an error. In such cases the
> array can be partially populated and relies on zero-initialization to
> indicate which entries are valid.
> 
> This behavior is relied upon by existing callers, but is not documented
> and can be easily misunderstood as automatic cleanup on failure.
> 
> Clarify the lifetime and error-handling semantics in the kerneldoc:
> callers must drop any non-NULL object references and free the array even
> when the function returns an error.
> 
> This is a documentation-only change and does not alter existing
> behavior.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I2d1bdf3f319d841cb548cedc7b699bab9efeeed9
> ---
>   drivers/gpu/drm/drm_gem.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a1a9c828938b..0f8013b9377e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -775,10 +775,22 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>    * For a single handle lookup, use drm_gem_object_lookup().
>    *
>    * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need to be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> - *
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop the references with
> + * drm_gem_object_put() and free the array with kvfree().
> + *
> + * Error handling and lifetime:
> + * drm_gem_objects_lookup() may allocate *@objs_out and acquire references on
> + * some objects before returning an error (e.g. copy_from_user() failure or
> + * a missing handle part-way through the lookup).
> + *
> + * In that case *@objs_out may be non-NULL and partially populated. The array
> + * is allocated zeroed, so unfilled entries are NULL. The caller must:
> + *   - drm_gem_object_put() any non-NULL entries in *@objs_out, and
> + *   - kvfree() the array itself.
> + *
> + * Callers that want automatic cleanup on failure should use
> + * drm_gem_objects_lookup_safe().

Strictly speaking drm_gem_objects_lookup_safe() does not exist yet so 
ideally you would add this paragraph in the following patch.

Otherwise LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>    */
>   int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>   			   int count, struct drm_gem_object ***objs_out)

