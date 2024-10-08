Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12432CEFC38
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 18:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF72E10E1BA;
	Tue,  8 Oct 2024 18:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTSBaDHS";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D74610E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 18:10:49 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-430576ff251so4625155e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728411047; x=1729015847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhtjBSM4BT5rCKLB0E5HLOaJi8vMA5XArxpkYb13T4g=;
 b=hTSBaDHSAR08ADmaVnBM6dYure6DxMQaEN0W+iyRdEGXlNDkJwcx5YfyrhzWwVA408
 jw2YnA8iT6c2yL+/7CuifylHpgt4xS9fmuKREH0mexk9PCatmrw3sathgJT3CngS+INi
 pdfB3VI/2zPT9LSK7eRd3net0Pf5R4KFqRCQMLkyDGJolr0IFFG+8ndFj33IMon12i8n
 1m6oVU043Cg3K4mSl3Znf9LbG5PxDRJlSGtNcXS0HRpQR/DHkZPjXRZGJ9hflsQZrT15
 InN/Dk6HQEaVux0ZKu6zhBg7FEyPtVU1CwVBWzEvGxVxaqfM3VzRaF/9qNeT3B2Wn3T2
 3aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728411047; x=1729015847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhtjBSM4BT5rCKLB0E5HLOaJi8vMA5XArxpkYb13T4g=;
 b=J3u4NAH9zWM/pema1GV2jU0ycWPSqGfMKuynAQ7HDWXFxKt1tDNxqNhNF8s0OnS6AM
 ujvbNUD14sHsbHFR/qSB3gKPu5PnQ24+e+H1m42dZxgLMAlq8VXodvoVDKLWFYU2OBeF
 luxx+ZGZc/m6WJwqu3b3WPCUB2yeSEZmSJvFG7+UbNY3yGToOkJahYkZwQjT7y+XxHhq
 cJ5+mc4D1sNn9g4KkPx6AceLufE/TwJynheJLrlqf2Bt0ALREymlDCY6fMfo6X5zvyi3
 sbdkTJCZIwcD4EsrBwY+PClbRUrAoFDLyOwudQWuHQQUYgeb93+H+G6v0RCBN1TdRl8O
 +TDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzO2OO4nULUyt0kCDhNlxpedkkMGNMHm72x2Un0fUpAkM5H+JPuOKwXHpu2BVu8pNIl8KEZsPY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8DKIXpBhh+pk0ZbAN727BM9/vtBgml0Y0cB7X1H9qftF5qQzt
 0EVJz5TKkCDVtvLYxtoi5019JUh9hbbqh5wWKej3xGFcH/1o1X/J
X-Google-Smtp-Source: AGHT+IEaHRN2bjjPtGVmgSTcIOBrXryhrUK4/4DuA46/HLvjaQ8BBUYfWCSjqbesU99/uBXlvVzTtQ==
X-Received: by 2002:adf:ecca:0:b0:374:c56e:1d4d with SMTP id
 ffacd0b85a97d-37d0e8f7539mr9188188f8f.54.1728411047192; 
 Tue, 08 Oct 2024 11:10:47 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89bfb494sm116704265e9.21.2024.10.08.11.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 11:10:46 -0700 (PDT)
Message-ID: <d363fa0b-a22b-4fad-9027-ed6f831b92dc@gmail.com>
Date: Tue, 8 Oct 2024 20:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Ring padding CPU optimisation and some RFC bits
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241008150532.23661-1-tursulin@igalia.com>
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
> I've noticed the hardware ring padding optimisations have landed so I decided
> to respin the CPU side optimisations.
>
> First two patches are simply adding ring fill helpers which deal with reducing
> the CPU cost of emitting hundreds of nops from the for-amdgpu_ring_write loops.
>
> If receptive for the idea, please double-check I preserved endianess behaviour
> as is.

I'm pretty sure that this was broken before or at least uses HW features 
which are not guaranteed to work any more.

Sunil has already commited a set which does mostly the same as this 
here. The only thing missing is the improvements for the IB patching and 
a bunch of things I've been working on recently.

Going to send those out in a Minute, would be cool if you could run a 
few performance analysis on those patches as well since you already seem 
to have the setup for that.

Thanks,
Christian.

>
> Last two patches are new and RFC. Both are incomplete conversion to two new
> helpers intended to deal with an often repeated pattern of:
>
> -               amdgpu_ring_write(ring, lower_32_bits(addr));
> -               amdgpu_ring_write(ring, upper_32_bits(addr));
> +               amdgpu_ring_write_addr(ring, addr);
>
> Last patch is the most uncertain one where there seems to be some magic bit
> used only on big endian. It has no name so I couldn't figure out what it was
> about.
>
> -       amdgpu_ring_write(ring,
> -#ifdef __BIG_ENDIAN
> -                               (2 << 0) |
> -#endif
> -                               lower_32_bits(ib->gpu_addr));
> -       amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> +       amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
>
> Anyway, both patterns have a lot of users so reductions in source code and
> binary size aside, main question is do these kind of helpers improve readability
> or are making it worse.
>
> (Note that the _xbe name in the last patch is just a placeholder.)
>
> Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
>
> Tvrtko Ursulin (4):
>    drm/amdgpu: More efficient ring padding
>    drm/amdgpu: More more efficient ring padding
>    drm/amdgpu: Add and use amdgpu_ring_write_addr() helper
>    drm/amdgpu: Document the magic big endian bit
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  19 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 101 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  25 +++---
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  27 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  66 +++++----------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  60 +++++---------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  45 ++++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  63 +++++---------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  48 ++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |   8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  16 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |   9 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |   8 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |   7 +-
>   28 files changed, 319 insertions(+), 345 deletions(-)
>

