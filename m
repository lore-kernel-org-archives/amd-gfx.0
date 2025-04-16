Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6487C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C0910E8E8;
	Wed, 16 Apr 2025 12:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGXQ+XJg";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8D210E8E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:35:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so56706355e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744806923; x=1745411723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnU1Gvrky2hgXSsf3VJy4M7LmrrlTT/bF3eyQNaYFBg=;
 b=LGXQ+XJgTuzfV7GTrdyhC/KgNDnox6XodrrC7BQBVFkqp0VY+M4Q5NXJvfF/bCLPnl
 i5W7H4uz6D8MVmluJxaFMl7Sm9A1cXNFWbeyl+RQv6IVrov3kJFN725RMfB4WDI2BBVs
 64ld2gpoCTzvcxbstmORw3KjsUockFWYrJ/WYTlvxkzI/0sOVt6M2Z2DhSmPDLpHoAkP
 O9OUj0EM7BwPvOfoHQEsYGpwuCXL9+RnVqWfkAWmoBRwcC1huY5K83Hq1vRoKKWNQTuZ
 9gJCvnu9YNvffYwcI3H1XCx+oN6BlM8x2/ke9Kjx95Mooy6L3glFmaRJbdMW58Uawadp
 a0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744806923; x=1745411723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnU1Gvrky2hgXSsf3VJy4M7LmrrlTT/bF3eyQNaYFBg=;
 b=EsBMky3SisAgEEE4bYehETdjY2CtWASypN+qJ88dsLkocy3s/a0Qlx4JYZcgkrZVhE
 lOaJnl4lvjvRBUOq5ctvy5lLcHcXkhqHDWwsBQpf5l4qZk8LEM5cTZLE2WTLe4UMIsbz
 IORT1K2z2xybenSSDhL3CWLXRV7Wo1SP6IVoEE3fzbkjNn0r+tolfjgR4yUg9PVM5MJB
 PCpP4JflXdQT2BG9k9FGbxitbNhI0UZOy2XO7+WMnhbnSHI504/HAquyOF15hJtD/hUt
 /i7MwjZVZ2opsteX7j+694vyRQGEDQRChLvairxdH40+kbabHK9jVYqogpQdJVHxmXjT
 1t9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeGcQU7o4HEn3Nas8dm0d+QmSZt8uTXfDa5V+fL5wql1G34sECwd9vp6Bqh2SkUylL0fohcA5n@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaQDgEZzM3heAvFyOCd6TO+OWo339OBfdoN6gir7NRKUt2T4a3
 hGQR8ueZgQQR60EKesvXV7JDbmohN1ioYvccZYvMRhh90QAO7d735W1a86XO
X-Gm-Gg: ASbGnct0Zk1p4teweR/41np5g4je3AGSMF9gPvb+cTfW9dc8YgbhVoWSTIESJZdmRUF
 RrjspgnO80IzJoTzUyMZhRJtrc+ot82s2+j5ZY5gvATSElUbKAMjpdizL3XVNNSJqprkoEh9uyQ
 OniuF1/R7sLWflGBmbO1UFkNu3BA7qOXQM2gPTOGfVFFo8o6sHoEi2nn2ILKItUiix6d6vZyCtR
 a11NDNVliWFuQINVWlcTOI7d9mnMk29IHfPFifMqsZdz/DbVuqlguJtxi0S4zpuhjBkYVYVy35K
 +IAs0wA9RYL4t1tStJi6RyHqRcNmG0eyOxBsWgu9sq3+JWVBXu9CKRl9VCjRCpv3nk+njA==
X-Google-Smtp-Source: AGHT+IFMHPdFOamaq9rXLNrWEp7ucHugiID2zmyuVbbr4Xm3lUAXUmzOUtQ1vDuv/+2VAuYOBKLJEQ==
X-Received: by 2002:a5d:584a:0:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-39ee5b9f98cmr1622497f8f.43.1744806922659; 
 Wed, 16 Apr 2025 05:35:22 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d1236sm20124895e9.13.2025.04.16.05.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 05:35:22 -0700 (PDT)
Message-ID: <1d1f9b2a-8584-4c20-9c4e-377d8ffd5aaf@gmail.com>
Date: Wed, 16 Apr 2025 14:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Don't pin VRAM without DMABUF_MOVE_NOTIFY
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, yang.su2@amd.com, hao.zhou@amd.com,
 asher.song@amd.com, pak.lui@amd.com
References: <20250416044529.1147595-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250416044529.1147595-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 16.04.25 um 06:45 schrieb Felix Kuehling:
> Pinning of VRAM is for peer devices that don't support dynamic attachment
> and move notifiers. But it requires that all such peer devices are able to
> access VRAM via PCIe P2P. Any device without P2P access requires migration
> to GTT, which fails if the memory is already pinned for another peer
> device.
>
> Sharing between GPUs should not require pinning in VRAM. However, if
> DMABUF_MOVE_NOTIFY is disabled in the kernel build, even DMABufs shared
> between GPUs must be pinned, which can lead to failures and functional
> regressions on systems where some peer GPUs are not P2P accessible.
>
> Disable VRAM pinning if move notifiers are disabled in the kernel build
> to fix regressions when sharing BOs between GPUs.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one here.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 667080cc9ae1c..9abe592968ab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -81,14 +81,21 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>  
>  	dma_resv_assert_held(dmabuf->resv);
>  
> -	/*
> -	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> +	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>  	 * support if all attachments can do P2P. If any attachment can't do
>  	 * P2P just pin into GTT instead.
> +	 *
> +	 * To avoid with conflicting pinnings between GPUs and RDMA when move
> +	 * notifiers are disabled, only allow pinning in VRAM when move
> +	 * notiers are enabled.
>  	 */
> -	list_for_each_entry(attach, &dmabuf->attachments, node)
> -		if (!attach->peer2peer)
> -			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
> +		domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	} else {
> +		list_for_each_entry(attach, &dmabuf->attachments, node)
> +			if (!attach->peer2peer)
> +				domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
> +	}
>  
>  	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
>  		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

