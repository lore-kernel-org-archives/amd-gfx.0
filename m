Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF929C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 08:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A40010E3B2;
	Fri, 28 Apr 2023 08:59:17 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC5210E3B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 08:59:15 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-957dbae98b4so1204815966b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682672354; x=1685264354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p3LCPqTG9uiEWpBbpC/oNZ2Dc+BVoGTnqa12vtaOSwA=;
 b=lzNJv5smR8LyX8XQWGTbejoJtbT9n4RgHralhmZLyB20Wvt1PVK6pKrDS+asHd7yMi
 LKbGyAKn3HKNVSe1QPbEUZxMFyyL/ScmO9cCtDP8FTst3X/M8e19opiW2U8+uFxTuEWb
 ZE3h0cPypaDbxvaL0WZnTowm5lPh9HLEK+/jkY0Vw60C1Q7hEc52jzO4qdOCAQfI3HZW
 TrGFSmFN5ocVfEcs/bekNkIPwygZttPxu80F1h5v77ATpDeND8HUH9teLYR1L8f2xgaj
 /XgkjglqQ248oSEu0AkeRgmq4g77gE5F7ZYEmqhXpKHnczJ2vuS+ERDGOmfOdzH9XwoY
 B3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682672354; x=1685264354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3LCPqTG9uiEWpBbpC/oNZ2Dc+BVoGTnqa12vtaOSwA=;
 b=OBtaFlP2GEayc8S6Z2lkgtwNtw6EGVtqvvNp7GxaWM9QefUSVDzNsbZzIy6ZjBpuHF
 9HvPYh1tMJdtKJrJgLS0mOJun2IP2Bp82bRSnlvHlABSQkl0tb9peSDR1D8zrAPaaEC/
 JY36to+kRW2Vdyco2G5vr0F7+EkzHwdUT/23GTZl1/SV7CA2wZLfsabfI6Vrw8kwcQr6
 peEmH2/V6F+iyVLOCEuAYnlnhg3+7xIaPhwoh5yLbuWDU0WV4xsTWBOpSGzo2i4+oKLh
 SG2EdVnqoj0YuFlT+gRozS5DOpe0Ug0am7BJoSviDhhAP+5SDKcZN7/RpElA3fE4XwKB
 YEgw==
X-Gm-Message-State: AC+VfDywA6rHwSPpU9ckwBelRr3uFHJkRXV74I8kWzPqxP+9JGnaobai
 VOBOFv38EzUnqEjkCQd0n28=
X-Google-Smtp-Source: ACHHUZ77xbT3RwvQ5iJmVXvxzP3ehYYWbaE/NYXjLt2mW/OBN4BuRRP+dvmhLaFIuNYgszobmLAQ6Q==
X-Received: by 2002:a17:907:16a9:b0:94f:31ee:ba36 with SMTP id
 hc41-20020a17090716a900b0094f31eeba36mr4672479ejc.37.1682672354073; 
 Fri, 28 Apr 2023 01:59:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 g25-20020a170906349900b0095336e8e012sm11033478ejb.176.2023.04.28.01.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 01:59:13 -0700 (PDT)
Message-ID: <7b8df33f-360a-8f75-1486-66df2933aa36@gmail.com>
Date: Fri, 28 Apr 2023 10:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/12] drm/amdgpu/gfx10: drop unused variable
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427152709.7612-1-alexander.deucher@amd.com>
 <20230427152709.7612-6-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230427152709.7612-6-alexander.deucher@amd.com>
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
> Just check the return value directly.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 24d7134228b0..5c67c91c4297 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7159,15 +7159,13 @@ static int gfx_v10_0_hw_init(void *handle)
>   static int gfx_v10_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int r;
>   
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>   
>   	if (!adev->no_hw_access) {
>   		if (amdgpu_async_gfx_ring) {
> -			r = amdgpu_gfx_disable_kgq(adev, 0);
> -			if (r)
> +			if (amdgpu_gfx_disable_kgq(adev, 0))
>   				DRM_ERROR("KGQ disable failed\n");
>   		}
>   

