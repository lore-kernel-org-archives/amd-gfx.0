Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E713C35FF3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 22:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29B810E94D;
	Thu, 13 Mar 2025 22:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qCSpwCyT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6142610E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OnPDbjgwn2rFSQurz7HH1whCFjxbPz79xCzbtGsL1mo=; b=qCSpwCyThT/6tEZRGCchwls4X4
 WYb1XVw3MqGZCUb5AYXZMaiGs/LycBCr0DTnb0tktGaz3ClGfwtmxo5qywdW5SRfAB7ao8MAOI+9n
 H43Pm5dWkqn16O6zuj770ZuUs0MTzwscz7bAhiBznpXUxDfQMWrVZCoNyUCO7aTr86TP5j73JEko9
 W7rXgIBeyRwuUlpPJE6F5PsCNoX0Z63n3nznNeAkn7SpSEAY5dImRuvDOi9Vizmm8bD7X7qxq8epS
 0Mdn0H8HxU8MUZZi7CySD1e94QuGWiGeLpTZwdfxIFHdG5hYzF6ll3fBOn/xEkQwd2iqXc+EjS0M6
 PmDBFUCw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tsqin-008MCQ-AH; Thu, 13 Mar 2025 23:08:15 +0100
Date: Thu, 13 Mar 2025 16:08:12 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Message-ID: <3wiqqnjoatmdt2j65f6fiu7bxbdyex5zku7ftrlouqqvf5mzwz@niv54l3lkkza>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-8-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313144136.1117072-8-alexander.deucher@amd.com>
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

On 03/13, Alex Deucher wrote:
> Plumb in support for disabling kernel queues in
> GFX11.  We have to bring up a GFX queue briefly in
> order to initialize the clear state.  After that
> we can disable it.
> 
> v2: use ring counts per Felix' suggestion
> v3: fix stream fault handler, enable EOP interrupts
> v4: fix MEC interrupt offset (Sunil)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 191 ++++++++++++++++++-------
>  1 file changed, 136 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 95eefd9a40d28..fde8464cbd3b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>  
>  	ring->ring_obj = NULL;
>  	ring->use_doorbell = true;
> +	if (adev->gfx.disable_kq) {
> +		ring->no_scheduler = true;

Hi Alex,

Just a question about this no_scheduler part.

Set no_scheduler to true, means that all of the queues of GFX11 will not
be preempted, right? I suppose you have to do it because you want to
initialize the clear state?

Thanks

> +		ring->no_user_submission = true;
> +	}
>  
>  	if (!ring_id)
>  		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> @@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
>  
>  static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -	int i, j, k, r, ring_id = 0;
> +	int i, j, k, r, ring_id;
>  	int xcc_id = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> @@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  	}
>  
> -	/* set up the gfx ring */
> -	for (i = 0; i < adev->gfx.me.num_me; i++) {
> -		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> -				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> -					continue;
> -
> -				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
> -							    i, k, j);
> -				if (r)
> -					return r;
> -				ring_id++;
> +	if (adev->gfx.num_gfx_rings) {
> +		ring_id = 0;
> +		/* set up the gfx ring */
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> +					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> +						continue;
> +
> +					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
> +								    i, k, j);
> +					if (r)
> +						return r;
> +					ring_id++;
> +				}
>  			}
>  		}
>  	}
>  
> -	ring_id = 0;
> -	/* set up the compute queues - allocate horizontally across pipes */
> -	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> -		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> -								     k, j))
> -					continue;
> +	if (adev->gfx.num_compute_rings) {
> +		ring_id = 0;
> +		/* set up the compute queues - allocate horizontally across pipes */
> +		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> +			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> +					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> +									     k, j))
> +						continue;
>  
> -				r = gfx_v11_0_compute_ring_init(adev, ring_id,
> -								i, k, j);
> -				if (r)
> -					return r;
> +					r = gfx_v11_0_compute_ring_init(adev, ring_id,
> +									i, k, j);
> +					if (r)
> +						return r;
>  
> -				ring_id++;
> +					ring_id++;
> +				}
>  			}
>  		}
>  	}
> @@ -4578,11 +4587,23 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
>  			return r;
>  	}
>  
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		ring = &adev->gfx.gfx_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +	if (adev->gfx.disable_kq) {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			/* we don't want to set ring->ready */
> +			r = amdgpu_ring_test_ring(ring);
> +			if (r)
> +				return r;
> +		}
> +		if (amdgpu_async_gfx_ring)
> +			amdgpu_gfx_disable_kgq(adev, 0);
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> @@ -4791,6 +4812,46 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	return r;
>  }
>  
> +static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
> +					      bool enable)
> +{
> +	if (adev->gfx.disable_kq) {
> +		unsigned int irq_type;
> +		int m, p, r;
> +
> +		for (m = 0; m < adev->gfx.me.num_me; m++) {
> +			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
> +				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +
> +		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
> +			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +					+ (m * adev->gfx.mec.num_pipe_per_mec)
> +					+ p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -4800,9 +4861,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +	gfx_v11_0_set_userq_eop_interrupts(adev, false);
>  
>  	if (!adev->no_hw_access) {
> -		if (amdgpu_async_gfx_ring) {
> +		if (amdgpu_async_gfx_ring &&
> +		    !adev->gfx.disable_kq) {
>  			if (amdgpu_gfx_disable_kgq(adev, 0))
>  				DRM_ERROR("KGQ disable failed\n");
>  		}
> @@ -5128,11 +5191,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> +	if (amdgpu_disable_kq == 1)
> +		adev->gfx.disable_kq = true;
> +
>  	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
>  
> -	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> -					  AMDGPU_MAX_COMPUTE_RINGS);
> +	if (adev->gfx.disable_kq) {
> +		/* We need one GFX ring temporarily to set up
> +		 * the clear state.
> +		 */
> +		adev->gfx.num_gfx_rings = 1;
> +		adev->gfx.num_compute_rings = 0;
> +	} else {
> +		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
> +		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +						  AMDGPU_MAX_COMPUTE_RINGS);
> +	}
>  
>  	gfx_v11_0_set_kiq_pm4_funcs(adev);
>  	gfx_v11_0_set_ring_funcs(adev);
> @@ -5163,6 +5237,11 @@ static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
>  	if (r)
>  		return r;
> +
> +	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -6548,27 +6627,29 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>  	pipe_id = (entry->ring_id & 0x03) >> 0;
>  	queue_id = (entry->ring_id & 0x70) >> 4;
>  
> -	switch (me_id) {
> -	case 0:
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -			ring = &adev->gfx.gfx_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> -		}
> -		break;
> -	case 1:
> -	case 2:
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			ring = &adev->gfx.compute_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> +	if (!adev->gfx.disable_kq) {
> +		switch (me_id) {
> +		case 0:
> +			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +				ring = &adev->gfx.gfx_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		case 1:
> +		case 2:
> +			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +				ring = &adev->gfx.compute_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		default:
> +			BUG();
> +			break;
>  		}
> -		break;
> -	default:
> -		BUG();
> -		break;
>  	}
>  }
>  
> -- 
> 2.48.1
> 

-- 
Rodrigo Siqueira
