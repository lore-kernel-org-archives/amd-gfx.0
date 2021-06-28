Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC994C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861A4619A3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861A4619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A62C89F0A;
	Mon, 28 Jun 2021 14:10:09 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC1889F31
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 14:10:08 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id j11so617495edq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gxFfY3WUQEYz+85rlFasOr27fVnt+m+u5HfJWwBwnTU=;
 b=vS7PTPfZLwyTaViqnKwpfJ9/MEqJISZIYxSCmB+Mtni+0gQ1odQ8wSWlZ2zEPVxelt
 i2PPmLFNh12LsPvWSvM22X7umDDO2Pw39dGl+vsc2mRVNGxuKw3xz+mD4uImRnVqtkFo
 /Q5dLdOLcpB2MxyyFu5eLMPdZootgEp0XLDww4V+QKT9T9tighPEK1pWpo3bARPaD4up
 3bhoJV9Hv/70PFSOJQR/d1q+QTiKUUS841JkoOUaVW9LhE2o3/Bs6vUHAwaZ/8d+VaC8
 ROme2Jiw3rPsHCO4SOoXY+/KYhU0ydv+KXMpXc3Rns/JAKoTgRBkl0bWAwNNDLW9yNRz
 cjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gxFfY3WUQEYz+85rlFasOr27fVnt+m+u5HfJWwBwnTU=;
 b=kbakya8LDS2iQMQbDwiQjaKYS9Brzgfe0VSWecJmzDYagYKJ+KNeAEY3PtTsI0PNOP
 N9Uznc68rl1plxvq9Z06izTLtmNAqfMMwrU4rg+MsycHMx/bar6GNOL4PzJ9BKbBNYH+
 O+JLeWYmOntupJaK+2vtZehbkHbqnH2qHEnwe+LvXZRN60KEqZxeCyI2oVVjnoW/h8fM
 myfwbXhDGeI8EtelclMRxJCGLhKqI9rfz5AkjcNIgIIFtaRGhtcjXH2BzOjHPrBGyTiM
 Frj0bh25f5qMRk96icj7szJgxISZdO/Ed7OQhDa0jtOFSpNBpy771fdnxH/G9X9HGWsM
 goAg==
X-Gm-Message-State: AOAM532/wAjBDeQt/Nxr7l7iI7LcgJwfe2gKmkU3Eo1r1Jvv+Iv+wNYX
 ByTz6h1m8AxrisUAUwWeu0thkneEuzY=
X-Google-Smtp-Source: ABdhPJxWZthr2feSzSXCkiK03Sp4pY06mHFkBuWEmlWJUZCIB5UCd1zBAngto8rvgw3dFXjSw6UGTw==
X-Received: by 2002:a05:6402:c92:: with SMTP id
 cm18mr33391438edb.29.1624889406848; 
 Mon, 28 Jun 2021 07:10:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:893:70fa:9408:ad54?
 ([2a02:908:1252:fb60:893:70fa:9408:ad54])
 by smtp.gmail.com with ESMTPSA id bz27sm7007897ejc.15.2021.06.28.07.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 07:10:06 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210625032409.15715-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <878b44fb-a768-6bc2-2873-b7a75fc5ee1e@gmail.com>
Date: Mon, 28 Jun 2021 16:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625032409.15715-1-kevin1.wang@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.06.21 um 05:24 schrieb Kevin Wang:
> 1. add non-aligned address support in amdgpu_device_vram_access()
> 2. reduce duplicate code in amdgpu_ttm_access_memory()
>
> because the MM_INDEX{HI}/DATA are protected register, it is not working
> in sriov environment when mmio protect feature is enabled (in some asics),
> and the old function amdgpu_ttm_access_memory() will force using MM_INDEX/DATA
> to handle non-aligned address by default, it will cause the register(MM_DATA)
> is always return 0.
>
> with the patch, the memory will be accessed in the aper way first.
> (in visible memory or enable pcie large-bar feature), then using
> MM_INDEX{HI}/MM_DATA to access rest vram memroy.

Well NAK to the whole approach.

The amdgpu_device_vram_access() are intentionally *NOT* using the VRAM 
aperture nor providing byte wise access.

And yes that this doesn't work under SRIOV is completely intentional as 
well.

What we could do is to use the aperture in amdgpu_ttm_access_memory() 
for unaligned access if that is indeed a problem.

Regards,
Christian.


>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
>   3 files changed, 58 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d14b4968a026..8095d9a9c857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev);
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>   
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write);
> +			       void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e6702d136a6d..2047e3c2b365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>   		amdgpu_acpi_is_power_shift_control_supported());
>   }
>   
> +static inline void amdgpu_device_vram_mmio_align_access_locked(struct amdgpu_device *adev, loff_t pos,
> +							       uint32_t *value, bool write)
> +{
> +	BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +	WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +	if (write)
> +		WREG32_NO_KIQ(mmMM_DATA, *value);
> +	else
> +		*value = RREG32_NO_KIQ(mmMM_DATA);
> +}
> +
> +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *adev, loff_t pos,
> +						  void *buf, size_t size, bool write)
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
> +			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, false);
> +			if (write) {
> +				value &= ~mask;
> +				value |= (*(uint32_t *)buf << shift) & mask;
> +				amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, true);
> +			} else {
> +				value = (value & mask) >> shift;
> +				memcpy(buf, &value, bytes);
> +			}
> +		} else {
> +			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, buf, write);
> +		}
> +
> +		pos += bytes;
> +		buf += bytes;
> +		size -= bytes;
> +	}
> +}
> +
>   /*
>    * VRAM access helper functions
>    */
> @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>    * @write: true - write to vram, otherwise - read from vram
>    */
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write)
> +			       void *buf, size_t size, bool write)
>   {
>   	unsigned long flags;
> -	uint32_t hi = ~0;
>   	uint64_t last;
>   
> -
>   #ifdef CONFIG_64BIT
>   	last = min(pos + size, adev->gmc.visible_vram_size);
>   	if (last > pos) {
> @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   			return;
>   
>   		pos += count;
> -		buf += count / 4;
> +		buf += count;
>   		size -= count;
>   	}
>   #endif
> -
>   	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -	for (last = pos + size; pos < last; pos += 4) {
> -		uint32_t tmp = pos >> 31;
> -
> -		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -		if (tmp != hi) {
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -			hi = tmp;
> -		}
> -		if (write)
> -			WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -		else
> -			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
> -	}
> +	amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
>   	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6297363ab740..cf5b8bdc2dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>   	struct amdgpu_res_cursor cursor;
> -	unsigned long flags;
> -	uint32_t value = 0;
>   	int ret = 0;
>   
>   	if (bo->mem.mem_type != TTM_PL_VRAM)
> @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
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
> +		amdgpu_device_vram_access(adev, cursor.start,
> +					  buf, cursor.size,
> +					  write);
>   
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
