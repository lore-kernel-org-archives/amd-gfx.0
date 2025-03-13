Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB1C35FF1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DD110E94B;
	Thu, 13 Mar 2025 21:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LOOHm2su";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187DF10E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lLlDoDXkRfMm5tC3mPwzpBB8Rwe1Y9WRknI089pH+lY=; b=LOOHm2suGCNeqbDr3FQ6oeg4DX
 esD9JD+EitNrz66jqP+W53K+DUHMij1mrJLx2z5BVbtDTpI/aQ04ICUp3NQVSSRgIQkbpX18zTxiu
 lN562ldaNW0yBY+oaGhIrzMH5fRkpj/yWcryKtfbdUmMG1qtCFtACDMIEQzfaXDMjqnGIoPePUXE+
 20ejEMbUTcB6BNk3XBDpYm5fqKSy+ysUJWwZoYhaLlocs7XZYA+M1hnmCZ+hxrw9NK9uW3VIapTNf
 pM7tyg+bGsZyAmOsjh26DfApu4R0K4RmhqXAHjCZGCSUeIMF5pYN9wh510Zs49v1wslltGYWxamcO
 St8TmCMw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tsqTT-008LoO-6f; Thu, 13 Mar 2025 22:52:25 +0100
Date: Thu, 13 Mar 2025 15:52:21 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Message-ID: <6yaahksm3dvejx5ja7dkgg3xi6qpf7izq6kbvje7addkgkuvoj@2qqcgry27paf>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313144136.1117072-3-alexander.deucher@amd.com>
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
> This would be set by IPs which only accept submissions
> from the kernel, not userspace, such as when kernel
> queues are disabled. Don't expose the rings to userspace
> and reject any submissions in the CS IOCTL.

Just out of curiosity, is CS == Command Submission?

> 
> Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5df21529b3b13..5cc18034b75df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>  	ring = amdgpu_job_ring(job);
>  	ib = &job->ibs[job->num_ibs++];
>  
> +	/* submissions to kernel queus are disabled */

/queus/queues/

> +	if (ring->no_user_submission)
> +		return -EINVAL;

Since this will be set for ASICs that don't accept userspace
submissions, maybe -ENOTSUPP would be more accurate?

Thanks

> +
>  	/* MM engine doesn't support user fences */
>  	if (p->uf_bo && ring->funcs->no_user_fence)
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	case AMDGPU_HW_IP_GFX:
>  		type = AMD_IP_BLOCK_TYPE_GFX;
>  		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -			if (adev->gfx.gfx_ring[i].sched.ready)
> +			if (adev->gfx.gfx_ring[i].sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>  				++num_rings;
>  		ib_start_alignment = 32;
>  		ib_size_alignment = 32;
> @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	case AMDGPU_HW_IP_COMPUTE:
>  		type = AMD_IP_BLOCK_TYPE_GFX;
>  		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -			if (adev->gfx.compute_ring[i].sched.ready)
> +			if (adev->gfx.compute_ring[i].sched.ready &&
> +			    !adev->gfx.compute_ring[i].no_user_submission)
>  				++num_rings;
>  		ib_start_alignment = 32;
>  		ib_size_alignment = 32;
> @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	case AMDGPU_HW_IP_DMA:
>  		type = AMD_IP_BLOCK_TYPE_SDMA;
>  		for (i = 0; i < adev->sdma.num_instances; i++)
> -			if (adev->sdma.instance[i].ring.sched.ready)
> +			if (adev->sdma.instance[i].ring.sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>  				++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;
> @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  			if (adev->uvd.harvest_config & (1 << i))
>  				continue;
>  
> -			if (adev->uvd.inst[i].ring.sched.ready)
> +			if (adev->uvd.inst[i].ring.sched.ready &&
> +			    !adev->uvd.inst[i].ring.no_user_submission)
>  				++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	case AMDGPU_HW_IP_VCE:
>  		type = AMD_IP_BLOCK_TYPE_VCE;
>  		for (i = 0; i < adev->vce.num_rings; i++)
> -			if (adev->vce.ring[i].sched.ready)
> +			if (adev->vce.ring[i].sched.ready &&
> +			    !adev->vce.ring[i].no_user_submission)
>  				++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;
> @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  				continue;
>  
>  			for (j = 0; j < adev->uvd.num_enc_rings; j++)
> -				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
> +				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  			if (adev->vcn.harvest_config & (1 << i))
>  				continue;
>  
> -			if (adev->vcn.inst[i].ring_dec.sched.ready)
> +			if (adev->vcn.inst[i].ring_dec.sched.ready &&
> +			    !adev->vcn.inst[i].ring_dec.no_user_submission)
>  				++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  				continue;
>  
>  			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
> -				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
> +				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  				continue;
>  
>  			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
> -				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
> +				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
> +				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		break;
>  	case AMDGPU_HW_IP_VPE:
>  		type = AMD_IP_BLOCK_TYPE_VPE;
> -		if (adev->vpe.ring.sched.ready)
> +		if (adev->vpe.ring.sched.ready &&
> +		    !adev->vpe.ring.no_user_submission)
>  			++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e9..4a97afcb38b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,6 +297,7 @@ struct amdgpu_ring {
>  	struct dma_fence	*vmid_wait;
>  	bool			has_compute_vm_bug;
>  	bool			no_scheduler;
> +	bool			no_user_submission;
>  	int			hw_prio;
>  	unsigned 		num_hw_submission;
>  	atomic_t		*sched_score;
> @@ -310,7 +311,6 @@ struct amdgpu_ring {
>  	unsigned int    entry_index;
>  	/* store the cached rptr to restore after reset */
>  	uint64_t cached_rptr;
> -
>  };
>  
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> -- 
> 2.48.1
> 

-- 
Rodrigo Siqueira
