Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9C4CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FDE10EF68;
	Wed, 24 Jun 2026 14:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="xR6KFFZv";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FE210EF68
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:59:38 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso8512525e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782313177; x=1782917977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/vKDsvl2bvipRpJp2GwzaynpfnK9rCzBVTBrKl5sOQ=;
 b=xR6KFFZvXmf7IwvR/V58YQFTl38fk49/DhHQcCgz8Rt67DGhmU4VlBV9FDqp2/UGTn
 STnfVDfMpXNT/jwQ0QUHLzX/3M9Oru9uVyLF/mrw028k5KMHnZNduu7ivp3Owi4RwZqs
 l0vaFHwCyrxjjSd42znm0xJt4Ts1FTeAojT5OD7aoXpLDsatSDYmQ19qhAhD8ZR/kb+3
 zxaLCDGDlQOiAFifDSqkCtYPjs2bpLEre64dVod062vL7CGzmHYkNeXErBXZIKz8hYie
 JJYicpMvhR6cCegXZAOTyc1zcGY/WBiephotkp8Snc9Q/cpAOts9/NV9KYH9Dbst8JBb
 djBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782313177; x=1782917977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/vKDsvl2bvipRpJp2GwzaynpfnK9rCzBVTBrKl5sOQ=;
 b=h9CoL6vTxJUnCQWf+MnSx/IElubOKCOWLjoouSMcBr+muWR494lzkp1MmszcPUGF/B
 pkzt+l8vQh8681Bvxe5OQC51+z4IyqNh2kE1ObsSx+OrGPEJ8AwVnfOOODKjlv3yRmsG
 XVBnDHxPZd/jUlHpyG41amW70EUnF01RG+a8JugCVVVwaTJNwf8Emtd/owPHbMBed6fM
 t6Ij0U6vLLfJOpcWY31tsubABJBcBTkCIWYnZlp+aIVFYyOeOzoh6D4Fn0swe/bn03KS
 jcYxRbLpXRDgko0/VAN1T8L5SYM12GEFY37tyxz7FVGEoZLERl6CD4fjbd0UYv2CHhET
 JE/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/awNV817diPgpJuJ9YqtH5p25up+wYImVskmzTBuVKLtREMg89amiTpud1KXEwwO4Ruc5mnsYn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4ONizULsLcT9RIibuc6+/2yK19iNMIym+9iIaoMx9QyGLJZuF
 vkwDSV4tD9Nti8D5gQt59iccZ4z13vo5WmdR7PC8mp5/eSEVhF5zGJVEOZZ7DdRZmnw=
X-Gm-Gg: AfdE7cloDs5VX27ET9JQQfl4zcVrjTKoiK0Q1NGy9MRyk4gs9zn8zY9o09f15hCbIPA
 of2N2PGwwb0rtqdJw89pwsvVhVLEmKy0Oh6iX85r8kn4p3SArA8HzAHVRWAYieOIm6mQqA94O1e
 p6tFfg+W88lfFFl3tzikpZ32hnRz/HZaJx41GAhcD/Wl1JOANp2AjtkXAY8N1N70KzJ+gmSdRCb
 Q8CB/HFS0kSVNXgny00qnBjoWhr51eGRDCNjzekjH/suTWNGTIKkldllvL8aEU3QXLXmNmUDJ2a
 m2VKgxbAFcTfI91ISAGFAkcjnXnCv7QPc3RXYaO4dkAunlv92yfbAZZv+GaqRCHRgjgjY7hgf5g
 LPlgaSXx3kQv/KU49OFvyLlxj1yR9zmH7X8/ale5K26tW75TL88lNL5mFBeWo3IJLA1Z1JysmOP
 lRFvnd18SHsE4JwqE/MQFFCRwVilSb4+jqpg==
X-Received: by 2002:a05:600c:4e09:b0:492:564f:5603 with SMTP id
 5b1f17b1804b1-4926084b963mr57507955e9.14.1782313177005; 
 Wed, 24 Jun 2026 07:59:37 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm6607335f8f.32.2026.06.24.07.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 07:59:36 -0700 (PDT)
Message-ID: <9143d988-08d1-4013-887d-d7dc5bb550fa@ursulin.net>
Date: Wed, 24 Jun 2026 15:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu/gmc12: Pass cam_index to retry fault
 handler
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-8-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260529103059.21470-8-timur.kristof@gmail.com>
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


On 29/05/2026 11:30, Timur Kristóf wrote:
> This is necessary if we want to make use of the filter CAM.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 7bbf5f848ce1b..90568d8ea0cf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -99,6 +99,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>   	bool write_fault = !!(entry->src_data[1] &
>   			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
>   	uint32_t status = 0;
> +	uint32_t cam_index;
>   	u64 addr;
>   
>   	addr = (u64)entry->src_data[0] << 12;
> @@ -110,7 +111,9 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>   		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>   
>   	if (retry_fault) {
> -		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +		cam_index = entry->src_data[2] & 0x3ff;
> +
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
>   							write_fault);
>   		/* Returning 1 here also prevents sending the IV to the KFD */
>   		if (ret == 1)

Looks the same as gmc_v9 so I feel more confident to give r-b.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

The only tweak I would potentially do is move the cam_index local into 
the local scope of the if branch. Any apply kernel coding style of 
leaving a blank line between the declaration block and code.

Regards,

Tvrtko

