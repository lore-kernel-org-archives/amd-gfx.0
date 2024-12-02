Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C03FE69E85
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 19:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26F610E13D;
	Mon,  2 Dec 2024 19:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBcwCfhZ";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFE010E072
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 19:18:43 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-385e1f3f2a6so1847571f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2024 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733167122; x=1733771922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mUP8KxObOiXfKwYfaXNMKqkHM2mCcNP9QgF6O/EoBBg=;
 b=UBcwCfhZ61IThTZ33sGy5VPlZVakcfY+SV/JAT891E9d7yHMLEKCgepht2uguSCxem
 NKM9citEKm+/0F5ERvNtLKOi1PVBxdTusPUEiXGWb9uzX2Mj3UqRtTMjNOvHsGSMAoi6
 G73MrSIeHd866jeUk/CrEzFpNw7a7uKROAcvVJ1r3x1e9ntxVaZWxqS+1phsDmKFR3/l
 LfBKFiaGnBKXs1pkV6BYcVXEgHnXqxm/+woZxEn6llUpIpyRJBnL8SD1WtLtnSwVtRCp
 hm4HyBz6pVw6kE0cm6So2KiJY4Voc0WsPTKz5bgzG/ccKXvj9+zHR1ixQzVMPOuuybwv
 TFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733167122; x=1733771922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUP8KxObOiXfKwYfaXNMKqkHM2mCcNP9QgF6O/EoBBg=;
 b=U+49uSUXYlY16lsHB3gLZAUwlEc6mf+ivXJv64ujHCyubkXOBYSkK1oXrx5LBK5yJd
 ON1hgqOpol3sxZW09ov9vk5AJNK8lEeGSfS90XEAzKweK6BcjHud5nlOuUBdaO9ubQE0
 FcgQIB1COfGaVj+EeeV+12URjCYl/0dd8TYP93W04dAFXDMKIeFQ9Uhw96QVoASbhV71
 9DfSEMXHNLU4KXlkwwutHygCspmwvg5Xk03R+TBX70lipzfE3PNB6b6LAQuY7N/wPaLO
 0mex39FyoKumMvQp1ii+7B+nLPrezqAaNPkabjY+1ZKIiCT90vZM0+5g1biThRDUGjZO
 LeyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEKgboa34vy/FVNdR2B5MIdensAVWrURRJee3C1nqoe/rH9/KzK53NGginsWQG+q+ZhOxgS1EW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqHhcjQ1SRV1u3DE2nmW2alKqIS5439bhEhK0zCvEDK1NO04iG
 lH3gJl7jM5z8dHjmMM/vXTNH7PtnP+sdHEpIoIfV8Pls6YOf9x5QGqEiFA==
X-Gm-Gg: ASbGnctvXFpvEUlg+jvkAA+78VZ0QDLoyv+53V4DFXcMp1DT+0OnW0DPb7lkvTaBBdU
 Rq1U7FhjCX/OT+Sxq/W+nmLlFb5jdwp3BUJgZsVOeaxrshl5s+xRSFDkCsbgifRqBnQygdjMVps
 IvdsZALd0ow8U8a4sDjv0N/4rL0reVJT7/6YF+gyQECaBZb9p5Tw0Ks2x7l0Xha4Q0E5H1Mf79G
 ssRmby7NwMGLAlZAjd4+LKj6xQC5RdZZnEXWlxMi/n+OfQQhCkkwSXTMywMsLq7EJsNyaWvjjpA
 TaM=
X-Google-Smtp-Source: AGHT+IHDr/mvbNnzfiArX9WNsQ0m0xPNTVoXLNy8BZhFu0M0r/4kwYuFrtBEQp00lrZKjTpQ1idVtA==
X-Received: by 2002:a5d:6d83:0:b0:385:f13c:570f with SMTP id
 ffacd0b85a97d-385f13c5a49mr4237821f8f.33.1733167121449; 
 Mon, 02 Dec 2024 11:18:41 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385de98d618sm10749059f8f.90.2024.12.02.11.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 11:18:40 -0800 (PST)
Message-ID: <c8bb8b47-314c-402e-87bb-3641b63eb6f7@gmail.com>
Date: Mon, 2 Dec 2024 20:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: rework resume handling for display (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241202165237.971604-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241202165237.971604-1-alexander.deucher@amd.com>
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

Am 02.12.24 um 17:52 schrieb Alex Deucher:
> Split resume into a 3rd step to handle displays when DCC is
> enabled on DCN 4.0.1.  Move display after the buffer funcs
> have been re-enabled so that the GPU will do the move and
> properly set the DCC metadata for DCN.
>
> v2: fix fence irq resume ordering
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++++-
>   1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2a25e0742f8e7..d882d46de1416 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3764,7 +3764,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>    *
>    * @adev: amdgpu_device pointer
>    *
> - * First resume function for hardware IPs.  The list of all the hardware
> + * Second resume function for hardware IPs.  The list of all the hardware
>    * IPs that make up the asic is walked and the resume callbacks are run for
>    * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
>    * functional state after a suspend and updates the software state as
> @@ -3782,6 +3782,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
>   			continue;
>   		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
> @@ -3792,6 +3793,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Third resume function for hardware IPs.  The list of all the hardware
> + * IPs that make up the asic is walked and the resume callbacks are run for
> + * all DCE.  resume puts the hardware into a functional state after a suspend
> + * and updates the software state as necessary.  This function is also used
> + * for restoring the GPU after a GPU reset.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
> +{
> +	int i, r;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> +			continue;
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
> +			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_device_ip_resume - run resume for hardware IPs
>    *
> @@ -3821,6 +3852,13 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>   	if (adev->mman.buffer_funcs_ring->sched.ready)
>   		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   
> +	if (r)
> +		return r;
> +
> +	amdgpu_fence_driver_hw_init(adev);
> +
> +	r = amdgpu_device_ip_resume_phase3(adev);
> +
>   	return r;
>   }
>   
> @@ -4909,7 +4947,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
>   		goto exit;
>   	}
> -	amdgpu_fence_driver_hw_init(adev);
>   
>   	if (!adev->in_s0ix) {
>   		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
> @@ -5489,6 +5526,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>   				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
>   					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
>   
> +				r = amdgpu_device_ip_resume_phase3(tmp_adev);
> +				if (r)
> +					goto out;
> +
>   				if (vram_lost)
>   					amdgpu_device_fill_reset_magic(tmp_adev);
>   

