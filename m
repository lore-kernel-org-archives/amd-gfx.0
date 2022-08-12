Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625FAC00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 11:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CC4112CED;
	Fri, 12 Aug 2022 11:39:32 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D7D9A85D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 11:39:24 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id y13so1527836ejp.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=NKnvBrSorWxczg0raWCrTMjgPQ+YZHC9w7rGBeUA1bg=;
 b=e0Qi36FSBNL36O8Ize+xZNs6KD9SzOsJBiJnf2ztdWfLGvxBX8Lf3iahaIo5zspteN
 8UpDWXD2YTR1Sai1QDbcoF8tU/CEnLnxW51N2ExZQLykLo+/r1IEwStPDvzWxYXTt4WS
 3S5bl5al68KXZgFoOU8Qd7l2WSwDl1VlFX+iv2kfmGXnuxu5WjW7uQkH+2eYqrVQwL/N
 CY9wpeomGAOsOWaya2MLfoCpuUSwjRlWcPk4VgPx4CJ4GEplpazxyC+I6X5M0f+y05n0
 B1Mx48lDAT9fzsPFNGRSX0wYtDQpieUZm8dDPwvmpkljpaa8dQSgKK9h6bzOG5XjkfLX
 IFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=NKnvBrSorWxczg0raWCrTMjgPQ+YZHC9w7rGBeUA1bg=;
 b=Pp+Ow+ryplxuze2TI+KnurEYizw4z1EQIW+4TLBksqDi+jWgEUyY6dmNqmiit/9Jql
 0TwxCc9eT6Z6cA/qpWqZdiraVFhZh0yyiJ2AGfqeWIAe37pBkxzyXQTHRIRMCCN5jN/m
 iK9y1VEaq3AODIRcMO8QejjZg2kTpBLg4YGM3ab4PmmjiqWb9lG+krwcvpOtP7zCvXfr
 cdaGUGHq6P8/2lmB55kl5DPDd27lgF2JFjXZrPW2S0kBR+ZrDEB2/ST4meNgTy+vMLv+
 kpwA709U9sYhdmam/UC5n5m9SPjVLeNCDcsuUp65rYyTJimc4zMF6KavK4Mm0Rv+Htw+
 N2GQ==
X-Gm-Message-State: ACgBeo0Zu6WBDfjLwCUEkqrmvtD1u+IsKoKYymRUdHB4PUtRt4C6HQcY
 9rVTH3ckmisDgG9wkh97ZoOLRmIHiuo=
X-Google-Smtp-Source: AA6agR60WHggCBzcSzVNy0TAJTy7nCNk8R6R3pr4T61KT6CPMm+wzdunfPVBDmw/E3XDUPRVDbUM9A==
X-Received: by 2002:a17:907:3e93:b0:730:a92b:e7e1 with SMTP id
 hs19-20020a1709073e9300b00730a92be7e1mr2474115ejc.621.1660304363095; 
 Fri, 12 Aug 2022 04:39:23 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 r30-20020a50d69e000000b0043bbc9503ddsm1197869edi.76.2022.08.12.04.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Aug 2022 04:39:22 -0700 (PDT)
Message-ID: <a8d38251-92ab-17ce-a3cd-c68fb7cb3ff7@gmail.com>
Date: Fri, 12 Aug 2022 13:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: modify mcbp implement for gfx9(v3)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220811031953.963227-1-Jiadong.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220811031953.963227-1-Jiadong.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Ray.Huang@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 11.08.22 um 05:19 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> 1. Use unmap_queue package to trigger preemption on gfx9
>     Add trailing fence to track the preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions
>     for the resumed ibs.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 161 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>   3 files changed, 143 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 82c178a9033a..ca626f0ad7b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)

> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)

Ok, that here needs much more explanation why you need it and how all 
this is supposed to work?

Regards,
Christian.

>   
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5332899642dc..887021fd56aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -751,7 +751,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>   static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>   				struct amdgpu_cu_info *cu_info);
>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>   static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>   static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   					  void *ras_error_status);
> @@ -824,9 +824,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
>   			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
>   
>   	if (action == PREEMPT_QUEUES_NO_UNMAP) {
> -		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, seq);
> +		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +
>   	} else {
>   		amdgpu_ring_write(kiq_ring, 0);
>   		amdgpu_ring_write(kiq_ring, 0);
> @@ -5446,11 +5447,16 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> +		if (flags & AMDGPU_IB_PREEMPTED)
> +			control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>   		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -			gfx_v9_0_ring_emit_de_meta(ring);
> +			gfx_v9_0_ring_emit_de_meta(ring,
> +				 (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ?
> +					true : false);
>   	}
>   
>   	amdgpu_ring_write(ring, header);
> @@ -5505,6 +5511,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>   	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>   	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
>   
>   	/* RELEASE_MEM - flush caches, send int */
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
> @@ -5515,6 +5522,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   					       EOP_TC_WB_ACTION_EN |
>   					       EOP_TC_MD_ACTION_EN)) |
>   				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> +				 (exec ? EOP_EXEC : 0x0) |
>   				 EVENT_INDEX(5)));
>   	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>   
> @@ -5620,33 +5628,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> -static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_ce_ib_state ce_payload = {0};
> -	uint64_t csa_addr;
> +	uint64_t offset, ce_payload_gpu_addr;
> +	void *ce_payload_cpu_addr;
>   	int cnt;
>   
>   	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> +
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		ce_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +	}
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>   	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
> +					   sizeof(ce_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
> +					   sizeof(ce_payload) >> 2);
> +}
> +
> +static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +	int i, r = 0;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	unsigned long flags;
> +
> +	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* assert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +	ring->trail_seq += 1;
> +	amdgpu_ring_alloc(ring, 13);
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +	/*reset the CP_VMID_PREEMPT after trailing fence*/
> +	amdgpu_ring_emit_wreg(ring,
> +				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> +				  0x0);
> +
> +	/* assert IB preemption, emit the trailing fence */
> +	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +				   ring->trail_fence_gpu_addr,
> +				   ring->trail_seq);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	/* poll the trailing fence */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (ring->trail_seq ==
> +		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i >= adev->usec_timeout) {
> +		r = -EINVAL;
> +		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +
> +	/* deassert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, true);
> +	return r;
>   }
>   
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_de_ib_state de_payload = {0};
> -	uint64_t csa_addr, gds_addr;
> +	uint64_t offset, gds_addr, de_payload_gpu_addr;
> +	void *de_payload_cpu_addr;
>   	int cnt;
>   
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> -	gds_addr = csa_addr + 4096;
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		de_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gds_backup) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +
> +		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +				 PAGE_SIZE);
> +	}
> +
>   	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>   	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>   
> @@ -5656,9 +5766,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
> +					   sizeof(de_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
> +					   sizeof(de_payload) >> 2);
>   }
>   
>   static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> @@ -5674,8 +5790,10 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> -	if (amdgpu_sriov_vf(ring->adev))
> -		gfx_v9_0_ring_emit_ce_meta(ring);
> +	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
> +		gfx_v9_0_ring_emit_ce_meta(ring,
> +					(!amdgpu_sriov_vf(ring->adev) &&
> +						flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -7024,6 +7142,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>   	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.preempt_ib = gfx_v9_0_ring_preempt_ib,
>   	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 799925d22fc8..614e9f8467fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -162,6 +162,7 @@
>   		 * 2 - Bypass
>   		 */
>   #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
> +#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
>   #define	PACKET3_COPY_DATA				0x40
>   #define	PACKET3_PFP_SYNC_ME				0x42
>   #define	PACKET3_COND_WRITE				0x45
> @@ -184,6 +185,7 @@
>   #define		EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
>   #define		EOP_TC_NC_ACTION_EN			(1 << 19)
>   #define		EOP_TC_MD_ACTION_EN			(1 << 21) /* L2 metadata */
> +#define		EOP_EXEC					(1 << 28) /* For Trailing Fence */
>   
>   #define		DATA_SEL(x)                             ((x) << 29)
>   		/* 0 - discard

