Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA623C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 09:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A25610EC80;
	Fri, 28 Apr 2023 09:03:27 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AC710EC80
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 09:03:24 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-94f4b911570so1510332966b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682672602; x=1685264602;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXznEczBFAhV0Es1kqE79IgGl9GN8m3JsEb3YKv7jRc=;
 b=e6dUR3lgD1YZ0vkqlF/uwadQspuDJ2zQbtd9uVMYAQXKn+AVucjFdt9PDMSyw7OwiX
 Ng9zHwRe+h3xEHb04/tc/BpMMOGfbBgs0PxlhMnPqp/tvuvcE9HNOzYJbfZl2Th8b2Va
 w9SwbljbB4QxdbXMqv17Wcazolr2aK8r8D9GEC5PEHkG4yndY6USUF5rKacF4GnykEbI
 idsUE3NHsCfz/ZJOLqRvNBBuL8BGC+IB5J+gGK1eCT4o24iA8ZD/IoS5XT8fEDGibFsp
 mEXEJ/3vSjg93ZZSk62Cm/+IL417UC4VXeKLBIgTiXfgaRVLAT4IZJSTZlN0JqlcSIEr
 hCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682672602; x=1685264602;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXznEczBFAhV0Es1kqE79IgGl9GN8m3JsEb3YKv7jRc=;
 b=ZW/c/Tba2kedphutSfjf8pGYwoQaXJq4FcmCUXGqb+LVAPFqaoa/rfQ+yThpNYzKDt
 vcuwBczq1efvnHhVY2td2eBRXoGURJFUmiGDz/Proatq69ybc9iG/qbVYmHAnLWV6Vf6
 X8y+z+jjLmk2vnlS8E6ybUW1XgUcsaxifQYqjgFGY4RwQFOtSnU/LrD7lVNpjkQI4k7v
 KGILrOLnV2+b9Hrq7+BzGMCqPRQUtU81iyvQxXSdpX9g04CTXVsuuovwL4rwmnmcqCsf
 wWDRzVVcIEzxlsHY9vEthveFoKXAoB2Ta7+VgbOM9mV+adEbs2eQe7YdKl+rCBkDlkTi
 XykQ==
X-Gm-Message-State: AC+VfDzXMV58N7pshETMMJdQRUP+BO9+3koCIZpPPhmwvN80Gej9BZeo
 EcIDUGq/SEDXUnnGlt0LpK8rv+Div+Q=
X-Google-Smtp-Source: ACHHUZ66nQCxDVg0xMZMASguHGJaZwPbZ0sOJMeerOzoMh152B19la6Feb4gLTOruTYz5APzKHSSjA==
X-Received: by 2002:a17:907:1c24:b0:94f:3338:12a2 with SMTP id
 nc36-20020a1709071c2400b0094f333812a2mr4136985ejc.33.1682672602640; 
 Fri, 28 Apr 2023 02:03:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a170906705400b0094f05fee9d3sm10954712ejj.211.2023.04.28.02.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 02:03:22 -0700 (PDT)
Message-ID: <ad808403-99ac-85e7-769d-d24eb835ab19@gmail.com>
Date: Fri, 28 Apr 2023 11:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 12/12] drm/amdgpu: put MQDs in VRAM
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427152709.7612-1-alexander.deucher@amd.com>
 <20230427152709.7612-12-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230427152709.7612-12-alexander.deucher@amd.com>
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

Am 27.04.23 um 17:27 schrieb Alex Deucher:
> Reduces preemption latency.
>
> v2: move MES MQDs into VRAM as well (YuBiao)
> v3: enable on gfx10, 11 only (Alex)

The why we do that not for gfx9 is missing.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
>   3 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 0560568b3925..92c5f0ce8bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -382,6 +382,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   	int r, i;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
> +	u32 domain_vram = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) ?
> +		AMDGPU_GEM_DOMAIN_VRAM : 0;

Maybe cleaner to do something like:

     domain = AMDGPU_GEM_DOMAIN_GTT;
     if (...)
         domain |= AMDGPU_GEM_DOMAIN_VRAM;

Christian.

>   
>   	/* create MQD for KIQ */
>   	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> @@ -413,6 +415,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   			ring = &adev->gfx.gfx_ring[i];
>   			if (!ring->mqd_obj) {
>   				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +							    domain_vram |
>   							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>   							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
>   				if (r) {
> @@ -434,6 +437,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
>   		if (!ring->mqd_obj) {
>   			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +						    domain_vram |
>   						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>   						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
>   			if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 0599f8a6813e..4560476c7c31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
>   		return 0;
>   
>   	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM |
>   				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>   				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e853bcb892fc..3adb450eec07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
>   		return 0;
>   
>   	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM |
>   				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>   				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
>   	if (r) {

