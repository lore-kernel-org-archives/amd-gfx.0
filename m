Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01546C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 10:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AB010E490;
	Mon, 24 Apr 2023 10:50:07 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320C710E490
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 10:50:06 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-94f0dd117dcso593714166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682333404; x=1684925404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xr2IXNVOHfCFSFlnPS6dVmdw6L+AAzdIDvnennZ2r10=;
 b=gvVvT6LVwSW/3NzAHOwbKiDe7PzQPgt55YPH568wbovPAcRW7WUa9Shnds2JjNojZm
 s2nD618Ez8RgEaHgTrrg44/Wcr2YJ6j+XcQZ430NMZ6BxF1LGa0+TlsI6smRIztY9gm3
 UYlTNZRJBp04IS11cwulVNeRGXODvWE1jhdFYERmnknZNFPqhqPbRnA9vBNnFQkR1GBp
 CzxDAZnyx+ykdUTevkV4w1ceeYdtNKW9oAN1w0eMrNPgZDt2Xv/4Lao55ENdtPsEz+AG
 vc2hqNdDLM5REHjI8nL3Od9HQP2nHyCBwlfl8bH93YC2dxj8DFJ9/aiBwMbfzHOUVTS/
 8lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682333404; x=1684925404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xr2IXNVOHfCFSFlnPS6dVmdw6L+AAzdIDvnennZ2r10=;
 b=OlBIdhRt5haPhK3e3LngJ4JIpphBRjI87Qo+HUx259pT9dR5iVujsyzdwYnNRRcwX2
 bNL08yfQwTS1eNFMH4t/Atydm7UCg4hXhQQ8UzVPeBoXLHot28WuiI00Sflw7y8x3UbW
 IRRPrNBD6gxVdJPkBhqNaNbYrhT1Fraes97C0meV8tbnr0Y3PUAe6JQPC0tfk1vt+iwn
 kQzb8MmvgoMf4EMrIkp43J7vhSoXzTfEXk0ZAp52o/Z/LyS4WERttQR4ahI33HK7/cm4
 aurp5MnZ1HEIiqYmt8b+DvmzQsmi0AKJW5+D0V70tzSYyYUrti+83MA+8ydpGumaiQ69
 x7BA==
X-Gm-Message-State: AAQBX9fDnlEIzn5Fb+VDoqJZmyMj1BsQjhARmzq0VsC2HP6pUn1XHkbg
 grCfZt56gZMKnup+s4UjyLHo0o24yYGpsw==
X-Google-Smtp-Source: AKy350Y1qyUEf8NQedL3GU/k1iqC4m4HvKCzicTK/lUyml7b8X7ARf3DMAOp4AxCuYY6g50ZuCXBwg==
X-Received: by 2002:a17:906:7d6:b0:957:2d2a:e8a2 with SMTP id
 m22-20020a17090607d600b009572d2ae8a2mr8960117ejc.27.1682333403834; 
 Mon, 24 Apr 2023 03:50:03 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 wv14-20020a170907080e00b009598cbe55c2sm1523648ejb.28.2023.04.24.03.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Apr 2023 03:50:03 -0700 (PDT)
Message-ID: <8d68b478-686e-0b77-4344-944b98fd63f5@gmail.com>
Date: Mon, 24 Apr 2023 12:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc
 hw_fini
Content-Language: en-US
To: Horatio Zhang <Hongkun.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com, Guchun.Chen@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 12:37 schrieb Horatio Zhang:
> The call trace occurred when the amdgpu is suspended
> before the mode1 reset. For the IP block that do not
> support ras features, the relevant interrupt is not
> opened during initialization, but hw_fini forced the
> close of this interrupt, which resulted in amdgpu_irq_enabled
> check warning.2

Sounds like it was a good idea to add this check.

>
> [  102.873958] Call Trace:
> [  102.873959]  <TASK>
> [  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
> [  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
> [  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
> [  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
> [  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
> [  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
> [  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
> [  102.874375]  process_one_work+0x21f/0x3f0
> [  102.874377]  worker_thread+0x200/0x3e0
> [  102.874378]  ? process_one_work+0x3f0/0x3f0
> [  102.874379]  kthread+0xfd/0x130
> [  102.874380]  ? kthread_complete_and_exit+0x20/0x20
> [  102.874381]  ret_from_fork+0x22/0x30
>
> [  102.980303] Call Trace:
> [  102.980303]  <TASK>
> [  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu]
> [  102.980357]  gmc_v11_0_suspend+0xe/0x20 [amdgpu]
> [  102.980409]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
> [  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
> [  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
> [  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
> [  102.980687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
> [  102.980740]  process_one_work+0x21f/0x3f0
> [  102.980741]  worker_thread+0x200/0x3e0
> [  102.980742]  ? process_one_work+0x3f0/0x3f0
> [  102.980743]  kthread+0xfd/0x130
> [  102.980743]  ? kthread_complete_and_exit+0x20/0x20
> [  102.980744]  ret_from_fork+0x22/0x30
>
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>

Assuming the corresponding _get() calls are already protected by the 
same check: Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 543af07ff102..0f6b037558bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4483,7 +4483,8 @@ static int gfx_v11_0_hw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int r;
>   
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 3828ca95899f..25f466c26d18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -951,7 +951,8 @@ static int gmc_v11_0_hw_fini(void *handle)
>   		return 0;
>   	}
>   
> -	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   	gmc_v11_0_gart_disable(adev);
>   

