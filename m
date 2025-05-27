Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75334C54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 16:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126E910E138;
	Tue, 27 May 2025 16:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="D5YAKiS3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BA810E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cNtBCNRcRHaLYKgytVJKz8X6b9dy1RDEH0785S3zd/A=; b=D5YAKiS3TJgtnlpWRRwgUR5f+W
 2yJsvyxmcNoPc3vsbhLhs99Gy+T0WyjqB981Q77yOYlVfFlaC/Vq7CSD6xAyUx2P71YaFD2Jl4+lg
 JfQ7pMxYXQ9e1YqqWVjN0wku4bDfRm1r8CVT34eGYqedFs2HuAinxW2LO9bmS9tH4QblJRIC4IzsD
 TYFJR62EbabcAbCRnMPpUEdbwgpuELHcdjjhpIEXqei75Vf/qTPS+Qvs2ZjmCoya08RcsCWPfu551
 NV8YKNF5uptkIcylb38nPdIVAckwpEZGu+7hPJQWBRxX9bQly46ivCSKr4HeRHfsWDtNVqeTWSSTL
 rMGLZoyg==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uJxSE-00Dr67-39; Tue, 27 May 2025 18:47:06 +0200
Date: Tue, 27 May 2025 10:47:02 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 02/10] drm/amdgpu: rework queue reset scheduler interaction
Message-ID: <mmoave25vjenpkpt3osch5kin5qnryurqaty5pmtsju7zh37xk@22wccbz47es6>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <20250522215559.14677-3-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522215559.14677-3-alexander.deucher@amd.com>
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

On 05/22, Alex Deucher wrote:
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> 
> Stopping the scheduler for queue reset is generally a good idea because
> it prevents any worker from touching the ring buffer.
> 
> But using amdgpu_fence_driver_force_completion() before restarting it was
> a really bad idea because it marked fences as failed while the work was
> potentially still running.
> 
> Stop doing that and cleanup the comment a bit.
> 
> v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings

Why keep this amdgpu_fence_driver_force_completion() for non-gfx is ok?
From the commit descriptions, sounds like we want to avoid
amdgpu_fence_driver_force_completion() before the driver restarts the
queue.

> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 +++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce5..e57401ef85140 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>  		bool is_guilty;
>  
> -		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
> -		/* stop the scheduler, but don't mess with the
> -		 * bad job yet because if ring reset fails
> -		 * we'll fall back to full GPU reset.
> +		dev_err(adev->dev, "Starting %s ring reset\n",
> +			s_job->sched->name);
> +
> +		/*
> +		 * Stop the scheduler to prevent anybody else from touching the
> +		 * ring buffer.
>  		 */
>  		drm_sched_wqueue_stop(&ring->sched);
>  
> @@ -157,19 +159,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  		r = amdgpu_ring_reset(ring, job->vmid);
>  		if (!r) {
> -			if (amdgpu_ring_sched_ready(ring))
> -				drm_sched_stop(&ring->sched, s_job);
>  			if (is_guilty) {
>  				atomic_inc(&ring->adev->gpu_reset_counter);
> -				amdgpu_fence_driver_force_completion(ring);
> +				if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
> +					amdgpu_fence_driver_force_completion(ring);
>  			}
> -			if (amdgpu_ring_sched_ready(ring))
> -				drm_sched_start(&ring->sched, 0);
> -			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
> -			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> +			drm_sched_wqueue_start(&ring->sched);
> +			dev_err(adev->dev, "Ring %s reset succeeded\n",
> +				ring->sched.name);
> +			drm_dev_wedged_event(adev_to_drm(adev),
> +					     DRM_WEDGE_RECOVERY_NONE);
>  			goto exit;
>  		}
> -		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
> +		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>  	}
>  	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  
> -- 
> 2.49.0
> 

-- 
Rodrigo Siqueira
