Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A60C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FB26100A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FB26100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAD26E17C;
	Wed, 21 Apr 2021 07:22:18 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069186E17C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:22:17 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id x12so41236508ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=IY3eSSPyenDqO3a2xTlYKXNgSthLDF5VbBYezL92jKQ=;
 b=ZZqYHmM7C7hOeIe8Cjuuis0DfCbnuk4kqtFXnwIn54c+Gw8jShfsDQnu7nU8yetqXA
 Mj4dOIXTfHHsOBq2wCWzjr5oMwKHz4FC74GGRzlxP6wWwly23SV1mpcKcsLpzhThNZCu
 yklgsv3dNTLF+ctzBsKhpnoSQmoFrPXYj0x0krndtA0oFzvEXqgjNacLHj9zLa3v7qSx
 oJ2kg/VOqYpXApurHti7sMeoNMfyiknIdlB4V86TmT4OzSRQu83AbVMzOxV2uSh2KVDz
 6g6aDpws9vgMj9U/aVWmqqCvicpGjiIXIXrQ1Oz4kz+92PlS/9fAQtljVq6wB5lGJlJf
 sm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IY3eSSPyenDqO3a2xTlYKXNgSthLDF5VbBYezL92jKQ=;
 b=GerPewZPUH06Bga1rWxKYPPxchKGbx+wXL+gavXLqfvcFkM4MCTHzIXwYoFOAOQu5F
 jxd+8UmqkitjyfqnGe8jAtnCTOubWLBYwhyRAuX8qiJgnHK6a7Nw/qqaBngtqLSEOrDf
 iJgZMvEJGPIt6c3MhS8ANC6aMya6RzOmpkhlpRPJmyt9Pxa4G5EWBa7Uquu72/vbdMHn
 +bYoJQFFz1g6o2oFmzYYQw0O1XP/E0RW8FVTV85x+xJBcdQfuAVxJDq9GUwCXPOjqp7w
 DtgX33EPqKwkKpc2sCryOX1rHn/vPOtfZbixewfXRC6nvDgRwmGZxHMEzhvlbrxwlvDp
 YABA==
X-Gm-Message-State: AOAM530t2DI6z/zFkiooa8n1qLCGKqOHaUQegDhFqe3Dvb8AkL9JoRV6
 7dlVGXKqd0qsmeXzkYvogLiy4dqUFaE=
X-Google-Smtp-Source: ABdhPJy29aPEXcobgYsYdPX4QZYpjvz01md/HUHEMYcBgHShqDhej8f8fZMmFCod1Qv8ehxvfcK+/A==
X-Received: by 2002:a17:906:3111:: with SMTP id
 17mr30968784ejx.403.1618989736649; 
 Wed, 21 Apr 2021 00:22:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:30c1:a1b7:433d:2c5d?
 ([2a02:908:1252:fb60:30c1:a1b7:433d:2c5d])
 by smtp.gmail.com with ESMTPSA id s13sm1374950ejz.110.2021.04.21.00.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Apr 2021 00:22:16 -0700 (PDT)
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com>
Date: Wed, 21 Apr 2021 09:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420202122.4701-4-Philip.Yang@amd.com>
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

Am 20.04.21 um 22:21 schrieb Philip Yang:
> Add interface to remove address from fault filter ring by resetting
> fault ring entry of the fault address timestamp to 0, then future vm
> fault on the address will be processed to recover.
>
> Check fault address from fault ring, add address into fault ring and
> remove address from fault ring are serialized in same interrupt deferred
> work, don't have race condition.

That might not work on Vega20.

We call amdgpu_gmc_filter_faults() from the the IH while the fault 
handling id done from the delegated IH processing.

More comments below.

> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 24 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c39ed9eb0987..338e45fa66cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -387,6 +387,30 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
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
> +	uint64_t key = addr << 4 | pasid;

We should probably have a function for this now.

> +	struct amdgpu_gmc_fault *fault;
> +	uint32_t hash;
> +
> +	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
> +	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
> +	fault->timestamp = 0;

There is no guarantee that the ring entry you found for the fault is the 
one for this address.

After all that is just an 8 bit hash for a 64bit values :)

You need to double check the key and walk the chain by looking at the 
next entry to eventually find the right one.

Christian.

> +}
> +
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9d11c02a3938..498a7a0d5a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
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
