Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ED3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 07:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D238F10E3B7;
	Wed,  8 Nov 2023 07:32:01 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC4F10E3B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:32:00 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso11001125a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699428719; x=1700033519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F3XP8fZMZ/yxEBFlm0Zp279Ofu7dPlyeMwQIqIh8Udo=;
 b=NW3a95GI9VRdb5eVYJ/w6YhLO+ofk1v07Ps76iq0UImx6U3EAOwVqj65JASPEekQQ6
 CrpKd48goAan/wnDsTF6X9JiO9AyXJ2pbOJxO8Bb4l/E6EI3xQoAU3fem4EPNSX6S9Ls
 mXyTePvs8sr+wne8+DlnV1GFLN2KrIv3MZWZ4XYi51RnDgVLSX/WyC6pKaYnfMmaF8jH
 Uo1A3PQk3aK8oxI3lfe1zK0cakKeED9SZhUE8V7bkaRKmTzTKv8kwI4/wWzCfA0hFyKj
 O9xgoDC4QQLIZv0THYmSgQmlNE/5qY564/oHOSrD03DWx1sx49slHDRy0f+ro8jj0YWr
 LUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699428719; x=1700033519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3XP8fZMZ/yxEBFlm0Zp279Ofu7dPlyeMwQIqIh8Udo=;
 b=o8dSRs51S7vBHJolI7+RzekPyU84i9Upp1m95FZzBRrfchls9TYCiXlPhQpgG78Mmi
 KS1phha6k5EL3QMmUmd17SePiuSYucHB4qxh5XZEwtlOYD2dWUTaVG6wHYLUYMkvn6h/
 0GypVpS47pB2r9NCvTl8DbSVNLfLovtU/AiFuLGeIqZIyFODsAsRDti1vokp251Amb/b
 LNrAiUZIjCXz+0K1mJrlIntYYhj3ud6DfKVx2A2r1dgs/EzARAGymUeVdMvyiVCkpMG+
 LruIRLGbQR5P3OUT2qSH9NIplp2kDRL/bQHcqV/nk4pKpH6wkSpy6swaiCVQbft0h5wz
 oKmg==
X-Gm-Message-State: AOJu0YxpyokBwzcAjyHS6OyzY3NHSfrNISH5VXGL7y/tXXx3Y+Xng9v1
 AnND8fjX436i3KQzAng3DlnRt79i4VNkZQ==
X-Google-Smtp-Source: AGHT+IHxlQYZ6AVCbEvOcpuMiJAQ8F4YMAD7t5r/j4wezCDJhOaMwVxRc50hfLBvIWG+PURoEYWBIA==
X-Received: by 2002:a50:aadd:0:b0:53b:9948:cc1f with SMTP id
 r29-20020a50aadd000000b0053b9948cc1fmr789894edc.12.1699428718984; 
 Tue, 07 Nov 2023 23:31:58 -0800 (PST)
Received: from [192.168.178.25] ([134.19.101.78])
 by smtp.gmail.com with ESMTPSA id
 cf27-20020a0564020b9b00b005435faef9cfsm6282692edb.52.2023.11.07.23.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 23:31:32 -0800 (PST)
Message-ID: <d0b683ff-f35f-4422-9e3a-bd4b1e5dbdfe@gmail.com>
Date: Wed, 8 Nov 2023 08:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix AGP init order
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107191403.2676735-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231107191403.2676735-1-alexander.deucher@amd.com>
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.11.23 um 20:14 schrieb Alex Deucher:
> The default AGP settings were overwriting the IP selected
> ones since the default was getting set after the IP ones
> were selected.
>
> Fixes: de59b69932e6 ("drm/amdgpu/gmc: set a default disable value for AGP")
> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-November/100966.html
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 ++
>   7 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0dcb6c36b02c..cef920a93924 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1062,9 +1062,6 @@ static const char * const amdgpu_vram_names[] = {
>    */
>   int amdgpu_bo_init(struct amdgpu_device *adev)
>   {
> -	/* set the default AGP aperture state */
> -	amdgpu_gmc_set_agp_default(adev, &adev->gmc);
> -
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>   		/* reserve PAT memory space to WC for VRAM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d8a4fddab9c1..ef80ea0929fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -672,6 +672,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>   	/* add the xgmi offset of the physical node */
>   	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>   	if (!amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4713a62ad586..5f794a907945 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -637,6 +637,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	base = adev->mmhub.funcs->get_fb_location(adev);
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
>   	if (!amdgpu_sriov_vf(adev) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 7f66954fd302..42e103d7077d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -211,6 +211,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	base <<= 24;
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 61ca1a82b651..efc16e580f1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -239,6 +239,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	base <<= 24;
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index fa59749c2aef..ff4ae73d27ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -413,6 +413,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
>   		base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
>   	base <<= 24;
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b66c5f7e1c56..fe52d132b629 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1614,6 +1614,8 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>   {
>   	u64 base = adev->mmhub.funcs->get_fb_location(adev);
>   
> +	amdgpu_gmc_set_agp_default(adev, mc);
> +
>   	/* add the xgmi offset of the physical node */
>   	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>   	if (adev->gmc.xgmi.connected_to_cpu) {

