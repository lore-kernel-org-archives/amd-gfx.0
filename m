Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323D3C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 07:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5063A10E09C;
	Thu, 15 Dec 2022 07:45:31 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A4710E09C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 07:45:26 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id b2so50258174eja.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 23:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wGB1nsfeyH8prjWCXDGUjy6bZyvdb3w29/AVsKNDVQ=;
 b=X+EDy4jhzAtTgNheE+KClDAvscMn5W6Wh0agfyCk8+adCQpf1n5QDtZtfz06/JZtYF
 jX1cp+A3bjPXeQDzEZ6L6ho9PlfRBTlX2K3t2Haukan1UOyMyKld2H/GNxdnXoBBmim9
 KWpY3YKvNBF/GuQJvYv1IuVhy4TUdtuaU/i5WDh5CfDuUM/LCa50uKiNa83xCLdNOjS2
 mBmVpi4PztoJn2UiHUfW8+7xmleRFqft1zlrMFewkb2Sy7rDNOccYbLw7RMNOc45M2KL
 u5DpM+2Obn6bcpNmW30x9nG92gPzl9VwkoUjMsxJVBeG+MnzhHSOCaPNITRrhe2FA9FF
 FFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wGB1nsfeyH8prjWCXDGUjy6bZyvdb3w29/AVsKNDVQ=;
 b=ZXsSNUs+TD4PYq2MlzzHz2zm4lcZYQFzO+jjC+THgrAiwKNEZzU+poN+vhs3lyFbDi
 w4FooxvfFbIWvaX2lhVXz5c1Id9M3yDFF2fZk2XbBvxztEXmm++lgvkxpvX6SslbMC2Y
 DB/ykp+9xv6j2w1UKEVMWqWC39N8ZM8Bs0bmN8Xt5KU+FLghdj+LW8eNTh+vOg46oxYU
 fzc6lptRXsCgBOYNHVIPOvZb+buJOtKqUJC0nldUe3ivu1/dBGTLwRu2raYBAuw6gE5L
 YsB2JSO2d1Mx8Kl4140ZqBaP+Jyv95DmVhJCctIlpuItedFvm4IIjvUNkcCldEypNjaa
 u+iQ==
X-Gm-Message-State: ANoB5plTUZBppQEp9FTxZ0nDfwrrlWYqIVQZtdYqaB6e9t9/gT8Mz249
 otCuEMPkzlcmuVsvYLOhQNg=
X-Google-Smtp-Source: AA0mqf5HGcPXHRHQxrVcZK2hzvI2aHTvnCYfOH8sCoJ462ZkzRSOs8yOcK/mkBw4G64pyxE8YW7kpg==
X-Received: by 2002:a17:906:e256:b0:7c0:edb6:e55f with SMTP id
 gq22-20020a170906e25600b007c0edb6e55fmr21709723ejb.37.1671090324738; 
 Wed, 14 Dec 2022 23:45:24 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 pk14-20020a170906d7ae00b0077016f4c6d4sm6766499ejb.55.2022.12.14.23.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Dec 2022 23:45:24 -0800 (PST)
Message-ID: <83ccb403-5c69-e191-41d9-0e5870baf40d@gmail.com>
Date: Thu, 15 Dec 2022 08:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] drm/amdgpu/gmc9: don't touch gfxhub registers during
 S0ix
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
 <20221214221654.1625194-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221214221654.1625194-2-alexander.deucher@amd.com>
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

Am 14.12.22 um 23:16 schrieb Alex Deucher:
> gfxhub registers are part of gfx IP and should not need to be
> changed.  Doing so without disabling gfxoff can hang the gfx IP.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 08d6cf79fb15..5f07c85bf729 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -484,6 +484,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>   			for (i = 0; i < 16; i++) {
>   				reg = hub->vm_context0_cntl + i;
>   
> +				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
> +					continue;
> +

I'm not sure we can do this because the higher layer will then have an 
incorrect impression of the interrupt state here.

Christian.

>   				if (j == AMDGPU_GFXHUB_0)
>   					tmp = RREG32_SOC15_IP(GC, reg);
>   				else
> @@ -504,6 +507,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>   			for (i = 0; i < 16; i++) {
>   				reg = hub->vm_context0_cntl + i;
>   
> +				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
> +					continue;
> +
>   				if (j == AMDGPU_GFXHUB_0)
>   					tmp = RREG32_SOC15_IP(GC, reg);
>   				else
> @@ -1862,9 +1868,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	r = adev->gfxhub.funcs->gart_enable(adev);
> -	if (r)
> -		return r;
> +
> +	if (!adev->in_s0ix) {
> +		r = adev->gfxhub.funcs->gart_enable(adev);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = adev->mmhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1911,11 +1920,15 @@ static int gmc_v9_0_hw_init(void *handle)
>   		value = true;
>   
>   	if (!amdgpu_sriov_vf(adev)) {
> -		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
> +		if (!adev->in_s0ix)
> +			adev->gfxhub.funcs->set_fault_enable_default(adev, value);
>   		adev->mmhub.funcs->set_fault_enable_default(adev, value);
>   	}
> -	for (i = 0; i < adev->num_vmhubs; ++i)
> +	for (i = 0; i < adev->num_vmhubs; ++i) {
> +		if (adev->in_s0ix && (i == AMDGPU_GFXHUB_0))
> +			continue;
>   		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
> +	}
>   
>   	if (adev->umc.funcs && adev->umc.funcs->init_registers)
>   		adev->umc.funcs->init_registers(adev);
> @@ -1939,7 +1952,8 @@ static int gmc_v9_0_hw_init(void *handle)
>    */
>   static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
> -	adev->gfxhub.funcs->gart_disable(adev);
> +	if (!adev->in_s0ix)
> +		adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
>   }
>   

