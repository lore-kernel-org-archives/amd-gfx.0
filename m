Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ABFCD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 07:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C287410E576;
	Thu, 21 Sep 2023 07:53:44 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB4510E576
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 07:53:42 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401187f8071so3539045e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695282821; x=1695887621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2F+TKc3lBL9Y2etFcUFLlo/t60iTFhXynhS8m7tZLt8=;
 b=KvlPs9kR/PAgVgxNqJXtXlN05COLG0tRtFJOwMaAJe3W49txOwIYG0+nsNqRu4+h32
 bOK0QysuVpPNIKdcj/2MTzzkpPvqXgKinFDxvFwBjLH3BcT75GJKpOpNxI0v9KnaWi5w
 /y2yzEBWTKpwEg8kIvRnU9OCG4MDlf9G9Fh+PVbnIZFR35s5iOPssaZiF6t5ETqD0la2
 /oKj9O8oIA6DLEGtdpIlFQGcf4OXYE+bGpSFzH2zlFdZ7zQE1etjUfmEQPTQPVRurgCE
 zWHZQCTmVwDzBUs43eT7nq/gtNcsHiYQ3bPHSdESRQ0f7htKfb7YKkCDO9CeCfQglWmx
 eVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282821; x=1695887621;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2F+TKc3lBL9Y2etFcUFLlo/t60iTFhXynhS8m7tZLt8=;
 b=B39R1gAlya2QjU94Xqb7RW0FLw9Q4O+pwaQKVL22U7IDYXh944PSROui62Pq3e24ol
 CEmpT1EZCIejQyaVJ8I4duzlxFv4eMobe0qdIw/AdT72HQxn3zaW/WpSmnBc8itOz6B9
 aUIVrBnJu/w209DQ2SvPWUVWfq5vPNxRMseIViMYA+noctXkn6uT1NUXu4s74i6OvV/p
 ThfeKAffxBHRdcUy0/Q6pRnAxHhhC/R9B9wLuF1bHxp+JoCiMsBzSa4Jme6aVq32jQ8p
 zN2Am6wvpCDgSv1pVGBTycnI0VecoiOn7jz+Ibm9bAbH+eIiYU86Xw9vpWgOncA5Mjt7
 9/uQ==
X-Gm-Message-State: AOJu0YymQgGm3G+vvIrPwO7NzbGi/kEo0vDRql+nzWRWOyrQhBoEgfYW
 qM/lFhMq88J9PV72B/FLugg=
X-Google-Smtp-Source: AGHT+IHfvKNXS0EjZGiHH54hjDWL6O5pk1HiGoSYNyoEM9OcIKHcrT7Y4wOAROOF0ISmJ/pa6T4ohg==
X-Received: by 2002:a05:600c:b89:b0:401:c7ec:b930 with SMTP id
 fl9-20020a05600c0b8900b00401c7ecb930mr6012377wmb.10.1695282820926; 
 Thu, 21 Sep 2023 00:53:40 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a1c7701000000b003fe23b10fdfsm4039914wmi.36.2023.09.21.00.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:53:39 -0700 (PDT)
Message-ID: <cd1ab757-f406-c2df-e602-bd1e6e9b459e@gmail.com>
Date: Thu, 21 Sep 2023 09:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] drm/amdgpu/gmc: add a flag to disable AGP
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920175823.3099627-1-alexander.deucher@amd.com>
 <20230920175823.3099627-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230920175823.3099627-2-alexander.deucher@amd.com>
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

Am 20.09.23 um 19:58 schrieb Alex Deucher:
> Allows the driver to disable the AGP aperture when
> it's not needed.  Program AGP explictly for all asics,
> but set the flag to align with previous behavior.  No
> functional change.
>
> v2: rework patch
> v3: fix broken rebase
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h           | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 3 ++-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   9 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c7793db6d098..fc1a585d05bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -315,7 +315,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
>   	u64 size_af, size_bf;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> +	if (mc->disable_agp) {
>   		mc->agp_start = 0xffffffffffff;
>   		mc->agp_end = 0x0;
>   		mc->agp_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index fdc25cd559b6..d3b014b84fa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -333,6 +333,8 @@ struct amdgpu_gmc {
>   	u64 MC_VM_MX_L1_TLB_CNTL;
>   
>   	u64 noretry_flags;
> +
> +	bool disable_agp;

I would still rather have adev->gmc.agp_start and adev->gmc.agp_end and 
initialized to valid default values and then never call 
amdgpu_gmc_agp_location().

This here basically just tells the function to not do anything, so we 
could rather not call it in the first place.

Regards,
Christian.

>   };
>   
>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e582073b57c8..2923007847bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -842,6 +842,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>   	}
>   
> +	if (amdgpu_sriov_vf(adev))
> +		adev->gmc.disable_agp = true;
>   	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 69f65e9c4f93..28dc08fe542b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -741,6 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>   	else
>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		adev->gmc.disable_agp = true;
>   	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 07579fa26fa3..a65118926ed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -213,6 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> +	amdgpu_gmc_agp_location(adev, mc);
>   }
>   
>   static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
> @@ -253,8 +254,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   
>   	if (gmc_v6_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> @@ -339,6 +340,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>   	}
>   
>   	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +	adev->gmc.disable_agp = true;
>   	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index e77e5593e1ab..680c7bc58c85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -241,6 +241,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> +	amdgpu_gmc_agp_location(adev, mc);
>   }
>   
>   /**
> @@ -288,8 +289,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   	if (gmc_v7_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
>   
> @@ -406,6 +407,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   	}
>   
>   	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +	adev->gmc.disable_agp = true;
>   	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 6acf649469dd..1576d22c8197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -415,6 +415,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, mc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> +	amdgpu_gmc_agp_location(adev, mc);
>   }
>   
>   /**
> @@ -473,8 +474,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
>   	}
>   
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   	if (gmc_v8_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
>   
> @@ -596,6 +597,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   	}
>   
>   	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +	adev->gmc.disable_agp = true;
>   	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2936a0fb7527..83a4e293ec4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1788,7 +1788,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   	}
>   
>   	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> -
> +	if (amdgpu_sriov_vf(adev))
> +		adev->gmc.disable_agp = true;
>   	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2e4a8bdbf50e..c2cb4b4cd2d7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1255,7 +1255,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   	agp_top = adev->gmc.agp_end >> 24;
>   
>   	/* AGP aperture is disabled */
> -	if (agp_bot == agp_top) {
> +	if (agp_bot > agp_top) {
>   		logical_addr_low = adev->gmc.fb_start >> 18;
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			/*

