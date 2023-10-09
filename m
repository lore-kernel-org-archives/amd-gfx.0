Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D3E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 08:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE70610E22C;
	Mon,  9 Oct 2023 08:44:52 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A359C10E22C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 08:44:49 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5362bcc7026so7506123a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696841088; x=1697445888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BX/zmXsukG29xnQSR9B0oKJIYsPA/ObsxX/z1vh64KQ=;
 b=OEGGRvByp6m5Um9sl7cUtvTTvTjBnoqeeJGMNTBAtCWWEyo4sxx7oh0qd9oCKelIiS
 z+lk2RVej+cHFIIVGYIuqzCbYum5hsoaG+rfVJuG+L8OtpsEhhDpTGEB/AThFfIAJjI9
 oL94qgKOQoLpuYn0ihZKu6nGP8W+9QkjNk1WHyrcHi1BwcVr31AlGC1o1xjkWNqu9SM9
 6VSRooUflPbjpmMoP2lFM3jQ4jHXZPeCQVFpP4sx4XLj1dedhRFo6JtWVy3hp0jhQleU
 b6jDfpQfpZ+SF1qtCdNi0R/DLyOWapo3BC0zCnEPlcA6BPz1cK95H4sj4ktWGTAZAS6p
 49tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696841088; x=1697445888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BX/zmXsukG29xnQSR9B0oKJIYsPA/ObsxX/z1vh64KQ=;
 b=u6+udWwhuHF0FUkKqplJyoBYdO+DK+sL/lpWSfdX2VG1ZutPXVNPOeS35uLqPPX8Kj
 Ys8PfQDHuQe1zdDkK1+0h3AjR+FQBrqHpdqK2G/tupEVYbF3GcbjpUsH+q5Dboa8cJir
 gSLYJG/PwnpZvF+ZJwtwH2gHqGyNphTF3YVzC1WMaQxGIxmFpKwgE74jwkp69d2fo0A/
 vCpTz5waSN2ogtzXvUG9/oxWYmSwuNYo48U9MX+fO/4YccDDjFRhJEkMwfWOHuCrr/zk
 Mcdy1wR4jq3JU0b03d2aUdboaNodSXqX/w4cQZYGcAJUtgz6jl4b4eF+5MLDAy6Jt+zr
 k7Iw==
X-Gm-Message-State: AOJu0YwG99DRL00gZb9yMXbjCFMImsEd694V1iDaLR+wUvHl4/kpDDL2
 91GR1wwN6urnzGsHzabLcfk=
X-Google-Smtp-Source: AGHT+IEqDKb4HRtZxZsDtu5W+2z42SiJNpGdTNUkysmwQtgtPeVtFaQtyIHbvgEelFrHF2SaoSsuVg==
X-Received: by 2002:a17:906:308b:b0:9b6:550c:71cb with SMTP id
 11-20020a170906308b00b009b6550c71cbmr12378269ejv.52.1696841087939; 
 Mon, 09 Oct 2023 01:44:47 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.31.182])
 by smtp.gmail.com with ESMTPSA id
 gr13-20020a170906e2cd00b009ad7fc17b2asm6466512ejb.224.2023.10.09.01.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:44:47 -0700 (PDT)
Message-ID: <45c6ae57-85fa-461a-b314-f2c99bf433f1@gmail.com>
Date: Mon, 9 Oct 2023 10:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] drm/amd: Evict resources during PM ops prepare()
 callback
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-2-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231006185026.5536-2-mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 20:50 schrieb Mario Limonciello:
> Linux PM core has a prepare() callback run before suspend.
>
> If the system is under high memory pressure, the resources may need
> to be evicted into swap instead.  If the storage backing for swap
> is offlined during the suspend() step then such a call may fail.
>
> So move this step into prepare() to move evict majority of
> resources and update all non-pmops callers to call the same callback.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one.

> ---
> v4->v5:
>   * Call amdgpu_device_prepare() from other callers to amdgpu_device_suspend()
>   * 3x evict calls -> 2x evict calls
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 ++++---
>   3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4cc78e0e4304..fdb2e9ae13e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1409,6 +1409,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   void amdgpu_driver_release_kms(struct drm_device *dev);
>   
>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
> +int amdgpu_device_prepare(struct drm_device *dev);
>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0cb702c3046a..cb334dc57c59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1760,6 +1760,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>   	} else {
>   		pr_info("switched off\n");
>   		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> +		amdgpu_device_prepare(dev);
>   		amdgpu_device_suspend(dev, true);
>   		amdgpu_device_cache_pci_state(pdev);
>   		/* Shut down the device */
> @@ -4335,6 +4336,31 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   /*
>    * Suspend & resume.
>    */
> +/**
> + * amdgpu_device_prepare - prepare for device suspend
> + *
> + * @dev: drm dev pointer
> + *
> + * Prepare to put the hw in the suspend state (all asics).
> + * Returns 0 for success or an error on failure.
> + * Called at driver suspend.
> + */
> +int amdgpu_device_prepare(struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> +		return 0;
> +
> +	/* Evict the majority of BOs before starting suspend sequence */
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_device_suspend - initiate device suspend
>    *
> @@ -4355,11 +4381,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	adev->in_suspend = true;
>   
> -	/* Evict the majority of BOs before grabbing the full access */
> -	r = amdgpu_device_evict_resources(adev);
> -	if (r)
> -		return r;
> -
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_fini_data_exchange(adev);
>   		r = amdgpu_virt_request_full_gpu(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 81affdf7c0c3..420196a17e22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2427,8 +2427,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>   	/* Return a positive number here so
>   	 * DPM_FLAG_SMART_SUSPEND works properly
>   	 */
> -	if (amdgpu_device_supports_boco(drm_dev))
> -		return pm_runtime_suspended(dev);
> +	if (amdgpu_device_supports_boco(drm_dev) &&
> +	    pm_runtime_suspended(dev))
> +		return 1;
>   
>   	/* if we will not support s3 or s2i for the device
>   	 *  then skip suspend
> @@ -2437,7 +2438,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>   	    !amdgpu_acpi_is_s3_active(adev))
>   		return 1;
>   
> -	return 0;
> +	return amdgpu_device_prepare(drm_dev);
>   }
>   
>   static void amdgpu_pmops_complete(struct device *dev)
> @@ -2637,6 +2638,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	if (amdgpu_device_supports_boco(drm_dev))
>   		adev->mp1_state = PP_MP1_STATE_UNLOAD;
>   
> +	ret = amdgpu_device_prepare(drm_dev);
> +	if (ret)
> +		return ret;
>   	ret = amdgpu_device_suspend(drm_dev, false);
>   	if (ret) {
>   		adev->in_runpm = false;

