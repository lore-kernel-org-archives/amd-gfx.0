Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C9AC54754
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 23:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE89710E125;
	Mon, 19 May 2025 23:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OQCnyZw+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB5610E125
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 23:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JwkOtpg7k0C1K9gfZbdKzV9wiUPyQNhvTGBMndtMxzc=; b=OQCnyZw+0BuRpYjJQgrKAuOWhe
 JZBjCa/xfIQpAQqcLfCjPiE8hcI8CLVRK8wdZcMM7YFs4uFD/6kc/GKUfJpIVafkP1Tbbgp/J77jY
 42+eNGW6LpDjYEe8afBTnpO2bvx7sb2DgoZ/3O2favXN0tBHQcQmpTXPkSy5ftBgTm7ebCIDDstZH
 hzp7ud89Ft42CYgilsRykHZr9fUeEUIBXlAvmrfHekSmI+363FyV84xcfE7Fh5CjTb35PQexRn+XG
 UN/1KpmxWARt0O9xScfJJDFeuGh/732dbM3SpidGfjiW8FZUf2N0qwW4OT1U8PMlPlTmLNplQbwcx
 JQXnTSxA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uHAFu-00ASid-LK; Tue, 20 May 2025 01:50:51 +0200
Date: Mon, 19 May 2025 17:50:46 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
Message-ID: <ggm5pb2sgyfe4irgrizjr4dohvxviob5p7ekqvvul4ktqvqlcj@zubqhw3yeuc4>
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502161720.1704-2-christian.koenig@amd.com>
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
> Testing this feature turned out that it was a bit unstable. The
> CP_VMID_RESET register takes the VMID which all submissions from should
> be canceled.
> 
> Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
> for the simple reason that we don't have enough. So resetting one VMID
> only killed the submissions of one specific process.
> 
> Fortunately that turned out to be exactly what we want to have.
> 
> So clear the CP_VMID_RESET register between every context switch between
> applications when we do the pipeline sync to avoid trouble if multiple
> VMIDs are used on the ring right behind each other.
> 
> Use the same pipeline sync function in the reset handler and issue an IB
> test instead of a ring test after the queue reset to provide a longer
> timeout and additional fence value should there be additional work on
> the ring after the one aborted.
> 
> Also drop the soft recovery since that pretty much does the same thing as
> CP_VMID_RESET, just on a lower level and with less chance of succeeding.
> 
> This now survives a stress test running over night sending a broken
> submission ever 45 seconds and recovering fine from each of them.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
>  2 files changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..c39fe784419b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
>  #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
>  #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
> +#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
>  #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
>  #define AMDGPUFB_CONN_LIMIT			4
>  #define AMDGPU_BIOS_NUM_SCRATCH			16
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d377a7c57d5e..92d9a28c62d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5565,7 +5565,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
>  	uint32_t seq = ring->fence_drv.sync_seq;
>  	uint64_t addr = ring->fence_drv.gpu_addr;
> +	struct amdgpu_device *adev = ring->adev;
>  
> +	amdgpu_ring_emit_reg_wait(ring,
> +				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +				  0, 0xffff);
> +	amdgpu_ring_emit_wreg(ring,
> +			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +			      0);
> +	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +			       ring->fence_drv.sync_seq,
> +			       AMDGPU_FENCE_FLAG_EXEC);
>  	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
>  			      lower_32_bits(addr), upper_32_bits(addr),
>  			      seq, 0xffffffff, 4);
> @@ -5896,20 +5906,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>  							   ref, mask);
>  }
>  
> -static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
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
>  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>  						 enum amdgpu_interrupt_state state)
>  {
> @@ -7185,16 +7181,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (r)
>  		return r;
>  
> -	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
> +	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))

Hi Christian,

What is the meaning of all of the above additions (7 + 7 + 5 + 7)? I see
it in many different parts of the code. Is this some indication of
preambles?

Thanks

>  		return -ENOMEM;
> -	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
> -	gfx_v9_0_ring_emit_reg_wait(ring,
> -				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
> -	gfx_v9_0_ring_emit_wreg(ring,
> -				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
> +	gfx_v9_0_ring_emit_pipeline_sync(ring);
> +	amdgpu_ring_commit(ring);
>  
> -	return amdgpu_ring_test_ring(ring);
> +	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>  
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -7437,7 +7429,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
>  		5 +  /* COND_EXEC */
> -		7 +  /* PIPELINE_SYNC */
> +		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		2 + /* VM_FLUSH */
> @@ -7475,7 +7467,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  	.reset = gfx_v9_0_reset_kgq,
>  	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
> @@ -7494,7 +7485,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
>  	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
>  		5 +  /* COND_EXEC */
> -		7 +  /* PIPELINE_SYNC */
> +		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		2 + /* VM_FLUSH */
> @@ -7533,7 +7524,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  	.patch_cntl = gfx_v9_0_ring_patch_cntl,
>  	.patch_de = gfx_v9_0_ring_patch_de_meta,
> @@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> -		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
> @@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
>  	.reset = gfx_v9_0_reset_kcq,
> @@ -7598,7 +7587,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> -		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
> -- 
> 2.34.1
> 

-- 
Rodrigo Siqueira
