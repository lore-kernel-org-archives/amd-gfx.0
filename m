Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2953C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B576B600CD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B576B600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C77C6E047;
	Tue, 13 Jul 2021 07:11:34 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663F6E047
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:11:32 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 b14-20020a1c1b0e0000b02901fc3a62af78so837426wmb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9XLHCpqWFwU6/1lKbF1LeuVkGChWsnYrsJTRf8mZRoI=;
 b=XwHXit+KrLvDoLTZbUQ1QW37JfeSVVYyu/qdf/HMcmeuwl4vICo+eeDRv3VN0W5wKr
 blHbaLP8FPJEo3EEcH+oG07TkkQ/FPDzMVUDWI+Nb737YUTUnB8Lgk82RWw0fhvkWMI3
 z2EflWcIauHuyQm69PfrLP+fLvPcFH6dJJZ1p3wZopHbLW08+ycVenC70fqiNzKoKq+X
 efdzVR6ppYH+QV91o4X8vkQl2pauaO5oz3EUGI9gtUxOJBS4Fy+gseE1n3iODrCjL7qT
 9EqGUPUGphsAUwbXqL39scBb+LZmXfTj2UiYjSXZBgU+WzsiSTmsmdxf+VFNlSSumZnS
 dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9XLHCpqWFwU6/1lKbF1LeuVkGChWsnYrsJTRf8mZRoI=;
 b=kd16+SVzHktS8wrl8GE51qLXsK89S4AkCANMJm7KZcPEf/691JMnjdQzve1Q/TYTED
 t+FtC/7IKHpfsUVNYMsQ0jO+x3K1wMUu+djaqO9hWeg8FEEVbqMYkzBgbz8PR+8BWe1p
 RfLjdxGGHKTYZYEDr2zVlUtzj4AyDhflqGivdyhzQxNqYo9ulcsOt+hcfuwXk3jozbTw
 AT1E0LIaqDNQQQTV+e8kGiFpp/W345Qg5xoazZocXqWhcXvWWJmomzUcYLvKu14feDPA
 FTnTZguRwMoaWtG7TzWihP0UQS3vYwe+fz2tBBYQWjpAc0a33vtJ0mtguobZAfFCWkdZ
 w0Sw==
X-Gm-Message-State: AOAM532PLoZT1t04rnBzkU22MJb+U8eodIZ9RZvs3zfnuzfCd9+kfYr2
 g1NTgnaYeJwPNUyfpvOTBdo=
X-Google-Smtp-Source: ABdhPJzfTVi5ceKkK7GU3fd2wplFZtfoYck2FPojEGiNmT9WdlPuglV5DP2EocxZ6MeaBVMPpuX8Aw==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr18434512wmc.138.1626160291562; 
 Tue, 13 Jul 2021 00:11:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7f5a:cff:4644:b698?
 ([2a02:908:1252:fb60:7f5a:cff:4644:b698])
 by smtp.gmail.com with ESMTPSA id b16sm13688349wrw.46.2021.07.13.00.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 00:11:31 -0700 (PDT)
Subject: Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210713032329.7393-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8536eff2-c869-9b06-2586-0f3cef928a96@gmail.com>
Date: Tue, 13 Jul 2021 09:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713032329.7393-1-kevin1.wang@amd.com>
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

Am 13.07.21 um 05:23 schrieb Kevin Wang:
> 1. using vram aper to access vram if possible
> 2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is
> enabled.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126 +++++++++++++++++-------
>   1 file changed, 89 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2aa2eb5de37a..8f6f605bc459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1407,6 +1407,91 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>   	return ttm_bo_eviction_valuable(bo, place);
>   }
>   
> +static void amdgpu_ttm_vram_mm_align_access(struct amdgpu_device *adev, loff_t pos,
> +					    uint32_t *value, bool write)

Please drop the _vram_ and _align_ part from the name. Just 
amdgpu_device_mm_access.

> +{
> +	unsigned long flags;
> +
> +	BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> +	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +	WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +	if (write)
> +		WREG32_NO_KIQ(mmMM_DATA, *value);
> +	else
> +		*value = RREG32_NO_KIQ(mmMM_DATA);
> +	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +}

That should still be in amdgpu_device.c and you completely messed up the 
drm_dev_enter()/drm_dev_exit() annotation.

Looks like you are working on an old branch where that is not yet merged?

> +
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
> +			amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, false);
> +			if (write) {
> +				value &= ~mask;
> +				value |= (*(uint32_t *)buf << shift) & mask;
> +				amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, true);
> +			} else {
> +				value = (value & mask) >> shift;
> +				memcpy(buf, &value, bytes);
> +			}
> +		} else {
> +			amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, buf, write);
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
> +	uint64_t last;
> +
> +#ifdef CONFIG_64BIT
> +	last = min(pos + size, adev->gmc.visible_vram_size);
> +	if (last > pos) {
> +		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> +		size_t count = last - pos;
> +
> +		if (write) {
> +			memcpy_toio(addr, buf, count);
> +			mb();
> +			amdgpu_device_flush_hdp(adev, NULL);
> +		} else {
> +			amdgpu_device_invalidate_hdp(adev, NULL);
> +			mb();
> +			memcpy_fromio(buf, addr, count);
> +		}
> +
> +		if (count == size)
> +			return;
> +
> +		pos += count;
> +		buf += count;
> +		size -= count;
> +	}
> +#endif

I would put this as a separate function into amdgpu_device.c.

But all of this should only be the second step since we need a much 
smaller patch for backporting first.

> +
> +	amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
> +}
> +
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1426,8 +1511,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>   	struct amdgpu_res_cursor cursor;
> -	unsigned long flags;
> -	uint32_t value = 0;
>   	int ret = 0;
>   
>   	if (bo->mem.mem_type != TTM_PL_VRAM)
> @@ -1435,41 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
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

This here is the problematic part and should use 
amdgpu_ttm_vram_access() instead.

That should be implemented first since we might need to backport that.

Regards,
Christian.

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
