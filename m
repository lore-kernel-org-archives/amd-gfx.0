Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B64DECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C284410E668;
	Thu, 27 Oct 2022 14:56:55 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA26310E668
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 14:56:52 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id q9so5482082ejd.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ow7RuCSnQ8gGAfAcZaggwMiQpRWBZfVlHUP9X/icI+c=;
 b=JKadrv9F+7S5Qwr5zB3bKrXBtlK/nbEtKPZYCkmVAXnAnhhDf17/rWvU0JIr4VoP8r
 EPZ9mwA6+9xD7Skm8HZN0oOvYG/xBHZt+Av4Ba6vZhigh2XjkQVO/5YPuIrjPrm8eCub
 CazqHkjrLuVu9NUydMzDl+rFjbkjDM9UNIf4Tq939dBKzOcb8JLdFzIF4KOnYipjLNOg
 TK1lgNBNUflXlLXJTMBRQ7BIxDwjdaLIzBp/qqYysxxlEPQr4fIrYwaJz36u++IIY/OX
 Rz2ppWdi3VZAxGp0x0LccRUTXFGPygTUT4C0nTnytp5AjJuQWWvHFNP4IBKWv1yUkmsn
 abgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow7RuCSnQ8gGAfAcZaggwMiQpRWBZfVlHUP9X/icI+c=;
 b=C3ND6iZ+ePzSxnYTsfPsVUDFkzxhOZN5hibR6Fxom3qiLlLcA/qisQOSoeWBY0YE+g
 oMKKpfEkpXwQc1iBbCZZiPWkTh/ZkdTjpisQJ1mgUnMcH1FNBpODj+kc/o1Pca6iex0z
 245kX6COko+b1EKflAmCEfnyozZPmGClyQigcuLnQ4iWggjS+ZOHVgs2nrNdZvl7x1Kz
 wAJH3tpNiWVYHtSRH7Zam3ySbCd1zcNApUbhDswbHdUF2S0w6uj/qlQ+vXVvYK4tFBSU
 hCdjgySsNkFSDTLwyqANe3QWcWyO3jLx+frBKL9tq04FtXtLJ7BHic3lE+SE+lFVjOXi
 yYdg==
X-Gm-Message-State: ACrzQf0DM+cDO/N2/mDmaz+0D12hpyHXvR9gu+YeJT9dZXXYa0zgYSWv
 9vJ5d8Yprp5QKBfHAFkYNzlMXubjn3A=
X-Google-Smtp-Source: AMsMyM6r5+6+tALTEbSHKQsiY53Ek/Uc5Cz5OD8hiOUiLS3tOfDHKPUTKnaqjzZxKvarytrWabh07Q==
X-Received: by 2002:a17:907:9493:b0:796:1166:70c4 with SMTP id
 dm19-20020a170907949300b00796116670c4mr35773786ejc.59.1666882611404; 
 Thu, 27 Oct 2022 07:56:51 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:955d:8a4:c803:d560?
 ([2a02:908:1256:79a0:955d:8a4:c803:d560])
 by smtp.gmail.com with ESMTPSA id
 ce12-20020a170906b24c00b007828150a2f1sm877697ejb.36.2022.10.27.07.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 07:56:50 -0700 (PDT)
Message-ID: <b9b6e6b9-3620-1fb2-568d-d6c03d5e3940@gmail.com>
Date: Thu, 27 Oct 2022 16:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd: Fail the suspend if resources can't be evicted
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221026190355.18166-1-mario.limonciello@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221026190355.18166-1-mario.limonciello@amd.com>
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
Cc: post@davidak.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.22 um 21:03 schrieb Mario Limonciello:
> If a system does not have swap and memory is under 100% usage,
> amdgpu will fail to evict resources.  Currently the suspend
> carries on proceeding to reset the GPU:
>
> ```
> [drm] evicting device resources failed
> [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <vcn_v3_0> failed -12
> [drm] free PSP TMR buffer
> [TTM] Failed allocating page table
> [drm] evicting device resources failed
> amdgpu 0000:03:00.0: amdgpu: MODE1 reset
> amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
> amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
> ```
>
> At this point if the suspend actually succeeded I think that amdgpu
> would have recovered because the GPU would have power cut off and
> restored.  However the kernel fails to continue the suspend from the
> memory pressure and amdgpu fails to run the "resume" from the aborted
> suspend.
>
> ```
> ACPI: PM: Preparing to enter system sleep state S3
> SLUB: Unable to allocate memory on node -1, gfp=0xdc0(GFP_KERNEL|__GFP_ZERO)
>    cache: Acpi-State, object size: 80, buffer size: 80, default order: 0, min order: 0
>    node 0: slabs: 22, objs: 1122, free: 0
> ACPI Error: AE_NO_MEMORY, Could not update object reference count (20210730/utdelete-651)
>
> [drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
> [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp> failed -62
> amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
> amdgpu 0000:03:00.0: PM: failed to resume async: error -62
> ```
>
> To avoid this series of unfortunate events, fail amdgpu's suspend
> when the memory eviction fails.  This will let the system gracefully
> recover and the user can try suspend again when the memory pressure
> is relieved.
>
> Reported-by: post@davidak.de
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f958603c8cc2..ae10acede495e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>    * at suspend time.
>    *
>    */
> -static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
> +static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   {
> +	int ret;
> +
>   	/* No need to evict vram on APUs for suspend to ram or s2idle */
>   	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
> -		return;
> +		return 0;
>   
> -	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
> +	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> +	if (ret)
>   		DRM_WARN("evicting device resources failed\n");
> -
> +	return ret;
>   }
>   
>   /*
> @@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
> -	amdgpu_device_evict_resources(adev);
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
>   
>   	amdgpu_fence_driver_hw_fini(adev);
>   

