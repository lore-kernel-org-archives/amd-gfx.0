Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6456C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3443510E371;
	Wed, 21 Sep 2022 12:52:42 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6242F10E3EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:52:39 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id z97so8497580ede.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=ex7/+LCTniYntvTST8z63/p9rsA0k2bs4umlNzLSSJI=;
 b=fX7mu4wZ4PJfxPIFFFOi8qUSdscTq/SR0O1pI9Bm4xsnS+ffDcg8VN5hQeJoQQXUTE
 dDm6v31koTYsk4UkqQGDNm93FsW3E0LNBRndxB90lfDSgUv841sH9f4VdXJ/UBy+ba9n
 2U5hU9qYWBtRHYldw+qtcTeo+rlwAnHGLvcWx0/37vBrV131s7X6GCcextYinfLBAx9+
 WTm5fNBQnmDLpdkYP3xZY419qY18t57YVE6B1+v5YfpCf/ZLf82CfXOt0x9R4MYR/YIK
 OyrB5ZR80U+fHygZqa0BMd4tZr3vFQ/pIFpjJldyBCn0LFpW3lWZHT7C88q/zrD1iDcv
 +zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=ex7/+LCTniYntvTST8z63/p9rsA0k2bs4umlNzLSSJI=;
 b=3Wrsl9aQaOaBlDa2Hc6p5nLkAQSEyYxXejAp0OMq3cSRswy5TbEoUq+BWSoG2RL96z
 aKlmDgkMFGNQLkB6xr2ElA2wLcStvVB1ZVIXTEQkBX6U5Phil3hjeA1gEsDTomsG/cwd
 mJO6g1x9zl6uMnbuxLC5US7Z12iarifEmbid/TR94NImoKYrRhp9+vtypOvIzfBnmGr8
 4CX1TJEA5+i/oQsrEVf5SXVAjFd7BWOhuNJZnJlkr25VdjDt8S5n8t0rS/m8eysaIBmm
 f/jCS1TAZ5xqz4Nf+bh7LmjIhYw7gY8JqFx12QwUoEJPQAyjcq12tIvcmVRFb95qEx5o
 KyuQ==
X-Gm-Message-State: ACrzQf2yH9EeXaGp6k5MoyDlxuYaveRakd9MppUMo2ZzTf1weBoKeDnG
 yh66TpojiEVuPFlGhb1kI4A=
X-Google-Smtp-Source: AMsMyM4LfQQtzSwutfyCzWWrU21J7uJo95Z4zgvvEGgTBOLEwCw3fyKsFkw/yoeZSajf/J/n7+AZ7w==
X-Received: by 2002:a05:6402:40cc:b0:452:697e:da18 with SMTP id
 z12-20020a05640240cc00b00452697eda18mr24298458edb.288.1663764757743; 
 Wed, 21 Sep 2022 05:52:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:75a1:d004:7ffb:260d?
 ([2a02:908:1256:79a0:75a1:d004:7ffb:260d])
 by smtp.gmail.com with ESMTPSA id
 qw17-20020a170906fcb100b00775f6081a87sm1204048ejb.121.2022.09.21.05.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Sep 2022 05:52:36 -0700 (PDT)
Message-ID: <eb1a44b6-2f4f-1797-42e5-f2a0bc251542@gmail.com>
Date: Wed, 21 Sep 2022 14:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v3)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-3-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220921094117.1071106-3-jiadong.zhu@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> 1. Modify the unmap_queue package on gfx9. Add trailing fence to track the
>     preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions for the resumed ibs.
>
> v2: Restyle code not to use ternary operator.
> v3: Modify code format.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 182 +++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>   3 files changed, 156 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 275b885363c3..aeb48cc3666c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -60,6 +60,7 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>   
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4a8be9595459..c568a4f5b81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -753,7 +753,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>   static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>   				struct amdgpu_cu_info *cu_info);
>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>   static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>   static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   					  void *ras_error_status);
> @@ -826,9 +826,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
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
> @@ -5357,11 +5358,17 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {

Why does this now depend on the amdgpu_mcbp parameter?

The goal was to completely remove that parameter and always enable the 
feature.

Regards,
Christian.

>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> +		if (flags & AMDGPU_IB_PREEMPTED)
> +			control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>   		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -			gfx_v9_0_ring_emit_de_meta(ring);
> +			gfx_v9_0_ring_emit_de_meta(ring,
> +						   (!amdgpu_sriov_vf(ring->adev) &&
> +						   flags & AMDGPU_IB_PREEMPTED) ?
> +						   true : false);
>   	}
>   
>   	amdgpu_ring_write(ring, header);
> @@ -5416,17 +5423,23 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>   	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>   	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
> +	uint32_t dw2 = 0;
>   
>   	/* RELEASE_MEM - flush caches, send int */
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
> -	amdgpu_ring_write(ring, ((writeback ? (EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_NC_ACTION_EN) :
> -					      (EOP_TCL1_ACTION_EN |
> -					       EOP_TC_ACTION_EN |
> -					       EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_MD_ACTION_EN)) |
> -				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> -				 EVENT_INDEX(5)));
> +
> +	if (writeback) {
> +		dw2 = EOP_TC_WB_ACTION_EN | EOP_TC_NC_ACTION_EN;
> +	} else {
> +		dw2 = EOP_TCL1_ACTION_EN | EOP_TC_ACTION_EN |
> +				EOP_TC_WB_ACTION_EN | EOP_TC_MD_ACTION_EN;
> +	}
> +	dw2 |= EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5);
> +	if (exec)
> +		dw2 |= EOP_EXEC;
> +
> +	amdgpu_ring_write(ring, dw2);
>   	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>   
>   	/*
> @@ -5531,33 +5544,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
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
> +				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +	/*reset the CP_VMID_PREEMPT after trailing fence*/
> +	amdgpu_ring_emit_wreg(ring,
> +			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> +			      0x0);
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
> +			le32_to_cpu(*ring->trail_fence_cpu_addr))
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
> @@ -5567,9 +5682,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
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
> @@ -5585,8 +5706,10 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> -	if (amdgpu_sriov_vf(ring->adev))
> -		gfx_v9_0_ring_emit_ce_meta(ring);
> +	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
> +		gfx_v9_0_ring_emit_ce_meta(ring,
> +					   (!amdgpu_sriov_vf(ring->adev) &&
> +					   flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -6914,6 +7037,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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

