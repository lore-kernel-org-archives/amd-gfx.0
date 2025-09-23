Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12034CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 11:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CE010E5FE;
	Tue, 23 Sep 2025 11:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGlVmB3f";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2166910E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 11:51:53 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-84ac859df55so243197685a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 04:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758628312; x=1759233112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/SZ72z1uK3sMAtUzsDz6X/AeofJ802quMx1OKL9rNV0=;
 b=FGlVmB3f/r1YlqsWyzadIFdwohjiP3MHsxeEdrmuKTWawr9zG6cN0gB6gLFAaVAdqa
 wSXtFK1Omwj+XcysfyzMrO872G6t1L+PNFlHvDa2BSiqUedlOukFzeOhkBT/R4AlFqSx
 ssiOS/6ixGETmGU9oS8Ww68BChtbatQ2gw5txIiQpsDxrtPpat0RF6sanpDMl6rPNnyq
 9msIUdxM1J08lsgW/b9WKD6bQm2zN1EeCpoZBl9pM+TdShCXjJuA6bCSz27m9/luK5YO
 9aKdzRan3h5NJnbi1SKAuxcyjDlgZY3eZ3VCylpx0TnS9XWaJQQEE2WyFaIx+pSfHULs
 ZkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758628312; x=1759233112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/SZ72z1uK3sMAtUzsDz6X/AeofJ802quMx1OKL9rNV0=;
 b=AyzdPFfLla8z9uTV01BFw6ERkY+MY+PY7KLPgOd31fb3bI1q38o3QKdAU5eZSAvboZ
 7a9LgnJr74B+C7IylCfz9bLy7CgUbhdmlZ4RGO4apo88BaLFUBWb7UZBMgSy+Mm9TLiW
 vT1v+CN5LcgqLpamBwsLYWWKyMtwwLgV2xLXbGjrmnjncHFoQc/AcFLBPhtXAtnxtoh0
 XhPFZ3BM/OOFWlJMI0nMv9HM9SlJTeq/03nJbr2IxK2mulDUTtJr7ozfkYot0CLEUvdL
 InQrNBhLs7njN+ui16xgiWoN5Dp2qjbckfXrnkAYeJ5S/wHBpRb6y+IcZFkjnaqpDObG
 9hrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGmAeDuKqPIketQeQBObxUDiKvgkA/J8Zxu6PJf0e4wpM4wCXxNkXOwWLlyZlrwGDtrluGORJr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzg50eB71XXnKzGJDooj50ThAkS5ExpNKA1cprqndfe1+q44/Jj
 FTn+u3qiX9lUYzhsWnD4RYymoQa2B2sfDrvAFLmbBw5UPO/ARmdR98w1
X-Gm-Gg: ASbGncvcN95oCfLQFDPFIhRn1c4kUU+yFOYoWCe5KlPS6lpLhKdjGQwVK6bj44ECd7X
 Mfx5Pu07prjHsvncyf0kYLYe+iDhcz2wmeNd8ji7GafAudOJPlQXoVBYModFxK5wFBWIE4VXpPe
 l4vjxY6l5bD9VKApaYQvJ6Nui3PtJxruCbEipqpJ8eQNFKdj5zZWL8gYztmQ4rC6b2Hbbme/dBn
 U7ra0Ju7k24hQ8PlWphByGd9UTPm5u+CUbhLtaRdBDnsYqa1Gdym7FtbwxdpKD6tBd3RbKj8F1R
 6f7LqJtGVVHnNpm+bY8syDhdmSR66JF3qRFMvBqg5UTrCmOdp+4qAV0XMw7RjLciXWfQ5zCNZTj
 WM4bT0bkfKoUZYNpxU9VwZZA91n9hng0vWp7e9LcxP7HAJStTvWvYCQ==
X-Google-Smtp-Source: AGHT+IGrYUrSepbEHfD+zhMhrhdZxwbKTi37BVOBQSQFX8T6Ba/ydRbXtlKmXFGqbiHJmzroGYaBeQ==
X-Received: by 2002:a05:620a:1a26:b0:850:6873:7277 with SMTP id
 af79cd13be357-8516ade741dmr212594185a.29.1758628311934; 
 Tue, 23 Sep 2025 04:51:51 -0700 (PDT)
Received: from [10.254.120.20] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85466eed260sm20273585a.30.2025.09.23.04.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 04:51:51 -0700 (PDT)
Message-ID: <c60ca7eb-ae30-4ed4-b167-9671ad6e445f@gmail.com>
Date: Tue, 23 Sep 2025 13:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250917095939.41615-2-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 17.09.25 11:59, David Rosca wrote:
> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
> Scheduler expects normal fences as job dependencies to be able to
> determine whether the fences come from the same entity or sched
> and skip waiting on them.
> With fence chain as job dependency, the fence will always be
> waited on forcing CPU round-trip before starting the job.
> 
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 2e93d570153c..779c11227a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,6 +29,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/sync_file.h>
>  #include <linux/dma-buf.h>
> +#include <linux/dma-fence-unwrap.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_syncobj.h>
> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>  					 uint32_t handle, u64 point,
>  					 u64 flags)
>  {
> -	struct dma_fence *fence;
> +	struct dma_fence *fence, *f;
> +	struct dma_fence_unwrap iter;
>  	int r;
>  
>  	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>  		return r;
>  	}
>  
> -	r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
> +	dma_fence_unwrap_for_each(f, &iter, fence) {
> +		if (!r)
> +			r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);

You should probably add an dma_fence_unwrap_cleanup() function which drops iter->chain and sets it to NULL and then code this like:

r = ...
if (r) {
	dma_fence_unwrap_cleanup(..);
	return r;
}

> +	}
> +
>  	dma_fence_put(fence);

That is superfluous now, fence was consumed by dma_fence_unwrap_for_each().

Regards,
Christian.

>  	return r;
>  }

