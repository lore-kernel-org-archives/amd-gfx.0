Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294D2C79FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 07:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ADF910EA86;
	Tue,  8 Sep 2026 07:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="qhe//s0E";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4325310EA86
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 07:41:51 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c250c6a6a9aso703745766b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788853309; x=1789458109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YoltGwMt4zi+qSoYuDvyZCj/ca3go0XF7HG62yGzi0=;
 b=qhe//s0EDBvyhj7i8RQmjkmwEpQXjKYLbEuAgQe5n9pLug459zMP4reNqLk/GHae6K
 ZktuAcj82z82ja/Jzk6bIxM/vrtXR6EJNO4/LSN6TnQ2J4Wl+yXTDmsDxnxKAQGeT1XE
 lgQvGIS96py2EdvdqXp91jG7Fgq/eKA8OeTJ3c+BnduGkVil6YicrXmlOp9kY7JjQbZu
 ba3shcgfsaAe8NVlvxG8rKFvLm7av4lPjF5XO4xmyOFm3hPr7bC2HdiSWhZPtI72PGTl
 GB+D4gpwIxKHk7L0HozhDJHy9yKBAj+qBHv2v37OtWb3vxBwBFpzBerf6PvDRKw5bR73
 rfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788853309; x=1789458109;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YoltGwMt4zi+qSoYuDvyZCj/ca3go0XF7HG62yGzi0=;
 b=GxmN9XZO8nOnA7iR4suY634FL7xxW4R23VS11yKPFNtTyIusO9p0yIwETcM7WUf2Lo
 J80tNUz2ZXenMEFvMaVgsNir2PUjWqy2iZwDMyUhZKkrhMIiRQHbL4RdjcL9fnYeGjac
 dZHlexdhfmS6SuQwq1s9Z/L2KJzGbMmpl/MEBrjNKgM+AA7UO9AJlue6Osy690NjH7yn
 kY/x6NaegNnNB1XmcMyI+1O3vQJPX0r3+TCclNQk95SPJibxsw/TF3cpWkeVLtAPq1M/
 crACAixzmjrInhPVOTOqpeYV0RgEeDj2BBMlzVymBFd+Y0hQlDuyYR5ej1v2KY/DKEsp
 /5hg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKY5pN6vSOfMf/HILLggLuqWctZlyqh0rCsfI87WpdIB75xhUJ30PyxkvbsxO3gpB1H22aFnEm@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcuBShiJjF5dgGo0ys/sTmirD+pBmYkDUHw+xROofFHT0P/ZmN
 k70CsCLbVDicPaTk8/+oMvIK+SnGU4dydQkr/op58P5XCr/7V7bhcbSiMm8QiQSBgzM=
X-Gm-Gg: AYBFou1QFFzUciTH0RJsvmovoczNcV0RxbABfjaSyrQ5e+KjE7XKbk2pwNtQo50as3/
 xJDSyDuC0JI4igvmu2Uf6egOSK+MtlsJb+zTNLsebqpjs2DTmU1kaHArTXPd22W5fMidK0aGfSs
 jlJzcRTDK0Cf1/vmKUWi2Yoa6oTI3/iWs88CXLUndNj/hD0X3QpluRo/0z86H80B1J9iJ3fFwJU
 MaO6SmUy/ek5EJQu4NE/4Mbtbji/mXlZ/wGCCfDpGSINgVWuncEaNWljU4FDCrn+xuRHfLlIrza
 PFu6jlzQh9z9eGF+p3DYzRYMRtpRG6CBZ0AOfqgIRHGjLcdaRPIJgKVl0CiWKuFmq0CRuImf0Q6
 BycGsXONDosqZfdFkgBbkBXW8u5ReQ5J7SWUt76dqbXBowtrWhYt95+DdbiZaRzKR5msv6pQAlO
 QZiz5TpsU6Gnxh/iLpOyhhu4PvMMLjHkWDKDef38gdW7ZAEceylQ2wAF3vxjH8LjaC0b60jQOWl
 EGA
X-Received: by 2002:a17:907:1c25:b0:c26:337e:7e05 with SMTP id
 a640c23a62f3a-c26337ea2f5mr1229242766b.4.1788853309296; 
 Tue, 08 Sep 2026 00:41:49 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm395738966b.19.2026.09.08.00.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:41:48 -0700 (PDT)
Message-ID: <8c9a61ed-5c68-4391-8736-251ac9deef9b@ursulin.net>
Date: Tue, 8 Sep 2026 08:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be
 per instance
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <nat@pixelcluster.dev>,
 Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <20260907203316.159103-11-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260907203316.159103-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 07/09/2026 21:33, Timur Kristóf wrote:
> This prepares the code for implementing recovery for SDMA 4.0.
> 
> Reorganize the SDMA 4.0 code so that the functions that are
> responsible for managing the SDMA engines take an instance ID
> as an argument.
> 
> This makes it possible to manage the SDMA instances
> independently of each other, which will enable us to
> also use these functions to implement resetting and
> recovering them independently.

Radom patch to drop a comment on the whole series. It looks clean and 
reasonable to me. Once the pre-requisite series is reviewed I can do a 
more detail pass and slap an r-b to it.

One discussion point could be is do we maybe want the prototype for all 
to be "struct amdgpu_sdma_instance *" instead of "struct amdgpu_device, 
const u32 instance_id"?

Could I also interest you in a related cleanup:

https://lore.kernel.org/amd-gfx/20260622143649.54632-1-tvrtko.ursulin@igalia.com/#t

?

I could make my patch store the self-index in struct 
amdgpu_sdma_instance and then respecitve callsite could get it from 
there. Maybe adev too unless we could rely on the existing 
sdma_instance->ring->adev.

Regards,

Tvrtko

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 253 +++++++++++++------------
>   1 file changed, 131 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index bdd140887e10..038e1ee8ff4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -915,60 +915,61 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>    * sdma_v4_0_gfx_enable - enable the gfx async dma engines
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    * @enable: enable SDMA RB/IB
>    * control the gfx async dma ring buffers (VEGA10).
>    */
> -static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev,
> +				 const u32 instance_id,
> +				 const bool enable)
>   {
>   	u32 rb_cntl, ib_cntl;
> -	int i;
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
> -		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
> -		WREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL, rb_cntl);
> -		ib_cntl = RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);
> -		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, enable ? 1 : 0);
> -		WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
> -	}
> +	rb_cntl = RREG32_SDMA(instance_id, mmSDMA0_GFX_RB_CNTL);
> +	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
> +	WREG32_SDMA(instance_id, mmSDMA0_GFX_RB_CNTL, rb_cntl);
> +	ib_cntl = RREG32_SDMA(instance_id, mmSDMA0_GFX_IB_CNTL);
> +	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, enable ? 1 : 0);
> +	WREG32_SDMA(instance_id, mmSDMA0_GFX_IB_CNTL, ib_cntl);
>   }
>   
>   /**
>    * sdma_v4_0_page_stop - stop the page async dma engines
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    *
>    * Stop the page async dma ring buffers (VEGA10).
>    */
> -static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
> +static void sdma_v4_0_page_stop(struct amdgpu_device *adev,
> +				const u32 instance_id)
>   {
>   	u32 rb_cntl, ib_cntl;
> -	int i;
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
> -		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
> -					RB_ENABLE, 0);
> -		WREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL, rb_cntl);
> -		ib_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL);
> -		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
> -					IB_ENABLE, 0);
> -		WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
> -	}
> +	rb_cntl = RREG32_SDMA(instance_id, mmSDMA0_PAGE_RB_CNTL);
> +	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
> +				RB_ENABLE, 0);
> +	WREG32_SDMA(instance_id, mmSDMA0_PAGE_RB_CNTL, rb_cntl);
> +	ib_cntl = RREG32_SDMA(instance_id, mmSDMA0_PAGE_IB_CNTL);
> +	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
> +				IB_ENABLE, 0);
> +	WREG32_SDMA(instance_id, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
>   }
>   
>   /**
>    * sdma_v4_0_ctx_switch_enable - stop the async dma engines context switch
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    * @enable: enable/disable the DMA MEs context switch.
>    *
>    * Halt or unhalt the async dma engines context switch (VEGA10).
>    */
> -static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev,
> +					const u32 instance_id,
> +					const bool enable)
>   {
>   	u32 f32_cntl, phase_quantum = 0;
> -	int i;
>   
>   	if (amdgpu_sdma_phase_quantum) {
>   		unsigned value = amdgpu_sdma_phase_quantum;
> @@ -994,56 +995,52 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
>   	}
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		f32_cntl = RREG32_SDMA(i, mmSDMA0_CNTL);
> -		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -		if (enable && amdgpu_sdma_phase_quantum) {
> -			WREG32_SDMA(i, mmSDMA0_PHASE0_QUANTUM, phase_quantum);
> -			WREG32_SDMA(i, mmSDMA0_PHASE1_QUANTUM, phase_quantum);
> -			WREG32_SDMA(i, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
> -		}
> -		WREG32_SDMA(i, mmSDMA0_CNTL, f32_cntl);
> -
> -		/*
> -		 * Enable SDMA utilization. Its only supported on
> -		 * Arcturus for the moment and firmware version 14
> -		 * and above.
> -		 */
> -		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
> -			    IP_VERSION(4, 2, 2) &&
> -		    adev->sdma.instance[i].fw_version >= 14)
> -			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
> -		/* Extend page fault timeout to avoid interrupt storm */
> -		WREG32_SDMA(i, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
> +	f32_cntl = RREG32_SDMA(instance_id, mmSDMA0_CNTL);
> +	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +			AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> +	if (enable && amdgpu_sdma_phase_quantum) {
> +		WREG32_SDMA(instance_id, mmSDMA0_PHASE0_QUANTUM, phase_quantum);
> +		WREG32_SDMA(instance_id, mmSDMA0_PHASE1_QUANTUM, phase_quantum);
> +		WREG32_SDMA(instance_id, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
>   	}
> +	WREG32_SDMA(instance_id, mmSDMA0_CNTL, f32_cntl);
>   
> +	/*
> +	 * Enable SDMA utilization. Its only supported on
> +	 * Arcturus for the moment and firmware version 14
> +	 * and above.
> +	 */
> +	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 2, 2) &&
> +	    adev->sdma.instance[instance_id].fw_version >= 14)
> +		WREG32_SDMA(instance_id, mmSDMA0_PUB_DUMMY_REG2, enable);
> +	/* Extend page fault timeout to avoid interrupt storm */
> +	WREG32_SDMA(instance_id, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
>   }
>   
>   /**
>    * sdma_v4_0_enable - stop the async dma engines
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    * @enable: enable/disable the DMA MEs.
>    *
>    * Halt or unhalt the async dma engines (VEGA10).
>    */
> -static void sdma_v4_0_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v4_0_enable(struct amdgpu_device *adev,
> +			     const u32 instance_id,
> +			     const bool enable)
>   {
>   	u32 f32_cntl;
> -	int i;
>   
>   	if (!enable) {
> -		sdma_v4_0_gfx_enable(adev, enable);
> +		sdma_v4_0_gfx_enable(adev, instance_id, enable);
>   		if (adev->sdma.has_page_queue)
> -			sdma_v4_0_page_stop(adev);
> +			sdma_v4_0_page_stop(adev, instance_id);
>   	}
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		f32_cntl = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
> -		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -		WREG32_SDMA(i, mmSDMA0_F32_CNTL, f32_cntl);
> -	}
> +	f32_cntl = RREG32_SDMA(instance_id, mmSDMA0_F32_CNTL);
> +	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> +	WREG32_SDMA(instance_id, mmSDMA0_F32_CNTL, f32_cntl);
>   }
>   
>   /*
> @@ -1303,41 +1300,38 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *adev)
>    * sdma_v4_0_load_microcode - load the sDMA ME ucode
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    *
>    * Loads the sDMA0/1 ucode.
>    * Returns 0 for success, -EINVAL if the ucode is not available.
>    */
> -static int sdma_v4_0_load_microcode(struct amdgpu_device *adev)
> +static int sdma_v4_0_load_microcode(struct amdgpu_device *adev, const u32 instance_id)
>   {
>   	const struct sdma_firmware_header_v1_0 *hdr;
>   	const __le32 *fw_data;
>   	u32 fw_size;
> -	int i, j;
> +	int j;
>   
>   	/* halt the MEs */
> -	sdma_v4_0_enable(adev, false);
> +	sdma_v4_0_enable(adev, instance_id, false);
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (!adev->sdma.instance[i].fw)
> -			return -EINVAL;
> +	if (!adev->sdma.instance[instance_id].fw)
> +		return -EINVAL;
>   
> -		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
> -		amdgpu_ucode_print_sdma_hdr(&hdr->header);
> -		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> +	hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[instance_id].fw->data;
> +	amdgpu_ucode_print_sdma_hdr(&hdr->header);
> +	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
>   
> -		fw_data = (const __le32 *)
> -			(adev->sdma.instance[i].fw->data +
> -				le32_to_cpu(hdr->header.ucode_array_offset_bytes));
> +	fw_data =
> +		(const __le32 *)(adev->sdma.instance[instance_id].fw->data +
> +			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>   
> -		WREG32_SDMA(i, mmSDMA0_UCODE_ADDR, 0);
> +	WREG32_SDMA(instance_id, mmSDMA0_UCODE_ADDR, 0);
>   
> -		for (j = 0; j < fw_size; j++)
> -			WREG32_SDMA(i, mmSDMA0_UCODE_DATA,
> -				    le32_to_cpup(fw_data++));
> +	for (j = 0; j < fw_size; j++)
> +		WREG32_SDMA(instance_id, mmSDMA0_UCODE_DATA, le32_to_cpup(fw_data++));
>   
> -		WREG32_SDMA(i, mmSDMA0_UCODE_ADDR,
> -			    adev->sdma.instance[i].fw_version);
> -	}
> +	WREG32_SDMA(instance_id, mmSDMA0_UCODE_ADDR, adev->sdma.instance[instance_id].fw_version);
>   
>   	return 0;
>   }
> @@ -1346,80 +1340,86 @@ static int sdma_v4_0_load_microcode(struct amdgpu_device *adev)
>    * sdma_v4_0_start - setup and start the async dma engines
>    *
>    * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
>    *
>    * Set up the DMA engines and enable them (VEGA10).
>    * Returns 0 for success, error for failure.
>    */
> -static int sdma_v4_0_start(struct amdgpu_device *adev)
> +static int sdma_v4_0_start(struct amdgpu_device *adev, const u32 instance_id)
>   {
> -	struct amdgpu_ring *ring;
> -	int i, r = 0;
> +	int r = 0;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v4_0_ctx_switch_enable(adev, false);
> -		sdma_v4_0_enable(adev, false);
> +		sdma_v4_0_ctx_switch_enable(adev, instance_id, false);
> +		sdma_v4_0_enable(adev, instance_id, false);
>   	} else {
>   
>   		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> -			r = sdma_v4_0_load_microcode(adev);
> +			r = sdma_v4_0_load_microcode(adev, instance_id);
>   			if (r)
>   				return r;
>   		}
>   
>   		/* unhalt the MEs */
> -		sdma_v4_0_enable(adev, true);
> +		sdma_v4_0_enable(adev, instance_id, true);
>   		/* enable sdma ring preemption */
> -		sdma_v4_0_ctx_switch_enable(adev, true);
> +		sdma_v4_0_ctx_switch_enable(adev, instance_id, true);
>   	}
>   
>   	/* start the gfx rings and rlc compute queues */
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		uint32_t temp;
> -
> -		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_0_gfx_resume(adev, i);
> -		if (adev->sdma.has_page_queue)
> -			sdma_v4_0_page_resume(adev, i);
> -
> -		/* set utc l1 enable flag always to 1 */
> -		temp = RREG32_SDMA(i, mmSDMA0_CNTL);
> -		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
> -		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
> -
> -		if (!amdgpu_sriov_vf(adev)) {
> -			/* unhalt engine */
> -			temp = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
> -			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> -			WREG32_SDMA(i, mmSDMA0_F32_CNTL, temp);
> -		}
> +	uint32_t temp;
> +
> +	WREG32_SDMA(instance_id, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> +	sdma_v4_0_gfx_resume(adev, instance_id);
> +	if (adev->sdma.has_page_queue)
> +		sdma_v4_0_page_resume(adev, instance_id);
> +
> +	/* set utc l1 enable flag always to 1 */
> +	temp = RREG32_SDMA(instance_id, mmSDMA0_CNTL);
> +	temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
> +	WREG32_SDMA(instance_id, mmSDMA0_CNTL, temp);
> +
> +	if (!amdgpu_sriov_vf(adev)) {
> +		/* unhalt engine */
> +		temp = RREG32_SDMA(instance_id, mmSDMA0_F32_CNTL);
> +		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> +		WREG32_SDMA(instance_id, mmSDMA0_F32_CNTL, temp);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v4_0_ctx_switch_enable(adev, true);
> -		sdma_v4_0_enable(adev, true);
> +		sdma_v4_0_ctx_switch_enable(adev, instance_id, true);
> +		sdma_v4_0_enable(adev, instance_id, true);
>   	} else {
>   		sdma_v4_0_init_pg(adev);
>   	}
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		ring = &adev->sdma.instance[i].ring;
> +	r = amdgpu_ring_test_helper(&adev->sdma.instance[instance_id].ring);
> +	if (r)
> +		return r;
>   
> -		r = amdgpu_ring_test_helper(ring);
> +	if (adev->sdma.has_page_queue) {
> +		r = amdgpu_ring_test_helper(&adev->sdma.instance[instance_id].page);
>   		if (r)
>   			return r;
> -
> -		if (adev->sdma.has_page_queue) {
> -			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
> -
> -			r = amdgpu_ring_test_helper(page);
> -			if (r)
> -				return r;
> -		}
>   	}
>   
>   	return r;
>   }
>   
> +/**
> + * sdma_v3_0_stop() - Stop an SDMA engine
> + *
> + * @adev: amdgpu_device pointer
> + * @instance_id: SDMA engine instance ID
> + *
> + * Stop the given SDMA engine instance (VEGA10).
> + */
> +static void sdma_v4_0_stop(struct amdgpu_device *adev, const u32 instance_id)
> +{
> +	sdma_v4_0_ctx_switch_enable(adev, instance_id, false);
> +	sdma_v4_0_enable(adev, instance_id, false);
> +}
> +
>   /**
>    * sdma_v4_0_ring_test_ring - simple async dma engine test
>    *
> @@ -1935,6 +1935,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   	int r;
>   
>   	if (adev->flags & AMD_IS_APU)
> @@ -1943,9 +1944,12 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (!amdgpu_sriov_vf(adev))
>   		sdma_v4_0_init_golden_registers(adev);
>   
> -	r = sdma_v4_0_start(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->sdma.num_instances; ++i) {
> +		r = sdma_v4_0_start(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
>   	sdma_v4_0_set_buffer_funcs(adev);
>   
>   	return 0;
> @@ -1966,8 +1970,8 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		}
>   	}
>   
> -	sdma_v4_0_ctx_switch_enable(adev, false);
> -	sdma_v4_0_enable(adev, false);
> +	for (i = 0; i < adev->sdma.num_instances; ++i)
> +		sdma_v4_0_stop(adev, i);
>   
>   	if (adev->flags & AMD_IS_APU)
>   		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true, 0);
> @@ -1978,10 +1982,12 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
>   	/* SMU saves SDMA state for us */
>   	if (adev->in_s0ix) {
> -		sdma_v4_0_gfx_enable(adev, false);
> +		for (i = 0; i < adev->sdma.num_instances; ++i)
> +			sdma_v4_0_gfx_enable(adev, i, false);
>   		return 0;
>   	}
>   
> @@ -1991,11 +1997,14 @@ static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   static int sdma_v4_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
>   	/* SMU restores SDMA state for us */
>   	if (adev->in_s0ix) {
> -		sdma_v4_0_enable(adev, true);
> -		sdma_v4_0_gfx_enable(adev, true);
> +		for (i = 0; i < adev->sdma.num_instances; ++i) {
> +			sdma_v4_0_enable(adev, i, true);
> +			sdma_v4_0_gfx_enable(adev, i, true);
> +		}
>   		return 0;
>   	}
>   

