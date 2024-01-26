Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEBC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC4B10FB67;
	Fri, 26 Jan 2024 15:22:17 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A095910FB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:22:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-40ee82d040dso3873055e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 07:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706282474; x=1706887274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGf+JqAJYqI9hwx7FlGvUQGBfTntB7665qe3TCwF28Q=;
 b=j1CT4GLE027/M/eprNYw8gDqoXeB++etWxqhk9cTnkZiPDsdrOAD57TuOtUBty7O6L
 HBsypSWdCi/ZOAfmvMbFbv1dYyKchWq3PcWQksUWX6YJaUmsPFt6SLGQUZGaDSGZ5OZ9
 JF5m3tkXTjhtFyDG9/E1OV6sCrjZ3sxbJJNYGofK1wTbJpeo6DU51wye640c5J6D+s7H
 P3p3cMZooApePJPD1njkzdCDyOSLMNsK7mQCRXWJDcNM2puv09pGW2WVqGkXID9CYKQp
 IWR2a+OK5fuifa5BQVPiJgboQf/vJUo6pLmyBX1U9Q7xRHD/v0ejvKAb3WTrWQ8OatpM
 501g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282474; x=1706887274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGf+JqAJYqI9hwx7FlGvUQGBfTntB7665qe3TCwF28Q=;
 b=GMjo3IRPqaQ4VtUichrpPp185Zfwxi3EHoCS2G0hSkSRfaGsi99ZneMZ1VVdeDPBp3
 8k7MPJsu8VBDY3Rv0vf34wBMY/L25kWtNBH0s3/SmXDbzxzzaZPu3EeOJVMx4yf+lady
 pzCtYsnKCcDzNYhUruKYc+AXoom6mH7Eh39GMgM3fAu4Bt+YyxykcJ1fd0pC+2jKSNPi
 OFVs4veBNkTqSw3RkzoYQDnZ3nmKLnTaI1xMwWPfpEiV0K9FMfs3RojbPjGwzRPBK5nx
 q6kXSyNf3KwevP6+/lXVaZ/bl7MuggJSEPRVnum67Zkp4NCoSPzdbZJXGzTIik5IZpfl
 wAuw==
X-Gm-Message-State: AOJu0Yz09te31lwztwJB2CZbqTfV1dSyap5Z+4GkwsEd+lguRg5smqy1
 RQEJ7+vzx2KMZGkDmKEx9YZZusL9NQ5nyqFkyYQIOX8xJPevIXNX
X-Google-Smtp-Source: AGHT+IGUxCMc0Vvg9/c1S5YWTNigpN8VfciV1Ig2KqwYHJ36ArKemLKcwiRe4h4N+WiAF0Nw4MzPOA==
X-Received: by 2002:a7b:c303:0:b0:40e:52f4:81bb with SMTP id
 k3-20020a7bc303000000b0040e52f481bbmr1022200wmj.146.1706282473857; 
 Fri, 26 Jan 2024 07:21:13 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c0a0700b0040eccfa8a36sm2202318wmp.27.2024.01.26.07.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:21:12 -0800 (PST)
Message-ID: <45ae1780-f0ab-4a75-a00b-f031a5c911c2@gmail.com>
Date: Fri, 26 Jan 2024 16:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] amdgpu/drm: Use vram manager for virtualization page
 retirement
Content-Language: en-US
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240124232143.7201-1-Zhigang.Luo@amd.com>
 <20240124232143.7201-3-Zhigang.Luo@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240124232143.7201-3-Zhigang.Luo@amd.com>
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>, Sashank.Saye@amd.com,
 YiPeng.Chai@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.01.24 um 00:21 schrieb Zhigang Luo:
> From: Victor Skvortsov <victor.skvortsov@amd.com>
>
> In runtime, use vram manager for virtualization page retirement.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> Change-Id: Ia8fe6c7d4e4acae9d3a953b3ba4567e8fc6de0fa
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 30 ++++++++++++++++--------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index f5c66e0038b5..6ff7d3fb2008 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -250,11 +250,11 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   	if (!*data)
>   		goto data_failure;
>   
> -	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
> +	bps = kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNEL);
>   	if (!bps)
>   		goto bps_failure;
>   
> -	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
> +	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);

That looks like an rather important bug fix which should be in a 
separate patch.

>   	if (!bps_bo)
>   		goto bps_bo_failure;
>   
> @@ -287,8 +287,10 @@ static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
>   
>   	for (i = data->last_reserved - 1; i >= 0; i--) {
>   		bo = data->bps_bo[i];
> -		amdgpu_bo_free_kernel(&bo, NULL, NULL);
> -		data->bps_bo[i] = bo;
> +		if (bo) {
> +			amdgpu_bo_free_kernel(&bo, NULL, NULL);
> +			data->bps_bo[i] = bo;
> +		}
>   		data->last_reserved = i;
>   	}
>   }
> @@ -328,6 +330,8 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_virt *virt = &adev->virt;
>   	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
> +	struct ttm_resource_manager *man = &mgr->manager;
>   	struct amdgpu_bo *bo = NULL;
>   	uint64_t bp;
>   	int i;
> @@ -343,12 +347,18 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   		 * 2) a ras bad page has been reserved (duplicate error injection
>   		 *    for one page);
>   		 */
> -		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
> -					       AMDGPU_GPU_PAGE_SIZE,
> -					       &bo, NULL))
> -			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
> -
> -		data->bps_bo[i] = bo;
> +		if  (ttm_resource_manager_used(man)) {
> +			amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
> +				bp << AMDGPU_GPU_PAGE_SHIFT,
> +				AMDGPU_GPU_PAGE_SIZE);
> +			data->bps_bo[i] = NULL;
> +		} else {
> +			if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
> +							AMDGPU_GPU_PAGE_SIZE,
> +							&bo, NULL))
> +				DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
> +			data->bps_bo[i] = bo;
> +		}

That code makes no sense. If the VRAM mgr is not enabled then 
amdgpu_bo_create_kernel_at() won't work either.

I suggest to completely remove the amdgpu_bo_create_kernel_at() code path.

Regards,
Christian.

>   		data->last_reserved = i + 1;
>   		bo = NULL;
>   	}

