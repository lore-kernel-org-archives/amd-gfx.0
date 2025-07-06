Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF7C83F03
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 14:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCDB10E26C;
	Sun,  6 Jul 2025 14:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qsTPdtHB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66B310E26C
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jAE+WuOT2bgMrRm3II/3tcwy/9CiUp13nUuP6YA818c=; b=qsTPdtHByz3AdDGJht7kF4gWeT
 nklGnRpxVeAW77+VgudJcXx+Esj3FUaJw0yIQauq6g0YEMLpy9C5C4Yy/E0duGC2e32UoZdycosvu
 sus1jt05TDeL56vNRMsNGcMjkRZzDSIDhWBKkK+R2K2xWqrg8r3YL3an9inv9ojKHmfAtd7WJ1S3o
 5Sn856J2JDKa6Puk7nXmoa9HI5QzQ8edAqu+HPWjdwomb3QVtytQcOBbUISOyFTcaMO0F9z7rZT/j
 BtVW9487CcrU+Jh0eCid2V/OGrLr9AlVUNJuCz61AkpZw0LCQqSb4i9a+yUVdYX8eW12xk69y9b3T
 vpb3arcQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQRg-00D9uF-6y; Sun, 06 Jul 2025 16:34:20 +0200
Date: Sun, 6 Jul 2025 08:34:16 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
Subject: Re: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling
Message-ID: <a4uhvkpsbekjywwjc2lamhxf3hspdiwgj4gvxk5uwnc6sjt2hd@q47f7oyp2uxm>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-2-alexander.deucher@amd.com>
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

On 07/01, Alex Deucher wrote:
> Move the force completion handling into the common
> engine reset function.  No need to duplicate it for
> every IP version.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
>  4 files changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 89a849640ab91..91e8f45fe886e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -573,9 +573,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	 * to be submitted to the queues after the reset is complete.
>  	 */
>  	if (!ret) {
> +		amdgpu_fence_driver_force_completion(gfx_ring);
>  		drm_sched_wqueue_start(&gfx_ring->sched);
> -		if (adev->sdma.has_page_queue)
> +		if (adev->sdma.has_page_queue) {
> +			amdgpu_fence_driver_force_completion(page_ring);
>  			drm_sched_wqueue_start(&page_ring->sched);
> +		}
>  	}
>  	mutex_unlock(&sdma_instance->engine_reset_mutex);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index d3072bca43e3f..572d105420ec3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_mask, tmp_mask;
> +	u32 inst_mask;
>  	int i, r;
>  
>  	inst_mask = 1 << ring->me;
> @@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  	}
>  
>  	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);

Now that you have deleted the below code, I think you can remove the
variable 'r' and use 'return sdma_v4_4_2_inst_start'.

> -	if (r)
> -		return r;
> -
> -	tmp_mask = inst_mask;
> -	for_each_inst(i, tmp_mask) {
> -		ring = &adev->sdma.instance[i].ring;
> -
> -		amdgpu_fence_driver_force_completion(ring);
> -
> -		if (adev->sdma.has_page_queue) {
> -			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
> -
> -			amdgpu_fence_driver_force_completion(page);

I guess I'm missing something, but this part is slightly different from
amdgpu_sdma_reset_engine since here
amdgpu_fence_driver_force_completion() can be called twice in some
cases.

Thanks

> -		}
> -	}
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 4d72b085b3dd7..ed1706da7deec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1618,10 +1618,8 @@ static int sdma_v6_0_restore_queue(struct amdgpu_ring *ring)
>  
>  	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	return 0;
> +
> +	return r;
>  }
>  
>  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 42a25150f83ac..b87a4b44fa939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
>  	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
>  
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	return 0;
> +
> +	return r;
>  }
>  
>  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
