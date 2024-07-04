Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290BC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 09:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C5610EA4B;
	Thu,  4 Jul 2024 09:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JsTDt66I";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B048D10EA4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 09:00:01 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-424ad289949so2530545e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jul 2024 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720083600; x=1720688400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r9lUHqq0boetgC3qEBrzRNpckwwW8BY5Wr9Q9u2mz8Y=;
 b=JsTDt66IJoJP723lbR7YLcdM1e+pgEr3o6MXz/eetLX5WGVAfe9tM4tGuSHJBNLBxC
 MsVJdlP1bTARE6/CYOwxmCv7q2Rpo85boUeGCwJBDRjA20rESRh4DDGwvFDRWyhzGQk3
 7mSSngNujZyLLbZQEpfDVfZHNAZwE6vH7p4o8BnT9l/rxIlnp5vCluM62TJ7159LETAm
 UiQSamycrwZn9bigxDq5X1H/uBpThO93J/aEmicycf1Xd9cJb4kEfBEgV/V+T7oFKKSd
 pcdq+zzpzxorMvmQBRz1SG9PKK34zzjx4MZEo7S6ZvVwZYwdkh1g212Xj4KdnyL2KVGL
 LuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720083600; x=1720688400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r9lUHqq0boetgC3qEBrzRNpckwwW8BY5Wr9Q9u2mz8Y=;
 b=DwLmjm1gXAHStVsJXDyEb+MwDkz1H18FI/iG4mCsNGu7/jfI5Or8gLJXyB43tK6Krk
 AjxJbG7qz4lnkR1kqgT1rjfiF2VSdE7z41dmMdRjBV1WQ2wAHkAaIaZklfWM7FwcJ9P4
 eyT/XhBCALn/ECmgvu8UowR7tDDACaaXlcU1e6/TpowsYOkPbMBO8YPpBbm3Lh11QiKm
 An1pxoFNOy9ciF+dZoqfcJotAVJvpz1YWayRd3cZH/Wkzgomp0AMWoFSR2y9zzUHkorO
 m+PBD71izRK3/hyv57ggeEXtyV8EhnSI00WJePZ7A6bid/Uh0ZlCbqyeQbn5a7NFMKoW
 WUYA==
X-Gm-Message-State: AOJu0YwOT6gKNegmv+ZtNqyk93ZFT8ywpj7bi0COEUEV85WvbGy6kD2U
 VwjI1up8Ps5iUe2kc+xe4T9rMfyp1ooGDVCopInqDJDp9u9QzC8f
X-Google-Smtp-Source: AGHT+IFMWhzR6U1whC6eII9m+Bhws53WgXbOI/+CYeHSDQSAaiEd9svSFA1ZCnTvlHTrF2z22y+GzA==
X-Received: by 2002:a05:600c:6a99:b0:425:68a3:f6e0 with SMTP id
 5b1f17b1804b1-4264a3d692cmr7601245e9.9.1720083599570; 
 Thu, 04 Jul 2024 01:59:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fca8bsm15285935e9.47.2024.07.04.01.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 01:59:59 -0700 (PDT)
Message-ID: <34338c4d-f273-421f-b3e1-912866980140@gmail.com>
Date: Thu, 4 Jul 2024 10:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm:amdgpu: enable IH ring1 for IH v7.0
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240703174908.2610353-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240703174908.2610353-1-sunil.khatri@amd.com>
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

Am 03.07.24 um 19:49 schrieb Sunil Khatri:
> We need IH ring1 for handling the pagefault
> interrupts which over flow in default
> ring for specific usecases.
>
> Enable ring1 allows software to redirect
> high interrupts to ring1 from default IH
> ring.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index aa6235dd4f2b..548b3c63a765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -546,8 +546,15 @@ static int ih_v7_0_sw_init(void *handle)
>   	adev->irq.ih.use_doorbell = true;
>   	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
>   
> -	adev->irq.ih1.ring_size = 0;
> -	adev->irq.ih2.ring_size = 0;
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
> +					use_bus_addr);
> +		if (r)
> +			return r;
> +
> +		adev->irq.ih1.use_doorbell = true;
> +		adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> +	}
>   
>   	/* initialize ih control register offset */
>   	ih_v7_0_init_register_offset(adev);

