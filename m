Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 09:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121FC10E3F8;
	Tue,  8 Nov 2022 09:40:49 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DA110E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 09:40:45 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id n12so36973426eja.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Nov 2022 01:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wJ+Whxu7RfUamVrlyOxk8U54nWHfh0vUvC4BAMz86q0=;
 b=J6SriMLt6L7Lrvw3fYuuobmsXBAHvLWd1qSTXvS/mE02B3Qg168XHPpWFRuH3RvNHl
 gsBBwDvCxcFkU93VLIReaLOrrSYKCcQg8vViyx40NDP/cKOI0ZRuqlvf2zUEILEqKBiw
 P9nYRCFYTFkZ30iR7AhWgSseJRrQeatslchVMAdtruGsFDWaiGrRvNchhuIKWiUU5bmH
 wgfe7qDWCq0dVCj8Nauk3C0NdvW9lF20wLDQ3cCwAx5tuOQZe0rMleJpjunSR5AUqu66
 dqIUGsq0y5c/+VTKcRnnn3KxpyPJb2zqu0DCWNbWTHb01ByqMvDLMin64OI6rOYGxeaC
 XFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ+Whxu7RfUamVrlyOxk8U54nWHfh0vUvC4BAMz86q0=;
 b=7gvc0S932tRgwQqDCYO3pjh2d9+d2YWi3NNX9mSBpxtAJnoS9jl69QqcwTvB7d1AaV
 OxjxjeyNrapzbKYYlHHvFc8ageq9qHXvWKt9k7ICUQCTG3v4Dr5KtGfPg296b4u0Q7Hd
 RwqVZGRpAO+Ys+ErmvQC5Y4DmjWdkq9i15c56bkOBi7Sj3zc24Qy1WFMVORh8CH+SURU
 nDrSm9CIRvE1NHOCJ1KbTdBF0eBiOpIshY/lGsLKi66j14UvQgPnKwKKdmL7MoO0HJVz
 7i1hrd7hshtDmj6q0p09D+ffWWwk0eZqf3UxSEAsbgu0gFTViv55gevXIe9bO0Mr0wtG
 2gQw==
X-Gm-Message-State: ACrzQf2p95+FNp8rZR28jXdfID9cNS61X6ilX4GNBbwlxUJwM3G6vxP/
 dx09bOdRjG+CImbWZCq7Ph4=
X-Google-Smtp-Source: AMsMyM53M7yu9b6vDcntwKUnKWdKK7ek8cH+6NpAkurmu06Nr2Qf2CFejqRJIv+dovOdmhoucaY/hQ==
X-Received: by 2002:a17:907:1def:b0:7ad:9673:8668 with SMTP id
 og47-20020a1709071def00b007ad96738668mr50900432ejc.698.1667900443433; 
 Tue, 08 Nov 2022 01:40:43 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402321a00b00463bc1ddc76sm5302312eda.28.2022.11.08.01.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Nov 2022 01:40:42 -0800 (PST)
Message-ID: <b96aa625-e135-4730-e6a2-ce57d064e51b@gmail.com>
Date: Tue, 8 Nov 2022 10:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221108024650.11787-1-Tong.Liu01@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221108024650.11787-1-Tong.Liu01@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.22 um 03:46 schrieb Tong Liu01:
> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR
> region firstly to make sure TMR can be allocated at 2MB
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>   drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>   4 files changed, 192 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index b81b77a9efa6..239c621feb0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
> +		int *usage_bytes)
> +{
> +	uint32_t start_addr, size;
> +
> +	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +		le32_to_cpu(firmware_usage_v2_1->start_address_in_kb),
> +		le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb),
> +		le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb));
> +
> +	start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
> +	size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);

As I wrote before try to avoid calling le*_to_cpu multiple times.

In this case here get the start_addr and size and then print it, not the 
other way around.

> +
> +	if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {

This is still not looking like normal kernel coding style. What editor 
are you using?

And please drop the explicit uint32_t conversion.

Regards,
Christian.

> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = size << 10;
> +		/* Use the default scratch size */
> +		*usage_bytes = 0;
> +	} else {
> +		*usage_bytes =
> +			le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb) << 10;
> +	}
> +	return 0;
> +}
> +
> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
> +		int *usage_bytes)
> +{
> +	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +		le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb),
> +		le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb),
> +		le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb),
> +		le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb));
> +
> +	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
> +
> +	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
> +	drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
> +
> +	if ((uint32_t)(fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +	}
> +
> +	if ((uint32_t)(drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* driver request VRAM reservation for SR-IOV */
> +		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.drv_vram_usage_size = drv_size << 10;
> +	}
> +
> +	*usage_bytes = 0;
> +	return 0;
> +}
> +
>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>   {
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						vram_usagebyfirmware);
> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
> -	uint32_t start_addr, size;
> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>   	uint16_t data_offset;
> +	uint8_t frev, crev;
>   	int usage_bytes = 0;
>   
> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
> -
> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
> -
> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -			/* Firmware request VRAM reservation for SR-IOV */
> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -			adev->mman.fw_vram_usage_size = size << 10;
> -			/* Use the default scratch size */
> -			usage_bytes = 0;
> -		} else {
> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> +		if (frev == 2 && crev == 1) {
> +			firmware_usage_v2_1 =
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +					firmware_usage_v2_1,
> +					&usage_bytes);
> +		} else if (frev >= 2 && crev >= 2) {
> +			firmware_usage_v2_2 =
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> +					firmware_usage_v2_2,
> +					&usage_bytes);
>   		}
>   	}
> +
>   	ctx->scratch_size_bytes = 0;
>   	if (usage_bytes == 0)
>   		usage_bytes = 20 * 1024;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 585460ab8dfd..4a73cb314086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>   		NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
> +/*
> + * Driver Reservation functions
> + */
> +/**
> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free drv reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, NULL);
> +}
> +
>   /**
>    * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>    *
> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  &adev->mman.fw_vram_usage_va);
>   }
>   
> +/**
> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from drv.
> + */
> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.drv_vram_usage_size == 0 ||
> +	    adev->mman.drv_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.drv_vram_usage_start_offset,
> +					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
> +					  &adev->mman.drv_vram_usage_reserved_bo,
> +					  NULL);
> +}
> +
>   /*
>    * Memoy training reservation functions
>    */
> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/*
> +	 *The reserved vram for driver must be pinned to the specified
> +	 *place on the VRAM, so reserve it early.
> +	 */
> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * only NAVI10 and onwards ASIC support for IP discovery.
>   	 * If IP discovery enabled, a block of memory should be
> @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9120ae80ef52..339838675b11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
>   
> +	/* driver VRAM reservation */
> +	u64		drv_vram_usage_start_offset;
> +	u64		drv_vram_usage_size;
> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index ff855cb21d3f..c0f56ae653f0 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1
>   };
>   
>   
> -/*
> -  ***************************************************************************
> -    Data Table vram_usagebyfirmware  structure
> -  ***************************************************************************
> +/*
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> +      driver can allocate driver reservation region under firmware reservation,
> +      used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> +    Host driver would overwrite the table with the following
> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
> +    } else {
> +      there is no VBIOS reservation region
> +      driver must allocate driver reservation region at top of FB.
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    }
> +  } else { //( NV1X and after)
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> +    }
> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
> +      driver can allocate driver reservation region under firmware reservation,
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    } else {
> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
> +      driver set used_by_driver_region0_in_kb = driver reservation size
> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
> +    }
> +  }
>   */
>   
>   struct vram_usagebyfirmware_v2_1
>   {
> -  struct  atom_common_table_header  table_header;
> -  uint32_t  start_address_in_kb;
> -  uint16_t  used_by_firmware_in_kb;
> -  uint16_t  used_by_driver_in_kb;
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  used_by_driver_in_kb;
>   };
>   
> +struct vram_usagebyfirmware_v2_2 {
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  fw_region_start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  reserved;
> +	uint32_t  driver_region0_start_address_in_kb;
> +	uint32_t  used_by_driver_region0_in_kb;
> +	uint32_t  reserved32[7];
> +};
>   
>   /*
>     ***************************************************************************

