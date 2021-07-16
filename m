Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD18C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936D7613E9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936D7613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DCC6E935;
	Fri, 16 Jul 2021 07:43:23 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2896E93B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 07:43:21 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id f190so3641336wmf.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bbGd+50LQ7bnpNxeWmk/j4hCWiLPHdZ4FI1jURN8+ZU=;
 b=rRx54SD9BCEGYv3mGipqKmEeNt9sI3jCJGU3UVz7hOZ12SRaS2Y7t2zcjUORq4rCxb
 BmMC7WA9iccOOH1OcheCpkkTWT4qC50fzFzi+hJUQSAl1AMSFnl6NQEeb4wh0DkhMy2C
 1ynYI7LDKW5LvlEt+Qg2MunTqXpQQwGCNrkDB+NrEj3ger5PVvPSFtyk5NIjgWq9ic3o
 +SJwngPX5pN0aCuLUx18KZSfmsaiBoIEp7G8PdMW2/ZQS3W20ET7wWtxK2it7gnTxBLX
 0ROLRTRHYoLQLjDo8fBYIUzEykU7gYC0xXNU4XUetgp65idBoX4KKtUXUGGny7qvMJyc
 JUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bbGd+50LQ7bnpNxeWmk/j4hCWiLPHdZ4FI1jURN8+ZU=;
 b=ph8EHF6KOEdJDnR9L3TLhnNs+hKL/flFm9jpmypVzl/1bSnia49x6koPHL7Qstn2Gk
 X5Gc9Y8OEJ3BnQCFna3nxKAuzwtTwLEaifSCfe8RztnVMFEwhP8m4GK5i7m1qGrIKfzz
 UmBP/ZuEAr72+k4wIcC+eEza1NiyJzz66o1B0n/MhCbGRNOk1DYSfk9A9jhNEUEnq6bV
 l8+DbXtHQ3yhxAbxX/kT4FCeF/fCcRkLraG4q10HRS0Arh5B+0s/l5qztE45ALpj6ryv
 DQ9ACszAZeCTil0XYvFZpG+w/A9EcxggBoeJ6KQTm5WX2WkVIXO7zeWZ4fgVtRmgyaYN
 tyzw==
X-Gm-Message-State: AOAM53127vCR9EIfGnVqoH54G9vzcqT1YYY1KKyIFfFLrrzwKNxieLCd
 1botNL8D1Sea1bKWJqgSkKg=
X-Google-Smtp-Source: ABdhPJyKm4H6TnDGKIXrD2Dpibh2choizSsg66IcKPU6tvF0l/EuBgz8P5HV7d9/vY4NEyDxh7CKCw==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr8849417wmb.167.1626421400448; 
 Fri, 16 Jul 2021 00:43:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e013:2fad:8ece:8234?
 ([2a02:908:1252:fb60:e013:2fad:8ece:8234])
 by smtp.gmail.com with ESMTPSA id b9sm11235943wrh.81.2021.07.16.00.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 00:43:19 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210716031042.827317-1-kevin1.wang@amd.com>
 <20210716031042.827317-3-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3d3a95cd-2076-1083-c5f5-54937549a524@gmail.com>
Date: Fri, 16 Jul 2021 09:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716031042.827317-3-kevin1.wang@amd.com>
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, frank.min@amd.com,
 christian.koenig@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 16.07.21 um 05:10 schrieb Kevin Wang:
> 1. using vram aper to access vram if possible
> 2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is
> enabled.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 91 +++++++++++++++----------
>   1 file changed, 54 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f4ff3c9350b3..62ea5089b4f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1407,6 +1407,56 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>   	return ttm_bo_eviction_valuable(bo, place);
>   }
>   
> +static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
> +				      void *buf, size_t size, bool write)
> +{
> +	while (size) {
> +		uint64_t aligned_pos = ALIGN_DOWN(pos, 4);
> +		uint64_t bytes = 4 - (pos & 0x3);
> +		uint32_t shift = (pos & 0x3) * 8;
> +		uint32_t mask = 0xffffffff << shift;
> +		uint32_t value = 0;
> +
> +		if (size < bytes) {
> +			mask &= 0xffffffff >> (bytes - size) * 8;
> +			bytes = size;
> +		}
> +
> +		if (mask != 0xffffffff) {
> +			amdgpu_device_mm_access(adev, aligned_pos, &value, 4, false);
> +			if (write) {
> +				value &= ~mask;
> +				value |= (*(uint32_t *)buf << shift) & mask;
> +				amdgpu_device_mm_access(adev, aligned_pos, &value, 4, true);
> +			} else {
> +				value = (value & mask) >> shift;
> +				memcpy(buf, &value, bytes);
> +			}
> +		} else {
> +			amdgpu_device_mm_access(adev, aligned_pos, buf, 4, write);
> +		}
> +
> +		pos += bytes;
> +		buf += bytes;
> +		size -= bytes;
> +	}
> +}
> +
> +static void amdgpu_ttm_vram_access(struct amdgpu_device *adev, loff_t pos,
> +				   void *buf, size_t size, bool write)
> +{
> +	size_t count;
> +
> +	count = amdgpu_device_aper_access(adev, pos, buf, size, write);
> +	size -= count;
> +	if (size) {
> +		/* using MM to access rest vram and handle un-aligned address */
> +		pos += count;
> +		buf += count;
> +		amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
> +	}
> +}

Just inline that function into the caller, don't really see the need to 
have that separated.

Apart from that looks good to me.

Regards,
Christian.

> +
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1426,8 +1476,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>   	struct amdgpu_res_cursor cursor;
> -	unsigned long flags;
> -	uint32_t value = 0;
>   	int ret = 0;
>   
>   	if (bo->mem.mem_type != TTM_PL_VRAM)
> @@ -1435,41 +1483,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   
>   	amdgpu_res_first(&bo->mem, offset, len, &cursor);
>   	while (cursor.remaining) {
> -		uint64_t aligned_pos = cursor.start & ~(uint64_t)3;
> -		uint64_t bytes = 4 - (cursor.start & 3);
> -		uint32_t shift = (cursor.start & 3) * 8;
> -		uint32_t mask = 0xffffffff << shift;
> -
> -		if (cursor.size < bytes) {
> -			mask &= 0xffffffff >> (bytes - cursor.size) * 8;
> -			bytes = cursor.size;
> -		}
> -
> -		if (mask != 0xffffffff) {
> -			spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -			WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) | 0x80000000);
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> -			value = RREG32_NO_KIQ(mmMM_DATA);
> -			if (write) {
> -				value &= ~mask;
> -				value |= (*(uint32_t *)buf << shift) & mask;
> -				WREG32_NO_KIQ(mmMM_DATA, value);
> -			}
> -			spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -			if (!write) {
> -				value = (value & mask) >> shift;
> -				memcpy(buf, &value, bytes);
> -			}
> -		} else {
> -			bytes = cursor.size & ~0x3ULL;
> -			amdgpu_device_vram_access(adev, cursor.start,
> -						  (uint32_t *)buf, bytes,
> -						  write);
> -		}
> -
> -		ret += bytes;
> -		buf = (uint8_t *)buf + bytes;
> -		amdgpu_res_next(&cursor, bytes);
> +		amdgpu_ttm_vram_access(adev, cursor.start, buf, cursor.size, write);
> +		ret += cursor.size;
> +		buf += cursor.size;
> +		amdgpu_res_next(&cursor, cursor.size);
>   	}
>   
>   	return ret;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
