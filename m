Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70838C369A1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E4810E092;
	Wed,  9 Apr 2025 13:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UAJQ0+cG";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C39A10E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:32:37 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso4124185f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744205556; x=1744810356; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P9dRVfcCBqMVo2qvHu8UcreMhW+Fp7Erpk48JR0y2ak=;
 b=UAJQ0+cGVNBHrLY9rnVHL/hmoAmWK+t/KeKHwKUDDn6gNO6ltaCsr+GYOIlfPnIGU1
 RpiIXJtyAOlHKZX5nAiqE2+wpiS+7edWRPDyOBcfK3tgOuE1zW7k7kgBRpPX4Q80vww5
 Plnnzy+xPwqAk/wxqEq+omSG55/6kXfG7Py0Ad5HZrtd7RqdEHzzMixzIWd9ijdtffYZ
 7L4Y4+kNj9jCo48SlccVXgLlRLVgxfJJBKpAG78+Rw0fNVNqqoclTSlMozvM4zKJAYU3
 BeSDfcoMhmcAIEcA57kPq+mg6+QCtcH7hrhJJif8r9xh+t+0nySWsG0APnSuPNddjkIo
 VxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744205556; x=1744810356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9dRVfcCBqMVo2qvHu8UcreMhW+Fp7Erpk48JR0y2ak=;
 b=UeIpLp7iJ97m5P3cyhKa+M4BuHuT2OXaHFtsK40y0J3CxvIw6CB4NzG6VO7bBgDMgf
 2HmoX1Ip1S98I+DJJjgt2RnSBIutFthKTLbdcYmkgVSKeSVJPUgOEE2mlX0z0ubd1lhE
 xiUt0ZpabLkifPempy72NuGbBUOWgD2yLACBVz1SLCneN19LKPN68yuEBeW1hUjZ6/Gn
 /hyksxSbq5mfDbkhHdTw65mASAtImnehUfYM5p1znEzHWSJKJ6WlfX+U39sdUbr53+k4
 mwjf7RUwa8jEBjZ0Zf2NrxN5ipegfsg567H9QBFFIzKc0QH/6Fs9x6m/l2cKidICF3gX
 vwyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqwRsppcBpfV/rxVO62Si2Jt8cRd49WjMYUjGa2itLDfqR2KOZ+gY2p/KsiW5fLg76gq6/fisb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuNvGovAs0eGnEofzkT2KihjuS6qFXHvgpFGjVvMMrKaQTdDoz
 tup9KzAKe/KOHkBGV07tUfHtxtS6K0tvNpSH1aZy6YzxKGO/tzyn
X-Gm-Gg: ASbGncuZ4+s6Wyy5h01VxkNTtDmUHP9o8vPWG3/Nm2fz/n5bokHVnUlpgagwNxzaQx5
 Yca83imZSlzDI8OrECTmFofmHmgkNiK7TwgTGx7UFXJldtvX18pRTEIXHTYqRTsCElmEe1+tjwU
 RY0rUE1O4r3cIu5tW4h4q8oHvFz1wJwOTPrMxl1f6ICC2u0IIIgyRyBbR1LDQmQP3z//g9kBCgA
 Us3PkR2FJRWP8OYatK9qJEX0gw1ClmdAYx95q1zvpNZX6eOWbMrPKdcDK2jSMubgiUjhsYnQaEe
 qKknBbkyuXqm/4lPj/z815ibv3t/Lf1IDRv4/87y+UuCtaK/CEjLF4X3f3hB9+qn+CLBc/YW8Mt
 datkp
X-Google-Smtp-Source: AGHT+IHng41g0rod6mkg7Ea5fBbnKBfZi1xO8c06NSY6zyCMMOO9MOFIw/WpjIV6JREhifuZtMuC8Q==
X-Received: by 2002:a05:6000:2a9:b0:391:2ab1:d4b8 with SMTP id
 ffacd0b85a97d-39d88525f29mr2525368f8f.1.1744205555939; 
 Wed, 09 Apr 2025 06:32:35 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8938a67bsm1652594f8f.46.2025.04.09.06.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 06:32:35 -0700 (PDT)
Message-ID: <1bc09462-b4c0-4c41-89cb-0ceef49d9101@gmail.com>
Date: Wed, 9 Apr 2025 15:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dan.carpenter@linaro.org
References: <20250409131817.25990-1-cesun102@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250409131817.25990-1-cesun102@amd.com>
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

Am 09.04.25 um 15:18 schrieb Ce Sun:
> Checking hive is more readable.
>
> The following smatch warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'

Please also remove the setting of hive and tmp_adev to NULL at the declaration.

This now becomes unnecessary and I'm pretty sure that some automated checker could complain about that as well.

Apart from that looks good to me.

Thanks,
Christian.

>
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 60269fba5745..eb0589a09a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
>  	} else {
>  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
> -		if (tmp_adev) {
> +		if (hive) {
>  			list_for_each_entry(tmp_adev, &device_list, reset_list)
>  				amdgpu_device_unset_mp1_state(tmp_adev);
>  			amdgpu_device_unlock_reset_domain(adev->reset_domain);

