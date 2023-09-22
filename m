Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0204ECD4F4A
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 10:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717F410E645;
	Fri, 22 Sep 2023 10:07:40 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A310E645
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 10:07:38 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso19915485e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695377257; x=1695982057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5k+2OHl4etuBq9jB6NuTe/piCYR16YyALB4YVX+e+I=;
 b=AyOogIORlvGojdbo7kFRwOeNhX/2Lyl9i1BDRuqMPmfW+UiwlaL73fr+BofofuKh/l
 KRmc/k1fAZp9A9WUE3iNc1BoyLta0myYFcOFBBGullf/TKGsaK8TUXnxZx9F2NG18kdm
 5P79GJ0UQdsLb04157tCXK0MH42SveDVmwmw21YO+7A3x2eT3KbLA+/W+TEfuVb2vmrm
 ieRvc/4ETM6OhcOcavXvBb72lkutTU81Wdu+2oBMlcI0MV0eRssXoG7QLkowo94NstlT
 UvC2Flti4O+AN/I7w74Y2WMaIT7lnw7eedb3wkAP78WiE5ON9hEyY3LWuYWbca1eSiS4
 qmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695377257; x=1695982057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5k+2OHl4etuBq9jB6NuTe/piCYR16YyALB4YVX+e+I=;
 b=dGB4MkAPaOiUPhFgzWc4z30OJYd0MOEKgXlAZsldM37v9aOcoAD9GikhVrnEGWQosw
 f3ujlQAlGHY8T2HZHTbN9XUsR+G66bzFUYMFjhh3oaI7gVpTMa42NksjBZcBtJuQYfun
 XgjC6LivkFMaq3eoxAsTyT6D1SK4toO0PrOLaywYWZCZAqow66mMyJrh3PcL3Ms6PRUU
 5CbbEwqZsgwHiF4jDzMd2MjxvCc5x4rMk70Wi4AMA8VnODT1VBa2E6wuOsN1lsMoL3SM
 MZyyVB5voPtYAibYNa8Xn6HCY16VfRLluLesdkf8SD4qB2w0sdB4Qz03oINKWTHg0lob
 qQyg==
X-Gm-Message-State: AOJu0YxYvUGaXJyKNbFX226JRU60LTKNMGgW9NoI4wTPxEADoW+PvPdO
 THtRXDO3te+DWQRt3893c2w=
X-Google-Smtp-Source: AGHT+IGRH+HB+DW6M+3RVa7VYlZ+NEAJizp1L9QSy4HuNXgpKAmHhd2rSYD8BQYJtlHLE2oVGWSwuA==
X-Received: by 2002:a7b:ca4f:0:b0:402:ea6a:c955 with SMTP id
 m15-20020a7bca4f000000b00402ea6ac955mr7917402wml.8.1695377256925; 
 Fri, 22 Sep 2023 03:07:36 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c248900b003fed78b03b4sm4185930wms.20.2023.09.22.03.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:07:35 -0700 (PDT)
Message-ID: <218346d2-a9c1-75bd-0666-4dce1a936197@gmail.com>
Date: Fri, 22 Sep 2023 12:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc6-8: properly disable the AGP aperture
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230921141300.415876-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230921141300.415876-1-alexander.deucher@amd.com>
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
Cc: Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.23 um 16:12 schrieb Alex Deucher:
> The BOT register needs to be larger than the TOP register
> for this to be properly disabled.  The lower 22 bits
> of the BOT address are always 0 and the lower 22 bits of
> the TOP register are always 1 so you need to make
> the upper bits of BOT larger than the upper bits of BOT.
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 5b837a65fad2..07579fa26fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -253,7 +253,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, 0);
>   	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
>   
>   	if (gmc_v6_0_wait_for_idle((void *)adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 6a6929ac2748..e77e5593e1ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -288,7 +288,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, 0);
>   	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
>   	if (gmc_v7_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 5af235202513..6acf649469dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -473,7 +473,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
>   	}
>   
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, 0);
>   	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
>   	if (gmc_v8_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");

