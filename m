Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8B3C83F05
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 14:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6923610E2B2;
	Sun,  6 Jul 2025 14:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qzVtZ73N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F3910E2B2
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aOra7yIF3FOJYwr0htqoWcvtnlM/1wtjPrcvwIViEbo=; b=qzVtZ73N5Hxl2FyE6xipQ0GiDY
 07tWFbpSn/7f8SEezc4PruhLr2Lluz9hEGd3GZOOUcO8C5LLV+D0VRlkZAC5mJJ49+ggCbpLLlbA9
 3Qn0ooZdEF27ZtHYxjCYHNkjlTzPdlWYH1Uxd9Xd3niSj5EmCDk7d+UOKZa6GlsPX8J9lkH4f+DmQ
 GDg0f05DvK4uDfc+VWK50xHDAc/xVfwyFe5uIRiZwdyTux0a8CLAuLpJ4mCE+P5xiEM9r94y1c43C
 UNR4RbohXbkKWtwhtV1RYIffe/QHFfTZga6q7Fdw27NMfhyEEb/61TpbaUDOqlZGAfw9H3FilBMcw
 iWJrkJPg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQpV-00DADW-9p; Sun, 06 Jul 2025 16:58:57 +0200
Date: Sun, 6 Jul 2025 08:58:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
Subject: Re: [PATCH 06/28] drm/amdgpu/gfx10: re-emit unprocessed state on
 ring reset
Message-ID: <a465ueihzix76srte55bwmshugihbks2fnr3yiq36xdy3wp3b7@ij3toxl3ahac>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-7-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-7-alexander.deucher@amd.com>
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
> Re-emit the unprocessed state after resetting the queue.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 ++++----------------------
>  1 file changed, 6 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5e099b5dc9a3c..65429afb33ec3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>  							   ref, mask);
>  }
>  
> -static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
> -					 unsigned int vmid)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t value = 0;
> -
> -	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -}
> -

You are eliminating the gfx_v10_0_ring_soft_recovery here, but why you
did not remove it in the GFX9 (previous commit)?

Also, I suppose the new recovery method from this series will replace
this soft_recovery, right? If so, I suggest you include this information
in the commit message.

Thanks

>  static void
>  gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>  				      uint32_t me, uint32_t pipe,
> @@ -9540,7 +9525,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> -	drm_sched_wqueue_stop(&ring->sched);
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
> @@ -9589,12 +9574,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = amdgpu_ring_test_ring(ring);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	drm_sched_wqueue_start(&ring->sched);
> -	return 0;
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>  
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -9613,7 +9593,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> -	drm_sched_wqueue_stop(&ring->sched);
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
> @@ -9625,9 +9605,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
>  				   0, 0);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r)
>  		return r;
>  
> @@ -9663,18 +9642,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	}
>  	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r)
>  		return r;
>  
> -	r = amdgpu_ring_test_ring(ring);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	drm_sched_wqueue_start(&ring->sched);
> -	return 0;
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>  
>  static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> @@ -9909,7 +9882,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v10_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
>  	.reset = gfx_v10_0_reset_kgq,
>  	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
> @@ -9950,7 +9922,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>  	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v10_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
>  	.reset = gfx_v10_0_reset_kcq,
>  	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
