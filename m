Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE39AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 08:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D71A8992E;
	Fri, 10 Nov 2023 08:59:57 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881B48992E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 08:59:55 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso13157655e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 00:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699606794; x=1700211594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t5aLSq9zmoR0J+HcCv77RF7yAFTqogyUJWsjrz4Wmtk=;
 b=LnHRYT9PYVn+pEBym5CL+vKFxTQHU7ZAxnlCWBhXV26fKa3XFBEQvIOgxMArFFDzwx
 Zcxn+OLgVdLVC98yQrVQCAainFaGdgfGfdEif5pfsmruv4vwuwzhpK6PR1iCaiQ49Pvr
 5HpVITyyk0717CsUbsgLt7V+RJwEWonmgla5GRGpzID4d2gvmsmCJk8GWySIuSws6tFp
 6gzoEzoJZvaK9MHHYPtcSWhpdH+mBgazBdlZd3k2Q0rtOqYjM0h9pSyAYqe9fP2i31om
 u7+JFIq8TRdAvy3jr6JHAWS65sQJDDsl8VqQZ2SRikEKJhLy//60ykv8ErwKd92t9Q9K
 uPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699606794; x=1700211594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5aLSq9zmoR0J+HcCv77RF7yAFTqogyUJWsjrz4Wmtk=;
 b=PaKfyZ7RoyA2jzg0ynfPmolygZUL0+6cDPt5rdOmUoUNQQ9ES6DA1Ij4jZBQ0AhU4b
 8u1M6yVj9mcvn5e5+Zdc6is0oy/w6sbdYrML/IFyC5U5dVgBbSoAfKUN+74HWZGRDNVE
 y3qjimyUL98lSWMiD7jr4mo9BeoGpX9Fv/EgtSX/BY0r3buKGZ8NMfAnTCmgmbnxF2Bv
 MJiZe7RfN0uVPwEBUs/QTKbpW5LXkf/teqcTkAoQx5nJmW1impfQ9IlTKLTQOaeuTVjb
 yhHZdI+0ELkeUAGwLE7efnbLUPPtQzE5RJOiP7fhiYPLUPnRlIYqE8QjOrCvL2tTnlYA
 z70w==
X-Gm-Message-State: AOJu0Yz/Ba05aNkth6IlFjpEPt+4nKpyp9aj8BaQZfB8kbtOPxLTmuXI
 ZuMVmsvYeCvqFtN7P8G/boA=
X-Google-Smtp-Source: AGHT+IGBY52nh6AymYPILQIFKHfBo4CNUI+bqHHcjwPumqSlHZ7LQRM4LQdTT72xy5yyrmrt8JfLTw==
X-Received: by 2002:a05:600c:4744:b0:405:4a78:a892 with SMTP id
 w4-20020a05600c474400b004054a78a892mr6292557wmo.9.1699606793660; 
 Fri, 10 Nov 2023 00:59:53 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a7bc013000000b0040a3e417d65sm4467348wmb.0.2023.11.10.00.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 00:59:53 -0800 (PST)
Message-ID: <437a606d-ca04-4b0d-bb5d-e1e863985a54@gmail.com>
Date: Fri, 10 Nov 2023 09:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move UVD and VCE sched entity init after
 sched init
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231108184152.4755-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231108184152.4755-1-alexander.deucher@amd.com>
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
Cc: ltuikov89@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.23 um 19:41 schrieb Alex Deucher:
> We need kernel scheduling entities to deal with handle clean up
> if apps are not cleaned up properly.  With commit 56e449603f0ac5
> ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
> the scheduler entities have to be created after scheduler init, so
> change the ordering to fix this.
>
> v2: Leave logic in UVD and VCE code
>
> Fixes: 56e449603f0ac5 ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: ltuikov89@gmail.com

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 22 ++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 24 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |  4 ----
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |  2 --
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  5 -----
>   13 files changed, 37 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 43a95feba884..03e669c34033 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2499,6 +2499,18 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   				  ring->name);
>   			return r;
>   		}
> +		r = amdgpu_uvd_entity_init(adev, ring);
> +		if (r) {
> +			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
> +				  ring->name);
> +			return r;
> +		}
> +		r = amdgpu_vce_entity_init(adev, ring);
> +		if (r) {
> +			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
> +				  ring->name);
> +			return r;
> +		}
>   	}
>   
>   	amdgpu_xcp_update_partition_sched_list(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 815b7c34ed33..65949cc7abb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -399,20 +399,20 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>    *
>    * @adev: amdgpu_device pointer
>    *
> + * Initialize the entity used for handle management in the kernel driver.
>    */
> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>   {
> -	struct amdgpu_ring *ring;
> -	struct drm_gpu_scheduler *sched;
> -	int r;
> +	if (ring == &adev->uvd.inst[0].ring) {
> +		struct drm_gpu_scheduler *sched = &ring->sched;
> +		int r;
>   
> -	ring = &adev->uvd.inst[0].ring;
> -	sched = &ring->sched;
> -	r = drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIORITY_NORMAL,
> -				  &sched, 1, NULL);
> -	if (r) {
> -		DRM_ERROR("Failed setting up UVD kernel entity.\n");
> -		return r;
> +		r = drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIORITY_NORMAL,
> +					  &sched, 1, NULL);
> +		if (r) {
> +			DRM_ERROR("Failed setting up UVD kernel entity.\n");
> +			return r;
> +		}
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index a9f342537c68..9dfad2f48ef4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -73,7 +73,7 @@ struct amdgpu_uvd {
>   
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>   int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev);
>   int amdgpu_uvd_suspend(struct amdgpu_device *adev);
>   int amdgpu_uvd_resume(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1904edf68407..0954447f689d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -231,20 +231,20 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>    *
>    * @adev: amdgpu_device pointer
>    *
> + * Initialize the entity used for handle management in the kernel driver.
>    */
> -int amdgpu_vce_entity_init(struct amdgpu_device *adev)
> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>   {
> -	struct amdgpu_ring *ring;
> -	struct drm_gpu_scheduler *sched;
> -	int r;
> -
> -	ring = &adev->vce.ring[0];
> -	sched = &ring->sched;
> -	r = drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIORITY_NORMAL,
> -				  &sched, 1, NULL);
> -	if (r != 0) {
> -		DRM_ERROR("Failed setting up VCE run queue.\n");
> -		return r;
> +	if (ring == &adev->vce.ring[0]) {
> +		struct drm_gpu_scheduler *sched = &ring->sched;
> +		int r;
> +
> +		r = drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIORITY_NORMAL,
> +					  &sched, 1, NULL);
> +		if (r != 0) {
> +			DRM_ERROR("Failed setting up VCE run queue.\n");
> +			return r;
> +		}
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index ea680fc9a6c3..6e53f872d084 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -55,7 +55,7 @@ struct amdgpu_vce {
>   
>   int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size);
>   int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_vce_entity_init(struct amdgpu_device *adev);
> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   int amdgpu_vce_suspend(struct amdgpu_device *adev);
>   int amdgpu_vce_resume(struct amdgpu_device *adev);
>   void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 58a8f78c003c..a6006f231c65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -577,8 +577,6 @@ static int uvd_v3_1_sw_init(void *handle)
>   	ptr += ucode_len;
>   	memcpy(&adev->uvd.keyselect, ptr, 4);
>   
> -	r = amdgpu_uvd_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index d3b1e31f5450..1aa09ad7bbe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -127,8 +127,6 @@ static int uvd_v4_2_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_uvd_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 5a8116437abf..f8b229b75435 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -125,8 +125,6 @@ static int uvd_v5_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_uvd_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 74c09230aeb3..a9a6880f44e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -432,8 +432,6 @@ static int uvd_v6_0_sw_init(void *handle)
>   		}
>   	}
>   
> -	r = amdgpu_uvd_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 1c42cf10cc29..6068b784dc69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -480,10 +480,6 @@ static int uvd_v7_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_uvd_entity_init(adev);
> -	if (r)
> -		return r;
> -
>   	r = amdgpu_virt_alloc_mm_table(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 67eb01fef789..a08e7abca423 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -441,8 +441,6 @@ static int vce_v2_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> -	r = amdgpu_vce_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 18f6e62af339..f4760748d349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -450,8 +450,6 @@ static int vce_v3_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> -	r = amdgpu_vce_entity_init(adev);
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index e0b70cd3b697..06d787385ad4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -486,11 +486,6 @@ static int vce_v4_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> -
> -	r = amdgpu_vce_entity_init(adev);
> -	if (r)
> -		return r;
> -
>   	r = amdgpu_virt_alloc_mm_table(adev);
>   	if (r)
>   		return r;

