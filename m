Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56FC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 07:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD1161168
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 07:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD1161168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C796E062;
	Thu,  6 May 2021 07:09:28 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D015A6E061
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 07:09:26 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id n2so4442038wrm.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 May 2021 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=lH0zZaTG2/gMqAB7e4/AEgsKIxZZqiyG3cjBugTWR8M=;
 b=dhCRHKnB6ZLKU59PTTN8persNwaWfrty0vulGebX6a7vbE/jlphN8FxMlPux5GRkxF
 3T7uFe7PnQCPGaPS4f/nTg6BwGCFOYt/gB8OjV/gTfa7rHkHXJGFg55xIBZhlnzwKKdC
 HuXO5qEEjUevF2ohGL7Xeoq05HYiaYK/fpmpNRaTaQA5S2DOIW6K6oT+lHe3pbFcxMCr
 7V6wgZP2PtRzp2UggiozoNiagth8+fPtOrs9eoRnJjUT1zxByn9+UzlDVDAYRGuV9TVW
 pXoE5+vZRCm4za420hXf+SYWdqsO9GDFsw5UgMt4VtfOUvp/oY1OSdIC/fWg+KELIlU3
 PuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lH0zZaTG2/gMqAB7e4/AEgsKIxZZqiyG3cjBugTWR8M=;
 b=nPUqfq9F0iPPMO2xpdeTdyePuGV6STQChWZhPpmilnqx8RVmENAd09Md+ax5XrIj+l
 pJw18FpQFGb5CAnAW445YXme+q/homS9I1ap/MKPawN4gW8GMm5ykoLUGndH+bX+9eVb
 YevmPD1A9yd4LVx9I4YxbBfiLE8w4vwUvJkoXqjh9d21TkI/1ciu/FjpAugo3EVQT5pV
 oF061G2I4uTo0TCzHdu30hJYcDXIa/LuLlQ1OzksAhGsmGVGtCwfvA9V47hBizWWVNF/
 czYtVYIzoa+lsbre2jShV43K64QH4f4UV+CLPUAcFFcBncWcoybIG82xK2zlbd9jSWZN
 k9Ew==
X-Gm-Message-State: AOAM532QIi+n+BO5KD3jW7PvbzMOmQ/yCM1MpYAQS4mn1r4pQ+NFyP9A
 L1SBen4lPw9FPCzrJVVpbi16SW0MveKjtb4v
X-Google-Smtp-Source: ABdhPJyFWc9TPqah6MsyaQIkPOIqoUXonvLLc2D6GQUkJmGXOUOdPvoTafeVo3bEYCIc5wL7h4jy4A==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr3177314wrz.256.1620284965430; 
 Thu, 06 May 2021 00:09:25 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:13a:17a0:fb6f:ee00:90ce:69a?
 ([2a01:e0a:13a:17a0:fb6f:ee00:90ce:69a])
 by smtp.gmail.com with ESMTPSA id 3sm9998754wma.45.2021.05.06.00.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 May 2021 00:09:25 -0700 (PDT)
Subject: Re: [PATCH v3] drm/amdgpu: add support for user trap handlers
To: Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
 <20210506065414.4993-1-samuel.pitoiset@gmail.com>
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Message-ID: <cb823f79-fce6-4360-395d-dd55fa47ffd6@gmail.com>
Date: Thu, 6 May 2021 09:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506065414.4993-1-samuel.pitoiset@gmail.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added GF10.3 support.

I re-tested this on GFX9 and it still works, though on GFX10+ the trap 
handler is never reached, is there something obviously wrong in this patch?

Thanks!

On 5/6/21 8:54 AM, Samuel Pitoiset wrote:
> A trap handler can be used by userspace to catch shader exceptions
> like divide by zero, memory violations etc.
>
> On GFX6-GFX8, the registers used to configure TBA/TMA aren't
> privileged and can be configured from userpace.
>
> On GFX9+ they are per VMID and privileged, only the KMD can
> configure them. At the moment, we don't know how to set them
> via the CP, so they are only emitted if a VMID is reserved.
>
> This introduces a new CS chunk that can be used to set the
> TBA/TMA virtual address at submit time.
>
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 31 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 20 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 47 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 19 ++++++++++
>   include/uapi/drm/amdgpu_drm.h            |  8 ++++
>   9 files changed, 136 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 90136f9dedd6..0cc9f5eb0484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -103,6 +103,19 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
>   	return r;
>   }
>   
> +static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser *p,
> +				     struct drm_amdgpu_cs_chunk_trap *data,
> +				     uint64_t *tba_addr, uint64_t *tma_addr)
> +{
> +	if (!data->tba_addr || !data->tma_addr)
> +		return -EINVAL;
> +
> +	*tba_addr = data->tba_addr;
> +	*tma_addr = data->tma_addr;
> +
> +	return 0;
> +}
> +
>   static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> @@ -111,6 +124,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	uint64_t *chunk_array;
>   	unsigned size, num_ibs = 0;
>   	uint32_t uf_offset = 0;
> +	uint64_t tba_addr = 0, tma_addr = 0;
>   	int i;
>   	int ret;
>   
> @@ -213,6 +227,19 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   
>   			break;
>   
> +		case AMDGPU_CHUNK_ID_TRAP:
> +			size = sizeof(struct drm_amdgpu_cs_chunk_trap);
> +			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
> +				ret = -EINVAL;
> +				goto free_partial_kdata;
> +			}
> +
> +			ret = amdgpu_cs_user_trap_chunk(p, p->chunks[i].kdata,
> +							&tba_addr, &tma_addr);
> +			if (ret)
> +				goto free_partial_kdata;
> +			break;
> +
>   		case AMDGPU_CHUNK_ID_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
> @@ -238,6 +265,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   
>   	if (p->uf_entry.tv.bo)
>   		p->job->uf_addr = uf_offset;
> +
> +	p->job->tba_addr = tba_addr;
> +	p->job->tma_addr = tma_addr;
> +
>   	kvfree(chunk_array);
>   
>   	/* Use this opportunity to fill in task info for the vm */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d4a40cd0fe09..21c3b6eaf359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -94,9 +94,10 @@
>    * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
>    * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
>    * - 3.41.0 - Add video codec query
> + * - 3.42.0 - Add AMDGPU_CHUNK_ID_TRAP
>    */
>   #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	41
> +#define KMS_DRIVER_MINOR	42
>   #define KMS_DRIVER_PATCHLEVEL	0
>   
>   int amdgpu_vram_limit;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 0c3b4fa1f936..d165970ffdd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -58,6 +58,10 @@ struct amdgpu_vmid {
>   	uint32_t		oa_base;
>   	uint32_t		oa_size;
>   
> +	/* user trap */
> +	uint64_t		tba_addr;
> +	uint64_t		tma_addr;
> +
>   	unsigned		pasid;
>   	struct dma_fence	*pasid_mapping;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..b8ed5b13ea44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -62,6 +62,10 @@ struct amdgpu_job {
>   	/* user fence handling */
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
> +
> +	/* user trap handling */
> +	uint64_t		tba_addr;
> +	uint64_t		tma_addr;
>   };
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ca1622835296..550d71b2a1a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -199,6 +199,8 @@ struct amdgpu_ring_funcs {
>   	int (*preempt_ib)(struct amdgpu_ring *ring);
>   	void (*emit_mem_sync)(struct amdgpu_ring *ring);
>   	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
> +	void (*emit_trap_handler)(struct amdgpu_ring *ring, uint32_t vmid,
> +				  uint64_t tba_addr, uint64_t tma_addr);
>   };
>   
>   struct amdgpu_ring {
> @@ -263,6 +265,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)->funcs->emit_vm_flush((r), (vmid), (addr))
>   #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)->funcs->emit_fence((r), (addr), (seq), (flags))
>   #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
> +#define amdgpu_ring_emit_trap_handler(r, v, tba, tma) (r)->funcs->emit_trap_handler((r), (v), (tba), (tma))
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f2513be72980..53552f7cc66b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1107,15 +1107,22 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	bool vm_flush_needed = job->vm_needs_flush;
>   	struct dma_fence *fence = NULL;
>   	bool pasid_mapping_needed = false;
> +	bool trap_handler_needed = false;
>   	unsigned patch_offset = 0;
>   	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
>   	int r;
>   
> -	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid) {
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>   
> +		trap_handler_needed = ring->funcs->emit_trap_handler && (
> +			id->tba_addr != job->tba_addr ||
> +			id->tma_addr != job->tma_addr);
> +	}
> +
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>   		gds_switch_needed = true;
> +		trap_handler_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   	}
> @@ -1127,12 +1134,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	mutex_unlock(&id_mgr->lock);
>   
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> +	trap_handler_needed &= !!ring->funcs->emit_trap_handler;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
>   
> -	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
> +	if (!vm_flush_needed && !gds_switch_needed &&
> +	    !trap_handler_needed && !need_pipe_sync)
>   		return 0;
>   
>   	if (ring->funcs->init_cond_exec)
> @@ -1186,6 +1195,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   					    job->oa_size);
>   	}
>   
> +	if (ring->funcs->emit_trap_handler && trap_handler_needed) {
> +		id->tba_addr = job->tba_addr;
> +		id->tma_addr = job->tma_addr;
> +		amdgpu_ring_emit_trap_handler(ring, job->vmid, job->tba_addr,
> +					      job->tma_addr);
> +	}
> +
>   	if (ring->funcs->patch_cond_exec)
>   		amdgpu_ring_patch_cond_exec(ring, patch_offset);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 49fd10a15707..26bbde676cf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -177,6 +177,15 @@
>   #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
>   #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0
>   
> +#define mmSQ_SHADER_TBA_LO_Sienna_Cichlid 0x10b2
> +#define mmSQ_SHADER_TBA_LO_Sienna_Cichlid_BASE_IDX 0
> +#define mmSQ_SHADER_TBA_HI_Sienna_Cichlid 0x10b3
> +#define mmSQ_SHADER_TBA_HI_Sienna_Cichlid_BASE_IDX 0
> +#define mmSQ_SHADER_TMA_LO_Sienna_Cichlid 0x10b4
> +#define mmSQ_SHADER_TMA_LO_Sienna_Cichlid_BASE_IDX 0
> +#define mmSQ_SHADER_TMA_HI_Sienna_Cichlid 0x10b5
> +#define mmSQ_SHADER_TMA_HI_Sienna_Cichlid_BASE_IDX 0
> +
>   #define GFX_RLCG_GC_WRITE_OLD	(0x8 << 28)
>   #define GFX_RLCG_GC_WRITE	(0x0 << 28)
>   #define GFX_RLCG_GC_READ	(0x1 << 28)
> @@ -7531,6 +7540,42 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>   				    (1 << (oa_size + oa_base)) - (1 << oa_base));
>   }
>   
> +static void gfx_v10_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
> +					    uint32_t vmid,
> +					    uint64_t tba_addr,
> +					    uint64_t tma_addr)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	nv_grbm_select(adev, 0, 0, 0, vmid);
> +	switch (adev->asic_type) {
> +	case CHIP_SIENNA_CICHLID:
> +	case CHIP_NAVY_FLOUNDER:
> +	case CHIP_VANGOGH:
> +	case CHIP_DIMGREY_CAVEFISH:
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO_Sienna_Cichlid,
> +				 lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI_Sienna_Cichlid,
> +				 upper_32_bits(tba_addr >> 8) |
> +					1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT);
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO_Sienna_Cichlid,
> +				 lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI_Sienna_Cichlid,
> +				 upper_32_bits(tma_addr >> 8));
> +		break;
> +	default:
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upper_32_bits(tba_addr >> 8) |
> +					1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT);
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upper_32_bits(tma_addr >> 8));
> +		break;
> +	}
> +	nv_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static int gfx_v10_0_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -9014,6 +9059,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>   	.soft_recovery = gfx_v10_0_ring_soft_recovery,
>   	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
> +	.emit_trap_handler = gfx_v10_0_ring_emit_trap_handler,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
> @@ -9050,6 +9096,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>   	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>   	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
> +	.emit_trap_handler = gfx_v10_0_ring_emit_trap_handler,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 16a3b279a9ef..417ac13a23b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4250,6 +4250,23 @@ static void gfx_v9_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>   				   (1 << (oa_size + oa_base)) - (1 << oa_base));
>   }
>   
> +static void gfx_v9_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
> +					    uint32_t vmid,
> +					    uint64_t tba_addr,
> +					    uint64_t tma_addr)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, 0, 0, 0, vmid);
> +	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, lower_32_bits(tba_addr >> 8));
> +	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upper_32_bits(tba_addr >> 8));
> +	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, lower_32_bits(tma_addr >> 8));
> +	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upper_32_bits(tma_addr >> 8));
> +	soc15_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static const u32 vgpr_init_compute_shader[] =
>   {
>   	0xb07c0000, 0xbe8000ff,
> @@ -6879,6 +6896,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>   	.soft_recovery = gfx_v9_0_ring_soft_recovery,
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +	.emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
> @@ -6918,6 +6936,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>   	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
> +	.emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 2b487a8d2727..17322ad4754e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -552,6 +552,7 @@ struct drm_amdgpu_gem_va {
>   #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
> +#define AMDGPU_CHUNK_ID_TRAP            0x0a
>   
>   struct drm_amdgpu_cs_chunk {
>   	__u32		chunk_id;
> @@ -646,6 +647,13 @@ struct drm_amdgpu_cs_chunk_syncobj {
>          __u64 point;
>   };
>   
> +struct drm_amdgpu_cs_chunk_trap {
> +	/** Trap Base Address */
> +       __u64 tba_addr;
> +	/** Trap Memory Address */
> +       __u64 tma_addr;
> +};
> +
>   #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ	0
>   #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD	1
>   #define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD	2
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
