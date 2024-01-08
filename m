Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB40C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840B110E189;
	Mon,  8 Jan 2024 08:15:09 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253AF10E189
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:15:07 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e47d74824so4648025e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jan 2024 00:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704701706; x=1705306506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eetiA0bXQJuhXlqdUPScajepL/APkI1GrGSn7KLU8jg=;
 b=UsZUe1uZ9R7Y/7/1ntQtjQvFVVsxwQN8p1FydNhYUZxfa5VP3bhywD5oc005+9UA+S
 wvU+OXBdiqylgRv1we4VjUzlRaKnQTuc2b4Idi7zhktbWI7c4i5as+SnV+Ge6aFHAfID
 nxhJ5DxJgJgU/034HINMY6Z+flsaj94AP9h+Yi9jo5CGn1R5T6hbCpkqJ2YH0JoHfyEM
 mD+OUFCkz7B4gGon0YefdOCT1cAnn8LAIvWtMgM+MCxFwbunNWRGHQ9rrsq2+9LqjeUp
 nznrbpfYrya5E4p30IaViOH8P50wc4nHWnk927x1jp85v8+Xdv1zLrqLYVzYygTxmao+
 YLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704701706; x=1705306506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eetiA0bXQJuhXlqdUPScajepL/APkI1GrGSn7KLU8jg=;
 b=EFyy4LwUQHmfyMA30pd/G/qKN6QABVhIfpi0Xe57tPnhSi4ANxxoJPc8JXSZ28sqDl
 EGRlpW9doFlgJaxp9w0gSydTtJ7PSZ7z6mDTKDLFoJdA18RCYTMSHlafL8iaBnqrEN8N
 sS8i+SDdMPy2GFkyD0yGPwAg3MVs11IoOsCAcpX2QCEIkwM2Edge5er8sFIxnFddSmOu
 Tb+Gh/thCKlL/NEXiIU3cpkwL+hELxATgzrbHqwr3CHAH2o/10A6pfBYVgYYdpMjsNRG
 Cg9kX7gl+z4+ewgItmBqnVHxN6fJCdFlm7OLeUPQ8+oAvUpqOr1GoWjYbCB/OjjAbWPj
 pm3A==
X-Gm-Message-State: AOJu0YxMF+kyXSGOzVNQH2aDdy7v5J0YCS1d4R2aJu73PEiDibt1tvlb
 YOJBs8ljxKDBmwvCvoB49+9ERC04GOE=
X-Google-Smtp-Source: AGHT+IHbWtQyEMonZtMlmsVhddnFMCdpdulbCfsVJ10blsLfyaT47RFuhb3JsvGTWVorf02N8XYbAg==
X-Received: by 2002:a05:600c:219:b0:40e:4777:7f0f with SMTP id
 25-20020a05600c021900b0040e47777f0fmr265277wmi.216.1704701705531; 
 Mon, 08 Jan 2024 00:15:05 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c351100b0040d839e7bb3sm10031656wmq.19.2024.01.08.00.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:15:05 -0800 (PST)
Message-ID: <c0af3207-a008-4723-b204-c5ab03f3c092@gmail.com>
Date: Mon, 8 Jan 2024 09:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: add param to specify fw bo location for
 front-door loading
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240103080632.7365-1-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240103080632.7365-1-le.ma@amd.com>
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.01.24 um 09:06 schrieb Le Ma:
> This param can help isolating data path issues on new systems in early phase.
>
> Change-Id: I0a972dd74fe2aad6b56628cea32ad72dcd17e283
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
>   4 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..9da14436a373 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -254,6 +254,8 @@ extern int amdgpu_agp;
>   
>   extern int amdgpu_wbrf;
>   
> +extern int fw_bo_location;

Well first of all all extern defines should have an amdgpu_ prefix.

Then absolutely NAK for upstreaming this. This is *not* a parameter an 
end user should be allowed to mess with.

Regards,
Christian.

> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 880137774b4e..852cec98ff26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -210,6 +210,7 @@ int amdgpu_seamless = -1; /* auto */
>   uint amdgpu_debug_mask;
>   int amdgpu_agp = -1; /* auto */
>   int amdgpu_wbrf = -1;
> +int fw_bo_location = -1;
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -989,6 +990,10 @@ MODULE_PARM_DESC(wbrf,
>   	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
>   module_param_named(wbrf, amdgpu_wbrf, int, 0444);
>   
> +MODULE_PARM_DESC(fw_bo_location,
> +	"location to put firmware bo for frontdoor loading (-1 = auto (default), 0 = on ram, 1 = on vram");
> +module_param(fw_bo_location, int, 0644);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 1bf975b8d083..2addbdf88394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -466,7 +466,7 @@ static int psp_sw_init(void *handle)
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -				      amdgpu_sriov_vf(adev) ?
> +				      (amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
>   				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   				      &psp->fw_pri_bo,
>   				      &psp->fw_pri_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index b14127429f30..1f67914568f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>   {
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
>   		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
> -			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> +			(amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
> +			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   			&adev->firmware.fw_buf,
>   			&adev->firmware.fw_buf_mc,
>   			&adev->firmware.fw_buf_ptr);

