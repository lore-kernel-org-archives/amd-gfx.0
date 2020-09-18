Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF15BC43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 11:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5593421D42
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEN1W2SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593421D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7516ECD7;
	Fri, 18 Sep 2020 11:27:31 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C1B6ECD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 11:27:30 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id lo4so7603526ejb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hXaBpysZzQ1vI+HhPMtYW+jQzYbGUoCK6Hq3sYpljVs=;
 b=iEN1W2SLPr9dWPf/hiovYGNKtcRKW7yoWn9qpi0k1e/ZuRo6tjVypt/pObKajp1Uy5
 J3kCP/EP9ff3Je2/HmrNSl6fhqUjFXS39VZCC8fjQkfhKOdm+pzBVatqWNV7C72t47LH
 bIVBtM2xLeWNxl61i+mI6/IjcNUJNSL3Vz3fNcX+5SBo9/u4agumypJ4iwpFeKZNdkPL
 xJGCs4vZ44lvJE2iWTVv/Bt6AY/FZ5TqFqm/I/LP7cfhg3VwPW8Ww4qMIpdEis005YJA
 NQtBtWwPGQAlNkaRscUtHdqf/q06+dDHvgjtkwE1vRiru+mjmAGeo6Ge0HXDqEJ/FqWg
 s+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hXaBpysZzQ1vI+HhPMtYW+jQzYbGUoCK6Hq3sYpljVs=;
 b=VDw19XHU7zi5KTxLA6rgU8mN6IH2bPSH19xlQgf2TjbMDsdiWlSmZZfsuYMi+jWHbj
 ozCO27yeuQq3yhRFnUQDt5yUfbx8ato+bZfmw3Ul56NxWU4mqlZ/wBMxNLgqq+DMv+IJ
 APay6ppwDHDwMv+THNLx+0lKkhL+7pY0QwbAKUgBmDkLJ0967eB/gkT1UevGVwZUGSxx
 deXRos79B2CuJXMLEPKb6CiRTb6B8zyZD8wscGEZ88Ypa+yRyonoB3H5fTyoRkC7ouNZ
 h16SWU4xpWYOYdplfN37SC5kNoQvVcpGof0xg/1fePZH6pIgR2s0EIsClA/FFJl/xbgt
 oEuQ==
X-Gm-Message-State: AOAM531bJ9UWKAnCWjuUJP456fjIjICycy8PK4zkpe1lG+S44D+9i2gu
 CQlm+c5KhV8Cfq0OraXy7CtmxDlVmdc=
X-Google-Smtp-Source: ABdhPJy50vFHYhgq3yxHh5CjTqt6Vm19X3IeZdGar8iH7vek6NRt3UHNj3WtvC47rlOJ1vzDLQVmbA==
X-Received: by 2002:a17:906:4046:: with SMTP id
 y6mr37075378ejj.148.1600428449144; 
 Fri, 18 Sep 2020 04:27:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f13sm2077366ejb.81.2020.09.18.04.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 04:27:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm/amdgpu: support indirect access reg outside of
 mmio bar (v2)
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
References: <1600422710-27228-1-git-send-email-Hawking.Zhang@amd.com>
 <1600422710-27228-3-git-send-email-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5117d8d3-833f-82a0-92cd-407e7d154750@gmail.com>
Date: Fri, 18 Sep 2020 13:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600422710-27228-3-git-send-email-Hawking.Zhang@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.09.20 um 11:51 schrieb Hawking Zhang:
> support both direct and indirect accessor in unified
> helper functions.
>
> v2: Retire indirect mmio access via mm_index/data
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 23 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   |  4 +-
>   4 files changed, 51 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 40ee44b..50341f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,12 +1019,13 @@ int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>   
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   			       uint32_t *buf, size_t size, bool write);
> -uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
> +uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
> +			    uint32_t reg, uint32_t acc_flags);
> +void amdgpu_device_wreg(struct amdgpu_device *adev,
> +			uint32_t reg, uint32_t v,
>   			uint32_t acc_flags);
> -void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
> -		    uint32_t acc_flags);
> -void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
> -		    uint32_t acc_flags);
> +void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
> +			     uint32_t reg, uint32_t v);
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
>   uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
>   
> @@ -1054,8 +1055,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>    */
>   #define AMDGPU_REGS_NO_KIQ    (1<<1)
>   
> -#define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
> -#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
> +#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
> +#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>   
>   #define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
>   #define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
> @@ -1063,9 +1064,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>   #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
>   
> -#define RREG32(reg) amdgpu_mm_rreg(adev, (reg), 0)
> -#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_mm_rreg(adev, (reg), 0))
> -#define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
> +#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)
> +#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_device_rreg(adev, (reg), 0))
> +#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
>   #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
>   #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
>   #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
> @@ -1111,7 +1112,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   		WREG32_SMC(_Reg, tmp);                          \
>   	} while (0)
>   
> -#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_mm_rreg((adev), (reg), false))
> +#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
>   #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
>   #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index abe0c27..2d125b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -267,7 +267,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>   		} else {
>   			r = get_user(value, (uint32_t *)buf);
>   			if (!r)
> -				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
> +				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value);
>   		}
>   		if (r) {
>   			result = r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 77785b2..beef764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -303,10 +303,10 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   }
>   
>   /*
> - * MMIO register access helper functions.
> + * register access helper functions.
>    */
>   /**
> - * amdgpu_mm_rreg - read a memory mapped IO register
> + * amdgpu_device_rreg - read a memory mapped IO or indirect register
>    *
>    * @adev: amdgpu_device pointer
>    * @reg: dword aligned register offset
> @@ -314,33 +314,27 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>    *
>    * Returns the 32 bit value from the offset specified.
>    */
> -uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
> -			uint32_t acc_flags)
> +uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
> +			    uint32_t reg, uint32_t acc_flags)
>   {
>   	uint32_t ret;
>   
>   	if (adev->in_pci_err_recovery)
>   		return 0;
>   
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
> -	    down_read_trylock(&adev->reset_sem)) {
> -		ret = amdgpu_kiq_rreg(adev, reg);
> -		up_read(&adev->reset_sem);
> -		return ret;
> -	}
> -
> -	if ((reg * 4) < adev->rmmio_size)
> -		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> -	else {
> -		unsigned long flags;
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_sem)) {
> +			ret = amdgpu_kiq_rreg(adev, reg);
> +			up_read(&adev->reset_sem);
> +		} else
> +			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> +	} else

This should use "} else {". Apart from that looks good to me.

Christian.

> +		ret = adev->pcie_rreg(adev, reg * 4);
>   
> -		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
> -		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
> -		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -	}
> +	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
>   
> -	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>   	return ret;
>   }
>   
> @@ -394,29 +388,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   		BUG();
>   }
>   
> -static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
> -				       uint32_t reg, uint32_t v,
> -				       uint32_t acc_flags)
> -{
> -	if (adev->in_pci_err_recovery)
> -		return;
> -
> -	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
> -
> -	if ((reg * 4) < adev->rmmio_size)
> -		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> -	else {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
> -		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
> -		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -	}
> -}
> -
>   /**
> - * amdgpu_mm_wreg - write to a memory mapped IO register
> + * amdgpu_device_wreg - write to a memory mapped IO or indirect register
>    *
>    * @adev: amdgpu_device pointer
>    * @reg: dword aligned register offset
> @@ -425,20 +398,25 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
>    *
>    * Writes the value specified to the offset specified.
>    */
> -void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
> -		    uint32_t acc_flags)
> +void amdgpu_device_wreg(struct amdgpu_device *adev,
> +			uint32_t reg, uint32_t v,
> +			uint32_t acc_flags)
>   {
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
> -	    down_read_trylock(&adev->reset_sem)) {
> -		amdgpu_kiq_wreg(adev, reg, v);
> -		up_read(&adev->reset_sem);
> -		return;
> -	}
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_sem)) {
> +			amdgpu_kiq_wreg(adev, reg, v);
> +			up_read(&adev->reset_sem);
> +		} else
> +			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> +	} else
> +		adev->pcie_wreg(adev, reg * 4, v);
>   
> -	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
> +	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
>   }
>   
>   /*
> @@ -446,21 +424,19 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>    *
>    * this function is invoked only the debugfs register access
>    * */
> -void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
> -		    uint32_t acc_flags)
> +void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
> +			     uint32_t reg, uint32_t v)
>   {
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
>   	if (amdgpu_sriov_fullaccess(adev) &&
> -		adev->gfx.rlc.funcs &&
> -		adev->gfx.rlc.funcs->is_rlcg_access_range) {
> -
> +	    adev->gfx.rlc.funcs &&
> +	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
>   		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
>   			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
> -	}
> -
> -	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
> +	} else
> +		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 63e734a..5da20fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -35,7 +35,7 @@
>   #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
>   	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
>   
> -TRACE_EVENT(amdgpu_mm_rreg,
> +TRACE_EVENT(amdgpu_device_rreg,
>   	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
>   	    TP_ARGS(did, reg, value),
>   	    TP_STRUCT__entry(
> @@ -54,7 +54,7 @@ TRACE_EVENT(amdgpu_mm_rreg,
>   		      (unsigned long)__entry->value)
>   );
>   
> -TRACE_EVENT(amdgpu_mm_wreg,
> +TRACE_EVENT(amdgpu_device_wreg,
>   	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
>   	    TP_ARGS(did, reg, value),
>   	    TP_STRUCT__entry(

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
