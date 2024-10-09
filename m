Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3AECED61D
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 07:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B0010E66D;
	Wed,  9 Oct 2024 07:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="N+V+HlfZ";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EE110E66D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:45:48 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-37d43a9bc03so76258f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Oct 2024 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1728459947; x=1729064747;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ex4SM2mp5XiUZxI9qk11vCABy4J7ln+jSgXeLbZUo4I=;
 b=N+V+HlfZTpezrKTeH3d2pdmQFMfSIPPARm9SPCSkJa968I7koJA6ecr3ZwZPnei/+C
 NIlRXWeGwA71nGIub94dxySlZslcLtTJ4DnrmH8oym0yeWHOW2YmJq2WsuBt9k/blzlX
 B6nlNunCw1/hoIfOyoXlahxrn8E+lXsBczkQQYKwjnuqDuGQbrPDgBJyoIxmmype1V+G
 MEwomgFbAVtlIfv9Z8YDDPwXyvs8OWLYHThIYiNv7txeVvID0i0dYXEg3h3z3OvizLZa
 JrvOC/3rhvjswzPfcv08/a6KLfW5+mHrKw0Wq5gF2pDYlnm2kUNoMrUWJtDQPFJsOdny
 OPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728459947; x=1729064747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ex4SM2mp5XiUZxI9qk11vCABy4J7ln+jSgXeLbZUo4I=;
 b=LKdMLzLbiFwVNvXqS+cOzuK1yzK/+lZ3i5eJtEFLt61Cyh4EzsOGLTszixX/3FvFSX
 RXP8sEW1D92hS7NTmCVg4UdtH94HbEugA6OWBJg2V64u56rJ6yanzjvBw+zxgwpHnyIO
 //8j8M7ddlynbX/lnmS3h5WuO4gt/MXAyl0bfTaqvjh9bJycXkqa7KaYpsNxN/mTKlx0
 /l0cMDr/cOIcYqLJ4akVk41zzCCox8jslYz2TJVcu9zg4uzE6IfKHhFH5z4tVHnZMz8R
 F/4XcSvgERR4L9CeyaQ6tnLdPOTT6Efa7l6q7WmQI4aMJYzCTTQpGkf9idt90DveFpm3
 jcxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh1TNRLo3BcRKM+6e5OeWBYQScHhTMnhc0npLlC8XozmYxm2zH7pJJJxMrMpeiwygb6/sTLRJW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCjRheRGXYGU5c6kcxUHUigAbZTu6UJHxsQtCTzrnmBEABKwWp
 tc9/jYnMBMfQG4cr/kk1YH/FC9xyC+nYnHA3g39q2wTE1jcYhJADQWllHNg317A=
X-Google-Smtp-Source: AGHT+IHL8EykEH3PV1RUtjkINsmgaM9bMLUBVgaTUm+6/1utniyg7WqSge4QobKs7eL3zim09hInkQ==
X-Received: by 2002:adf:f884:0:b0:37d:3973:cb8d with SMTP id
 ffacd0b85a97d-37d3a9f84e2mr829787f8f.24.1728459947289; 
 Wed, 09 Oct 2024 00:45:47 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16972cd2sm9691618f8f.107.2024.10.09.00.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 00:45:46 -0700 (PDT)
Message-ID: <5f5a792e-b578-44bd-958e-46e6be3bd873@ursulin.net>
Date: Wed, 9 Oct 2024 08:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: stop masking the wptr all the time
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, tursulin@igalia.com, sunil.khatri@amd.com
References: <20241008181134.1350-1-christian.koenig@amd.com>
 <20241008181134.1350-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20241008181134.1350-2-christian.koenig@amd.com>
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


On 08/10/2024 19:11, Christian König wrote:
> Stop masking the wptr and decrementing the count_dw while writing into
> the ring buffer. We can do that all at once while pushing the changes to
> the HW.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 +++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ----
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a6e28fe3f8d6..364466d6d3de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -90,12 +90,11 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>   	if (WARN_ON_ONCE(ndw > ring->max_dw))
>   		return -ENOMEM;
>   
> -	ring->count_dw = ndw;
> -	ring->wptr_old = ring->wptr;
> -
>   	if (ring->funcs->begin_use)
>   		ring->funcs->begin_use(ring);
>   
> +	ring->count_dw = ndw;
> +	ring->wptr_old = ring->wptr;
>   	return 0;
>   }
>   
> @@ -122,8 +121,6 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   		memset32(ring->ring, ring->funcs->nop, chunk2);
>   
>   	ring->wptr += count;
> -	ring->wptr &= ring->ptr_mask;
> -	ring->count_dw -= count;
>   }
>   
>   /**
> @@ -153,9 +150,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
>   
> -	if (ring->count_dw < 0)
> +	if ((ring->wptr - ring->wptr_old) > ring->count_dw)
>   		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
>   
> +	ring->wptr &= ring->ptr_mask;
> +
>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 36fc9578c53c..439793206b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -378,8 +378,6 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
>   {
>   	ring->ring[ring->wptr++ & ring->buf_mask] = v;
> -	ring->wptr &= ring->ptr_mask;
> -	ring->count_dw--;

The DRM_ERROR and its if condition two lines above the above hunk could 
be removed too, no?

Regards,

Tvrtko

>   }
>   
>   static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
> @@ -403,8 +401,6 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	}
>   
>   	ring->wptr += count_dw;
> -	ring->wptr &= ring->ptr_mask;
> -	ring->count_dw -= count_dw;
>   }
>   
>   /**
