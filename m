Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C073C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 07:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0E410E57C;
	Wed, 16 Mar 2022 07:18:09 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E9010E539
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 07:18:08 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id r13so2239098ejd.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=6m8cpBAN/UuKQ8pmj9N0RepY1DwXcvNI8v2C4K9sg38=;
 b=Wnfqnj+j9mMGs2Nic8xNHnLsSjkQbBIFjx33zjZ9/8njDV6UB3oCT+CyMoa3Yuy0TY
 z3ZITs1GsTublUIyM/Cx4FXRCnrT6dw31gLEZvhJIspDj/1wSzahZO3KyowpAWene2g2
 1NBPFWsls2aC+1JPBMsyJ4tFeTy9ETxk1oPg39zbDa0N+DDtsweR7h/FHuV0s7J8aKcG
 bNYq5TEkpl60bNxmnHzJIUelW1ZHFbh/eUsDbZNQqBpJWmRnEmMa/gcO4XOPeYTVN+sJ
 f38pEYUspjWlzimJhauAKP16unsB8jeq1uHEEY+GDba5lnH7jlgHcAUJU7rZYXHZ05S+
 nwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6m8cpBAN/UuKQ8pmj9N0RepY1DwXcvNI8v2C4K9sg38=;
 b=5iUUghXymkvscaG20dqL+RLyBpSYofvYl69svG4WZDQvGKV1F8lYKgjVWjnXhaGXyO
 45uVKB7iv7QIpbN0WpLq2FSU/qmIFLq9+Du7pWrcyWtjx0QNeX7S5io0mr1r5Iy4/60Z
 QkIgD6JCArWURNNqYfpeLavb2mPAqCkD0St6SwNFg1D9zn7oZlHDj1MJpb32kalCm52P
 ARj8cdgT0nIV3rSBh9wwL1fbky9y5Nyvp31w22apKUT0SKuYyjGZCfbpVA+RaLQ3TacJ
 KUT4mE5J0Tnu9bKm5RryZyBi6zUFBIvaFZJgSXTARe0F4rRr9XgSEEbp6AErtJ9vxyDP
 6eog==
X-Gm-Message-State: AOAM531AkG9ah8ttrjHzW0qy0AaAY53FgXjbuIdEE5ZswfCSzpt4gHB5
 j76OTawAdxMD00llKoeoWFQ=
X-Google-Smtp-Source: ABdhPJxGhAN9NCo0RLOuLoWdblY79MOC8/J65+eCQdImMRb0eXNG2+nwl3Px/XUuQzoNGZe/gpLONA==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id
 q11-20020a170906a08b00b006cf65bce7demr25807399ejy.220.1647415086590; 
 Wed, 16 Mar 2022 00:18:06 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:e172:567b:db98:7f8b?
 ([2a02:908:1252:fb60:e172:567b:db98:7f8b])
 by smtp.gmail.com with ESMTPSA id
 sa13-20020a1709076d0d00b006ce3ef8e1d4sm509903ejc.31.2022.03.16.00.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 00:18:06 -0700 (PDT)
Message-ID: <c7e4568e-5bee-ab1c-cc4f-5985200f0fa8@gmail.com>
Date: Wed, 16 Mar 2022 08:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315181300.2808453-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220315181300.2808453-1-alexander.deucher@amd.com>
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

Am 15.03.22 um 19:13 schrieb Alex Deucher:
> If the GPU is passed through to a guest VM, use the PCI
> BAR for CPU FB access rather than the physical address of
> carve out.  The physical address is not valid in a guest.
>
> v2: Fix HDP handing as suggested by Michel
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Might be a good idea to have a function or macro to figure out if we 
should use the BAR or not on APUs.

Anyway patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 +-
>   5 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1b313a95c7e5..eb902654f35d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5733,7 +5733,7 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>   		struct amdgpu_ring *ring)
>   {
>   #ifdef CONFIG_X86_64
> -	if (adev->flags & AMD_IS_APU)
> +	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>   		return;
>   #endif
>   	if (adev->gmc.xgmi.connected_to_cpu)
> @@ -5749,7 +5749,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   		struct amdgpu_ring *ring)
>   {
>   #ifdef CONFIG_X86_64
> -	if (adev->flags & AMD_IS_APU)
> +	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>   		return;
>   #endif
>   	if (adev->gmc.xgmi.connected_to_cpu)
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

