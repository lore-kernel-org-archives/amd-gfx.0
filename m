Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566FBC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAAA112A07;
	Mon, 22 Apr 2024 11:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gST9ddwW";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BFE112A07
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:35:16 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-41a55be31dfso5926705e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713785715; x=1714390515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YDwd/t3ambiwwvYXXf9oQ9xau7vdLMlTz+5v6vyfmFc=;
 b=gST9ddwWimpXgfkxIStJOBTSrMpx2e1XAa82zmZmgW5mBgrJhAtcB2bGDewoG6enF8
 LobECYq1LfKWpv4A0Uyl4w0WJ7lEbSQYCuUo9d6MMvjxxI3uzMlqggS4RmIDaxRIRo6D
 vz45QV8eepr0pru1iL0Xj/j16zZe+mdNsg6z7ezrSgNInI+DqWk03Du7i+8C6Q9nkfb8
 N3uIgUFJGdF2NDpVoB6ne4FOz3TzNc4QccZHCn38zniSiqaLYJc3QhfOzIwJMrPFpejh
 Zetj7fg48FpG0kad+UYQ29L0GdzyJh3gfrGiMqBR9opPZd9+eFquyH+SXg0XS8cwwpc7
 6/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713785715; x=1714390515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDwd/t3ambiwwvYXXf9oQ9xau7vdLMlTz+5v6vyfmFc=;
 b=BnwhogJwQYDkG5XCp0xmmj/Q78KJwiyVcBBhkTxkyWK1UOlmWSsd2Rsw5DGl4bzvFJ
 NXDtKf9OXk9uTlDIryL7pfoipdDhH1ruVvBImKB4miGTSvvrqULTTEuvE1/BtPvNMwek
 m0H/kbAZZl3bl5+rQ1MytViJheVTSK7n6vkcgWvpMD/4gS1V0nprAKbt63xtW6GfiTN8
 nEwRyR+5NE6EI+jfVgJhrtBdp7a2OIh3wtYODsPFYMHAsp1ulkRRG7Tsuh5EMsYgbCN4
 eLOfXzFCFLRJDOpqPP2kc15iGbjLzDH2u/LznzaUAAyWueQKxDcNWkvJYWwBIdUiCA7E
 Hzwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPRYN1fHxsnXz0WTqSR18XrlhBTU9rylV6nZHNMSG7h//Ol6GGGkrGNU0cl9OG0jEMmypXXg7LpFhYg9XYMZIjpJp3ZHq+9SlRjYVgGA==
X-Gm-Message-State: AOJu0YyMRnQeTqRSj0vu8Tfr0gSLyNXpkDYcaZcmzMQSFLADVc/mtlTT
 Ni0VH6SDiVsxlG5S84D3yTQmW0/Wc1GqrgEO4wv76MZz1PLnc+lh
X-Google-Smtp-Source: AGHT+IEy38CvlML9XjiYgjHuC/4O6j+8vO2iXBRSqPWzN2rkOFUEFZk33kUQnUC8BnZ9dHeM4eOtBg==
X-Received: by 2002:a05:600c:34c4:b0:41a:5de5:85f8 with SMTP id
 d4-20020a05600c34c400b0041a5de585f8mr1719955wmq.13.1713785714816; 
 Mon, 22 Apr 2024 04:35:14 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b0041a7aa23dbfsm1680899wmb.48.2024.04.22.04.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 04:35:14 -0700 (PDT)
Message-ID: <300ffa6a-de88-4227-a7f4-25ad7548d1c4@gmail.com>
Date: Mon, 22 Apr 2024 13:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240420190247.3130325-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240420190247.3130325-1-alexander.deucher@amd.com>
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

Am 20.04.24 um 21:02 schrieb Alex Deucher:
> This avoids a potential conflict with firmwares with the newer
> HDP flush mechanism.

The patch is fine, but I'm starting to wonder why we are using the newer 
HDP flush mechanism in the first place?

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2156
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b2417ba4759b..c44ec41f1cb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -280,17 +280,21 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask = 0;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
> -
> -	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
> -			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
> -			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
> -	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
> -	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
> -	amdgpu_ring_write(ring, ref_and_mask); /* reference */
> -	amdgpu_ring_write(ring, ref_and_mask); /* mask */
> -	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
> -			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
> +	if (ring->me > 1) {
> +		amdgpu_asic_flush_hdp(adev, ring);
> +	} else {
> +		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
> +
> +		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
> +				  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
> +				  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
> +		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
> +		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
> +		amdgpu_ring_write(ring, ref_and_mask); /* reference */
> +		amdgpu_ring_write(ring, ref_and_mask); /* mask */
> +		amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
> +				  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
> +	}
>   }
>   
>   /**

