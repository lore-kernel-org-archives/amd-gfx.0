Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C3C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 16:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B43610A1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 16:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B43610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2F189D52;
	Fri, 23 Apr 2021 16:28:33 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A4D89D52
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 16:28:32 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id s15so58112414edd.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=jpqIJ3AOjZ/RznB9qcbrFQSeFVWODw3rWBsXhfikHAA=;
 b=bdlA6P/py1bRVbk4okCaxE4xxvVoZAfarvLCYRnyWY8U5jQppuMnmRANoeH0R8xsjL
 QUWZ6Xf/2lvj6hkLYcuIqSBe/Dyf/pnXv0Km4Lto8QsUJLhwGnV4UrdEgeGvLHLiNz0F
 DjNbd92QiCnP8BF24U4VytHMxKI+0i2fLxTzo4A+CCIDtGjaA1UJde9VGJR0x1TT3gBH
 WnMIUKaIaOAnpFxoRRDFU6dijWuaSPTD8d/il9Eb0r7cBjfDpyldCWxy0ZSWFs4rT3fO
 sv/W6DJWAF2K59f8qkgiilR4aX5XlnXyEX3d2qy8mzN2rWVwAMUaAFwSZOL7EJVTUUop
 ne0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jpqIJ3AOjZ/RznB9qcbrFQSeFVWODw3rWBsXhfikHAA=;
 b=EcrhrUrMYUYR5MkiFp0Oqy4vk/GY0SzGaake0Vh3xkNS2xIi2vKwWjCqqz+ySAG0Uf
 04jFDHe84Q1nhPP2D4ahRFcihnyfOBcR8uxn/Qn3U2gzFsr3bOY7mXcPk7v6xTiqL8cy
 PVu/idho+3DXoanv0YGxIyR5prgvT62r59HX7MQr5KSCtlvzTYrlMaWTv5rwctQjbg86
 RfLXIYv39aTuJUAulVzXjugLu6brFkS3Sxa0yLlnJb8AW6vKuRIDdpLdSAVxCnqP0Tr9
 uhqotE7LPCAv5wP/5+zX+XrYJZnSG/ChjuRCe4toEP6oCkAipKxrhnJSNZPUaAQBjXEb
 ixnw==
X-Gm-Message-State: AOAM531Zpq1nrBmk5kU7e3YRGNt9azTLA8cGPm/2GbL8Y+fZyE+wmi5t
 AHzgGxpV8u5lNzhaVEHQwqUa++ryPig=
X-Google-Smtp-Source: ABdhPJzNgcSlOqiqZzzQRESROH0kFkpgO8jGALCo9n3mvt0Qau0RC5nZNeAbzfSP0KBNu1qCqmpTRA==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr5487340edo.385.1619195311511; 
 Fri, 23 Apr 2021 09:28:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4245:6600:99f9:ae6e?
 ([2a02:908:1252:fb60:4245:6600:99f9:ae6e])
 by smtp.gmail.com with ESMTPSA id n14sm4245391ejy.90.2021.04.23.09.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Apr 2021 09:28:31 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] drm/amdgpu: address remove from fault filter
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c3e7c9b4-90b2-ff53-e137-a24cf18ee495@gmail.com>
Date: Fri, 23 Apr 2021 18:28:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423153550.25188-1-Philip.Yang@amd.com>
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



Am 23.04.21 um 17:35 schrieb Philip Yang:
> Add interface to remove address from fault filter ring by resetting
> fault ring entry key, then future vm fault on the address will be
> processed to recover.
>
> Use spinlock to protect fault hash ring access by interrupt handler and
> interrupt scheduled deferred work for vg20.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
>   4 files changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c39ed9eb0987..91106b59389f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
>   }
>   
> +/**
> + * fault_key - get 52bit hask key from vm fault address and pasid
> + *
> + * @addr: 48bit physical address
> + * @pasid: 4 bit
> + */
> +static inline uint64_t fault_key(uint64_t addr, uint16_t pasid)

Please prefix with amdgpu_gmc_

> +{
> +	return addr << 4 | pasid;
> +}
> +
>   /**
>    * amdgpu_gmc_filter_faults - filter VM faults
>    *
> @@ -349,15 +360,20 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   {
>   	struct amdgpu_gmc *gmc = &adev->gmc;
>   
> -	uint64_t stamp, key = addr << 4 | pasid;
> +	uint64_t stamp, key = fault_key(addr, pasid);
>   	struct amdgpu_gmc_fault *fault;
> +	unsigned long flags;
>   	uint32_t hash;
>   
>   	/* If we don't have space left in the ring buffer return immediately */
>   	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>   		AMDGPU_GMC_FAULT_TIMEOUT;
> -	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp)
> +
> +	spin_lock_irqsave(&gmc->fault_lock, flags);

Uff the spinlock adds quite some overhead here. I'm still wondering if 
we can't somehow avoid this.

Christian.

> +	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp) {
> +		spin_unlock_irqrestore(&gmc->fault_lock, flags);
>   		return true;
> +	}
>   
>   	/* Try to find the fault in the hash */
>   	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
> @@ -365,8 +381,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   	while (fault->timestamp >= stamp) {
>   		uint64_t tmp;
>   
> -		if (fault->key == key)
> +		if (fault->key == key) {
> +			spin_unlock_irqrestore(&gmc->fault_lock, flags);
>   			return true;
> +		}
>   
>   		tmp = fault->timestamp;
>   		fault = &gmc->fault_ring[fault->next];
> @@ -384,9 +402,51 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   	/* And update the hash */
>   	fault->next = gmc->fault_hash[hash].idx;
>   	gmc->fault_hash[hash].idx = gmc->last_fault++;
> +	spin_unlock_irqrestore(&gmc->fault_lock, flags);
>   	return false;
>   }
>   
> +/**
> + * amdgpu_gmc_filter_faults_remove - remove address from VM faults filter
> + *
> + * @adev: amdgpu device structure
> + * @addr: address of the VM fault
> + * @pasid: PASID of the process causing the fault
> + *
> + * Remove the address from fault filter, then future vm fault on this address
> + * will pass to retry fault handler to recover.
> + */
> +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
> +				     uint16_t pasid)
> +{
> +	struct amdgpu_gmc *gmc = &adev->gmc;
> +
> +	uint64_t key = fault_key(addr, pasid);
> +	struct amdgpu_gmc_fault *fault;
> +	unsigned long flags;
> +	uint32_t hash;
> +
> +	spin_lock_irqsave(&gmc->fault_lock, flags);
> +	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
> +	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
> +	while (true) {
> +		uint64_t tmp;
> +
> +		if (fault->key == key) {
> +			fault->key = fault_key(0, 0);
> +			break;
> +		}
> +
> +		tmp = fault->timestamp;
> +		fault = &gmc->fault_ring[fault->next];
> +
> +		/* Check if the entry was reused */
> +		if (fault->timestamp >= tmp)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&gmc->fault_lock, flags);
> +}
> +
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9d11c02a3938..0aae3bd01bf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -246,6 +246,7 @@ struct amdgpu_gmc {
>   		uint64_t	idx:AMDGPU_GMC_FAULT_RING_ORDER;
>   	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
>   	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
> +	spinlock_t		fault_lock;
>   
>   	bool tmz_enabled;
>   
> @@ -318,6 +319,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>   			     struct amdgpu_gmc *mc);
>   bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp);
> +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
> +				     uint16_t pasid);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 498b28a35f5b..7416ad874652 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -839,6 +839,7 @@ static int gmc_v10_0_sw_init(void *handle)
>   	adev->mmhub.funcs->init(adev);
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
> +	spin_lock_init(&adev->gmc.fault_lock);
>   
>   	if ((adev->flags & AMD_IS_APU) && amdgpu_emu_mode == 1) {
>   		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4da8b3d28af2..3290b259a372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1444,6 +1444,7 @@ static int gmc_v9_0_sw_init(void *handle)
>   	adev->mmhub.funcs->init(adev);
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
> +	spin_lock_init(&adev->gmc.fault_lock);
>   
>   	r = amdgpu_atomfirmware_get_vram_info(adev,
>   		&vram_width, &vram_type, &vram_vendor);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
