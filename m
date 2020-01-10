Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD3C33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418762072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBBOOyqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418762072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064636E9C6;
	Fri, 10 Jan 2020 11:28:03 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913F36E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 11:28:02 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z7so1428823wrl.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4K4vi4uo+LcosdDA4CTdGKb4SWnYD7tdxrfndYXjeyA=;
 b=KBBOOyqwvUejfH76eMefMb31lG8pzz6gCHJ7BFkPWd/D9Pjkgu4P0IEElfhndO9o8z
 jMTNbgPfcBll/nzrAeKw5AA2dykUBU+ohPp6OHP3ftdB9wTn6wMZzhx55L4QUxzBRky2
 NcHWk0k0H4SU8PqlGSdm8KZiv4sPD2Z0Ck6Zql2QT86rA3ruxUr4Z/tkdgEowT7NqqUj
 TykQs2Llkw2dEWkKr64ZaAraBW9+GcdV5rocm0D2mA4KSXo+6ikBwd9lkncXPNmvi9LH
 oXSxVE/TrXKJygb2FqC3ZYwL514iAwTm39aWo95xqtqk2xOMeKKS9Vjhg8ovCPeAxb5m
 ns1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4K4vi4uo+LcosdDA4CTdGKb4SWnYD7tdxrfndYXjeyA=;
 b=gNn6BiS0FlHbZ0J8Lci7Y4vXr+krSwPeGq0jP9B9lEPg/wMn5TZ1toBW+/i4pHIYKT
 rSDYyYFtHgZ9ujoftEL3ovEi3RfC00f03vD4ZcdoZACKFLjWunBsEnq+wVhffAeJWPvC
 zZzN4E1Porqru8cUYiB7zomU+MfJSKJ+D428wzV7W/ezsjKKmy8679YuZRS00Wb8G6oU
 ZcxPVodyTLpS4CdQJL1DN4c+ggn4S2SKmlcSjLDQuxx0T/kIq32rFxMBt/bsN506a1oY
 S4+drLQNl4a82zEAAgtzc7MLC+4aLr428xqLrwwgD+AwrD+ImNunwC771pOhdUfmjZSY
 6nyQ==
X-Gm-Message-State: APjAAAXJQhSAtZ6r+QoZQCPN9NfeHYRTG0ThpOqJBHXHYYuGX5MPS2Kf
 NhmLMFbCLkf1AQsumJ4Tk0Ezj7w9
X-Google-Smtp-Source: APXvYqxvwsfpI2MeiAvk7gGdW4cdFOMdZGPAxHdogSMNUMB8MgoUAbwPrK2JfciQvT7oFb6slAifJQ==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr2991070wrq.57.1578655681025; 
 Fri, 10 Jan 2020 03:28:01 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y7sm6685717wmd.1.2020.01.10.03.28.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 03:28:00 -0800 (PST)
Subject: Re: [PATCH 7/7] drm/amdgpu: tlbs invalidate replaced by kiq_pm4_funcs
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200110000412.66930-1-alex.sierra@amd.com>
 <20200110000412.66930-7-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <df3ade95-935e-1518-30be-47184beb2474@gmail.com>
Date: Fri, 10 Jan 2020 12:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110000412.66930-7-alex.sierra@amd.com>
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

The end result looks good, but you should consider re-ordering this 
patch set.

That would clean things up and make review much easier.

Adding code first and then removing it later on in the same patch set is 
not a good practice.

Regards,
Christian.

Am 10.01.20 um 01:04 schrieb Alex Sierra:
> TLBs invalidation was removed from gmc_v9 and gmc_v10 files.
> This implementation has been moved to kiq_pm4_funcs calls.
>
> Change-Id: I66463e2e5fdf7611ef4a802eb517ae0d269987c3
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 32 ++------------------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 32 ++------------------------
>   2 files changed, 4 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 8cf34c7bd416..09408b8b390f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -250,35 +250,6 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
>   	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
>   }
>   
> -static int gmc_v10_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
> -					uint16_t pasid, uint32_t flush_type,
> -					bool all_hub)
> -{
> -	signed long r;
> -	uint32_t seq;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> -	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> -	amdgpu_ring_write(ring,
> -			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> -			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
> -			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> -			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> -	if (r < 1) {
> -		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> -		return -ETIME;
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * GART
>    * VMID 0 is the physical GPU addresses as used by the kernel.
> @@ -441,9 +412,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint16_t queried_pasid;
>   	bool ret;
>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready)
> -		return gmc_v10_0_invalidate_tlbs_with_kiq(adev,
> +		return kiq->pmf->kiq_invalidate_tlbs(ring,
>   						pasid, flush_type, all_hub);
>   
>   	for (vmid = 1; vmid < 16; vmid++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 7cc6f305bfa8..670b2b62789b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -455,35 +455,6 @@ static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
>   	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
>   }
>   
> -static int gmc_v9_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
> -				uint16_t pasid, uint32_t flush_type,
> -				bool all_hub)
> -{
> -	signed long r;
> -	uint32_t seq;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> -	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> -	amdgpu_ring_write(ring,
> -			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> -			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
> -			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> -			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> -	if (r < 1) {
> -		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> -		return -ETIME;
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * GART
>    * VMID 0 is the physical GPU addresses as used by the kernel.
> @@ -598,12 +569,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint16_t queried_pasid;
>   	bool ret;
>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	if (adev->in_gpu_reset)
>   		return -EIO;
>   
>   	if (ring->sched.ready)
> -		return gmc_v9_0_invalidate_tlbs_with_kiq(adev,
> +		return kiq->pmf->kiq_invalidate_tlbs(ring,
>   						pasid, flush_type, all_hub);
>   
>   	for (vmid = 1; vmid < 16; vmid++) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
