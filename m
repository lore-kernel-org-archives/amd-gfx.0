Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853A6CCD1A5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 09:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE2D10E0B7;
	Tue, 21 Oct 2025 09:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grI1IE0u";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2E710E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 09:23:44 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-63c09ff13aeso9690434a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761038623; x=1761643423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6vOZDtj1d95COQ56SxUZ30tPKsrlE1HlNkkwxI7JqaM=;
 b=grI1IE0uaIU7GFFUZEgmnqpA6/BYaOppipV9MGutu/TpHOjvsESPczoOcecMzgJT8z
 rggnQjUpLF6epo2h9tMZkkwkzoXE5gYDcDetpfPw47W4D6QKESopYSvBP3eYZzNeHwU8
 9jR4XZlFk9yDYQKu4q7QqPqiW/aptwh3Y3EfkPtXOOjVs6i5UrU2456n9IEKnqx8o7fM
 ejiG7m2uewY5ofqxJlXuUwF2KBT3/nLm4Mk1LsZ3N/cLem/R2OPInBdz1m/dd5tjB77+
 vU9iNdBvCHzfU12zv7Q61ezrOl7Sa9q7k9W0BsGYlcd4zy63WOevYu487BPUY4jvuUks
 fiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761038623; x=1761643423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vOZDtj1d95COQ56SxUZ30tPKsrlE1HlNkkwxI7JqaM=;
 b=lXk1+31PUuF0bfvKyE8zeC+QHx3/a4U1MbqgGdusvfdvu6aFo7ppJdlP/sE6PazD8L
 UsxlHAwCkyfJDlIMxQJECsFj5vgV2oAKbCARn9+ZBJSHZcF0Opd/DoyLT877ZkANR6QL
 Bu5sMHY6cyCN0eisIWpLcVl+CJZAg1Zy2KGbeLtrIhKHBYRw2iE7Qv09N4qv3+fzAFEv
 /r3awvJ/ekK18w45PfiWHlTTCWhb/SLY22M5EqZHXDC8wjSn0qu0hCcPYqmMi3KgpEZr
 g2//agyVmkzfnQ05Y5P7qItHAQIL3MSw/kMimfje/XZic7yngbOmgzPIxtgEVwWpjodH
 xe1A==
X-Gm-Message-State: AOJu0YyJ4Z/kpxgFTJpUcT7qz4YI6+M1y0HEjBPhLdZGnhmZUl/dOV5c
 nz9b7JFanXHVriXZ77MxafSJuXxi2IfavdTRP0/ohZl6emHzGTG2+6YJ
X-Gm-Gg: ASbGncsec4cSJgykho70XE+4DFkhNJc/oHuWrCYqVMdCMLxsbgAX2ZwAW82JAgulOQy
 xqnuVZs2WJpNCIxP5U7ZVAe3sI4v3sWot1WA2XD2PmFGhvxoB24YgNj1IY/bH5cGZNNZvpSjgY0
 0ljqUPO0nI8SUY9/DwG0v01U2PHu5Kgqe+XmBWzeMjGFzhwqZdJFT6sv2er5IAxCQ2Jck6tdNAg
 R/g3/1LW6/CWNhMxtTMdTi5K+usooXzNXru1OG0bWMd1whjnETFJ7CXovaHQPzQQOvDHD8lYWiz
 JTV/p2B11smEWF2HLXRV5T3zZkABo3UOtZfhHFy59+cvSGzmfhSEX4QQYkRle6wErewNv03MHX3
 SqDrpdVlM/Z8uwDL1fnarL8gHp8T2t3WLpdncolIdJCmhp0cfz7RHR4emHfWFg5hLXspmnJ+FHY
 dU92a3MVR5hImS4auQLcekbVildQlrppvffD4hSJKwRRxiQnZ3OapglSSnFUOIxLMzPytp7oFfx
 8l2/0jvLzTvthpkyg12JITpj4u2bnXH8J9tXEpuac9yt2X6S386E0E=
X-Google-Smtp-Source: AGHT+IEX/8n453BvSoM2dOxIJNkCF1PSl6m0kDo3jYRdIS1S+8mx9kztefemLxiIQNR6NHijPzYMqg==
X-Received: by 2002:a17:907:7ea6:b0:b3e:3c1c:d2f2 with SMTP id
 a640c23a62f3a-b6474940fc1mr2100636366b.36.1761038623128; 
 Tue, 21 Oct 2025 02:23:43 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24da:f700:36af:90f4:d5fb:1eff?
 (20014C4E24DAF70036AF90F4D5FB1EFF.dsl.pool.telekom.hu.
 [2001:4c4e:24da:f700:36af:90f4:d5fb:1eff])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb525d1asm1025062366b.58.2025.10.21.02.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:23:42 -0700 (PDT)
Message-ID: <44ecb43a-5f6e-440e-9e16-f56ca697eed4@gmail.com>
Date: Tue, 21 Oct 2025 11:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <20251020194631.102260-2-siqueira@igalia.com>
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



On 10/20/25 21:38, Rodrigo Siqueira wrote:
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 5ec5c3ff22bb..29de8dbe2917 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>    * @ring: amdgpu_ring structure holding ring information
>    * @ndw: number of dwords to allocate in the ring buffer
>    *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> + * inspecting the code, you may encounter places where this function is invoked
> + * like this: amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer
> + * numbers. The idea of using each integer addition instead of the final result
> + * is to explicitly indicate each block of operation that will be inserted into
> + * the ring.

To clarify this further, I recommend using the term "packet" instead of 
"block of operation".

> + *
> + * Returns:
> + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> + * maximum dword allowed for one submission.
>    */
>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>   {
> @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
>   		ring->funcs->begin_use(ring);
>   }
>   
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>    *
>    * @ring: amdgpu_ring structure holding ring information
>    * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 87b962df5460..e83589619a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>   #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>   
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

