Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EFCEFC20
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AD710E575;
	Tue,  8 Oct 2024 15:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hv6vGcdz";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2258310E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:10:56 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so59630255e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728400254; x=1729005054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rheDy/a6YUMg/F57v6c06GSvH2BCehQCODs/bPE7JuE=;
 b=Hv6vGcdzrf3X2eMi+ouPCPdQWwfWR7/VAXEqxPV1EsKW4wT7uhez26qP861r9zbeo9
 d6YTSs3rxCmfGk1L8zskUc2GWhY5GyoCVCY4RFLRkJVGCRKi3L1XJCQi1mGwpEtUBlUp
 +RciVBEoGfX2B/8nypWg3mbNk/bmD3o5jvJL1fs7EDv+Xc+O7HaXgWDUo2X9Eh9bWHCG
 lACHfC7Q1fFpM10q1wWGA9keTd+308v23Bfq/PTmYiQoqkja+H9VTjeuQjN/rEWNaf3G
 E5mA0Q0B7FqZyvtENGliwuxXIZEA0iELLwnwXTR5rTuPq+87d9Re1K9QpQjmi5V4FcYO
 Mufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728400254; x=1729005054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rheDy/a6YUMg/F57v6c06GSvH2BCehQCODs/bPE7JuE=;
 b=Ye5pHFf8dkbf3DgR/Qyio3mbEmqWxEPQGzTPlJzwSyt0Az8uovlScrQzCvDFHRukpL
 7FIR+SfkDnOqSKKs4IY5xXWDccfvfjKNt7y7ykmEm2+WQW3TpqGq5IZ+/wl7hNB35NUe
 28rcWICWhXVkMCIbBxikpSEXfUzx5To2XL2GHcOTX9reCFdtdaDsO5Mzww8So5F65EY4
 zpUdH04MjP0Qx/UrSif0fWDRyvKYc1vc8CfEsdsp4cRUxyEmX+6bLn2sNh3S8VWM3Bbd
 m5pFZfsiUvnLMoUAmLIIMvUE3mz6gvDuDo3QgB0mhPvGHLnpc9MwADiM5atR8BFbrJXi
 Ei7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmfBYi6iZqv39VJnxEPQK4SMN7A6fpSPZn6UjIL7joWPs0jYjipnD02UaCZqvYnh1G0a+2ArB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz84i+Tcml0c78m5mi+LUcSIOE+1AK/3wKAbIIfnfji262tZpDL
 co9Iph6rJJC17GiZXqfIa18ZAtAcfSbfWufq0wPWzSGeO+pIsJ/D
X-Google-Smtp-Source: AGHT+IEJCBimO0L75qAxpHlr7jxM345P1FGobOJnXcypXsYTm2UXaMYeEir5zGcQ1pmH5FKRcmqB9Q==
X-Received: by 2002:a05:600c:35c9:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-42f85ae8efbmr130872175e9.22.1728400253989; 
 Tue, 08 Oct 2024 08:10:53 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43057b4008fsm3397225e9.13.2024.10.08.08.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 08:10:53 -0700 (PDT)
Message-ID: <02141366-ce3a-4b9b-9185-1cf1bcdc23d1@gmail.com>
Date: Tue, 8 Oct 2024 17:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] drm/amdgpu: Document the magic big endian bit
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
 <20241008150532.23661-5-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241008150532.23661-5-tursulin@igalia.com>
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

Am 08.10.24 um 17:05 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Similar to the previous patch but with the addition of a magic bit1 set on
> big endian platforms. No idea what it is but maybe adding a helper and
> giving both it and the magic bit a proper name would be worth it.

As far as I know that bit is deprecated and not guaranteed to work any 
more in the CP engine.

I think we should just completely drop trying to use the bigendian 
support like that.

Regards,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 ++------------
>   2 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index aeab6fe21db6..68f3799f173c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -503,6 +503,19 @@ static inline void amdgpu_ring_write_addr(struct amdgpu_ring *ring, u64 addr)
>   	amdgpu_ring_write64(ring, v);
>   }
>   
> +static inline void
> +amdgpu_ring_write_addr_xbe(struct amdgpu_ring *ring, u64 addr)
> +{
> +	u64 v;
> +
> +#ifdef __BIG_ENDIAN
> +	v = (u64)lower_32_bits(addr) << 32 | upper_32_bits(addr) | (2 << 0); /* Magic bit name? */
> +#else
> +	v = addr;
> +#endif
> +	amdgpu_ring_write64(ring, v);
> +}
> +
>   /**
>    * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
>    * @ring: amdgpu_ring structure
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 24fb58543041..de1909c1de49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8549,12 +8549,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	amdgpu_ring_write(ring, header);
>   	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> -	amdgpu_ring_write(ring,
> -#ifdef __BIG_ENDIAN
> -		(2 << 0) |
> -#endif
> -		lower_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> +	amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
>   	amdgpu_ring_write(ring, control);
>   }
>   
> @@ -8584,12 +8579,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>   	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> -	amdgpu_ring_write(ring,
> -#ifdef __BIG_ENDIAN
> -				(2 << 0) |
> -#endif
> -				lower_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> +	amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
>   	amdgpu_ring_write(ring, control);
>   }
>   

