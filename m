Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D10C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 09:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1DC10E4CE;
	Tue,  9 Jul 2024 09:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F62Fw2W+";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C0510E4CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 09:22:43 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2eeb2d60efbso12031241fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jul 2024 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720516961; x=1721121761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s+5V8mka5DMNM/pBALDG709t8jlATa+UuybwbKGpXSA=;
 b=F62Fw2W+hkt06cSbjLvOiI6bD9v56Dw901N6Co5Sz1JJwfWKFt5f2DYJwiWbjY2SCF
 jfX09CJrVJPp3TIRax5CRnuEr3xJe05aEX8F1v8RrjBrh3BB57+Z1sb/98yPGpLByb5F
 7rYcc1pXBC519hT+N5M4LNJZG6be4ODZiswampJyhu/bzM07CQmZF9rh0OTDl9RkqY54
 WvSiDDCPUbWgmkYRTxd4J0eIa1ZHpOY2oC5+wPpa36pTYaarJdOTp0nJaborxI3TDPmU
 HJ+Q0isKKByYF01N4P5bl6F6sA1cmFqO0OO1LP59wTYTMJQM1yMACWG+e6RpJZo935YH
 ZLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720516961; x=1721121761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+5V8mka5DMNM/pBALDG709t8jlATa+UuybwbKGpXSA=;
 b=xJUbBN/xbGTw0P/q8mFcWUE4lW2+EB6UsydoFi9sElwluQcIHm7eN4RCBtf9hSdVXM
 STMKC10nEO7yGSf4FEpGX6wYZUXgwFe1Ti1P/cz9RAXTI93bF1QBQWtmazyjXwVW8MfF
 2OrAqNmcdTahqf6im2kct/SFNvj7hsLro3uI3fSLfogrKv8sapOW5ytShKf8IF//Ev7y
 n3q09faBozwSbF6YFMpG7aHV7g8Mh6RhdIAVNSrxSwr52RwCA7j1RJqezheprng+clqw
 Te8yuuoTSpOeyu2F+EyiZ2gSszmUXvHS6XnGeeZKGuRwfruAk1Ce87Gv5HvAudlxDhRm
 FvrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXteuiaTSFM4/Nxy8PLEPXRB6hq/Jsth+PCqQOOkapyNnbLySDMek+PjTg1xxO9/PLmJziFcWlNahMfwM2P8jZBtbC4KiDisZWzv5dh2g==
X-Gm-Message-State: AOJu0YxRBRzr2xVVTEe7251k4y9wcy1O5hirXJXLCdv94qWk5+UlSYuJ
 9PlyP/+TKDkzv4/Tv/TrG5oVZGZ2hCUi9UA74mRsd27RbRpcYVSk1mO8gCh6
X-Google-Smtp-Source: AGHT+IEn2xiSf7PfX8t/rkx/mtBtMfa3Je24dfT4hZuYh27UCXsRGpiJ1+m331JS+KUwKZ4Pisd2Lw==
X-Received: by 2002:a2e:98d4:0:b0:2ee:8d81:5a92 with SMTP id
 38308e7fff4ca-2eeb317149dmr13327331fa.38.1720516960824; 
 Tue, 09 Jul 2024 02:22:40 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5a32sm32028345e9.24.2024.07.09.02.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 02:22:40 -0700 (PDT)
Message-ID: <b8cb720a-5eeb-4d87-bffc-33f48ecd9ca3@gmail.com>
Date: Tue, 9 Jul 2024 11:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/job: Replace DRM_INFO/ERROR logging
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240708190419.3615363-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240708190419.3615363-1-alexander.deucher@amd.com>
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

Am 08.07.24 um 21:04 schrieb Alex Deucher:
> Use the dev_info/err variants so we get per device logging
> in multi-GPU cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index cf0c4470ab9c..e238f2832f65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -41,7 +41,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	int r;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
> +		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
>   			 __func__, s_job->sched->name);
>   
>   		/* Effectively the job is aborted as the device is gone */
> @@ -53,19 +53,20 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   	if (amdgpu_gpu_recovery &&
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
> -		DRM_ERROR("ring %s timeout, but soft recovered\n",
> -			  s_job->sched->name);
> +		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
> +			s_job->sched->name);
>   		goto exit;
>   	}
>   
> -	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> -		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> -		   ring->fence_drv.sync_seq);
> +	dev_err(adev->dev, "ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> +		job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> +		ring->fence_drv.sync_seq);
>   
>   	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>   	if (ti) {
> -		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> -			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +		dev_err(adev->dev,
> +			"Process information: process %s pid %d thread %s pid %d\n",
> +			ti->process_name, ti->tgid, ti->task_name, ti->pid);
>   		amdgpu_vm_put_task_info(ti);
>   	}
>   
> @@ -82,7 +83,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
>   		if (r)
> -			DRM_ERROR("GPU Recovery Failed: %d\n", r);
> +			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))
> @@ -274,7 +275,7 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>   	while (!fence && job->vm && !job->vmid) {
>   		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
>   		if (r) {
> -			DRM_ERROR("Error getting VM ID (%d)\n", r);
> +			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
>   			goto error;
>   		}
>   	}

