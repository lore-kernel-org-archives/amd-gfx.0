Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7B7C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 19:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E62110E0C9;
	Mon, 27 Nov 2023 19:09:14 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EA510E090
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 19:09:12 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b479ec4a3so8391175e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701112151; x=1701716951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0TA5kKmrVUYrKs/M0IzHPEc34/l2/aasr4JDwFHAWg=;
 b=cgQSeNA2dOH+CuPKWBzPFcs6cvHEX+cKHvq7iDB6AFMpqL7sQnWdJsBAF9pDp0QGc+
 1bAwakXDDiyZ0K+CS2kNhcsS7FerslNLGb/bRhyic+/GjDM3iodIF30QHhchN1l9DJID
 TXn8YoNK+SVBoAeuAMyk5WU7YNaW/8FT9stWw8HREPvFPx74ChK0z3yy3ZYcy2c8d2d7
 SF+CvjhpPVti3pUqud2b0CCQW+6wlvSAcUWw+ux/nBD4iZzZm84tNG9jA1+XbkCT1Xpq
 GhjO66kM6mX80Ew8muAbsc+QAR+E3gFRfKrzi0mNroJGVJ/lw/eAJpOFKd966KQZnkER
 Ndfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701112151; x=1701716951;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0TA5kKmrVUYrKs/M0IzHPEc34/l2/aasr4JDwFHAWg=;
 b=RjOWNBpKWdagcl5D6dFNJJaBqbDFo5Sjy53I/sCmE/uIUuEYE7pmXluyprm+RhYZ08
 750lDrWkYqGXSRFK6yNlesGOCbXs6ocMc5miuSJgXOx+i1UI/Q4UDmuzwRZipJ7FaDeq
 HYGsykRtkw+iuvMYxHO4jzF7mvtF+HxCGl8r3tl2lhKUvBsyVm7hVJUwDz64kGYeORi4
 GhiCP+U9NbdwFslS2BeIOOQpT3bYmK1ht0kgNINjZc+ekJSj2dhf2e4jMSxkC0BbNiV2
 dNzy3TD5rd/zFZGEgsf7455VxTUDxI6c41Wc/zr1VmiCYZWPK1P9Hme2L846SDY0HLJx
 E1Qg==
X-Gm-Message-State: AOJu0YzcDtLSz1V5kHkgww+gy+HUkYGsGH3UddHH9YVMKqsw83f1QPrB
 0TTvLmACGwFL2ttJgwbAWlE=
X-Google-Smtp-Source: AGHT+IFyTksDamHc0Y2cr1SyBAxtAFsd9RvDR60Yh3JdW79atuLLvh529HnIGIx6tzqqBLPBLr9W5Q==
X-Received: by 2002:a05:600c:3510:b0:40b:45e2:1f56 with SMTP id
 h16-20020a05600c351000b0040b45e21f56mr2874234wmq.39.1701112150592; 
 Mon, 27 Nov 2023 11:09:10 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a5d674a000000b00332eef1ca7asm8131648wrw.80.2023.11.27.11.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 11:09:10 -0800 (PST)
Message-ID: <d0e3f1e2-a263-4a35-a986-90b838dbb81f@gmail.com>
Date: Mon, 27 Nov 2023 20:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: check if AGP is disabled in
 amdgpu_gmc_agp_addr()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231121150556.84900-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231121150556.84900-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Am 21.11.23 um 16:05 schrieb Alex Deucher:
> Return AMDGPU_BO_INVALID_OFFSET if the AGP aperture is disabled.
> There is no reason to check further if the aperture is disabled.

Yeah, but there shouldn't be a reason to check it earlier either.

The "if (bo->ttm->dma_address[0] + PAGE_SIZE >= adev->gmc.agp_size)" 
just below this code here should catch that perfectly well.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5f71414190e9..0f85f906791b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -181,6 +181,9 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   
> +	if (!adev->gmc.agp_size)
> +		return AMDGPU_BO_INVALID_OFFSET;
> +
>   	if (bo->ttm->num_pages != 1 || bo->ttm->caching == ttm_cached)
>   		return AMDGPU_BO_INVALID_OFFSET;
>   

