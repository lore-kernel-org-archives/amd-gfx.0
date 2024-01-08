Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF0C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083BE10E17D;
	Mon,  8 Jan 2024 08:17:37 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180F910E17D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:17:35 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5bso8246715e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jan 2024 00:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704701853; x=1705306653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2rXXnyss9tXEJ31eEX5k/K6YgdEGYW2cDRNp3mQ1Gjo=;
 b=QlxjemKoUtgDjYKZIJfIsoIH9DkBKA8eNf4HNNNU1VKmZlcD/B9rEVnBz9Pkj5OoTB
 xYnsDD0bB/TV2JlYXhPoxbWdAh2FYCXWmDO1e+DI8XmA1Ez8FWb/xOryR0mXQyPiEqJt
 CYnUuu5iWeEBZxknwAbv8AqdEzMh/n72UkTTHsRiWPPczy4G8MULZYn0vmRps0y81WOa
 1oICvDsjE9t9CeqOdSG6X2b8skedHTFOEx82kDmkbwugvonHBBfDuUPifwl/l8iYIjPj
 2iGIyhySnlcHwADa01sSAX78VDaNSSiC4QR183GWGcpL4k8fPgBmZKP80Gcv7jtCLYkA
 nV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704701853; x=1705306653;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2rXXnyss9tXEJ31eEX5k/K6YgdEGYW2cDRNp3mQ1Gjo=;
 b=DazMLm1wrRUPQul8wafHD395E+/AxXfHQ8CejJ05kppmNJG+J58jtqVJ5V1cmYa/B/
 7OW93pMIMUc7TEkh+ux3GiBAIeqgt90rB4eEexdmvL8+vBVoeAgitvnHlYqsQpO3HNHv
 1is+lyPgwZQhiLcLOl5M4SDLE7V6tKwaAs6/H0bvJ3L8f3BBIhNUdfRfKPFKLzPNMP0r
 X5HMi8KCPYt6K7npiYM2JR6ad/W9PFuieZ4sMx+OH5UZMJ2T/YzbGBvl1mnvmR66ggvB
 nSDOF2+heNARKtY/Qf2DQ0rdKHpBloSeHNGHWaAI4tIB2jMwrUWFvYQEhsgnq60X6g7J
 /e9Q==
X-Gm-Message-State: AOJu0Yx/371/ajFm5nY2loEM59eOOwIJ0g4plsL1MdQdNQ/hJpXlRqmE
 buSMMHX7m7vQ48mc52GmVu0J6Vsq3H4=
X-Google-Smtp-Source: AGHT+IGGbSwkb+fKyY2LHKctTRi4kmffyzEWtK7+U5FtU9bUMcNbo55xTIq9xNOBCM445rcv1LAtwA==
X-Received: by 2002:a05:600c:3583:b0:40e:47d2:8b01 with SMTP id
 p3-20020a05600c358300b0040e47d28b01mr349508wmq.162.1704701853475; 
 Mon, 08 Jan 2024 00:17:33 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 je4-20020a05600c1f8400b0040e38b7cfdasm10136347wmb.4.2024.01.08.00.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:17:33 -0800 (PST)
Message-ID: <8677656a-50c9-4372-9776-07fc5d5da58a@gmail.com>
Date: Mon, 8 Jan 2024 09:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc9: re-enable AGP
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240103215536.1780386-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240103215536.1780386-1-alexander.deucher@amd.com>
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

Am 03.01.24 um 22:55 schrieb Alex Deucher:
> It should be fixed with
> commit ca0b006939f9 ("drm/amdgpu: fix AGP addressing when GART is not at 0")
> so re-enable it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 9bff72356a37..de961bedad3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1632,7 +1632,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>   	} else {
>   		amdgpu_gmc_vram_location(adev, mc, base);
>   		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
> -		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
> +		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
>   			amdgpu_gmc_agp_location(adev, mc);
>   	}
>   	/* base offset of vram pages */

