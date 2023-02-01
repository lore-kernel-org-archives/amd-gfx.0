Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F10EC38142
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Feb 2023 16:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F294E10E422;
	Wed,  1 Feb 2023 16:06:16 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2743810E422
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Feb 2023 16:06:16 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so52862798ejc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Feb 2023 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=prBUWmsUsaG8CSdjJVtMXBT94MO72/n2qXYoPW7K5C8=;
 b=HUF42p/oWEH30bPHTniX9qcc8hAoDX4DYpicimv5DH2vImBUFz8J6OC6k3pihCO2N7
 IG4HFBYiUdZaPnIc2gJMGLoxu+t1wvP366LmeIMJyUlhT+jJsJcDThCJssn/EoJ3S916
 pTP42dCJX6vLfERmu/GZgdJAD9L5DcrpBbnQfgAlD8g7fSeOasYH5eJ4vRo8nEK2Z7aH
 eFdhiqJ2toHd3pEFIg9234As5A6dK0e/1DsQFh3ASUJW0yoqHd/dVokQiZQts1Y2rbab
 lmDBBb18o58LZ5Wvxg/JiioBfM/MXBR+awQU5eqSRL39Rxpm2G9XSGjUTzk6fWzKsRYG
 jE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prBUWmsUsaG8CSdjJVtMXBT94MO72/n2qXYoPW7K5C8=;
 b=KH5tLkkD9Amp/b7a0ty6N9x4G91VmKi5YA5kDuY/zU4FBHImchrZD6m30EizHYKL/a
 N18vq8E2PzkY7PXoEOH3hh4WT8ce7d9x7JmQmcASHOYjRTGPEG8iPxbAcrhx3G/cLjiR
 mj2pE6vH+Tx9f6J+rMsS24108JjhgKoqz+Qn07Wivk6C2FZbmEEckY/aEAUGPE1blhLZ
 wF0UtaKgrRO2SNSKxJvmwRWxvmOfBfihLkBUHs8xBFbtMzF939Br49ynB8lCxgBtfqNj
 UnsWSMJPJ0Ym5YlVhbSemC1gd83bWyFpujaV7CA10ZdHzOuZeb0vNojPGOQdpvvRsF+y
 nwHg==
X-Gm-Message-State: AO0yUKXVqgfbZhSVA+hiKI68GLiUPhvpeVWCSyQ2Hl/rmdkn8wACCCQY
 vQAw8opyZc0tnHhQqqbivqGTxK28WVc=
X-Google-Smtp-Source: AK7set9rtpVvouHM0RIbcGCJloXVOgFwgzT2n/oXdC5pG2QxW7eQy3e2oubVx9mueJYBsliSqd3+0w==
X-Received: by 2002:a17:907:990b:b0:87b:dac1:bbe6 with SMTP id
 ka11-20020a170907990b00b0087bdac1bbe6mr3127915ejc.36.1675267574570; 
 Wed, 01 Feb 2023 08:06:14 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:b4eb:d58:8989:1340?
 ([2a02:908:1256:79a0:b4eb:d58:8989:1340])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a170906525100b0088c804c4ae2sm2512904ejm.201.2023.02.01.08.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Feb 2023 08:06:13 -0800 (PST)
Message-ID: <087a0514-52ad-35a0-63d5-9d5a1f34ed9e@gmail.com>
Date: Wed, 1 Feb 2023 17:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] drm/amdgpu: add force_sg_display module parameter (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230127175128.2570382-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230127175128.2570382-1-alexander.deucher@amd.com>
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

Am 27.01.23 um 18:51 schrieb Alex Deucher:
> Add a module parameter to force sg (scatter/gather) display
> on APUs.  Normally we allow displays in both VRAM and GTT,
> but this option forces displays into GTT so we can explicitly
> test more scenarios with GTT.

I'm still absolutely not keen to add module parameters for internal testing.

Even with tainting the kernel this is not something we should allow end 
users to do.

Christian.

>
> v2: fix checks
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> For reference since the original patch was buggy.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  3 +++
>   3 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 872450a3a164..73d0a0807138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
>   #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>   extern int amdgpu_vcnfw_log;
>   
> +extern int amdgpu_force_sg_display;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4cf2028b5235..c8975c2da853 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -943,6 +943,18 @@ MODULE_PARM_DESC(smu_pptable_id,
>   	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>   module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>   
> +/**
> + * DOC: force_sg_display (int)
> + * Force display buffers into GTT (scatter/gather) memory for APUs.
> + * This is used to force GTT only for displays rather than displaying from
> + * either VRAM (carve out) or GTT.
> + *
> + * Defaults to 0, or disabled.
> + */
> +int amdgpu_force_sg_display;
> +MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
> +module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 981010de0a28..840190dd78e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1516,6 +1516,9 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   	}
> +	if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
> +	    amdgpu_force_sg_display && adev->mode_info.gpu_vm_support)
> +		domain = AMDGPU_GEM_DOMAIN_GTT;
>   	return domain;
>   }
>   

