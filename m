Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C7C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 08:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6879210E3CB;
	Fri, 28 Apr 2023 08:59:45 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A134910E3CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 08:59:43 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-953343581a4so1468661566b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682672381; x=1685264381;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSqWTohsvaMOgz8rdFgyAAwEa3h3CCb9UaPX8DLTFAE=;
 b=pIyw/VJsA8+F5ArLeMKFLkWPZccFBWi3092RR13MQwh15FsDP9g0EH2dBX+KaTf1g8
 +BZ50BuhKZZJcrLCab6XfHhuQ4NReXhrlOhxjfEVwakXYK95fbo8wosC6/eicEvr/GQ6
 +vcH+atYpJUL/0XgrUIpC/5PJemvK+ns8JovMZL9qjWhZLGx1HsWi1kdGHy6DV2FJ0YA
 iUA6kPsyCa6HoO+xHu8VhB7D/7xGk1aord34EPWj/TN/qatnnYEwxaYcCudWg15IdFF5
 o88vBeTA/mXmWy34oqgRiPDvtVuy4w17Sv0iMEbb/o+bzT8zPa2DWDbR2JcG7Yvq5FX5
 5EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682672381; x=1685264381;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSqWTohsvaMOgz8rdFgyAAwEa3h3CCb9UaPX8DLTFAE=;
 b=CwVx0X534loJdDmZyp2YnCZhXd+AC5VteweBB8Y20XSXzB8BL13FzQpK/+p2qyxGnC
 dSXJbSQPFREQXJsxmQwb5fHh6TsPokoyaIgY4yRGW3mkPbtbuUZzN/931Bm3KW8Onbdx
 VWYxZPrFVWbUu65lM6ND+u2rnMeAniOxu752b/JzbdwhI15JxdV+v0O08jXXGC9LMyvU
 47yZvvFTCojsoHBgErrP0e79VJ2QnHojfYS47JK668tmWLGRvdVBIc+kdpLi+C17OenN
 53ZwT95C5BYTrxywf99aB7ufIaDC/UbdyXPtzfTghdC9IwinzovBrfahBU8HulYSPnrq
 qVMQ==
X-Gm-Message-State: AC+VfDw6yj6f6p3OymBFzHyLg55vMfZqPI+dGfa++iyk/9gSk2IUbLAw
 99+g9HWz+rjL02YS2Gvbj4PO3IsC0i4=
X-Google-Smtp-Source: ACHHUZ56+2kZqu1DUxpRvaOJttaQ98otKYbrNsYrMYDIb/kWmP3OauP7iw7o4LdJDWqWN41vNQcyhg==
X-Received: by 2002:a17:907:3f28:b0:932:ac6c:7ef9 with SMTP id
 hq40-20020a1709073f2800b00932ac6c7ef9mr4795062ejc.22.1682672381485; 
 Fri, 28 Apr 2023 01:59:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a17090676ce00b00932ba722482sm11093000ejn.149.2023.04.28.01.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 01:59:41 -0700 (PDT)
Message-ID: <91203b9f-c558-21fb-7099-8ec1c46661a2@gmail.com>
Date: Fri, 28 Apr 2023 10:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/12] drm/amdgpu/gfx11: drop unused variable
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427152709.7612-1-alexander.deucher@amd.com>
 <20230427152709.7612-7-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230427152709.7612-7-alexander.deucher@amd.com>
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
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d36d365cb582..256014a8c824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4373,7 +4373,6 @@ static int gfx_v11_0_hw_init(void *handle)
>   static int gfx_v11_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int r;
>   
>   	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> @@ -4381,8 +4380,7 @@ static int gfx_v11_0_hw_fini(void *handle)
>   
>   	if (!adev->no_hw_access) {
>   		if (amdgpu_async_gfx_ring) {
> -			r = amdgpu_gfx_disable_kgq(adev, 0);
> -			if (r)
> +			if (amdgpu_gfx_disable_kgq(adev, 0))
>   				DRM_ERROR("KGQ disable failed\n");
>   		}
>   

