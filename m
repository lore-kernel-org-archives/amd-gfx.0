Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE625C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 07:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F6A10E6CA;
	Wed,  2 Apr 2025 07:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtiPVhgR";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635DF10E6CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 07:37:08 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4394a823036so59326665e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743579423; x=1744184223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lwfhrhIi+RSBUdz9M99Znt3puoWyJqrqnpkkc8L0NH0=;
 b=PtiPVhgRkMHahaBQ0/E2F89XeilsqG0CKUO+tUrf1rEWF9E1dS5iZmmIf2a6ai8A5x
 FD9DJgFbLYGWslWJKEFo+C8QKvTTgdu2a6ArIllKqv+9JMyiD13pwJ3/iLMshzICEbKv
 14YLEI3E5hrhRPpDGxwnANpYrjFV8Md9qLkw+yVXjf3cOYtFmgUQsF9Eep653Pk07ve3
 daNs8aTEf6h1jbaRUA5Y3cRR9SF+YSRLRP9yax14FNZVyJNVDvksSWqlzd9OzH15if4v
 mxdHDfxSl68kDpfN3oDCvwZzZco/XyZ2Wsa3USLhpMAV4kp39czGd9/FkqA4E5DNuSdd
 p11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743579423; x=1744184223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lwfhrhIi+RSBUdz9M99Znt3puoWyJqrqnpkkc8L0NH0=;
 b=vmJTlhaTxsKUE4w/eojFZJmQOKeNkdU2RCTq9/v6tZjYYDKb4C02itH4CaQ3vBV2JM
 uyGmn4MisFPz9znN4ZWu/5Oqao9Wft4O2mixY4XN5oi5Gcwgg8jhDsjSFOh6ljxXJNxl
 IHV/Q/oWDcBUIC52crZeBWng0egK+6BjyD9ILLNsCr2Q1iQfjDYEO6WdizU69vPuDkbN
 cVSOccSE9Jl7faWIgz4ELp+HwNZdp2lYrkRdC1dOhJ1p5VmMtsOI5iiVx6X/tfZPWGSV
 0GsVauDn0G5dcJ6nArhYPeBk4JjA95dBPt7CSsvcdQJKy3u+XpiZuHlq5vDocj9poS8/
 KqGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfypYDWt92f8W3doL1pBcxdDeaFieBwqHF207oam8c7ZtENbv8ohGKbzK3ortbOWN4TO18DW1D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZocg2kk6m0oVT/QTGM5ulOuEuquZzm3z2uXF7zmYxRjwWRy9N
 dVGuH0T2qYqH5dllv8nid9oJrn/gfU8m3N0g4n4KRv1snPGd3tVO
X-Gm-Gg: ASbGncs459KWkd4OJF5PzziA4NUWETdQPwL/d4DENpDpAdr8B9fDx3jxp+PWJZ541Cu
 u1B3VZNY02YqJbdj7MZZZJTy6nXzr6FOUhxtJzvFXdAreZY1y1TSqQNqZoiXQECGeQG7GfLFKtP
 42c77D0lpu+1I/I15hu9LT2n+mmk7BlAeGaAdTRE0p+xW+ztNGePEO3g9zgiNIXhxemeECuX/z0
 kBzGZU3u+obMOAaydL8izGIqoPMp7h/98UmrkOBF3gDMpkXq6aONVi+0CcVjKT9RFkA98nzjCdY
 Aesv/qjpxCPovjo4pV6ptIiWMe8HZdcjAmMwda4cQkDtBYeH2Fin3iwWz47HQOAvF7Gh2q7iJQ=
 =
X-Google-Smtp-Source: AGHT+IHmF3Ino2XnzOiQqI9EOl5pbKjWeFhx+y+MIW5/uiOVty0zCZaf89Rs55UdP9UeoHeshVCB8Q==
X-Received: by 2002:a05:600c:4f03:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43eb5c2bee4mr11363705e9.18.1743579423117; 
 Wed, 02 Apr 2025 00:37:03 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16049sm29833135e9.0.2025.04.02.00.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 00:37:02 -0700 (PDT)
Message-ID: <be35f643-0006-4a12-be34-2b0f02cb3a5f@gmail.com>
Date: Wed, 2 Apr 2025 09:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20250331154456.1879064-1-jay.cornwall@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250331154456.1879064-1-jay.cornwall@amd.com>
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



Am 31.03.25 um 17:44 schrieb Jay Cornwall:
> KIQ invalidate_tlbs request has been seen to marginally exceed the
> configured 100 ms timeout on systems under load.
>
> All other KIQ requests in the driver use a 10 second timeout. Use a
> similar timeout implementation on the invalidate_tlbs path.
>
> v2: Poll once before msleep
> v3: Fix return value
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 ++++++++++++++-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ffca74a476da..3cdb5f8325aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -356,7 +356,6 @@ enum amdgpu_kiq_irq {
>  	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
>  	AMDGPU_CP_KIQ_IRQ_LAST
>  };
> -#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
>  #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>  #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>  #define MAX_KIQ_REG_TRY 1000

Unrelated to this patch here, but defines like those *must* have an AMDGPU_ prefix.

Please fix in a follow up patch.

Regards,
Christian.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 464625282872..ecb74ccf1d90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  				   uint32_t flush_type, bool all_hub,
>  				   uint32_t inst)
>  {
> -	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> -		adev->usec_timeout;
>  	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>  	unsigned int ndw;
> -	int r;
> +	int r, cnt = 0;
>  	uint32_t seq;
>  
>  	/*
> @@ -761,10 +759,21 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  
>  		amdgpu_ring_commit(ring);
>  		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
> +
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +		might_sleep();
> +		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +		       !amdgpu_reset_pending(adev->reset_domain)) {
> +			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +		}
> +
> +		if (cnt > MAX_KIQ_REG_TRY) {
>  			dev_err(adev->dev, "timeout waiting for kiq fence\n");
>  			r = -ETIME;
> -		}
> +		} else
> +			r = 0;
>  	}
>  
>  error_unlock_reset:

