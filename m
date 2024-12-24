Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0380E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2024 09:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5918B10E0E6;
	Tue, 24 Dec 2024 09:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="yhaLRu/o";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0261710E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2024 09:17:58 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so32414525e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2024 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1735031817; x=1735636617;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jep13BE9PBPFLV6gRhNR3YnWc64sB1aHzxcp+bI0mWk=;
 b=yhaLRu/oS56H69Qiz6xlBCPjnahHbuCpo4mtqA2jdly6k6hfHALUT3fZWBC/oRs/sf
 Uubc5sh0p54/j7LSegKIGMq3UfLFV+Jf7KHzBqjVNNHbmTmXnrhz1HA5lIFwRIDbng5u
 8cKzh1JRNNQwAZQkHeIkwnBCcM6sj/KtdgvMWt/51Dr0JuIDIw3q8IqjHcFJt+y4R0+G
 iigd3U+sLOOB9R5O5murp+CFE+pjlTtFmJcygGwt/0QzUNU3FPYUBD8BziGBOV+NuRcs
 BVXjVi06ByY2aYQTKqXcMwFHHbFhgpJI8AILw+jiJHfVavDbXP7XP4ounH1sbEUqpeDn
 9i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735031817; x=1735636617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jep13BE9PBPFLV6gRhNR3YnWc64sB1aHzxcp+bI0mWk=;
 b=N7USOnnWdhtLcRwzENoj9HbRM9I2AgrO/UlCQiZImuinWUYpfttPyag06MPUT/aG4G
 PkzFGBqZu96juXfSnMS/Hv+wdGHwe9YAg6LtLZi2nvp7BU27+jaB5q4R5kANk1ijUwRe
 fr6Jn/XQOeZw+P6qaIrK8jbGCVndqxmivNSH8m/LL2v2livM0KjqF+pQxmm3s8CQ4zvY
 uR9dWwA9BquSpwNqNwOQDa0k1CL0tzL6Hz3STT9ZhZRHBCTS0qWx7MrWkAQRytb6y47+
 uySbedzQ0m9n3ljQcA8yZjAFcGpkF+Nd6c89L+URFlCHYmqcXVnEr25P6qXHWwb8DOsE
 O0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKLk/vTtD+8CYi7rdwY9tnDSt4LvyxYOiLxIaT2BOuq5ebqBUtJJMyfIBeO/ju395+mBZjKR8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiOfWdaJk7kkxGsB5sGVqY1WqRObSW3cxDgBFbCfDq+skZqli6
 11NoWTO9MoFutw3rYw6TqXgb8Zrq1bdTqz0qnTJP3EGQH2dtPiCrqw8s64GHSeY=
X-Gm-Gg: ASbGncsNAwq9zpJ/GXazhiaAMhVjxR6UdQEjHaNI9zr3phlOua/nHUuMKJhltR6pHgv
 LSYs5FdDz02WXEQDOUrXuSFgGiOly5uSw85oSFEQAgZ7F7/veNOJ2gbMth5VGgzvj/lpZFebCIE
 TzgRQmhBG67p3fn6aoBO0D2qVzk9dsS5STf8RyM966K9TbHm0LQMLxd4+RObUrnCeMwedIDQHN6
 olULcd8RP4QxPieBCuDexLSq8bPXYNILqcLAiUZveutI7R2e7qEq/CMPG82KlOS07tT3M46
X-Google-Smtp-Source: AGHT+IFHxwRTOMucKzpK/ldPVb679Odqx56ofhCRxDt9LbVuzYNUdhpXo8wMsQn1dKhvFEYcPGISug==
X-Received: by 2002:a05:600c:1550:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-43668b5f6a5mr122435885e9.26.1735031817325; 
 Tue, 24 Dec 2024 01:16:57 -0800 (PST)
Received: from [192.168.0.101] ([90.241.98.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84722dsm13651444f8f.53.2024.12.24.01.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 01:16:56 -0800 (PST)
Message-ID: <5231b17a-483b-4ff8-8451-fcc715627a4f@ursulin.net>
Date: Tue, 24 Dec 2024 09:16:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Use efficient ring padding with more rings
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20241223163913.38767-1-tursulin@igalia.com>
 <20241223163913.38767-3-tursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20241223163913.38767-3-tursulin@igalia.com>
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


On 23/12/2024 16:39, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> We can easily expand the approach of writing nops in blocks using memset32
> (via the respective helper) to more rings.
> 
> We do that by trivially factoring out a new amdgpu_ring_fill() helper out
> of amdgpu_ring_insert_nop() and call it from SDMA and VPE vfuncs.
> 
> The amount of padding with those rings is a bit less than GFX but it is
> still a bit nicer to use the same approach across the board.

Scratch this for now, I think there is a way to make something in this 
area more sellable by adding more advantages.

Regards,

Tvrtko

> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 +++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 15 ++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 16 +++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 16 +++++++------
>   12 files changed, 111 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a27e32f48f99..c3a68eae1c9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -99,16 +99,16 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>   	return 0;
>   }
>   
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_fill - insert dwords into a ring
>    *
>    * @ring: amdgpu_ring structure holding ring information
> - * @count: the number of NOP packets to insert
> - *
> - * This is the generic insert_nop function for rings except SDMA
> + * @val: dword value to insert
> + * @count: the number of dwords to insert
>    */
> -void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +void amdgpu_ring_fill(struct amdgpu_ring *ring, u32 val, u32 count)
>   {
> -	uint32_t occupied, chunk1, chunk2;
> +	u32 occupied, chunk1, chunk2;
>   
>   	occupied = ring->wptr & ring->buf_mask;
>   	chunk1 = ring->buf_mask + 1 - occupied;
> @@ -116,16 +116,29 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   	chunk2 = count - chunk1;
>   
>   	if (chunk1)
> -		memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
> +		memset32(&ring->ring[occupied], val, chunk1);
>   
>   	if (chunk2)
> -		memset32(ring->ring, ring->funcs->nop, chunk2);
> +		memset32(ring->ring, val, chunk2);
>   
>   	ring->wptr += count;
>   	ring->wptr &= ring->ptr_mask;
>   	ring->count_dw -= count;
>   }
>   
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @count: the number of NOP packets to insert
> + *
> + * This is the generic insert_nop function for rings except SDMA
> + */
> +void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +{
> +	amdgpu_ring_fill(ring, ring->funcs->nop, count);
> +}
> +
>   /**
>    * amdgpu_ring_generic_pad_ib - pad IB with NOP packets
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index dee5a1b4e572..4a8134b682f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -346,6 +346,7 @@ void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring);
>   void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring);
>   void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
>   
> +void amdgpu_ring_fill(struct amdgpu_ring *ring, u32 val, u32 count);
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 121ee17b522b..92a444922b2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -459,14 +459,16 @@ static int vpe_resume(struct amdgpu_ip_block *ip_block)
>   
>   static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (i == 0)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				VPE_CMD_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count) {
> +		count--;
> +		amdgpu_ring_write(ring, nop | VPE_CMD_NOP_HEADER_COUNT(count));
> +		if (count > 1)
> +			amdgpu_ring_fill(ring, nop, count);
> +		else if (count)
> +			amdgpu_ring_write(ring, nop);
> +	}
>   }
>   
>   static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index d9bd8f3f17e2..275494e6cc8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -200,14 +200,15 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
>   static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -					  SDMA_NOP_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring, nop | SDMA_NOP_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 135c5099bfb8..7e1498a60f01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -224,14 +224,16 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index c611328671ed..eae8310407eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -400,14 +400,16 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index b48d9c0b2e1c..68120baafbbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -784,14 +784,16 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 56507ae919b0..076a07400db6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -344,14 +344,16 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b764550834a0..97079c63e462 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -436,14 +436,16 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b1818e87889a..8913f3ed4e2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -253,14 +253,16 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 1a023b45f0be..f2b04adfebdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -238,14 +238,16 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 9c17df2cf37b..ce2af42a9289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -270,14 +270,16 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
>   static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
> -	int i;
> +	const u32 nop = ring->funcs->nop;
>   
> -	for (i = 0; i < count; i++)
> -		if (sdma && sdma->burst_nop && (i == 0))
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (count && sdma && sdma->burst_nop)
> +		amdgpu_ring_write(ring,
> +				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
> +
> +	if (count > 1)
> +		amdgpu_ring_fill(ring, nop, count);
> +	else if (count)
> +		amdgpu_ring_write(ring, nop);
>   }
>   
>   /**
