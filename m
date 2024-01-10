Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13DFC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DE610E569;
	Wed, 10 Jan 2024 08:49:11 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ED810E569
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 08:49:10 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e4d778e5eso19679905e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704876549; x=1705481349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/VQYhMMaJ3shelCxJxyqS3LISabdrZQvYz0JvKb+8So=;
 b=WkRlJgBdPM+hSGkpSMrTuKlw+9P0MneLFHIPv+pPSYVCuZVeqMblKU/1Wp1Iw9AwKx
 qzbwf8vf4spKtIvg0mtKGLhjjoqJldlWM7OLo2qFJq066JyAOmzpKib8TUwlQrjl0Qgc
 frLJpOufCF9QOVHIh0Kg8YJjvs35Zdh4f10G3UcyWw3ZzARmZmQkUHzk7Q1FM1KMbePA
 9gvu0T6ne+hDSgX/KkeQOrwRCnWcJVbw1jSSeSLQhH5nzxO/+L2lmpOs6dOshwV6oFo4
 7rvqLM4Ho0De+xJC7WwWUs7eas8Goz3KcXu7TdyCJbF+iRk96DegIUB40WJzY9qTcadf
 I04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704876549; x=1705481349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/VQYhMMaJ3shelCxJxyqS3LISabdrZQvYz0JvKb+8So=;
 b=JX+XJ1+FL+vZg09CUZ0FcLLNCyVf3jAqehFq5od6HQ0caDbtU1keJAgu/1QAee96E2
 RTxJsp9vkxkAjiZ+axaJDKVo4Am/WxxcncbuvnzvE9eF7wxS2uoTSnYklqx/vqPi4EB8
 Av23EHJR7kDNmcz8H1uL0/BJgGCQICSnxo+6wDsdtoVm2Vh1VSs7bDr8CVMMmE/0LO4Y
 ghmMo4Z1W5hBJSzGdTTLBdOLgKY57Jalqjq1Y1kMkuUlcTZODBsGOd2UgFhnVvd7C6I7
 uP+7Y/jJkCU0PfncpEgslVfDqTY3t+jROZEo8kk817FieH5WjomWkyVtWCNY5ZnKXdMG
 +GQA==
X-Gm-Message-State: AOJu0YzenNwi4jKPkPrralBOvkGb4eAkFZSvTQa4xmZ4rfAo+fyYmXhL
 YzWAToOFcnpxc6YOYtlGx/E=
X-Google-Smtp-Source: AGHT+IHDO9p3CHa82DSOuxCTV0lxhY72KunEqSFnF9SgY0cqRCbH0EKGjnSX8feNI+fCQa3WGAWlIg==
X-Received: by 2002:a05:600c:a4b:b0:40e:4084:d82c with SMTP id
 c11-20020a05600c0a4b00b0040e4084d82cmr357340wmq.34.1704876548581; 
 Wed, 10 Jan 2024 00:49:08 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c430c00b0040e596320bfsm22466wme.0.2024.01.10.00.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 00:49:07 -0800 (PST)
Message-ID: <06df795e-76c2-483d-889a-aabd59b3b823@gmail.com>
Date: Wed, 10 Jan 2024 09:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v2] drm/amdgpu: add debug flag to place fw bo on vram
 for frontdoor loading
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109130008.30294-1-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240109130008.30294-1-le.ma@amd.com>
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.01.24 um 14:00 schrieb Le Ma:
> Use debug_mask=0x8 param to help isolating data path issues
> on new systems in early phase.
>
> v2: rename the flag for explicitness (lijo)
>
> Signed-off-by: Le Ma <le.ma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
>   4 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..3d8a48f46b01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1144,6 +1144,7 @@ struct amdgpu_device {
>   	bool                            debug_vm;
>   	bool                            debug_largebar;
>   	bool                            debug_disable_soft_recovery;
> +	bool                            debug_use_vram_fw_buf;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 880137774b4e..0776b0c5e4e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,6 +128,7 @@ enum AMDGPU_DEBUG_MASK {
>   	AMDGPU_DEBUG_VM = BIT(0),
>   	AMDGPU_DEBUG_LARGEBAR = BIT(1),
>   	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
> +	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
>   };
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2117,6 +2118,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>   		pr_info("debug: soft reset for GPU recovery disabled\n");
>   		adev->debug_disable_soft_recovery = true;
>   	}
> +
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_USE_VRAM_FW_BUF) {
> +		pr_info("debug: place fw in vram for frontdoor loading\n");
> +		adev->debug_use_vram_fw_buf = true;
> +	}
>   }
>   
>   static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 51bfe3757c89..215994409ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -				      amdgpu_sriov_vf(adev) ?
> +				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
>   				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   				      &psp->fw_pri_bo,
>   				      &psp->fw_pri_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 0efb2568cb65..3e12763e477a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>   {
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
>   		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
> -			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> +			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
> +			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   			&adev->firmware.fw_buf,
>   			&adev->firmware.fw_buf_mc,
>   			&adev->firmware.fw_buf_ptr);

