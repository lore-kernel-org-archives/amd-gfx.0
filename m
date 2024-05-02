Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88278C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB01D10E282;
	Thu,  2 May 2024 15:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="io1hL950";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333AD1123B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:22:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so75264265e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714663346; x=1715268146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HlA3a1Bp4pbaJQNeOD2CYLd7CaiKBIPVm9mY3HEnKeg=;
 b=io1hL950tuOylfClMXRRvczgl5KMH2qyBwkZV6gNIeh46pweI8T7RanfPnVYw79vqh
 tganC9GSbdbYVKKLPzlEvFT0D+HkYdbiaWZajSjx8dfXzToZFGYX/T8T/SE0leUPq9fU
 z3rgrmj7Cekbwfeg/pAu05zQTFqH87DLKKrz7kwTkFjp1vTWS5ghSD8VGXDdfL84OPVt
 r7SmHzkIfTG97MXFr3hXwJQ3Jp1IiYsGA2qVeDcR+7X6lRbMsx3OjTwv+JjxydfSd/KD
 XixV515I5FEU8mouxpKfRsarIdzpHurzc6/MJAPxVOPSuhDOGU6z6K3qXtkq0ywu2eHc
 7u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663346; x=1715268146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HlA3a1Bp4pbaJQNeOD2CYLd7CaiKBIPVm9mY3HEnKeg=;
 b=ZIj5JsgSYJs3JKgtUho+dukBZwEreY0pbgsCXmqtymT6sZJSaJudUwlIlxmtersDlM
 bW+8b2zjR7djewC8z0z4Pvx+4MzAqYcGN3VHUM1LMFGcA2XtIC3TN5P1QiawAKG2thCJ
 MPh+Adasz2uIlc49E5eunpmjf+I9uxL9DCN5rVqDFqFqovgvWogQi5W1F92yaF1B4qua
 XrFIaM8QlLXaBcCUn8jMTMaBltXZY0hIkO9OhP1sa88JGxwzlL/L5OKMGg3hnclf1B9V
 +Z7x2gsL+cJnNBslXFbsBXRVUU5pXeSg/5YAvlNtvCMk9WTQgZ01d5ibgxNBNJqcJ0Xq
 N24w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0eqXf4z/wOhE9XKFhIzCjT+b+6tL+6p8oU4nTM9N9MusGs1+MQ0zY8aG9rsjk+wV9gW34xd5+zo05HqDA0kf1TBWm6xkdRxBpooi5Zg==
X-Gm-Message-State: AOJu0Yy/WEzIWsXY3rD7jhaIqm6dzCIHIz/gIcHdvWpKQOAgO3Vmhmvm
 b0eK73Ll71zoGbjqQhDEQqbL1mIdJ0bCn0KadDn1fsHhxSnTLg0RK9+NB//1
X-Google-Smtp-Source: AGHT+IEYAefCVaRSUOZpNeu7HMZy4zfeNZu3AF139lFxfIJJT1BWGb6qbaAQoDaHD8+GyIYpDwoKeQ==
X-Received: by 2002:a05:600c:4fcb:b0:415:540e:74e3 with SMTP id
 o11-20020a05600c4fcb00b00415540e74e3mr33668wmq.40.1714663346376; 
 Thu, 02 May 2024 08:22:26 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a5d6303000000b00347eb354b30sm1486387wru.84.2024.05.02.08.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:22:25 -0700 (PDT)
Message-ID: <9fec4ce7-6814-4abd-a14f-5f4b9034f204@gmail.com>
Date: Thu, 2 May 2024 17:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/14] drm/amdgpu: add kernel config for gfx-userqueue
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-15-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426134810.1250-15-shashank.sharma@amd.com>
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



Am 26.04.24 um 15:48 schrieb Shashank Sharma:
> This patch:
> - adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
> - moves the usequeue initialization code for all IPs under
>    this flag
>
> so that the userqueue works only when the config is enabled.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/Makefile    | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>   4 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 22d88f8ef527..bba963527d22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
>   	  Add -Werror to the build flags for amdgpu.ko.
>   	  Only enable this if you are warning code for amdgpu.ko.
>   
> +config DRM_AMDGPU_USERQ_GFX
> +	bool "Enable Navi 3x gfx usermode queues"
> +	depends on DRM_AMDGPU
> +	default n
> +	help
> +	  Choose this option to enable usermode queue support for GFX
> +          workload submission. This feature is supported on Navi 3X only.

When this is for Navi 3x only I would name that DRM_AMDGPU_NAVI3X_USERQ 
instead.

And since we enable/disable GFX, Compute and SDMA I would drop "gfx" 
from the comment and description.

Apart from that the approach looks good to me.

Christian.

> +
>   source "drivers/gpu/drm/amd/acp/Kconfig"
>   source "drivers/gpu/drm/amd/display/Kconfig"
>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index a640bfa468ad..0b17fc1740a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -184,8 +184,12 @@ amdgpu-y += \
>   amdgpu-y += \
>   	amdgpu_mes.o \
>   	mes_v10_1.o \
> -	mes_v11_0.o \
> -	mes_v11_0_userqueue.o
> +	mes_v11_0.o
> +
> +# add GFX userqueue support
> +ifneq ($(CONFIG_DRM_AMD_USERQ_GFX),)
> +amdgpu-y += mes_v11_0_userqueue.o
> +endif
>   
>   # add UVD block
>   amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 27b86f7fe949..8591aed9f9ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1349,8 +1349,10 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 2;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
> +#endif
>   		break;
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):
> @@ -1362,8 +1364,10 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 1;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
> +#endif
>   		break;
>   	default:
>   		adev->gfx.me.num_me = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 90354a70c807..084059c95db6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1267,7 +1267,10 @@ static int sdma_v6_0_sw_init(void *handle)
>   		return -EINVAL;
>   	}
>   
> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>   	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
> +#endif
> +
>   	return r;
>   }
>   

