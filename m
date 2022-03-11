Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA612C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 12:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2A410E94E;
	Fri, 11 Mar 2022 12:18:02 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BA110E94E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 12:18:00 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id h15so12663337wrc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=Inu4L4PKBaVXOpMnYYom4gpESCx5Jhs4VOAij02ZZBU=;
 b=RIxCpPGuR2jC2WL49VIYAcenY5uLxInnOMJi+ND2iB9x0kwSrqNok9QT/Ctnea6VyN
 72yrO4f51Rwv7SwwlNAm8CivC4M8roLYg/D44gFqsGrXioWmAzXvkVdGcBcln4akpvYd
 EA6W35gxim5P1acDr2wpcPmIo2th9Okxm/0RN3Il2ltPO0yonRtTAXeSGgI2fKioeBkc
 Hkejs1K7cn60TS9nhSUq2zm+XxYm4AJ4cSxf79xef+e3iwFli3a1OhIovTl3msKSvHRo
 YEbsas6+NCYq6I95uz9UcWZH2TKAXy+nLsKjKBihTjf5LVvlFzy5TemW2ZbqTNVhCa5z
 SHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Inu4L4PKBaVXOpMnYYom4gpESCx5Jhs4VOAij02ZZBU=;
 b=oKhxtUKqKzg2ZIYEs40AQHy3vifjb4Ary9WpjTeUPON/xBXeGhJ0NlcNaMet7JM/vb
 VKADK8z6dxCCYN4sVm3XsG37JwePHbGFagIevH2nze4Kc2ZBznixBJRiHVSmD26E71BH
 pgOU0c5Sd3ttvUie84aA4FB+kVTiUFphJ/r7P7LtRINJw0MZICwep90KvNzETmLg4mon
 hiEVFb4H+H5yE7oRxl1prce+vfObqVtHxsmAWD2IhG1RCZKaVRAr0TRji8ODe/dBNqh6
 BZ+qfObr0vUTdqnzxqp/3avLtl5OBk3NtZyUKYx//HN7OdzgYhSAqOvQXCkeLz00xLCV
 zaMw==
X-Gm-Message-State: AOAM531O8UMcofV5f4KLXB7ljA9bnHlbLfuoBU9Zhz5Op2rZ3+CMbxlt
 3CVNL6YJoaS5pmXvi/0PXyY=
X-Google-Smtp-Source: ABdhPJywedt6S47EferW1kZdbFfZoeFWOn/lhvwfw+78/cfrrIQq879fz2aZmw/23rWooTGP9OslBw==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id
 q13-20020adff94d000000b001e55ca12b80mr7242673wrr.323.1647001079115; 
 Fri, 11 Mar 2022 04:17:59 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 11-20020a05600c22cb00b00382a960b17csm10186012wmg.7.2022.03.11.04.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Mar 2022 04:17:58 -0800 (PST)
Message-ID: <f0a629b1-5e82-d1f0-52c7-7b27404e9e97@gmail.com>
Date: Fri, 11 Mar 2022 13:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220310180615.2245997-1-alexander.deucher@amd.com>
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

Am 10.03.22 um 19:06 schrieb Alex Deucher:
> If the GPU is passed through to a guest VM, use the PCI
> BAR for CPU FB access rather than the physical address of
> carve out.  The physical address is not valid in a guest.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f60b7bd4dbf5..9887a60e8eae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -814,7 +814,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
> -	if (adev->flags & AMD_IS_APU) {
> +	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
>   		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>   		adev->gmc.aper_size = adev->gmc.real_vram_size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 344d819b4c1b..979da6f510e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -381,8 +381,9 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
> -	if (adev->flags & AMD_IS_APU &&
> -	    adev->gmc.real_vram_size > adev->gmc.aper_size) {
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
> +	    !amdgpu_passthrough(adev)) {
>   		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
>   		adev->gmc.aper_size = adev->gmc.real_vram_size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ca9841d5669f..1932a3e4af7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -581,7 +581,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
> -	if (adev->flags & AMD_IS_APU) {
> +	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
>   		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
>   		adev->gmc.aper_size = adev->gmc.real_vram_size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 431742eb7811..5fa613d41799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1456,7 +1456,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   	 */
>   
>   	/* check whether both host-gpu and gpu-gpu xgmi links exist */
> -	if ((adev->flags & AMD_IS_APU) ||
> +	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
>   	    (adev->gmc.xgmi.supported &&
>   	     adev->gmc.xgmi.connected_to_cpu)) {
>   		adev->gmc.aper_base =

