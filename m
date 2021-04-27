Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75CC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 07:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C9A6112F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 07:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C9A6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4246E904;
	Tue, 27 Apr 2021 07:25:45 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D7C6E904
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 07:25:44 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id d27so35367808lfv.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=SQapjw/7B5El96waq6j0z1gTfQ42rhyZo93M+t8hnos=;
 b=grkfsrbpQH6WOjWhMckjhMcuK6aytsHfQ/nQzvi53iwneTU6mC4ndCw5ZEvRLgrk7F
 AKJSqbSMljffUdVF6QJgeb8Tpe7gysDmgG0AxPay39UaiETqoYH0yBCr5vyOU1kMPjEB
 1xxVNQta09tDPDq+uHQiR2CCgLoe+WW4MBZo7cq3q+kREuwOBtFV/sXgz3TNWGhVRF2U
 c6YNxP+h0/PAk5o4oTMLWFmwcn6jnHKmmoBcW1eOhbztLXrOvIYrUOGJDppens0c0f2h
 yV/FBWC08bCnESioib5q3wZnv5YFQfQXCS/JHMBaDJWNCC5W72jP7KcjjjftuDiR0U4s
 t6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SQapjw/7B5El96waq6j0z1gTfQ42rhyZo93M+t8hnos=;
 b=AyxITV8dHk/0+UhErKG1YqYA1lxpU7gJz+L3veuw5YRZusz9Amr6K6jfl7KXSVV8qa
 BLayHk3lFLSedtKNSQHlXCAXCDSIzPjODMLNK2gAXNklGEu+tc9MgOfvg6ymNOFstqVV
 0PZbN7on/uoIScJ3ivzxs3v5InTqBGrw+FJYFTG0vWsRaVAExqaxP28Lm3Md6lGiAGJ2
 XNuOzx3XuEbYN9Ni5+vpNzzewoM1ExE5A8riJgExBspusU7cDxYqxV3pKGwbkVhtZE5s
 gHBC5D305+nAdgVHwuKtsDKZZGosKnwzlgAjNb5hQEpt62jvubCUFkIEDkGJC9oCp/Sa
 1Pvw==
X-Gm-Message-State: AOAM5301klO6gXLBgGhOS+qQX1RiHs2fnzoW7aBXoeAx13FcvCocChkK
 eaJK77pOphDrXc/4qVOoE7y95IKYlM4=
X-Google-Smtp-Source: ABdhPJz74L1EBf8yOaiobijyAXeHmLhqR20Trs2HJnMFxESeMmSXz15ZdKIk3lOkoRYKMPztGxBlzQ==
X-Received: by 2002:a05:6512:3ca0:: with SMTP id
 h32mr16264011lfv.184.1619508342567; 
 Tue, 27 Apr 2021 00:25:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a350:9a64:f84e:e755?
 ([2a02:908:1252:fb60:a350:9a64:f84e:e755])
 by smtp.gmail.com with ESMTPSA id j26sm1645833lfh.106.2021.04.27.00.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 00:25:42 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] drm/amdgpu: address remove from fault filter
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210426212631.8130-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7b3b212a-bdca-1778-2732-4260253cd45d@gmail.com>
Date: Tue, 27 Apr 2021 09:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426212631.8130-1-Philip.Yang@amd.com>
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

Am 26.04.21 um 23:26 schrieb Philip Yang:
> Add interface to remove address from fault filter ring by resetting
> fault ring entry key, then future vm fault on the address will be
> processed to recover.
>
> Define fault key as atomic64_t type to use atomic read/set/cmpxchg key
> to protect fault ring access by interrupt handler and interrupt deferred
> work for vg20. Change fault->timestamp to 56-bit to share same uint64_t
> with 8-bit fault->next, it is big enough for 48bit IH timestamp.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 54 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++-
>   2 files changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c39ed9eb0987..888b749bd75e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
>   }
>   
> +/**
> + * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
> + *
> + * @addr: 48bit physical address
> + * @pasid: 4 bit
> + */
> +static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
> +{
> +	return addr << 4 | pasid;
> +}
> +
>   /**
>    * amdgpu_gmc_filter_faults - filter VM faults
>    *
> @@ -349,13 +360,14 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   {
>   	struct amdgpu_gmc *gmc = &adev->gmc;
>   
> -	uint64_t stamp, key = addr << 4 | pasid;
> +	uint64_t stamp, key = amdgpu_gmc_fault_key(addr, pasid);
>   	struct amdgpu_gmc_fault *fault;
>   	uint32_t hash;
>   
>   	/* If we don't have space left in the ring buffer return immediately */
>   	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>   		AMDGPU_GMC_FAULT_TIMEOUT;
> +
>   	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp)
>   		return true;
>   
> @@ -365,7 +377,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   	while (fault->timestamp >= stamp) {
>   		uint64_t tmp;
>   
> -		if (fault->key == key)
> +		if (atomic64_read(&fault->key) == key)
>   			return true;
>   
>   		tmp = fault->timestamp;
> @@ -378,7 +390,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   
>   	/* Add the fault to the ring */
>   	fault = &gmc->fault_ring[gmc->last_fault];
> -	fault->key = key;
> +	atomic64_set(&fault->key, key);
>   	fault->timestamp = timestamp;
>   
>   	/* And update the hash */
> @@ -387,6 +399,42 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
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
> +	uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
> +	struct amdgpu_gmc_fault *fault;
> +	uint32_t hash;
> +
> +	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
> +	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
> +	while (true) {
> +		uint64_t tmp;
> +
> +		if (atomic64_cmpxchg(&fault->key, key, 0) == key)
> +			break;
> +
> +		tmp = fault->timestamp;
> +		fault = &gmc->fault_ring[fault->next];
> +
> +		/* Check if the entry was reused */
> +		if (fault->timestamp >= tmp)
> +			break;
> +	}

Maybe rewrite this as "do { ... } while (fault->timestamp < tmp)".

> +}
> +
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9d11c02a3938..95e18ef83aec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -66,9 +66,9 @@ struct firmware;
>    * GMC page fault information
>    */
>   struct amdgpu_gmc_fault {
> -	uint64_t	timestamp;
> +	uint64_t	timestamp:56;

I think 48 bits should be enough for the timestamp for current hardware.

Apart from that looks good to me now,
Christian.

>   	uint64_t	next:AMDGPU_GMC_FAULT_RING_ORDER;
> -	uint64_t	key:52;
> +	atomic64_t	key;
>   };
>   
>   /*
> @@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>   			     struct amdgpu_gmc *mc);
>   bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp);
> +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
> +				     uint16_t pasid);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
