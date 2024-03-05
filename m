Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2758C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0A4112976;
	Tue,  5 Mar 2024 09:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GdjrYuEo";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B3A112976
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:23:18 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-412ee78f030so1821775e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 01:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709630596; x=1710235396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cFd7yOvdXgTWs5yhPnGmK/O/s+ANxXU0hwG+z9cLTWY=;
 b=GdjrYuEoirfzsN4hum0HbfgTYMcKry4NbHbUr4Dwi6d/yhGiSXLRMiCyFiHR7YkwSP
 6d9GZNpfZn3fgA+Cj4RjuiM+Ew+DIOykz4WJV3+ShlzNp4NvVOAnVowLsnr5ZPba+joU
 pzAkXSRChFLF44+0CSzDAhoOhSyurBHH1f2WjcmDOGF9ItslBI+TK/g+UuOXNRzxwsHd
 DvSmVQLjT/X9/t4KbFbblg6kFi+qAglWnXBefS+t8rl1lWk+y7ftvf+F/m4Kxn7NtDSK
 e4DsiHtd6Eh8SiWTLfdhxJyzPxTjIn8BlRgVxCFInHrTa7vtlVIjq7AsCWqAu2CrS19v
 GNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630596; x=1710235396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFd7yOvdXgTWs5yhPnGmK/O/s+ANxXU0hwG+z9cLTWY=;
 b=K4fAUm0hY8zFdj7l+R8eTuB0w3BrvEX3vxoHD2N/btuDi4steb1uP818pnM+8bqQsq
 JtHqqNjHfLNoAPNaq8pqn87aAHWxvTUdMymkdUYNLuQcpTBGIfo9AkWLlCqJaXjT70Ve
 wn0kqIWI3ZNpwThIGiGi9zX7qKVLZOwd4Lopvm8q6DtmjE+DHk5AJ3Z/cxCRknXjQo+X
 rRXReq7A5XbRh/h3cjvS3VHSja7RVOvAbxvipLwfuwPgUJnFoROyGs/kicoIaJxpzF9s
 8ti9WBaY169mqJC+xePozOfSjsqTrmbVk6YM9b+LaLkq/sSnkXfXNKa3hx2qWuxYTTfW
 3Ozg==
X-Gm-Message-State: AOJu0YyPiGsR3xAkzPqh1kPnq88FtaDkhTzgWXx+5tUjrS/g6eWdqvUp
 va3XD0zefz48vhxnwaTe+RkddQT363BBnrk8MWUd29X0bNhkWBrbPlYOty1PFvw=
X-Google-Smtp-Source: AGHT+IHAHIKhHBVQ/JXGsIPjm8oRMR/sjkwevQa7ayzzn9yjxXf4z71NvOG9APaPu+byuvZgSsy0Ag==
X-Received: by 2002:a05:600c:4fcf:b0:412:ebfe:68fe with SMTP id
 o15-20020a05600c4fcf00b00412ebfe68femr1054715wmq.35.1709630596107; 
 Tue, 05 Mar 2024 01:23:16 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 jg4-20020a05600ca00400b00412effedb29sm14444wmb.7.2024.03.05.01.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:23:15 -0800 (PST)
Message-ID: <80ed3bbc-397e-44d3-a42d-63e6005e0531@gmail.com>
Date: Tue, 5 Mar 2024 10:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add ring timeout information in devcoredump
Content-Language: en-US
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240301124344.2594714-1-sunil.khatri@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240301124344.2594714-1-sunil.khatri@amd.com>
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

Am 01.03.24 um 13:43 schrieb Sunil Khatri:
> Add ring timeout related information in the amdgpu
> devcoredump file for debugging purposes.
>
> During the gpu recovery process the registered call
> is triggered and add the debug information in data
> file created by devcoredump framework under the
> directory /sys/class/devcoredump/devcdx/
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
>   4 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9246bca0a008..9f57c7795c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -816,6 +816,17 @@ struct amdgpu_reset_info {
>   #endif
>   };
>   
> +/*
> + *  IP and Queue information during timeout
> + */
> +struct amdgpu_ring_timeout_info {
> +	bool timeout;

What should that be good for?

> +	char ring_name[32];
> +	enum amdgpu_ring_type ip_type;

Those information should already be available in the core dump.

> +	bool soft_recovery;

That doesn't make sense since we don't do a core dump in case of a soft 
recovery.

> +};
> +
> +
>   /*
>    * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
>    */
> @@ -1150,6 +1161,10 @@ struct amdgpu_device {
>   	bool                            debug_largebar;
>   	bool                            debug_disable_soft_recovery;
>   	bool                            debug_use_vram_fw_buf;
> +
> +#ifdef CONFIG_DEV_COREDUMP
> +	struct amdgpu_ring_timeout_info ring_timeout_info;
> +#endif

Please never store core dump related information in the amdgpu_device 
structure.

Regards,
Christian.

>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 71a5cf37b472..e36b7352b2de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -51,8 +51,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	memset(&ti, 0, sizeof(struct amdgpu_task_info));
>   	adev->job_hang = true;
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +	/* Update the ring timeout info for coredump*/
> +	adev->ring_timeout_info.timeout = TRUE;
> +	sprintf(adev->ring_timeout_info.ring_name, s_job->sched->name);
> +	adev->ring_timeout_info.ip_type = ring->funcs->type;
> +	adev->ring_timeout_info.soft_recovery = FALSE;
> +#endif
> +
>   	if (amdgpu_gpu_recovery &&
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
> +#ifdef CONFIG_DEV_COREDUMP
> +		adev->ring_timeout_info.soft_recovery = TRUE;
> +#endif
>   		DRM_ERROR("ring %s timeout, but soft recovered\n",
>   			  s_job->sched->name);
>   		goto exit;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..d4f892ed105f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -196,8 +196,16 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>   			   coredump->reset_task_info.process_name,
>   			   coredump->reset_task_info.pid);
>   
> +	if (coredump->timeout_info.timeout) {
> +		drm_printf(&p, "\nRing timed out details\n");
> +		drm_printf(&p, "IP Type: %d Ring Name: %s Soft Recovery: %s\n",
> +				coredump->timeout_info.ip_type,
> +				coredump->timeout_info.ring_name,
> +				coredump->timeout_info.soft_recovery ? "Successful":"Failed");
> +	}
> +
>   	if (coredump->reset_vram_lost)
> -		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +		drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
>   	if (coredump->adev->reset_info.num_regs) {
>   		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
>   
> @@ -228,6 +236,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>   		return;
>   	}
>   
> +	coredump->timeout_info = adev->ring_timeout_info;
>   	coredump->reset_vram_lost = vram_lost;
>   
>   	if (reset_context->job && reset_context->job->vm)
> @@ -236,6 +245,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>   	coredump->adev = adev;
>   
>   	ktime_get_ts64(&coredump->reset_time);
> +	memset(&adev->ring_timeout_info, 0, sizeof(adev->ring_timeout_info));
>   
>   	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>   		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 19899f6b9b2b..37172d6e1f94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -97,6 +97,7 @@ struct amdgpu_coredump_info {
>   	struct amdgpu_task_info         reset_task_info;
>   	struct timespec64               reset_time;
>   	bool                            reset_vram_lost;
> +	struct amdgpu_ring_timeout_info timeout_info;
>   };
>   #endif
>   

