Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF44CCAC598
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 10:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9577610E193;
	Wed, 17 Sep 2025 10:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="jf7pBlsj";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAAF10E193
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 10:15:47 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso44154515e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1758104146; x=1758708946;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ycun2+PT43f5yBkFLM2ehojSIpMd2qyDNqzxkeYW2iM=;
 b=jf7pBlsjqSCfagbuWyRxo0vDUZUFwP2ZTh7G0zbDUil0s/hDlsDbiD1q3J9+9fvAT4
 ydEf/T6AYTNjKpPJc3WhI77Zq+iWng5/B0vqmoLprje5dTNEVzfUp2uHb85DKLoRwZjA
 Xq+hSLcXoXTjAX/3AjtLV2IlsFpiiIAkM5YV2YyAvDsDopyLwQ9D/JibH/OKpiwZwMWg
 g+cADqlhVM4MNtFaM2nMPhh4iTD+41hldNDLzWs87JKVsOuJjmBaIT/OAM2DtN/xokOe
 Mx0ZaEmdhqwdUeV6TxqRV5oEIS4UqmGZj5EbgtYE3y9Y9K9Wl0qBEte2Mcwst5lyjadv
 5mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758104146; x=1758708946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ycun2+PT43f5yBkFLM2ehojSIpMd2qyDNqzxkeYW2iM=;
 b=BV6JjTfYG6a/rozdxIRUow1+ra9VMKfCJ6aCyWGrBiwDsZwCieQ0Ir8RYqs2qFmIrq
 cnQnncogd1NrkMU6kDXRx6xn8r2PM1QXULQRPok+P1Yq9qCx2VruCuFjBzrVW53Sbgrq
 ObmgDXtq5BJ5k37slznfZ8esd7ImR+5ZFRkqFZG7XAsrP1OfRivHza66AcZmPEz2LaaV
 r8gPYctGrRp3GNvrRCbzQf9IRY+Qa3oLhp8UZgxea/qIhx/7VFzVS9QgagcFUeP2nKum
 M/CNg6rx1a8ib8qB2igFk7un9SKttwno5a68+9LZZAKLG3zBhbrJJKLLvRSHbqqvS9F2
 77PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh8r2nzuQwgsPvfi9wlDwLH5Fty5F//Y7aEiuP5VKZj/lbAbvQIvQkIBqY4gh8oy+d7YGfPz+B@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvbqGWP2PNorrGari6qEeiDoE1BBOiSw0nA/JUdITkgZiQryGu
 P/35KdsfeLAZi1ZPUV9lvRyogzOJghr96Ch+/sBK9bVcAg49yNqY10xWK+1L0kVLY0U=
X-Gm-Gg: ASbGncu8iOsxajzz4UDPgOH/cMeJU1Z3Fibk74p3WGJdwS4512/W5ejes9K2wi0hxny
 Hha/ne9+/8FB3/Ed2GAJA/Y/t12KlZ9wBj61vS0yOlNOh/Z8cXk/BT0bhNgOu3N7f0T5p87XJA3
 Z/i/K+PukphXtlZ1nC6R2Tvk61VhZCYJB1Jseq7lsefNysIJMM01Vw/8e3W+5JprAOwWWzlCxrg
 UAwmEjFY5mTBp1n0jZUVN44GQqk1hK5PnxUcZe7+FSBSRcqvlq7C3yrYkO4YCaj9k2RQBYLc16O
 uaHrCQyNSkbuTR+w6tfvmjoyni1bhSschOqTtIOmaqhdAh0qFT8fcRAdRB8YYTinyou5ZU9+9eE
 Rxkbvj+lQP2fEihT/UOdoXcVAPlKn0/w2HsQ=
X-Google-Smtp-Source: AGHT+IHp3WWrcX0IUyyQ7aYBSim6FWhJWx4hcjoRqleeSmiOqiCrhVpxm6pl41cLDZY4u6uFkF080A==
X-Received: by 2002:a05:600c:4507:b0:45f:29ed:2cff with SMTP id
 5b1f17b1804b1-46206f04fabmr10769775e9.35.1758104145635; 
 Wed, 17 Sep 2025 03:15:45 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-460942b6c3csm24383255e9.1.2025.09.17.03.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 03:15:45 -0700 (PDT)
Message-ID: <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
Date: Wed, 17 Sep 2025 11:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250917095939.41615-2-david.rosca@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Hi,

On 17/09/2025 10:59, David Rosca wrote:
> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
> Scheduler expects normal fences as job dependencies to be able to
> determine whether the fences come from the same entity or sched
> and skip waiting on them.
> With fence chain as job dependency, the fence will always be
> waited on forcing CPU round-trip before starting the job.

Interesting! I was sending patches to fix this differently last year or 
so, by making the scheduler use dma_fence_array for tracking 
dependencies and relying on dma_fence_unwrap_merge to unwrap, coalesce 
contexts and only keep the latest fence for each. But I did not have a 
good story to show for which use cases it helped. So I am curious if you 
could share which scenario you found gets an improvement from your patch?

Regards,

Tvrtko

> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 2e93d570153c..779c11227a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,6 +29,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/sync_file.h>
>   #include <linux/dma-buf.h>
> +#include <linux/dma-fence-unwrap.h>
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_syncobj.h>
> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>   					 uint32_t handle, u64 point,
>   					 u64 flags)
>   {
> -	struct dma_fence *fence;
> +	struct dma_fence *fence, *f;
> +	struct dma_fence_unwrap iter;
>   	int r;
>   
>   	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>   		return r;
>   	}
>   
> -	r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
> +	dma_fence_unwrap_for_each(f, &iter, fence) {
> +		if (!r)
> +			r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
> +	}
> +
>   	dma_fence_put(fence);
>   	return r;
>   }

