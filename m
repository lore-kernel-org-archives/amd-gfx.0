Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97472C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 11:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C2961452
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C2961452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942C66EA6A;
	Thu, 22 Apr 2021 11:02:08 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1BC6EA7A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 11:02:06 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id bx20so51780738edb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=JWdakk3x3/c3jr1gLi6IO84ttjmeJ+pBA/7Yf6F4AtA=;
 b=uFq1sc5chNuU+Xv51Glmf6oY6/Bi99H4cpije4L4xvzddrgkf4QvSrPDOSIqIAV+t0
 I+wUgRG9zPRXO1WkfH+q7nt3lVKgIyPlZlXWAvvkEoFjwb5FQpW4l+mh4Ss4iTs2vn1Z
 JyTI0wO1TInVezaBTvK0tEWLpuyJ0ydG2DNnz8QS1hrh86YqU/dbkKdMhFbX1JX47BUr
 zHBfNB7d8pX78bIxq1nsiu2RvIYXksyr2mkaOaBgz4FcCTnr5dnUZjQw9O7/FHAZq2BG
 d8f+0+wcLRUg7BTWo9Ba3fxZwIOxFkAHSpKk6ugGX0D741Onxja9LfILjBlZaD/l6yxa
 SIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JWdakk3x3/c3jr1gLi6IO84ttjmeJ+pBA/7Yf6F4AtA=;
 b=spcR7dPfJLbO13fflZK7i+2kYGURZeOc1cZew2JABuiCQHTA/OuBwGIWSKhT2evfK5
 qzN6sxO9XDpr9yT6ihiS/E37C5AZhBGzuu6pF9eoGGSFOwYrX/ko7Ub93Yo3rpczIRcA
 ezwdM21W2HHj1VX3IWiZe4ZZoO6H4fiCTl7x9crUDh/bAX8+A9GzufYykp9jjFqFRgLv
 ePE5NHJV4NRISnXAl93cGOPSEc132cGD3IsUOiHzdiepaS+CW4D+brxxI09m9280OlVG
 /Cfvj64gDhhiScUUyNJwdUE0rhowIUCzgIWF9vMgib5PISxHDiy279sEa/ToQoFTzCdo
 7vMA==
X-Gm-Message-State: AOAM533U2zTDA2rej7kjI/P/ZzkP2VFuy7dbyC8lxUfHQux9Z3qlLD/C
 SI4kR9pbgVC3F/DDcdTH9GQ=
X-Google-Smtp-Source: ABdhPJxu2VjzRKjqEoY2y3yw1FuhhCCqP43s3XgWw50V1nxR/FXezTgawP1uy8qnMiJ3XJiSikOEjw==
X-Received: by 2002:a05:6402:10c6:: with SMTP id
 p6mr3082967edu.241.1619089325185; 
 Thu, 22 Apr 2021 04:02:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2fbd:d2a4:da7e:4526?
 ([2a02:908:1252:fb60:2fbd:d2a4:da7e:4526])
 by smtp.gmail.com with ESMTPSA id l6sm1629317ejc.92.2021.04.22.04.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 04:02:04 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add sdma single packet invalidation
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 emily.deng@amd.com
References: <20210422104950.72339-1-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f99fa3dd-3d6f-d867-f24b-782e2e38d5a9@gmail.com>
Date: Thu, 22 Apr 2021 13:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422104950.72339-1-Victor.Zhao@amd.com>
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

Am 22.04.21 um 12:49 schrieb Victor Zhao:
> Add sdma single packet invalidation

Well NAK on many aspects of this.

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 14 +++++++++-----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 12 ++++++++++++
>   4 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c39ed9eb0987..b2cf0e00ce38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -435,13 +435,13 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
>   
>   	/*
>   	 * The latest engine allocation on gfx9/10 is:
> -	 * Engine 2, 3: firmware
> -	 * Engine 0, 1, 4~16: amdgpu ring,
> +	 * Engine 1, 2, 3, 4: firmware
> +	 * Engine 0, 5~16: amdgpu ring,
>   	 *                    subject to change when ring number changes
>   	 * Engine 17: Gart flushes
>   	 */
> -#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> -#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> +#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFE1
> +#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFE1
>   
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ca1622835296..fb3de16321ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -192,6 +192,9 @@ struct amdgpu_ring_funcs {
>   	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>   					uint32_t reg0, uint32_t reg1,
>   					uint32_t ref, uint32_t mask);
> +	void (*vm_invalidate)(struct amdgpu_ring *ring,
> +				uint32_t reg0, uint32_t reg1,
> +				uint32_t req, uint32_t mask, uint32_t hub);

What is that good for? You need a much wider explanation if you want to 
change the design here.

Please rather implement the emit_reg_write_reg_wait() callback properly.

>   	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
>   				bool secure);
>   	/* Try to soft recover the ring to make the fence signal */
> @@ -270,6 +273,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> +#define amdgpu_ring_vm_invalidate(r, d0, d1, v, m, h) ((r)->funcs->vm_invalidate((r), (d0), (d1), (v), (m), (h)))
>   #define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
>   #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>   #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 498b28a35f5b..0fdf60a7c53d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -481,11 +481,15 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>   			      (hub->ctx_addr_distance * vmid),
>   			      upper_32_bits(pd_addr));
>   
> -	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
> -					    hub->eng_distance * eng,
> -					    hub->vm_inv_eng0_ack +
> -					    hub->eng_distance * eng,
> -					    req, 1 << vmid);
> +	if ((!strcmp("sdma0", ring->name)) || (!strcmp("sdma1", ring->name)))

Seriously?

> +		amdgpu_ring_vm_invalidate(ring, 0xffffffff, 0x1f,
> +					  req, 1 << vmid, 1 << ring->funcs->vmhub);
> +	else
> +		amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
> +						    hub->eng_distance * eng,
> +						    hub->vm_inv_eng0_ack +
> +						    hub->eng_distance * eng,
> +						    req, 1 << vmid);
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>   	if (use_semaphore)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 920fc6d4a127..fd7df9194f05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1219,6 +1219,17 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>   	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
>   }
>   
> +static void sdma_v5_0_ring_vm_invalidate(struct amdgpu_ring *ring,
> +		uint32_t reg0, uint32_t reg1,
> +		uint32_t req, uint32_t mask, uint32_t hub)
> +{
> +	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
> +			SDMA_PKT_POLL_REGMEM_HEADER_SUB_OP(4));
> +	amdgpu_ring_write(ring, req);
> +	amdgpu_ring_write(ring, reg0);
> +	amdgpu_ring_write(ring, ((reg1 & 0x1f) << 16) | (mask & 0xffff) | (hub << 21)); /* reference */

That's not sufficient. That you use the single packet doesn't protects 
you from concurrent access of the invalidation control registers.

Christian.

> +}
> +
>   static int sdma_v5_0_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1654,6 +1665,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>   	.emit_wreg = sdma_v5_0_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
> +	.vm_invalidate = sdma_v5_0_ring_vm_invalidate,
>   	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
>   	.patch_cond_exec = sdma_v5_0_ring_patch_cond_exec,
>   	.preempt_ib = sdma_v5_0_ring_preempt_ib,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
