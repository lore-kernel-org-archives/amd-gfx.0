Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE818C47DDF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFA010FB79;
	Fri, 26 Jan 2024 15:43:28 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605D410FB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:43:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-40ee705e9bfso5817275e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706283745; x=1706888545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7ivn/vqbEjk7Npo9DY1yD+4LrcCbmIkQnwOJizKz38=;
 b=LxyK7gOUkCPWAnUHMWsCvoYFfVq4jRXR6cXL2O9MIBYNuZVOIjotRV9mPSY6SyouHd
 kpFj+BSWKHktBq1C5YBC2HPXRcj80kysuWN/pQcNa/ggHxpYSm/JLsEGbzeEUZJKyCHi
 2uMZh42R4bZ6QH/ISdruXWtzjbBUp/wibBwyzO3p9vPEaivLh15dxzZAVfQKvqVT+f3A
 aPtvBREODvBdu9VuVwwzNCSnV7Ukmt90x5ei2e5VloLwn7O9IP5LSLSSJI+xeLT3xNva
 062yOdw6IHElD8VCJL84evKtnrH/wbfa51oG/txY0aX/ONpt4WRdJmiMbJ5Y/IJX4lOj
 kSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706283745; x=1706888545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7ivn/vqbEjk7Npo9DY1yD+4LrcCbmIkQnwOJizKz38=;
 b=mENyF1E7PbuRrQqsiUEG0hAQ+bRAgZza9MvV5b3MO7eLvyNwABVQJv8YzgTCdqo1n2
 kYIJdr1tzpPd/92fxSXfFM7THcHj/DW3BrOprj5VC/7csQxDtxfHIEwDJ2zV7ppcNO7e
 LwhLur1y/7OGuAn9mioifVgj+9/KKXPZqFl9DezKK6jfMr/RYVH631sBwigdvIIKwfAt
 L0P88PXwsEoN7xIE3kmfxkuvv0vO/V+mNr/xiTQkobGZ3xTvRLeYdw5MvjDLThte275i
 DxqG0R5eI0F4o94K9mEt5qd7zsxL7UieMkzXFVLAzXqsjc3pMTk9gpbSuCyIhSKTRezE
 WQTw==
X-Gm-Message-State: AOJu0YwF9T3t2/P2mhcHS7DdjiZvErIqr/2yqFmbrSdMwAbkhtWTFZoS
 12Cnbep62n3Mvm0ncuz5dM2VjRvI7AuMZ02ofcyPl5B3sbFhOPmR
X-Google-Smtp-Source: AGHT+IG0X3EuEpDPTBqKmSr0sdMol8GSzPwIdjc9o9yXcADFXHXMjj01ihPW7nJtFy/Uv8/m//fRrA==
X-Received: by 2002:a05:600c:4511:b0:40e:696a:f024 with SMTP id
 t17-20020a05600c451100b0040e696af024mr1062217wmo.3.1706283745470; 
 Fri, 26 Jan 2024 07:42:25 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600c450500b0040e9d507424sm2219183wmo.5.2024.01.26.07.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:42:23 -0800 (PST)
Message-ID: <b2ce3b80-36d0-4775-a36e-4fe1fff1b09a@gmail.com>
Date: Fri, 26 Jan 2024 16:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: move the drm client creation behind drm
 device registration
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125061831.28290-1-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240125061831.28290-1-le.ma@amd.com>
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.01.24 um 07:18 schrieb Le Ma:
> This patch is to eliminate interrupt warning below:
>
>    "[drm] Fence fallback timer expired on ring sdma0.0".
>
> An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
> introduced by patch below:
>
>    - drm/amdkfd: Export DMABufs from KFD using GEM handles
>
> And re-locating the drm client creation following after drm_dev_register
> looks like a more proper flow.

In generally sounds like a good idea to me, question is if we shouldn't 
generally call amdgpu_amdkfd_device_init() a bit later now.

The KFD device can't work without the DRM render nodes any more, so 
enabling it to early could cause trouble in userspace as well.

Regards,
Christian.

>
> Change-Id: I0fece177b78345187068f92a823d96b3b7581140
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
>   3 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index add315644773..69eb0f5574d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -139,14 +139,13 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>   }
>   
> -static const struct drm_client_funcs kfd_client_funcs = {
> +const struct drm_client_funcs kfd_client_funcs = {
>   	.unregister	= drm_client_release,
>   };
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   {
>   	int i;
>   	int last_valid_bit;
> -	int ret;
>   
>   	amdgpu_amdkfd_gpuvm_init_mem_limits();
>   
> @@ -165,12 +164,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   			.enable_mes = adev->enable_mes,
>   		};
>   
> -		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
> -		if (ret) {
> -			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
> -			return;
> -		}
> -
>   		/* this is going to have a few of the MSBs set that we need to
>   		 * clear
>   		 */
> @@ -209,10 +202,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   
>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>   							&gpu_resources);
> -		if (adev->kfd.init_complete)
> -			drm_client_register(&adev->kfd.client);
> -		else
> -			drm_client_release(&adev->kfd.client);
>   
>   		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 00eed8c10cd4..b2c6f2b3c0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -40,6 +40,8 @@
>   
>   extern uint64_t amdgpu_amdkfd_total_mem_size;
>   
> +extern const struct drm_client_funcs kfd_client_funcs;
> +
>   enum TLB_FLUSH_TYPE {
>   	TLB_FLUSH_LEGACY = 0,
>   	TLB_FLUSH_LIGHTWEIGHT,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0d0aa4b798ac..d0b98343481d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2293,6 +2293,17 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>   	}
>   
> +	if (adev->kfd.init_complete) {
> +		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
> +				      &kfd_client_funcs);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to init DRM client: %d\n",
> +				ret);
> +			goto err_pci;
> +		}
> +		drm_client_register(&adev->kfd.client);
> +	}
> +
>   	ret = amdgpu_debugfs_init(adev);
>   	if (ret)
>   		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);

