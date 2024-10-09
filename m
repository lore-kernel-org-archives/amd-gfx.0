Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FD8CED618
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 07:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D761910E668;
	Wed,  9 Oct 2024 07:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="BgPYdKyt";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF80610E668
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:41:26 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so57521105e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Oct 2024 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1728459685; x=1729064485;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oj/NwM+qjHsFNNbOuM7wam7uLLA6VPnVQruA/XI1lrY=;
 b=BgPYdKytel0y1CQ54QmEcU2pc1YpC5HhbTX9Z9KtiuVjVs30wOzZkchLvdd7hMz4YC
 kdbu7OTYBVDBpQXaDMVVxLUpxeDmC33hqywv7QFzrAHo/JfF5JUFhhMccFSm9rHPXqBq
 L5QtQEyIgdT2NPaUg7Qksx8qCC2Mf6Z8Z1jyys3dKfbfeOO5XuMC9LWSXSafsE1bzbJr
 PPLXhzFjAIi2N5uVqC5OF45auMXaCmUT4i5dDzadcfyZVTFfA1s77vb1lQotDyPYy9nB
 Qx18ANtNL0sazwi1sqkYYgNojDpplRus6V8m3U9G831pmqjb2JzJROHA/3vO5h8mhv6L
 crqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728459685; x=1729064485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oj/NwM+qjHsFNNbOuM7wam7uLLA6VPnVQruA/XI1lrY=;
 b=RKRwe8S+ANo8WCkvBP7haqj+oAZRg/GrebgWyFHaoUy9RViKkxAvgljfHeOAU2E6Hl
 N9sEGf2OFfPE4h8Jt8grl2VwrkOSdoDTEaRCt0aTp3KeRS9O4+h+19m8uCDXEnqLtQIo
 Y+vyRsiFabV7XbsSbsVDgQMJlBFDWaCxlj3ucGy5ofinX5Cnfkr9a6zf120ul4H1KeyA
 J8G4h99A3HsM1Cqjejjx2NxjHfDWLQwC378Gaeva26/u0gHe3jgJUVtdGG4S/jfWEtTa
 lIh+MqvoqBJWS3z1kTKJm8tVNBQ7pI3W8aZ35EOdBmMzQ+dh0ZOQ5UzcroVv7+S549of
 K2fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeY+CUC2OqLxw/xc1w9iVd7UBx7i6FKoDkExUdaspQCto5xGQnpi/NLLSiFlHJiqA4LEy0qD4u@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx33V7BzTIOHWIGQjyygNgmFHi56OAY3+Nel5kzAgFthwGKn8iQ
 Kboa9Z2Bg2pnkqYOROmpdCe7QNRo1l5bXDWt9b8V/SDCqOuH15SLyshwepPyxH4=
X-Google-Smtp-Source: AGHT+IGq2lRs8ITFrjhKJsKNsbQzMxrn1GRkoQKUxybFqceOz9CtzqHvS38B9xFEXk36GmCScvYsMA==
X-Received: by 2002:adf:a31e:0:b0:37c:d4e8:2c67 with SMTP id
 ffacd0b85a97d-37d3aa87330mr728111f8f.52.1728459684930; 
 Wed, 09 Oct 2024 00:41:24 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d59b2b85sm11489405e9.34.2024.10.09.00.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 00:41:24 -0700 (PDT)
Message-ID: <3d3de66f-01fd-4adb-83c6-140bfc570f1f@ursulin.net>
Date: Wed, 9 Oct 2024 08:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: drop volatile from ring buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, tursulin@igalia.com, sunil.khatri@amd.com
References: <20241008181134.1350-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20241008181134.1350-1-christian.koenig@amd.com>
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
> Volatile only prevents the compiler from re-ordering reads and writes.
> Since we always only modify the ring buffer from one CPU thread and have
> an explicit barrier before signaling the HW this should have no effect at
> all and just prevents compiler optimisations.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
>   2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 910293664902..a6e28fe3f8d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	uint32_t occupied, chunk1, chunk2;
> -	uint32_t *dst;
>   
>   	occupied = ring->wptr & ring->buf_mask;
> -	dst = &ring->ring[occupied];
>   	chunk1 = ring->buf_mask + 1 - occupied;
>   	chunk1 = (chunk1 >= count) ? count : chunk1;
>   	chunk2 = count - chunk1;
>   
>   	if (chunk1)
> -		memset32(dst, ring->funcs->nop, chunk1);
> +		memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
>   
> -	if (chunk2) {
> -		dst = ring->ring;
> -		memset32(dst, ring->funcs->nop, chunk2);
> -	}
> +	if (chunk2)
> +		memset32(ring->ring, ring->funcs->nop, chunk2);
>   
>   	ring->wptr += count;
>   	ring->wptr &= ring->ptr_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 574336d6714a..36fc9578c53c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -246,7 +246,7 @@ struct amdgpu_ring {
>   	struct drm_gpu_scheduler	sched;
>   
>   	struct amdgpu_bo	*ring_obj;
> -	volatile uint32_t	*ring;
> +	uint32_t		*ring;
>   	unsigned		rptr_offs;
>   	u64			rptr_gpu_addr;
>   	volatile u32		*rptr_cpu_addr;
> @@ -288,7 +288,7 @@ struct amdgpu_ring {
>   	u64			cond_exe_gpu_addr;
>   	volatile u32		*cond_exe_cpu_addr;
>   	unsigned int		set_q_mode_offs;
> -	volatile u32		*set_q_mode_ptr;
> +	u32			*set_q_mode_ptr;
>   	u64			set_q_mode_token;
>   	unsigned		vm_hub;
>   	unsigned		vm_inv_eng;
> @@ -386,10 +386,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   					      void *src, int count_dw)
>   {
>   	unsigned occupied, chunk1, chunk2;
> -	void *dst;
>   
>   	occupied = ring->wptr & ring->buf_mask;
> -	dst = (void *)&ring->ring[occupied];
>   	chunk1 = ring->buf_mask + 1 - occupied;
>   	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
>   	chunk2 = count_dw - chunk1;
> @@ -397,12 +395,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	chunk2 <<= 2;
>   
>   	if (chunk1)
> -		memcpy(dst, src, chunk1);
> +		memcpy(&ring->ring[occupied], src, chunk1);
>   
>   	if (chunk2) {
>   		src += chunk1;
> -		dst = (void *)ring->ring;
> -		memcpy(dst, src, chunk2);
> +		memcpy(ring->ring, src, chunk2);
>   	}
>   
>   	ring->wptr += count_dw;

Dropping volatile and removal of local variables in 
amdgpu_ring_insert_nop() and amdgpu_ring_write_multiple() look unrelated 
to me. Best practice would be if you had split those two changes. Or at 
least add to the commit message the usual "while at it" blurb.

Regards,

Tvrtko
