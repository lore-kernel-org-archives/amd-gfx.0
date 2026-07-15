Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EEDC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4142810E15C;
	Wed, 15 Jul 2026 09:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="LupqXz8U";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEAAC10E15C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:18:21 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so8072474a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784107100; x=1784711900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wkrHy2eei6iDbTadBOAtASLNoGyQkIkD1j4SUch0CKg=;
 b=LupqXz8UWSdv187knhaBcT3GARRJZWkyirtoKVAyM54fncWTF2JSIqBWqqQnQ43hbr
 Rx+Mc09YW+FQtunQMHROfSnsfYVIKKQv7ZV7uoFYZWw9riDpWIwXkLH7xrrsLORNP0S0
 heJO2vb7TChTk14qH4wZWZnSC4frNS9rRobO9KmObY5GF2jL7ukNmYQVaw2u29bMRMC8
 1J6ywaC3LJGBsOiCjOFfOI8orelDjTQk1zlPyO9VMz7VK9I8UIoy4UQHua+zppFQNBnl
 VmzsQLTTvGcGgC2upiOIDfEdzsB45Cazk8rVCe79SEJUuTGLcL3qB7Wsh+lFb9K2CDOU
 inOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784107100; x=1784711900;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wkrHy2eei6iDbTadBOAtASLNoGyQkIkD1j4SUch0CKg=;
 b=p1O39Js4cSBuwrZA5vlM7EWgR4d2bOZL2clKFA9FV0RqGNU6nx3Fnf6beck4uxLqCe
 Zj6orV/VOlSyrxsO+k4eD+inM07OL1kTB1eC0mVkiR0sudUoNEBRMSyfvOrfL+Cmkc6U
 Yr0UJfY50OIo88yNq0HjPbis+GH0R5kyFzjA80l0PBKVmoPcbTvNzk8ee42n2KuRUC2E
 rjhBH8Jy7E/2kMwP7AQaxbRcjQmYqZSaqZXV6eLDd28LlVE/1vql6K+Qd8c9a2RKBB4/
 YToFdl/NeMEcEKlaU+wwjGsLEnqZY44Bu/sBNlL/5sRBzQ4L+8/5VcCCdlzwnKyd3aj3
 yqww==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQFp6BtyIIi//5O3Ds9mZxdHu7f4EYXyaHvUqniaDv6h/Z78flLmwnOUBTmD1/olIeN9G7LF0t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsFJzV4phonCoHWfYrf4TdnEyrS1sFhA54WrekCrbEfDLOh4hk
 /yxrKoy8WRcNrxKHNrv2xQsNNa2wxPSEmyFCfU3/XBEWcwCaHqweWZFiYS5WK0HxXd0=
X-Gm-Gg: AfdE7cnWotH6ZPGHxYeKYRmXQOtrytt/FF/BVZa+wNfFDJS8ccD9OWKZkA3+Yr95P6+
 jbQqlxWo9YrwytgXd6E3cO8RbpaDAxNrfrdpi3ZV2uycfZgeIkbjoED8Oq3Ga9c5baQW6zVvHZv
 tuJBx4kOUCeXsHK5or62RXIabqoDUcG+BR+A09JSqVkg7vspK/4oFhgcnAuth60BvO/2IiNQ93M
 f7V7PjqdzkYAnov6PWRhHZ1XLcnPJ8Xp3Rs7k50FXPOqRuiRRZmXPz2GsqBfaMCvXOBzwjyE2mm
 rZ6X9dxTxXBsvtHyPaV7Zxk6oBDHtJhbuysF2ZpWfjf6yqKAcKZoczmDMekwGlLIpewO1fd78XF
 kBshGePdlbBbv0Lc0d3cVU4Hb4TEY485jno/QAss1fO1ibhRUEpSj9lACHUUtSOcp1KHNOVN6vE
 SNheVkHTngOMq0uRhmDrq6/7+StN21LfyswA==
X-Received: by 2002:a17:906:2091:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c1684dc968cmr6836866b.19.1784107099969; 
 Wed, 15 Jul 2026 02:18:19 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15fc29937esm807972866b.22.2026.07.15.02.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 02:18:19 -0700 (PDT)
Message-ID: <d6e5a13d-bb65-4633-8c0e-8b89f292bc3f@ursulin.net>
Date: Wed, 15 Jul 2026 10:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu/gfx7: Clean up gfx ring during reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-7-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-7-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> Clear the WPTR and RPTR at ring initialization.
> Additionally clear the ring contents during reset.

Please add the why part to your commit messages. ;)

Cover letter mentions the series is reworking to match gfx7 to gfx8 but 
I looked in drm-tip and amd-staging-drm-next and 
gfx_v8_0_cp_gfx_resume() does not yet have these changes.

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index a93cc02c3400..915612628f9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2546,8 +2546,14 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
>   	WREG32(mmSCRATCH_ADDR, 0);
>   
>   	/* ring 0 - compute and gfx */
> -	/* Set ring buffer size */
>   	ring = &adev->gfx.gfx_ring[0];
> +	atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> +	atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);

One day we need to fix this whole atomic64 situation.

Regards,

Tvrtko

> +
> +	if (amdgpu_in_reset(adev))
> +		amdgpu_ring_clear_ring(ring);
> +
> +	/* Set ring buffer size */
>   	rb_bufsz = order_base_2(ring->ring_size / 8);
>   	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
>   #ifdef __BIG_ENDIAN
> @@ -2559,6 +2565,7 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
>   	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
>   	ring->wptr = 0;
>   	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
> +	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
>   
>   	/* set the wb address whether it's enabled or not */
>   	rptr_addr = ring->rptr_gpu_addr;

