Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB65C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 11:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D38F10E376;
	Wed,  1 Jun 2022 11:48:15 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A50310E376
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 11:48:14 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so3217140ejc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sPxK5UghEuYFIAiafTc7D7nHEIB1svqjAjjDyxsCIlo=;
 b=BejQVTVVfRVbhf86VYRL4odjGSn4Fyq8tpA02vzwDiCqhf5ZlG9p/zHI2QNvCFDXPm
 F0d0XlbQ24Vpt6XV44X4BFYJAxsHObmB00OtzGLbnaDikcwz1TznMLzfn9NLk4yUjzkv
 72726NpTUZ+x4dzPc/KDfWDA3fTkF+jdgfKm25NJxS4Kqb5OMYRoutb8ePwf+uXQ7gJP
 lJ4DxAWkmaaCG9cesr6TnWsp+83Qd61oprsRt4LJ8lBQfC/JTtHL7BVfij1D5Tp+t4or
 S4dgeCJDWiCj4qJaPQRC1knCNOi8cZQ79sMOXffbJbXE1PKVoxuFWPQYks3FhgvucNuT
 TVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sPxK5UghEuYFIAiafTc7D7nHEIB1svqjAjjDyxsCIlo=;
 b=Ig3LcNvFNc5ozVoLjCC7u0CTVT2ZBYyctoqUrTS4KDBzcq+sAcPAg5aYD+yHbAUhgK
 5eMvWTqDCWt3SbW0bjLcmwkVHWJ3Rdx2+SlClpYks2rN0G14c8BIYxI58IPSimsgEqqd
 wzKEVSFjHYiEHuqGG+MVvwFxeWMgyTFXncSnPXdLu18VXJyz1GXN+VrdwhT3v03IHTD5
 cBe4fXLEuwGLYTd0N82AztHlvtCaKcjiCJ0NSvAQU2l0a3vAnBJLm7g8pMpjyTxVVJu5
 ZVk0XdnUyP/03FKtoLUKDWJBwbxlyjVYqBflC3X1BAkxZqwPbsT9X0X24NJaDdD7au1k
 C6xw==
X-Gm-Message-State: AOAM530Ky6YFo5YOdcZNQ1lYcj1CgMqygeFnwQV18+rOuuKBDuPshLNR
 W5JTZLVnbmAA+/oafiCBhhmWCiuJxbE=
X-Google-Smtp-Source: ABdhPJznohQDqnQJczZhyHDfi9jcZs43fmwdao1iJMhO9bPhxuEc9sbb4bi9xY4jdDWcXz9di0e36A==
X-Received: by 2002:a17:907:2ce2:b0:6ff:3971:e334 with SMTP id
 hz2-20020a1709072ce200b006ff3971e334mr21914614ejc.211.1654084092946; 
 Wed, 01 Jun 2022 04:48:12 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a1709060dcb00b006fe9f9d0938sm614004eji.175.2022.06.01.04.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jun 2022 04:48:12 -0700 (PDT)
Message-ID: <47f997f0-e9a3-c46b-931d-756dd28cb230@gmail.com>
Date: Wed, 1 Jun 2022 13:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Content-Language: en-US
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220601072732.2773139-1-zhenguo.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220601072732.2773139-1-zhenguo.yin@amd.com>
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
Cc: jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.22 um 09:27 schrieb ZhenGuo Yin:
> The scratch register should be accessed through MMIO instead of RLCG
> in SRIOV, since it being used in RLCG register access function.
>
> Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")

Maybe better but the register offset into a local constant then.

Apart from that looks good to me.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c5f46d264b23..8331e0c5e18e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3784,7 +3784,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0), 0xCAFEDEAD);
>   	r = amdgpu_ring_alloc(ring, 3);
>   	if (r) {
>   		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
> @@ -3799,7 +3799,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>   	amdgpu_ring_commit(ring);
>   
>   	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
> +		tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0));
>   		if (tmp == 0xDEADBEEF)
>   			break;
>   		if (amdgpu_emu_mode == 1)

