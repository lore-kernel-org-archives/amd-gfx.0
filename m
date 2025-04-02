Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2138C36014
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 07:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A665710E6C9;
	Wed,  2 Apr 2025 07:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/CgUf8T";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A89B10E6C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 07:29:28 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-399749152b4so2973848f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743578967; x=1744183767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Yhv0hrddqjhs6y0Ap8mljmOVw8NccDkr71/RKNDxQ4=;
 b=I/CgUf8T7Sbq8QWiRCbEt84JmWjk0wYh9+qTGqKQD2ypz7X9yqXyoq9rnS2Pv3LCWq
 io9X1M7gnMLm1SEVSKkHvLQT9u25Q7M29yuEHoga5FbU5HoE+ZlslDCDukUt0dSr4k9j
 O804yi6tq4UY1HKbloNsr+C3xLi8Pw3I5RefybsYQnMF0L9RUJ4sH6g6tsqEf/LARaC4
 UcEYE2+e5+7BNdzv7ynjyZmlaIvIuFeq7PnuCS3eDPlny6cfqgyk6/bbE4a6g55DC/JA
 Awrt5aiRZVOKcCVSLottt9LPNtVigCHXGguHKAm5ks0E585Nh/BN1C1ajAXljPddBiee
 W8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743578967; x=1744183767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Yhv0hrddqjhs6y0Ap8mljmOVw8NccDkr71/RKNDxQ4=;
 b=o3GTWpKEgyBRsTS9x0r3aQXRQ7yGS36I4toAKvdffAnK7lMdd15ZSZZuSQ8uCy4tkv
 Imsl+zDQ+qffD3KyLl6ZMgyrHEKOV40YJ+vFCtVVRB/B44KJwrgfuilcr7mdf7WGR2VV
 u6SU1t+i/OR3GgMlIr4C+LazbgfDbWKEKueJp2ywSR21zNa2VLqOmFq8SY1O+YJmKpHm
 Pi3BVqWO2uzwDFi2oh/7YlLIsakeujEtuLi9T6CKSAjIBFk/UeccpgunwgFzmsSStUyf
 r/WOTXHmqmoFAzYZzEoo7uZ/wb/kBHP9u8ZIZdUyKidYP3HaMhVMucKSPG3MkI/K1fMQ
 5OtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsh/JgKhPDjNHNxZpBWYkuWdSSVYan2j0tpAevwxw6SKjJv8lSXbCbRFLiT17WIQlzdymiJBFj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSDK6Usw2zYzRkyvqJCuHTS9YOxbVkK3wJf5aYuQSojF0CHpNh
 lNmjxnAfm7Ek6rvand7XGqexPrJn9/sDAtLjl2yJLHmcjSQ0fRr7Oj5bwQ==
X-Gm-Gg: ASbGnctW4pdJmdADtxTmHjV8NZzce/riG2Vj3WHDsXVZ4DLYdgSSFrWz7grpt4ReKto
 cE4k2lB3VbtPfYEeI/xeZ+NTQuBqQrpdF8/vs44aWLsYG+P2wzy3gE4kBlH0Fzgj9jXiwhT5ld1
 U6zU+rUSt1xkDQL9ZQNFws0qRT8SiG6j1ARMiCxT5X3sgITDd5V1F2zuUm0PSfZk3QoJ8g+Lpa2
 eeWmJym91tLuBhylSCyRgUcwy0V+gH+3fo+bnpvmcNVA15TzPv+/8N57idvU3W1BFFQdcp8iZoV
 Qa/T0zcb9weDdkMY+eiPzgtM2uzUKNj4XtsB26TJ8AMI6ujVnSiCBN2etxJ+3T0Ucyihl+rleIk
 CcxD40c1K
X-Google-Smtp-Source: AGHT+IGzBGqJDR6cy6U+xzLdeGTKKpnPUqkYUkfLJhI2dxvs0+boQrKPF1/6D9JrBzxv7FB53drN8w==
X-Received: by 2002:a5d:47cb:0:b0:391:300f:749e with SMTP id
 ffacd0b85a97d-39c23646f8dmr5416598f8f.11.1743578966412; 
 Wed, 02 Apr 2025 00:29:26 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0a3sm16321083f8f.71.2025.04.02.00.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 00:29:25 -0700 (PDT)
Message-ID: <1760a5dd-95c3-4e47-9745-de27e05ce375@gmail.com>
Date: Wed, 2 Apr 2025 09:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix
 KFDMemoryTest.PtraceAccessInvisibleVram fail on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240812065929.1842802-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240812065929.1842802-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 12.08.24 um 08:59 schrieb Samuel Zhang:
> Ptrace access VRAM bo will first try sdma access in
> amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
> access.
>
> Since ptrace only access 8 bytes at a time and
> amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
> it returns fail.
> On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
> is blocked for security reasons.
>
> The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
> that len in (0, PAGE_SIZE] are allowed. This will not only fix the ptrace
> test case on SRIOV, but also improve the access performance when the
> access length is < PAGE_SIZE.
> len > PAGE_SIZE case support is not needed as larger size will be break
> into chunks of PAGE_SIZE len max in mem_rw().
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5daa05e23ddf..a6e90eada367 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	unsigned int num_dw;
>  	int r, idx;
>  
> -	if (len != PAGE_SIZE)
> +	if (len > PAGE_SIZE)
>  		return -EINVAL;

We intentionally avoided that since the MM approach is usually preferable as long as you don't transmit large amounts of data.

You could only add a check here for SRIOV.

Regards,
Christian.

>  
>  	if (!adev->mman.sdma_access_ptr)
> @@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  		swap(src_addr, dst_addr);
>  
>  	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -				PAGE_SIZE, 0);
> +				len, 0);
>  
>  	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>  	WARN_ON(job->ibs[0].length_dw > num_dw);

