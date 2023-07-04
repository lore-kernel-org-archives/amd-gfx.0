Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A8EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 18:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F3C10E009;
	Tue,  4 Jul 2023 18:22:18 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8626510E009
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 18:22:16 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so826343f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jul 2023 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688494933; x=1691086933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBB/lu3hCVl+f5rjUQ88TsUiMzlikvVpr/cYlHLRXYQ=;
 b=KbYvkKxXTa1DGX/zb5mbAxBTGxt0J685Iu7JvE40M4dPcgHsv6d4gUZbH5MeyWejbb
 aIeYJ6Pz7YcFlfW9ICQnx7SkM4EmD3JFfOlhmj/nXjQ/XEjJzLJnTPcbD5tpVTjzZiCV
 7l3vxyI2xfcuBZnchvsNpkcT0xc5eToINTDDb6C4Nos85VFhn4TJn13L2fMKVqzIlyP/
 /UiDvy6En1M182fBDz5RqmKGSmzW0Z/nVjvBx1rkRm/6tCsEWg0JlipKizV6+nDPrcNO
 bgpoQK3mzxrSPsEayRG6Il7m1lWgE+StclonGvdaQtLVPhTOWJrDJ9Va/vrysm2c/TpY
 GYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688494933; x=1691086933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mBB/lu3hCVl+f5rjUQ88TsUiMzlikvVpr/cYlHLRXYQ=;
 b=HgZkyt0hxy/fdBljGdydBa+YNvrUMDyhue0Bo5giFU3HeldRhAMplV8aMByITo+H+/
 /BIQrDRA5Ct0jrXxrRijemSwrBnT5ROyWk00Tu7fYjzNcbeQPJd5foT1gZ5zjWAiRf5f
 sEZZX2mPQVkZHeiuT5Yi5MRmKhfk/NoLTBQeo3w6jQYwMSe9FBN1b7wBUHsioA/q7Y4E
 i6iHu2kMsbMGY89RRFU4IXIGZmHudujV0cETpWCsP+5lGDwMhuBl1+3lRvaRGBWiSTuP
 ToO2eJvCjRstYT34miMiTNFxqNeBJAg1rHtxoppdKK7y1/rkuBqibUP/lWITpG8JEmhA
 VGEA==
X-Gm-Message-State: ABy/qLaE8rHpPPm7J0V5FSFQT3dg45jBHG53ebgofKxEu0IVvjbGBLaZ
 bwG35GZr1FDzCz3/FPKoCCwyPZ8SkT8=
X-Google-Smtp-Source: APBJJlE1075ZogTF3P7X94vNFnR7QPuxnIJ3EHcbuzFGREpQ/wW6CjDq9jPHW/VxNyTYAF0jZhKUoA==
X-Received: by 2002:adf:f6d1:0:b0:313:f7a1:3d92 with SMTP id
 y17-20020adff6d1000000b00313f7a13d92mr10960997wrp.66.1688494932752; 
 Tue, 04 Jul 2023 11:22:12 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15e7:1300:962b:c8b3:38c6:bb3f?
 ([2a00:e180:15e7:1300:962b:c8b3:38c6:bb3f])
 by smtp.gmail.com with ESMTPSA id
 s2-20020adff802000000b00313de682eb3sm28899117wrp.65.2023.07.04.11.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 11:22:12 -0700 (PDT)
Message-ID: <2a59333f-5748-edba-f9b4-722080ed5bec@gmail.com>
Date: Tue, 4 Jul 2023 20:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Prefer dev_warn over printk
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230704154324.4094268-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230704154324.4094268-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.07.23 um 17:43 schrieb Srinivasan Shanmugam:
> Fix the below warning:
>
> WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then
> dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 13b89f78d07d..77a32d53655d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -973,7 +973,7 @@ static int gmc_v10_0_sw_init(void *handle)
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> -		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
> +		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
>   		return r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index c68ecb7dfa39..73ab3624f8fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -824,7 +824,7 @@ static int gmc_v11_0_sw_init(void *handle)
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> -		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
> +		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
>   		return r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ebdbc823fae3..2aeeda276ab7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2151,7 +2151,7 @@ static int gmc_v9_0_sw_init(void *handle)
>   	dma_addr_bits = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) ? 48:44;
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
>   	if (r) {
> -		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
> +		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
>   		return r;
>   	}
>   	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);

