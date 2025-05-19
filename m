Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DBC54754
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 23:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251A810E02A;
	Mon, 19 May 2025 23:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oldXW7Ad";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8C810E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 23:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U28c+x2+CYOuTSCcMi44aICZ062j9LybqxMLSiCdMbU=; b=oldXW7Ad6oxlK23G531jUlsSPR
 MLAmGOqxW4ubAeA//FuYvTSoaBCo+z6CnQvXhA5OwymWRvIvAOMzI8NhzbKWEUIu2q42mzzjux0Lp
 lEQ0XYS1/++7bxxF1wZx6GN/BN6yMUU8Oiaf6MTbtjFWzjocvlH51qT20rMBc4M1bgBfWsfKbUTSS
 EFVmUPVeSf8F8CFotyByr/PT6z3tC6cVX5yJcuMvpliz6Ykl2zmm3qyjUnvLMmYHKXzkoAYHyu81O
 cH1hPx/nnF3Ps0NyShplRfC/7Qp9utbx28NU2C2Xmr0KgMx2RxfN1d8OdqCmkrZBxxGuyxaoVNeot
 1nxAyMzQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uHAJu-00ASqU-Mo; Tue, 20 May 2025 01:54:59 +0200
Date: Mon, 19 May 2025 17:54:55 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/amdgpu: rework queue reset scheduler interaction
Message-ID: <v6dyspsffwlnmuvrl7hos7xoauim5ibsyadf3fzmas424lra2h@krsminxpgeul>
References: <20250502161720.1704-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502161720.1704-1-christian.koenig@amd.com>
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

On 05/02, Christian König wrote:
> Stopping the scheduler for queue reset is generally a good idea because
> it prevents any worker from touching the ring buffer.
> 
> But using amdgpu_fence_driver_force_completion() before restarting it was
> a really bad idea because it marked fences as failed while the work was
> potentially still running.
> 
> Stop doing that and cleanup the comment a bit.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce..a0fab947143b 100644
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
> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  		r = amdgpu_ring_reset(ring, job->vmid);
>  		if (!r) {
> -			if (amdgpu_ring_sched_ready(ring))
> -				drm_sched_stop(&ring->sched, s_job);
> -			if (is_guilty) {
> +			if (is_guilty)
>  				atomic_inc(&ring->adev->gpu_reset_counter);
> -				amdgpu_fence_driver_force_completion(ring);
> -			}
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
> 2.34.1
>

Hi Christian,

I tested your series with Polaris and the 6600 series with the HangTest
suite, and with your series, the following tests failed:

 - soft_recovery_loop
 - soft_recovery_pagefault_read
 - soft_recovery_pagefault_write

When using the latest code of the amd-staging-drm-next, all of the above
tests behave well. I'll try to identify what is going on.

Thanks

-- 
Rodrigo Siqueira
