Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD36C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 09:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9196EA45;
	Wed, 24 Nov 2021 09:37:13 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BC96EA45
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 09:37:11 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id y196so1654382wmc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1K2j9URWA287OmhArZZPhuabmMYAYw7HGpQOysEGofk=;
 b=GIVyHw0MAwVmBAuYaNprugASoQQgdrrX/Iv5qI62qRIXEOUA6i8m89kUiGhzEB4V/M
 QnEP9n8W+g2ZloBfZX64A0rJNtOJICgtGsMhV/Dk8prim79bJkZEgmsVxQcxnPoJH2EN
 bcoOo431zrwxmoWgUYAKhni+REwpyKw0tz7vFvmLHCPcNNmXnLVdVk467L2WYR4N+MdN
 dRwgSzcZurMSx1gQpCl2lNERBwb8wO/tvX4a2nZAtqCmBQdRh6Il22eofCRb+m2Hs2f6
 wAbdRqNVJNT3PFSBeOIpj8E3XblOfXm+D6TEYqKZJhKfAcMfOOVmonREFJ6dZiPUgJmx
 32ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1K2j9URWA287OmhArZZPhuabmMYAYw7HGpQOysEGofk=;
 b=s2OzxRaoLghkaTpdInR/yIci8jKZV4CknTBN0anhzFr2rbDy7X6ZYFvuc0UNxTOKUi
 zuqPXL1KjfPwFkKlh6jIWhL6UtxXAkrPJfNF21S5a+ndj/1aau7bGAEvn+YDcsmiqrnQ
 zrJ7TPI6Rx3P7W7ODdLRfKw/b11oeMwKv6fFxCFz+oNP7qIpP78vG++kf/ILR2GuCgmJ
 5R3nGSrcAFPMIMV144wAHOpcBYX3TevP8Hc+GT99xzk3ZAK69r69js0xP5kFAabiDjZD
 oIO0fSsaLqZUYchDiOesgQP6IHLQJsTm8fRs2g/THw6qSpFV0Caehl5IX61Hge04PkgG
 GOKA==
X-Gm-Message-State: AOAM533pYH/4Ci8ICDbJLlLVBaoYZ4RFQ77Jn2TyAWDJNsSFZzzsYWaY
 jf/5tDwi7BbfL+1oDU9kpqmVJIZmqNc=
X-Google-Smtp-Source: ABdhPJz/idB8hVlamuNAqVJKc7h5wkb5H2APoTui+m9kcysYLpBIEcggtn6za4guZQzIe4CKUfbiEQ==
X-Received: by 2002:a1c:9d03:: with SMTP id g3mr12563199wme.143.1637746630150; 
 Wed, 24 Nov 2021 01:37:10 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id bg34sm1850108wmb.47.2021.11.24.01.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 01:37:09 -0800 (PST)
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
Date: Wed, 24 Nov 2021 10:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123192254.21681-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.11.21 um 20:22 schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault because we want receive other interrupts while
> handling retry fault to recover range. There is no overflow flag set
> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
> and drain retry fault.
>
> Add helper function amdgpu_ih_decode_iv_ts to get 48bit timestamp from
> IV entry. drain retry fault is done if processed_timestamp is
> equal to or larger than checkpoint timestamp.
>
> Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
> rptr is larger then timestamp of next entry.
>
> Helper amdgpu_ih_ts_after to compare time stamps with 48bit wrap around.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 107 ++++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  13 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |   1 +
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |   1 +
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |   2 +-
>   7 files changed, 99 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 0c7963dfacad..30b4e0e01444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -164,52 +164,45 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	}
>   }
>   
> +/* return true if time stamp t2 is after t1 with 48bit wrap around */
> +static inline bool amdgpu_ih_ts_after(uint64_t t1, uint64_t t2)
> +{
> +	return ((int64_t)(t2 << 16) - (int64_t)(t1 << 16)) > 0LL;
> +}
> +
>   /* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> +static bool amdgpu_ih_has_checkpoint_processed_ts(struct amdgpu_device *adev,
>   					struct amdgpu_ih_ring *ih,
> -					uint32_t checkpoint_wptr,
> -					uint32_t *prev_rptr)
> +					uint64_t checkpoint_ts)
>   {
> -	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
> -
> -	/* rptr has wrapped. */
> -	if (cur_rptr < *prev_rptr)
> -		cur_rptr += ih->ptr_mask + 1;
> -	*prev_rptr = cur_rptr;
> -
> -	/* check ring is empty to workaround missing wptr overflow flag */
> -	return cur_rptr >= checkpoint_wptr ||
> -	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
> +	return !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts);

I don't see much of a reason to keep this function, it only consists of 
a call to amdgpu_ih_ts_after() and is used only once.

>   }
>   
>   /**
> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
>    *
>    * @adev: amdgpu_device pointer
>    * @ih: ih ring to process
>    *
>    * Used to ensure ring has processed IVs up to the checkpoint write pointer.
>    */
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>   					struct amdgpu_ih_ring *ih)
>   {
> -	uint32_t checkpoint_wptr, rptr;
> +	uint32_t checkpoint_wptr;
> +	uint64_t checkpoint_ts;
>   
>   	if (!ih->enabled || adev->shutdown)
>   		return -ENODEV;
>   
>   	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -	/* Order wptr with rptr. */
> +	/* Order wptr with ring data. */
>   	rmb();
> -	rptr = READ_ONCE(ih->rptr);
> -
> -	/* wptr has wrapped. */
> -	if (rptr > checkpoint_wptr)
> -		checkpoint_wptr += ih->ptr_mask + 1;
> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>   
>   	return wait_event_interruptible(ih->wait_process,
> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
> -						checkpoint_wptr, &rptr));
> +				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
> +						checkpoint_ts));
>   }
>   
>   /**
> @@ -254,6 +247,56 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	return IRQ_HANDLED;
>   }
>   
> +/**
> + * amdgpu_ih_process1 - interrupt handler work for IH ring1
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Interrupt handler of IH ring1, walk the IH ring1.
> + * Returns irq process return code.
> + */
> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)

I don't think we need this new function any more.

The check if the timestamp goes backwards can now be done inside the 
page fault handler.

> +{
> +	uint64_t ts, ts_next;
> +	unsigned int count;
> +	u32 wptr;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return IRQ_NONE;
> +
> +	wptr = amdgpu_ih_get_wptr(adev, ih);
> +	if (ih->rptr == wptr)
> +		return 0;
> +
> +restart_ih:
> +	count = AMDGPU_IH_MAX_NUM_IVS;
> +
> +	ts = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 0);
> +	ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 1);
> +	while (amdgpu_ih_ts_after(ts, ts_next) && --count) {
> +		amdgpu_irq_dispatch(adev, ih);
> +		ih->rptr &= ih->ptr_mask;
> +		ts = ts_next;
> +		ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr, 1);
> +	}
> +	/*
> +	 * Process the last timestamp updated entry or one more entry
> +	 * if count = 0, ts is timestamp of the entry.
> +	 */
> +	amdgpu_irq_dispatch(adev, ih);
> +	amdgpu_ih_set_rptr(adev, ih);
> +	wake_up_all(&ih->wait_process);
> +
> +	wptr = amdgpu_ih_get_wptr(adev, ih);
> +	/* Order reading of wptr vs. reading of IH ring data */
> +	rmb();
> +	if (amdgpu_ih_ts_after(ts, amdgpu_ih_decode_iv_ts(adev, ih, wptr, -1)))
> +		goto restart_ih;
> +
> +	return IRQ_HANDLED;
> +}
> +
>   /**
>    * amdgpu_ih_decode_iv_helper - decode an interrupt vector
>    *
> @@ -298,4 +341,20 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   
>   	/* wptr/rptr are in bytes! */
>   	ih->rptr += 32;
> +	ih->processed_timestamp = entry->timestamp;
> +}
> +
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed offset)
> +{
> +	uint32_t iv_size = 32;
> +	uint32_t dw1, dw2;
> +	uint32_t index;
> +
> +	rptr += iv_size * offset;
> +	index = (rptr & ih->ptr_mask) >> 2;
> +
> +	dw1 = le32_to_cpu(ih->ring[index + 1]);
> +	dw2 = le32_to_cpu(ih->ring[index + 2]);
> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..d7e1ffeca38f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -68,6 +68,7 @@ struct amdgpu_ih_ring {
>   
>   	/* For waiting on IH processing at checkpoint. */
>   	wait_queue_head_t wait_process;
> +	uint64_t		processed_timestamp;
>   };
>   
>   /* provided by the ih block */
> @@ -76,12 +77,17 @@ struct amdgpu_ih_funcs {
>   	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   			  struct amdgpu_iv_entry *entry);
> +	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
> +				 signed offset);
>   	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   };
>   
>   #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>   #define amdgpu_ih_decode_iv(adev, iv) \
>   	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
> +	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \

Please drop that WARN_ON_ONCE here.

Regards,
Christian.

> +	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
>   #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>   
>   int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> @@ -89,10 +95,13 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> +					    struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,
>   				struct amdgpu_iv_entry *entry);
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed offset);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e9023687dc9a..891486cca94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct work_struct *work)
>   	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>   						  irq.ih1_work);
>   
> -	amdgpu_ih_process(adev, &adev->irq.ih1);
> +	amdgpu_ih_process1(adev, &adev->irq.ih1);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 38241cf0e1f1..8ce5b8ca1fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
>   static const struct amdgpu_ih_funcs navi10_ih_funcs = {
>   	.get_wptr = navi10_ih_get_wptr,
>   	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>   	.set_rptr = navi10_ih_set_rptr
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index a9ca6988009e..3070466f54e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
>   static const struct amdgpu_ih_funcs vega10_ih_funcs = {
>   	.get_wptr = vega10_ih_get_wptr,
>   	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>   	.set_rptr = vega10_ih_set_rptr
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index f51dfc38ac65..3b4eb8285943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
>   static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>   	.get_wptr = vega20_ih_get_wptr,
>   	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>   	.set_rptr = vega20_ih_set_rptr
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 10868d5b549f..663489ae56d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   
>   		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>   
> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
> +		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>   						     &pdd->dev->adev->irq.ih1);
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}

