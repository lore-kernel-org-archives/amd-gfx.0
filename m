Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D94C369C2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 13:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA48110E05F;
	Wed, 16 Apr 2025 13:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeYt8qZM";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F210E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 13:52:27 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso53190695e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744811546; x=1745416346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nTTb1odMXISpQvcHYiL+Ly/K6T7CvqztnhjmvonsGw8=;
 b=JeYt8qZMlr9dBXhW4LrKJSRV1WNTweng0qDaGwcolKTMTWaYw4mPWFKZIriZhKBSF6
 FF+w5ggk0D0/tuv+ZixKWcEaYE187+qYbz4NExejcuJoq6jRmH+HhkCNhq7lPCGS3dzm
 IfUiQ3YrBkB3/Evl81qVekq7anT5mzHlkALK/9oVOHcypuqIBFtzBYR7SgAFc6ITAk1g
 8R4CFf0PRri2kEPdPWi726X6m429gxyGR4wHzBljD/LTzFfFMXU+htZxBjokdNXjp7Xf
 2+4KQELIoYXaLm1Gl8z+bvBRCVi2nBTF3JQOP9B/6gNLg/nR2q5snxMWtX0J77fnI5Zh
 pFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811546; x=1745416346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTTb1odMXISpQvcHYiL+Ly/K6T7CvqztnhjmvonsGw8=;
 b=j9H+WxkfJvQjkl+BqYlCRoo8jhvjeLzEjtK4AaE52ask5wixJg1EeCH5BWgFDG5z3b
 4yKVtfl31waOkVliwg7Fv4OO+hmc0NgekjaPYvZixWhheAgAnSDMndI++vFkhm37ubPL
 esIbOQAcXxNlCdh7Wq2kzY2D7viRgOelhPllJD32IvD/ghQM63QTNBGhJ1AWmBm0sGjt
 W6+rpGwF8HvvlogfAyg3kDJrQyvjO4bJjTePFrBnCSeI6+S1QicZPLmBCQGUvTr7jqvA
 QEwn/QElNFsDjUzUgU4RxopjOoTKzgNs6Xsbd67Nl+ibssLWUEjiNYT2jOWX7z23Wrkv
 DTaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZcgRXKdlQ/OAlwIg1Bun/e85T9KEKThdTBPH3A74CJz/gs6B26p/0N/AiyXg3g1Wt08lk9fJm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOca85/DVA89mhnOIL/O2zdHqAxAPi1HuyQKdFlbEt3xYwih0R
 mdb+2BqWe0wLJRbKYh+2fHgER2WK+wm4/6X4+NiEBxmluXXsa/8WhxwwFElN
X-Gm-Gg: ASbGncvFX35/NCl+uFtinm89rhIIDC9gKJUR6h2JNf10vxNdH1JTp5b+v2ygNB4VJdy
 9YgLZzh+v6GH5VLJr24cZnLrnlgy7Fe73JQWK7mAdJdNp5gDi2XP7he/hYPufrZuiX3bYLCyxOM
 WQ0RY5en0ngMA+uKk7TDSCbRQo7Cq8rViijOgf4BfPrc7d9OGd42jMm0ywf/HSFNF0egVzlCdn7
 LbQXb5M3K7co09iOctbxdvuaR1P7xHnXwgfco/5rbjB2RMM7Xz65gcWrDEhHzPXy37m0n2Ri9qv
 o9Biy91hpDfzyu/82fMEjjdhlDITbxyI9odrFlRiygqK2CILJWnXq5KAkIuo9w2S6AKzsw==
X-Google-Smtp-Source: AGHT+IHQJgMGFbOA2NJOwR0dioSrlj3hpAm3JU5czo0UCRD7pyTKeoSBWV0uwfarXLkaboM2HuVHCw==
X-Received: by 2002:a05:600c:3b8a:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-4405d6cc4f2mr23557775e9.31.1744811545233; 
 Wed, 16 Apr 2025 06:52:25 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963fccsm17050980f8f.3.2025.04.16.06.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:52:24 -0700 (PDT)
Message-ID: <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
Date: Wed, 16 Apr 2025 15:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, emily.deng@amd.com
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250414104655.336497-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
>
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
>  6 files changed, 82 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5b60d714e089..e706afcb7e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>  {
>  	u64 hive_vram_start = 0;
> -	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
> -	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> -	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> +	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes;
> +
> +	hive_vram_end = ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21) - 1;
> +
> +	if (!mc->vram_start) {
> +		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> +		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> +		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> +			mc->mc_vram_size >> 20, mc->vram_start,
> +			mc->vram_end, mc->real_vram_size >> 20);
> +	}
> +
>  	mc->gart_start = hive_vram_end + 1;
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	mc->fb_start = hive_vram_start;
>  	mc->fb_end = hive_vram_end;
> -	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> -			mc->mc_vram_size >> 20, mc->vram_start,
> -			mc->vram_end, mc->real_vram_size >> 20);
> -	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> -			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
> +
> +	dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n",
> +			mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc->gart_start, mc->gart_end);
>  }
>  
>  /**
> @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  				     &job);
>  	if (r)
>  		goto error_alloc;
> -
> -	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> +							adev->gmc.pdb0_bo :
> +							adev->gart.bo);
>  	job->vm_needs_flush = true;
>  	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>  	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 */
>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
> -	u64 vram_addr = adev->vm_manager.vram_base_offset -
> +	u64 vram_addr_first = adev->vm_manager.vram_base_offset -
>  		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	u64 vram_addr = adev->vm_manager.vram_base_offset;
>  	u64 vram_end = vram_addr + vram_size;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
> @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		vram_addr = vram_addr_first;
> +		vram_end = vram_addr + vram_size;
> +	}
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> -	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
> -		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
> +	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
> +		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
> +			(vram_addr >= vram_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,
> +			flags);
> +	}
>  
>  	/* The n+1'th PDE0 entry points to a huge
>  	 * PTB who has more than 512 entries each
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..758b47240c6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>  	struct amdgpu_bo		*pdb0_bo;
>  	/* CPU kmapped address of pdb0*/
>  	void				*ptr_pdb0;
> +	bool enable_pdb0;
>  
>  	/* MALL size */
>  	u64 mall_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d90e9daf5a50..83a3444c69d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>  		goto error_unpin;
>  	}
>  
> -	if (gpu_addr)
> +	if (gpu_addr) {
>  		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> +		if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_pdb0) {
> +			if ((*bo_ptr)->tbo.resource->mem_type == TTM_PL_VRAM) {
> +				*gpu_addr -= amdgpu_ttm_domain_start(adev, TTM_PL_VRAM);
> +			}
> +		}
> +	}

Please NAK to that approach here. The GPU offset should still point into the mapped VRAM.

>  
>  	if (cpu_addr) {
>  		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..5ebb92ac9fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 7c7a9fe6be6d..73ac05b9a1bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>  	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>  
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +	    adev->gmc.enable_pdb0 = amdgpu_sriov_vf(adev);
>  	return 0;
>  }
>  
> @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  {
>  	u64 base = adev->mmhub.funcs->get_fb_location(adev);
>  
> +	if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> +		adev->gmc.vmid0_page_table_depth = 1;
> +		adev->gmc.vmid0_page_table_block_size = 12;
> +	} else {
> +		adev->gmc.vmid0_page_table_depth = 0;
> +		adev->gmc.vmid0_page_table_block_size = 0;
> +	}
> +

What is the justification to moving that stuff around?

>  	amdgpu_gmc_set_agp_default(adev, mc);
>  
>  	/* add the xgmi offset of the physical node */
> @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> -		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
> +		if (!adev->gmc.enable_pdb0)
> +			amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
> +		else
> +			amdgpu_gmc_sysvm_location(adev, mc);
>  		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
>  			amdgpu_gmc_agp_location(adev, mc);
>  	}
> @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> -		adev->gmc.vmid0_page_table_depth = 1;
> -		adev->gmc.vmid0_page_table_block_size = 12;
> -	} else {
> -		adev->gmc.vmid0_page_table_depth = 0;
> -		adev->gmc.vmid0_page_table_block_size = 0;
> -	}
> -
>  	/* Initialize common gart structure */
>  	r = amdgpu_gart_init(adev);
>  	if (r)
> @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)

Drop the connected_to_cpu check here.

>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)

And here.

>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index fe0710b55c3a..13b229d07ac4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *adev, int hu
>  static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *adev,
>  					       int hubid)
>  {
> -	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev->gmc.pdb0_bo : adev->gart.bo);

That can be written as adev->gmc.pdb0_bo ?: adev->gart.bo

>  
>  	mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
>  
> -	WREG32_SOC15_OFFSET(MMHUB, 0,
> +	if (adev->gmc.pdb0_bo) {
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> +				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +				    (u32)(adev->gmc.fb_start >> 12));
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> +				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +				    (u32)(adev->gmc.fb_start >> 44));
> +
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> +				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +				    (u32)(adev->gmc.gart_end >> 12));
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
> +				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +				    (u32)(adev->gmc.gart_end >> 44));
> +	} else {
> ++		WREG32_SOC15_OFFSET(MMHUB, 0,
>  			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
>  			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>  			    (u32)(adev->gmc.gart_start >> 12));
> -	WREG32_SOC15_OFFSET(MMHUB, 0,
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
>  			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
>  			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>  			    (u32)(adev->gmc.gart_start >> 44));

When you indent the WREG32_SOC15_OFFSET() you need to indent the following lines as well.

>  
> -	WREG32_SOC15_OFFSET(MMHUB, 0,
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
>  			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
>  			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>  			    (u32)(adev->gmc.gart_end >> 12));
> -	WREG32_SOC15_OFFSET(MMHUB, 0,
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
>  			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
>  			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>  			    (u32)(adev->gmc.gart_end >> 44));
> +	}

The programming of the end addr is still the same, you don't need to change anything here.

Regards,
Christian.

>  }
>  
>  static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,

