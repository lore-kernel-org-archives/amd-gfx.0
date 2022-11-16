Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9152EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 10:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A298E10E458;
	Wed, 16 Nov 2022 10:20:24 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075AD10E464
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 10:20:20 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id d9so24400863wrm.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 02:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJd/kPZe8tht3PZNMtoqvoX2LQTRKzrqogvzeSuaPoU=;
 b=SBp78Dq4y2Emnd3ISqctjtnMRJC2dVxDfD1AQzTcZlXz89qzlXS7YvUGOHMr6zm8O7
 agSp9ywJ6qu9XmPz1raO4hSEV5iiLNIecA9UlT8nEx/gfoGBon884wIK6GssuXvIRtog
 iUbdWVb+piIyyR+/8imI7W4Ksn/mvFpVff13RzIhYLsnj29mqn8c2RW+SVTJ7ec5/lPh
 dM9eMhpjHy/bXkjIgrJp5kvSqECu0ixUqYmh8pw+hZRHcGBG4qbHvy9Ct3ia3YBM3wnj
 Z82g28B16IOcHnCegm7LJhmEoSNfixt9g0PhUsgKyQ6J6o32+BlO/OgUIAjh13dq9lng
 bn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJd/kPZe8tht3PZNMtoqvoX2LQTRKzrqogvzeSuaPoU=;
 b=yHr/aenTL8w2mozEexUA9Jd/0TBoPNGAtXoXhQ01CZpDVg+34GdNYDNoEfw7JM1KQ4
 en6uuUek/BIuOojm2T2aJIslV/Hq0dF5CnmSMpw1WMOUwgNIeeVJoqZap3eKrsfaEFs1
 /58iOYMFz/vVU9E0icEEIaLRDSc7XJMa6+T9HjIJI3Li+N1YhqSw5dnad/Ns4luwKp6S
 j3O5+6m7G4BePsyf/CeMpr3cgkuTetVihnwjgiJ1GUNs5bJfz+wlBorIYkdVc15RtMbh
 UdAW/LEz1RCLFCgzv5lFJmpG9RDHvUmFvm9Jzki2TWi1vCM6Z+DfmJYWCdrC1C7hFXn1
 WyAw==
X-Gm-Message-State: ANoB5pn6wndF/GZd8uKQQBB7xafx6llSFr/w/AnsAC1g2oxRsj1jyHlr
 8rz9cfMkYV9kpBnLYK/BnWM=
X-Google-Smtp-Source: AA0mqf6OcAlxfXV2/jDR+SQqtVt1cCRHsawBBL/P9JrtRlIYIfoo0OLHfK5G9ByODJUvBW6clfkqzw==
X-Received: by 2002:a5d:590c:0:b0:22e:3c69:f587 with SMTP id
 v12-20020a5d590c000000b0022e3c69f587mr13756212wrd.670.1668594018452; 
 Wed, 16 Nov 2022 02:20:18 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:a719:712a:c9e4:718d?
 ([2a02:908:1256:79a0:a719:712a:c9e4:718d])
 by smtp.gmail.com with ESMTPSA id
 bj19-20020a0560001e1300b0022cdb687bf9sm18304829wrb.0.2022.11.16.02.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Nov 2022 02:20:17 -0800 (PST)
Message-ID: <269dd660-2d81-169e-3a20-5bd648a62271@gmail.com>
Date: Wed, 16 Nov 2022 11:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] drm/amdgpu: Fix VRAM BO evicition issue on resume
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com, gpiccoli@igalia.com
References: <20221116054721.1008253-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221116054721.1008253-1-Arunpravin.PaneerSelvam@amd.com>
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
Cc: Mario.Limonciello@amd.com, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.11.22 um 06:47 schrieb Arunpravin Paneer Selvam:
> This patch fixes the VRAM BO eviction issue during resume when
> playing the steam game cuphead.
>
> During psp resume, it requests a VRAM buffer of size 10240 KiB for
> the trusted memory region, as part of this memory allocation we are
> trying to evict few user buffers from VRAM to SYSTEM domain, the
> eviction process fails as the selected resource doesn't have contiguous
> blocks. Hence, the TMR memory request fails and the system stuck at
> resume process.
>
> This change will skip the resource which has non-contiguous blocks and
> goes to the next available resource until it finds the contiguous blocks
> resource and moves the resource from VRAM to SYSTEM domain and proceed
> for the successful TMR allocation in VRAM and thus system comes out of
> resume process.

Well quite a big NAK to this.

Eviction of not contiguous allocations is perfectly possible, it's just 
not supposed to happen during resume when the DMA which is supposed to 
do that is not available.

The fundamental problem is that the PSP code frees and re-allocates the 
TMR during suspend/resume. This is absolutely not supposed to happen.

I'm going to propose a WARN_ON() to prevent subsystems from doing that. 
And I strongly suggest to fix the PSP code instead.

Regards,
Christian.

>
> v2:
>    - Added issue link and fixes tag.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2213
> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: stable@vger.kernel.org #6.0
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index aea8d26b1724..1964de6ac997 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1369,6 +1369,10 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>   	    amdgpu_bo_encrypted(ttm_to_amdgpu_bo(bo)))
>   		return false;
>   
> +	if (bo->resource->mem_type == TTM_PL_VRAM &&
> +	    !(bo->resource->placement & TTM_PL_FLAG_CONTIGUOUS))
> +		return false;
> +
>   	return ttm_bo_eviction_valuable(bo, place);
>   }
>   

