Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A71EC1EB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B0A10E8BF;
	Thu,  5 Feb 2026 14:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="bVurRQFh";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="tec9Cs2Z";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA56B10E1B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770300128;
 bh=NIER8mHl26+Ggoor9RylPzC
 cOI2IfloTp3HGkEA+rgA=; b=bVurRQFhAFEA+xfqF1JtBmxMNY+cH5NSjNVi0RZ15U4522ginn
 TSPUEFxfXqYVKS8DIW+dgs026XQ8MrJtc5ZiAQiCHUl0HQXE65ouygwtvQxtSp91m3L/lo7TEF0
 dDxKhe03I7pbix5K0cWFF2uh6o11j4u3xEi05uHPkhS7Cb3hczASNtDMQTVHK11tVRo1q4Uau1u
 j3U/2Pa6819ZovowA6kRDUI/A8AIX2RVzmXKepvOWsF7+pBgx2W3gT33g+0ekBe/4P9jZ+pRqPg
 RiqEPjfgzwjusYX0BMcv9/jWkhEyOtAa6sDZkF3YlvKYhDKlwA53KKHdZcRiOGa+XMg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770300128; bh=NIER8mHl26+Ggoor9RylPzC
 cOI2IfloTp3HGkEA+rgA=; b=tec9Cs2ZEJrkpt0XdC16GqmLOqjQC8DFzdkC6odcacoPggZTM5
 IdhJR0/2Jr8NEIGUrTLrm70n/e0A4Me0MxDQ==;
Message-ID: <937673e3-36a0-4ff0-a76d-c63a34885184@damsy.net>
Date: Thu, 5 Feb 2026 15:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-6-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260130173042.15008-6-alexander.deucher@amd.com>
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



Le 30/01/2026 à 18:30, Alex Deucher a écrit :
> We only want to stop the work queues, not mess with the
> fences, etc.
> 
> v2: add the job back to the pending list.
> v3: return the proper job status so scheduler adds the
>      job back to the pending list
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 6 ++----
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e69ab8a923e31..a5b43d57c7b05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6313,7 +6313,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   			if (!amdgpu_ring_sched_ready(ring))
>   				continue;
>   
> -			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> +			drm_sched_wqueue_stop(&ring->sched);
>   
>   			if (need_emergency_restart)
>   				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> @@ -6397,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>   			if (!amdgpu_ring_sched_ready(ring))
>   				continue;
>   
> -			drm_sched_start(&ring->sched, 0);
> +			drm_sched_wqueue_start(&ring->sched);
>   		}
>   
>   		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index df06a271bdf99..cd0707737a29b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -92,7 +92,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct drm_wedge_task_info *info = NULL;
>   	struct amdgpu_task_info *ti = NULL;
>   	struct amdgpu_device *adev = ring->adev;
> -	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_RESET;
>   	int idx, r;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -147,8 +146,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   				ring->sched.name);
>   			drm_dev_wedged_event(adev_to_drm(adev),
>   					     DRM_WEDGE_RECOVERY_NONE, info);
> -			/* This is needed to add the job back to the pending list */
> -			status = DRM_GPU_SCHED_STAT_NO_HANG;
>   			goto exit;
>   		}
>   		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
> @@ -184,7 +181,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   exit:
>   	amdgpu_vm_put_task_info(ti);
>   	drm_dev_exit(idx);
> -	return status;
> +	/* This is needed to add the job back to the pending list */
> +	return DRM_GPU_SCHED_STAT_NO_HANG;

This part seems unrelated to the patch and is overwriting what was done 
in patch 1/12.

Pierre-Eric


>   }
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
