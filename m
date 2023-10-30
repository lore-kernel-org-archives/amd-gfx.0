Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5189C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 16:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301FF10E333;
	Mon, 30 Oct 2023 16:04:43 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DEB10E333
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 16:04:42 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so33435825e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698681880; x=1699286680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uQE+oo6MFbLmo94nOkcUGbPOqe4Ex86qspiIiuFDFwA=;
 b=GHyq0xdxTSdvtx6TxPIFka3ZyuKM3YqaQ2C8MQ3isjtmEeVHTisWj1vXCnzPZv7C/q
 7sdabrXVOHrTheuUXY4fRpZtn/gDYXtAVRe9HsDxyMrop27qAfiVavnqy3NDXxtkj46I
 t8W+F5xXFSCIJ0vpRiGYfL+KSjLDOOUGqV9fj7w3bRVfC4kCFgg+fTpZyke0oFGoop/p
 CVvGj0lPn6hDBQLQBhpKwe3Y32vxvvqmYTfs/vUdCYxgRc+VP+kIMwVZQzxBz/Q267wN
 2pkHeV9rW4RP2GlI/7k4hbuzdziBTDkE/KKuBLZI+iUrepNwS1jN32waREo1d8SmBlz1
 +gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698681880; x=1699286680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uQE+oo6MFbLmo94nOkcUGbPOqe4Ex86qspiIiuFDFwA=;
 b=jOx7IT3UhL61xzstKMOoj2w8x9hcZGc7e2urBcjsTbAhBfSiF5e9IZiNmaSLGQZ99G
 D35e8ylNciDsxDHhE6zmGR6Jur3ih8NH+4yKO9xGKQSridxOwA9/+YntLfM5bdn+dhu6
 MATZqy2dbrwrn31jmHSrXuqk2ghySURuN+s06MnZOSzr7yXzdVh9zr9fWWOBEfrpALsS
 J3+F7bL2WzQEEgqyXcrOGNDu4NwvscwjEPNR6mxFN1Pm4QZgv1n58A3aeEGm1hB38U2W
 Gg9H7BJuBlykiAFE4ALHS36XT0E2OMVbYoThGfMng0ufrA9FyRQFwMEwgg9Z2wNEnJzB
 UAgA==
X-Gm-Message-State: AOJu0Yyh24XknDYYeWwYFPgexeu8xT3FkkuFFjkj+5+gUvkjiRVcbHex
 vu6fJgaRAIDfZD2nevvwZ0o=
X-Google-Smtp-Source: AGHT+IHXQrP5cbHfNFqC5YPIM6q0ik12pK42NIhw2nfWluqJScneHVfZ/ZnhUMxLwIbRvfQCbLR9kQ==
X-Received: by 2002:a5d:64a9:0:b0:32d:ddb9:289f with SMTP id
 m9-20020a5d64a9000000b0032dddb9289fmr30273wrp.34.1698681880248; 
 Mon, 30 Oct 2023 09:04:40 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a056000010c00b003232f167df5sm8537746wrx.108.2023.10.30.09.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 09:04:39 -0700 (PDT)
Message-ID: <f691b236-e5da-4f4e-aaf1-bd74f2f9db56@gmail.com>
Date: Mon, 30 Oct 2023 17:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the vram base start address
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231030122205.24805-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231030122205.24805-1-Arunpravin.PaneerSelvam@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.10.23 um 13:22 schrieb Arunpravin Paneer Selvam:
> If the size returned by drm buddy allocator is higher than
> the required size, we take the higher size to calculate
> the buffer start address. This is required if we couldn't
> trim the buffer to the requested size. This will fix the
> display corruption issue on APU's which has limited VRAM
> size.
>
> gitlab issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/2859
> JIRA ticket link: https://ontrack-internal.amd.com/browse/SWDEV-425461
>
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

IIRC that hack with the start address is actually not needed any more, 
but we need to double check this.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 18f58efc9dc7..08916538a615 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -77,7 +77,16 @@ static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
>   	return true;
>   }
>   
> +static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
> +{
> +	struct drm_buddy_block *block;
> +	u64 size = 0;
>   
> +	list_for_each_entry(block, head, link)
> +		size += amdgpu_vram_mgr_block_size(block);
> +
> +	return size;
> +}
>   
>   /**
>    * DOC: mem_info_vram_total
> @@ -516,6 +525,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	mutex_unlock(&mgr->lock);
>   
>   	vres->base.start = 0;
> +	size = max_t(u64, amdgpu_vram_mgr_blocks_size(&vres->blocks),
> +		     vres->base.size);
>   	list_for_each_entry(block, &vres->blocks, link) {
>   		unsigned long start;
>   
> @@ -523,8 +534,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   			amdgpu_vram_mgr_block_size(block);
>   		start >>= PAGE_SHIFT;
>   
> -		if (start > PFN_UP(vres->base.size))
> -			start -= PFN_UP(vres->base.size);
> +		if (start > PFN_UP(size))
> +			start -= PFN_UP(size);
>   		else
>   			start = 0;
>   		vres->base.start = max(vres->base.start, start);

