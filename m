Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A672EC1EB5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 13:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F405510E8AB;
	Thu,  5 Feb 2026 13:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="mFPicWYK";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="HVG6R3hN";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EBD10E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770298466;
 bh=PipKUCWNZTHt9rdlZntBUm/
 97YLOZsSgHNKjS5bp3Vg=; b=mFPicWYKUxH4dU5dtnLWf+dnIQbJOApT02Q4kG6XKRvmABXqM9
 ZhI/b1HTPtUrbW3/vQbBvKbEm4EiU/3e5DJibT/vOPja+k8SeBnOljmpN6DAuWlG6e3pQ7kcLGV
 /cKAUAhmNqF7p/ETh6VeusGXcXWvwDhVtqJ7rQ8pKYPMWZ84lAKlBsHZq9vH0kbhkVqs9QpsEWI
 +IiSECbyHfn78n2IKgtDz9Lu4PS0Y/zFjWvqiOXbJR33UJdazEl4iBdcFj1KlMRtE/g6vs98uKz
 8U47+qcZywbzqQdkG6vgB8YeZ53BJ3VCkKT8FhmXbRHVL5AMacPs7UO8fCUd02w8wdA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770298466; bh=PipKUCWNZTHt9rdlZntBUm/
 97YLOZsSgHNKjS5bp3Vg=; b=HVG6R3hNARBaZGbkKfgBuHNtB60pJC1/M1gp/WbETveii1hDwQ
 TmMfx2ogNGQshwhUpvljNMhb8nSv0S4jHSDA==;
Message-ID: <ddf9062a-3017-4ce6-affd-2f485740ef59@damsy.net>
Date: Thu, 5 Feb 2026 14:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: re-add the bad job to the pending list
 for ring resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260130173042.15008-2-alexander.deucher@amd.com>
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
> Returning DRM_GPU_SCHED_STAT_NO_HANG causes the scheduler
> to add the bad job back the pending list.  We've already
> set the errors on the fence and killed the bad job at this point
> so it's the correct behavior.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index aaf5477fcd7ac..2c82d9e8c0be1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -92,6 +92,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct drm_wedge_task_info *info = NULL;
>   	struct amdgpu_task_info *ti = NULL;
>   	struct amdgpu_device *adev = ring->adev;
> +	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_RESET;
>   	int idx, r;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -135,13 +136,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	    ring->funcs->reset) {
>   		dev_err(adev->dev, "Starting %s ring reset\n",
>   			s_job->sched->name);
> +		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> +		drm_sched_wqueue_stop(&ring->sched);
>   		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>   		if (!r) {
> +			/* Start the scheduler again */
> +			drm_sched_wqueue_start(&ring->sched);
>   			atomic_inc(&ring->adev->gpu_reset_counter);
>   			dev_err(adev->dev, "Ring %s reset succeeded\n",
>   				ring->sched.name);
>   			drm_dev_wedged_event(adev_to_drm(adev),
>   					     DRM_WEDGE_RECOVERY_NONE, info);
> +			/* This is needed to add the job back to the pending list */
> +			status = DRM_GPU_SCHED_STAT_NO_HANG;
>   			goto exit;
>   		}
>   		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
> @@ -177,7 +184,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   exit:
>   	amdgpu_vm_put_task_info(ti);
>   	drm_dev_exit(idx);
> -	return DRM_GPU_SCHED_STAT_RESET;
> +	return status;
>   }
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b82357c657237..129ad51386535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>   void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>   				    struct amdgpu_fence *guilty_fence)
>   {
> -	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> -	drm_sched_wqueue_stop(&ring->sched);
>   	/* back up the non-guilty commands */
>   	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
>   }
> @@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>   			amdgpu_ring_write(ring, ring->ring_backup[i]);
>   		amdgpu_ring_commit(ring);
>   	}
> -	/* Start the scheduler again */
> -	drm_sched_wqueue_start(&ring->sched);
>   	return 0;
>   }
>   
