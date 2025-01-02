Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93078E77194
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 13:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455D810E703;
	Thu,  2 Jan 2025 13:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDIIcWVC";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411D210E6FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 13:57:00 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so11781265e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2025 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735826158; x=1736430958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+64Vi+Y1QhPBu0b0nkooHu2ojs1dRv/ImtMBWDxzNY=;
 b=LDIIcWVCFCjxfDGxx/ZFU4WFHCk7vchS4X1L4jPGwdcx8NyAftCPhmkUdToxMhOPPK
 ASpvyJyXG86CQBLA5RRkyD9s+I2SpnbWj5zMcRONqp4dUtRX7zGwkh8iAWP3NL2t57Uq
 YllGRc+vpZgrnJk5grh11dme+7B3QAby1iGdF6oVHpYICf4ilZ4y1poz3w0LaPzTBB4P
 dDXzjXtBEcUSwnJhtkzEgKosyrIQcU2OfmEOoDef3gMSE1IPQjoQyDYUMS4yRqHH1qgO
 BlWZrLng+AjzjX0WZ/Mk4l8l3lgRTRD8oXVJjibeqpE3mCmjYS61aR1d8bz1JfC1t6/v
 qp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735826158; x=1736430958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+64Vi+Y1QhPBu0b0nkooHu2ojs1dRv/ImtMBWDxzNY=;
 b=Aa97qodOuXNREZt4Fn8DI/mOJwo3ZVdMSSCV+F5wkN9JjTavH4T8Ji6Zzfb+bdM2Wn
 5NbyPtAMII61kHNk+PEX81NrUt5hPJsF1o9Uwv/hAjJykr6TXjAkzdDdbWExS/7Stera
 wyDbPvQ6yHI1KocO2QRKsCCy0quZhkp7/lBMM0j6uBM3m0m8bCEdjkxl4XmK9Ac6vZvj
 0en//G+hL68uTFlXbEQ57/QApJ2XKJm9Hq76KZUlxu0//tY5ugcr5OxfOV/NsGhZ7A9f
 xk8psRe4r9lGjCYiiJjcKXSZgOQz4cPFxWnrrbEnAks8g0yYHym5c+djNTNhe/qmVOqI
 RAog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXHtSjWGkRnt0+LC5jXnPXK5N0M4uifFZC8qDH29h+TW5oORBbj7AQA4zfS3IZX6TwGoi9fUfG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymEO6iKDBZOUjLot/yV0oHn9ciEK3wShTLjVjne5J9a36twpZf
 TnXW9v3puZU0bZ22s+fZaug831Uc53Ps8t8pES7SF272uMlhulU4fzcmwA==
X-Gm-Gg: ASbGncvOFhyBFkImdqG5cIMdO+nTU1ma5Ges8Fn2A0niSxAgYkb6x/N7eWLaYAb6G+T
 wgOLgdO4ld747rAB3/3kL+I99zwe0HwM/neoYPV9dLXgNpRfMZ9LpT4eb834Ybb0gfUqyIDcjS4
 E+qkdUdSp/UnZSvYYS4zOnlP8l7ZD2/fRGfgiYQP/FLigJtd/vJz7MEgPTJ7cAyaVaxh/xFZyaM
 ZPd2hchqPK3iShi4YW78/Qo9STDL4Kj/buCedPNDaNz4tXwxIuoNI1D5eppq23TraIvZ3XFU9yB
 7q2Xky6s0g==
X-Google-Smtp-Source: AGHT+IFPn11Ibpwk8QQ53MRPVLfi3CoNTZCqc3S5VVTqxGDRLdyZwLLPnJKRXAGi6SUiFW87obPByw==
X-Received: by 2002:a05:6000:144b:b0:385:fb2c:6021 with SMTP id
 ffacd0b85a97d-38a223ff339mr42631675f8f.39.1735825785567; 
 Thu, 02 Jan 2025 05:49:45 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8288b8sm37883557f8f.11.2025.01.02.05.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 05:49:45 -0800 (PST)
Message-ID: <5f216d24-0a84-47f3-95c5-03724e74af3f@gmail.com>
Date: Thu, 2 Jan 2025 14:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: Consolidate a bunch of similar sdma
 insert nop vfuncs
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
 <20241227111938.22974-5-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241227111938.22974-5-tursulin@igalia.com>
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

Am 27.12.24 um 12:19 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> A lot of the hardware generations apparently uses the same nop insertion
> logic, just with different masks and shifts.
>
> We can consolidate if we store those shifts and mask in the ring and
> shrink both the source and binary.

The shift and mask should be identical for most HW generations anyway. 
Only SI might be a bit different.

So probably better to have a special function for SI and a general for 
all other HW generations.

Regards,
Christian.

>
> Though it appears a bit of a departure from the existing "duplicate
> everything" state so we will see how this is received.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 19 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 19 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 23 +++++++----------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 +++++++----------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 19 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 19 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 19 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 19 ++++---------------
>   11 files changed, 62 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 429c77db920f..4c0861ebc77a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -303,6 +303,11 @@ struct amdgpu_ring {
>   	struct {
>   		struct amdgpu_sdma_instance *instance;
>   		int			     index;
> +
> +		struct {
> +			u32		mask;
> +			unsigned int	shift;
> +		} nop_pkt;
>   	} sdma;
>   
>   	/* used for mes */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index d43dfec82624..148413f01875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -34,6 +34,24 @@
>    * GPU SDMA IP block helpers function.
>    */
>   
> +void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count)
> +{
> +	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> +	const u32 nop = ring->funcs->nop;
> +	u32 i;
> +
> +	if (!count)
> +		return;
> +
> +	if (sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring, nop |
> +					(--count & ring->sdma.nop_pkt.mask) <<
> +					ring->sdma.nop_pkt.shift);
> +
> +	for (i = 0; i < count; i++)
> +		amdgpu_ring_write(ring, nop);
> +}
> +
>   uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
>   				     unsigned int vmid)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 7debf3ed0b46..d2642a9113ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -159,6 +159,7 @@ struct amdgpu_buffer_funcs {
>   #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>   #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>   
> +void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count);
>   uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
>   int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>   			      struct ras_common_if *ras_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 2e844dba4ad5..e0ed65eca431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -221,19 +221,6 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
>   	WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
>   }
>   
> -static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v2_4_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -252,7 +239,7 @@ static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	/* IB packet must end on a 8 DW boundary */
> -	sdma_v2_4_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -866,6 +853,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	return r;
> @@ -1137,7 +1126,7 @@ static const struct amdgpu_ring_funcs sdma_v2_4_ring_funcs = {
>   	.emit_hdp_flush = sdma_v2_4_ring_emit_hdp_flush,
>   	.test_ring = sdma_v2_4_ring_test_ring,
>   	.test_ib = sdma_v2_4_ring_test_ib,
> -	.insert_nop = sdma_v2_4_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v2_4_ring_pad_ib,
>   	.emit_wreg = sdma_v2_4_ring_emit_wreg,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 104fd1214c4c..8a644ea28589 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -397,19 +397,6 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v3_0_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -428,7 +415,7 @@ static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	/* IB packet must end on a 8 DW boundary */
> -	sdma_v3_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1152,6 +1139,8 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	return r;
> @@ -1579,7 +1568,7 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
>   	.emit_hdp_flush = sdma_v3_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v3_0_ring_test_ring,
>   	.test_ib = sdma_v3_0_ring_test_ib,
> -	.insert_nop = sdma_v3_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v3_0_ring_pad_ib,
>   	.emit_wreg = sdma_v3_0_ring_emit_wreg,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index c91d05a4593e..0f0f05a03cd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -781,19 +781,6 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v4_0_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -812,7 +799,7 @@ static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	/* IB packet must end on a 8 DW boundary */
> -	sdma_v4_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1876,6 +1863,8 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   
>   		if (adev->sdma.has_page_queue) {
>   			ring = &adev->sdma.instance[i].page;
> @@ -1917,6 +1906,8 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   			ring->sdma.instance = &adev->sdma.instance[i];
>   			ring->sdma.index = i;
> +			ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +			ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   		}
>   	}
>   
> @@ -2443,7 +2434,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>   	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v4_0_ring_test_ring,
>   	.test_ib = sdma_v4_0_ring_test_ib,
> -	.insert_nop = sdma_v4_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v4_0_ring_pad_ib,
>   	.emit_wreg = sdma_v4_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
> @@ -2475,7 +2466,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
>   	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v4_0_ring_test_ring,
>   	.test_ib = sdma_v4_0_ring_test_ib,
> -	.insert_nop = sdma_v4_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v4_0_ring_pad_ib,
>   	.emit_wreg = sdma_v4_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index d1d21a3951f8..f68b7f2e0a40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -341,19 +341,6 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v4_4_2_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -372,7 +359,7 @@ static void sdma_v4_4_2_ring_emit_ib(struct amdgpu_ring *ring,
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	/* IB packet must end on a 8 DW boundary */
> -	sdma_v4_4_2_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1431,6 +1418,8 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   
>   		if (adev->sdma.has_page_queue) {
>   			ring = &adev->sdma.instance[i].page;
> @@ -1455,6 +1444,8 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   			ring->sdma.instance = &adev->sdma.instance[i];
>   			ring->sdma.index = i;
> +			ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +			ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   		}
>   	}
>   
> @@ -2013,7 +2004,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>   	.emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,
>   	.test_ring = sdma_v4_4_2_ring_test_ring,
>   	.test_ib = sdma_v4_4_2_ring_test_ib,
> -	.insert_nop = sdma_v4_4_2_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v4_4_2_ring_pad_ib,
>   	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
> @@ -2045,7 +2036,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>   	.emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,
>   	.test_ring = sdma_v4_4_2_ring_test_ring,
>   	.test_ib = sdma_v4_4_2_ring_test_ib,
> -	.insert_nop = sdma_v4_4_2_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v4_4_2_ring_pad_ib,
>   	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 97536f82dfcd..bbf60bfa4b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -433,19 +433,6 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v5_0_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -472,7 +459,7 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>   	 * (wptr + 6 + x) % 8 = 0.
>   	 * The expression below, is a solution of x.
>   	 */
> -	sdma_v5_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1453,6 +1440,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	adev->sdma.supported_reset =
> @@ -1991,7 +1980,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>   	.emit_hdp_flush = sdma_v5_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v5_0_ring_test_ring,
>   	.test_ib = sdma_v5_0_ring_test_ib,
> -	.insert_nop = sdma_v5_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v5_0_ring_pad_ib,
>   	.emit_wreg = sdma_v5_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 8eaddee1d97d..69b88db32117 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -250,19 +250,6 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v5_2_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -289,7 +276,7 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
>   	 * (wptr + 6 + x) % 8 = 0.
>   	 * The expression below, is a solution of x.
>   	 */
> -	sdma_v5_2_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1358,6 +1345,8 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	adev->sdma.supported_reset =
> @@ -1986,7 +1975,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>   	.emit_hdp_flush = sdma_v5_2_ring_emit_hdp_flush,
>   	.test_ring = sdma_v5_2_ring_test_ring,
>   	.test_ib = sdma_v5_2_ring_test_ib,
> -	.insert_nop = sdma_v5_2_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v5_2_ring_pad_ib,
>   	.begin_use = sdma_v5_2_ring_begin_use,
>   	.end_use = sdma_v5_2_ring_end_use,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 3ead269eccdc..aa3992fd5313 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -235,19 +235,6 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /*
>    * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -274,7 +261,7 @@ static void sdma_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>   	 * (wptr + 6 + x) % 8 = 0.
>   	 * The expression below, is a solution of x.
>   	 */
> -	sdma_v6_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1351,6 +1338,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	adev->sdma.supported_reset =
> @@ -1707,7 +1696,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
>   	.emit_hdp_flush = sdma_v6_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v6_0_ring_test_ring,
>   	.test_ib = sdma_v6_0_ring_test_ib,
> -	.insert_nop = sdma_v6_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v6_0_ring_pad_ib,
>   	.emit_wreg = sdma_v6_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v6_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 5fadaf35a03a..4ccc00248a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -267,19 +267,6 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> -{
> -	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> -}
> -
>   /**
>    * sdma_v7_0_ring_emit_ib - Schedule an IB on the DMA engine
>    *
> @@ -306,7 +293,7 @@ static void sdma_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
>   	 * (wptr + 6 + x) % 8 = 0.
>   	 * The expression below, is a solution of x.
>   	 */
> -	sdma_v7_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
> +	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
>   
>   	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_INDIRECT) |
>   			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1365,6 +1352,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		ring->sdma.instance = &adev->sdma.instance[i];
>   		ring->sdma.index = i;
> +		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
> +		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
>   	}
>   
>   	adev->sdma.supported_reset =
> @@ -1687,7 +1676,7 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
>   	.emit_hdp_flush = sdma_v7_0_ring_emit_hdp_flush,
>   	.test_ring = sdma_v7_0_ring_test_ring,
>   	.test_ib = sdma_v7_0_ring_test_ib,
> -	.insert_nop = sdma_v7_0_ring_insert_nop,
> +	.insert_nop = amdgpu_sdma_ring_insert_nop,
>   	.pad_ib = sdma_v7_0_ring_pad_ib,
>   	.emit_wreg = sdma_v7_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v7_0_ring_emit_reg_wait,

