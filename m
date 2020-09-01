Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B82EC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27065206C0
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpKGOp7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27065206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65A56E5A1;
	Tue,  1 Sep 2020 07:15:44 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEAD6E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:15:44 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z1so273416wrt.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LjS7SguMbpGBOpWkNWTQfOjqGUf4w/9lfb7X+/cu5s4=;
 b=mpKGOp7NvmIgmtYnKdjVVLdHyyf9H85uY7B1ihtCZtKQflz75jeK23Ctm5DimySj9V
 T8XdMkjp9Sf2Npu/6XaJu9IgleorkNtUMC1oCsnhvX1wkcFUMS0H8xEzzx4wMwd4sHOE
 oKKpl4YzaBU6iL87OpU8AdLOgahZvOM6Xv9LxK648L7CsAv6Q1StQIaLPPJnVE3wwLf9
 thQPurR0o0Io1dNCX4IXvPLmfvMl+uKUtNRsfROFH3NOnxtpRY1pGCqHFFdhXE+Z22Ss
 eX4HNcrAO4lmNWWJHEGlPX6Y56fzA8zzTDKGRg4vfs+lacfa+VHizqmPESd1e7G4OV8J
 WX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=LjS7SguMbpGBOpWkNWTQfOjqGUf4w/9lfb7X+/cu5s4=;
 b=DsYdxtSxedSVfX5h+MKKhZvSm8tEsOFyLna5LBSBXN5kOzWtUKgOm3N5knM/3LL2G4
 Mz92VC4ExxSl+5P8o5i0TNnfDOGuoaNvYzjuOKDcxVwbR8gi+KJNyiWEKOpeePrEQCVi
 389B/HillBMZjls9jYzvh1Rkm56tTPQmIyW74vclCJGVoVHQzl40dIkSRAtXbHEAU4xB
 nG/hA1wrRH40TIE1Hw2QdNZoW/kVz+uXfyNsizcW+LbmIIBkFVhX+L7x9s6dR+4987pI
 xfMGtVow19+UItwEcoc5eUuwhz7AKwPmYymWZvMvLX5koQXfP3NAmYYygyrIrmCVF/Yr
 /MRg==
X-Gm-Message-State: AOAM533YDmrz3aN3XhSm4Z69R4zX3T4GlcRbvCQYpMP83kL52tg8dOBO
 XhrLwh4WRCRPME05aO6mpf0=
X-Google-Smtp-Source: ABdhPJw43auT95yOEPqcVF1STnI5EsRv6sGrN7fOfXQ72BR70IiFb2baS1IcmIkZSDu+DQ97axtiCA==
X-Received: by 2002:adf:fbc6:: with SMTP id d6mr285947wrs.189.1598944543148;
 Tue, 01 Sep 2020 00:15:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k12sm774838wrn.39.2020.09.01.00.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 00:15:42 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 christian.koenig@amd.com
References: <20200901011727.14059-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71346823-d141-a6a5-76db-64651bf68290@gmail.com>
Date: Tue, 1 Sep 2020 09:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901011727.14059-1-Dennis.Li@amd.com>
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

Am 01.09.20 um 03:17 schrieb Dennis Li:
> When GPU is in reset, its status isn't stable and ring buffer also need
> be reset when resuming. Therefore driver should protect GPU recovery
> thread from ring buffer accessed by other threads. Otherwise GPU will
> randomly hang during recovery.

One style comment inline, apart from that looks good to me.

>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 172dc47b7f39..8db56a22cd1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   {
>   	uint32_t ret;
>   
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_rreg(adev, reg);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {

This is not correctly indented, the following lines of an if clause 
should be under the ( of the first line. Same for other cases as well.

Regards,
Christian.

> +		ret = amdgpu_kiq_rreg(adev, reg);
> +		up_read(&adev->reset_sem);
> +		return ret;
> +	}
>   
>   	if ((reg * 4) < adev->rmmio_size)
>   		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -332,6 +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
>   		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   	}
> +
>   	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>   	return ret;
>   }
> @@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_wreg(adev, reg, v);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {
> +		amdgpu_kiq_wreg(adev, reg, v);
> +		up_read(&adev->reset_sem);
> +		return;
> +	}
>   
>   	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ad9ad622ccce..4ea2a065daa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -	    !amdgpu_in_reset(adev)) {
> +	    down_read_trylock(&adev->reset_sem)) {
>   
>   		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>   		const unsigned eng = 17;
> @@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   				1 << vmid);
> +
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e1a0ae327cf5..33b7cf1c79ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -			!amdgpu_in_reset(adev)) {
> +			down_read_trylock(&adev->reset_sem)) {
>   		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   						   1 << vmid);
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> @@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	if (amdgpu_in_reset(adev))
>   		return -EIO;
>   
> -	if (ring->sched.ready) {
> +	if (ring->sched.ready &&
> +		 down_read_trylock(&adev->reset_sem)) {
>   		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
>   		 * heavy-weight TLB flush (type 2), which flushes
>   		 * both. Due to a race condition with concurrent
> @@ -626,6 +628,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		if (r) {
>   			amdgpu_ring_undo(ring);
>   			spin_unlock(&adev->gfx.kiq.ring_lock);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
>   
> @@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
> -
> +		up_read(&adev->reset_sem);
>   		return 0;
>   	}
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
