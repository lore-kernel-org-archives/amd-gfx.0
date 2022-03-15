Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8786EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037F110E3F7;
	Tue, 15 Mar 2022 14:40:26 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C1510E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:40:25 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id r23so2068510edb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=k0y1rUPrGNFp6XNREvkZl4fICgMrgYMBzBeJMsWJhWE=;
 b=BMz+Duvtyymm/g30l9ZjduAZDo+PnQ9fuQ6bjNJljojFm20SMT1vQqNxr0KKsvpyqD
 f7nI01zN4DhKnjvQ7ygH0NuMFDtcN6La1tAlnzFLYqdNkafZPxj2lThVH92tjyhHgSK3
 KNEPK5XR9eUE4ulI6J9HdnVSZiSiBhUhQGaRxlp7VFMTm7YQMGtnuVCKtHpKg45cEa4i
 lFsuxmO8N6GHe1/a6r/W4JH1yupoP53KivEQGeWQFmJ1NOthxLN7DuB+SoA8LHNkyjlc
 gbmS1PZe4/p7dVHLsQK/zfkg0E/3oZ6SYORW7JyOpkI+M8V4zSq12UbuDMLDMRkT4v1x
 opDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=k0y1rUPrGNFp6XNREvkZl4fICgMrgYMBzBeJMsWJhWE=;
 b=tJod87MRUhS21V2fYRsUzGPLS+3Go3kn4iQHPkTn+iiJhvddhUGvq8fC1MNPIb+/6p
 Ou0TimTr4floe4quoLQUmzcQEdajTCZ4CvPw3iX3uAtIuqd3UHtjvHnvF1C9V+6irSZT
 62aA+Uo+E79QRiicfR5O1J/oZciQYVtyEBqcZIppTPn/u8W1cXUm2af8RgdsD/KVfID1
 QFQq20Bndng/IRVW49AI39BQNDi43O4v27SADIfVzJTALhV2x75ipo+ahc0jjK7Ube/2
 9q4RgpcmfmToJ4VUVCNvEm4QTEVrMTZBfFGOjqfIrXMEgLXfAQf9fkvdbe/pUJ2hDcgV
 Hd3A==
X-Gm-Message-State: AOAM532FpTSgYPQC136xBId52gNSSw10yaktRgYwhg2AvZGuC/NsUnAG
 HDkXI9NR7MKtUVovWFc0NxuXV7rX0UU=
X-Google-Smtp-Source: ABdhPJwqzORJHnW6FXe8APCv65SCk704UQaKN/OdYSHrd3yG4AhOwJ06SCB166Qoq5LnEFJM1i52ng==
X-Received: by 2002:a05:6402:4252:b0:416:6cd8:e273 with SMTP id
 g18-20020a056402425200b004166cd8e273mr25999216edb.328.1647355223895; 
 Tue, 15 Mar 2022 07:40:23 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a056402358c00b00418d7f02d63sm152419edc.53.2022.03.15.07.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 07:40:23 -0700 (PDT)
Message-ID: <c391a70a-b70b-0fa7-acb0-c3124eca53da@gmail.com>
Date: Tue, 15 Mar 2022 15:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Merge get_reserved_allocation to
 get_vbios_allocations.
Content-Language: en-US
To: Yongqiang Sun <yongqiang.sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315141130.150367-1-yongqiang.sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220315141130.150367-1-yongqiang.sun@amd.com>
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.03.22 um 15:11 schrieb Yongqiang Sun:
> Some ASICs need reserved memory for firmware or other components,
> which is not allowed to be used by driver.
> amdgpu_gmc_get_reserved_allocation is to handle additional areas.
> To avoid any missing calling,
> merged amdgpu_gmc_get_reserved_allocation to
> amdgpu_gmc_get_vbios_allocations.
>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> Change-Id: I142127513047a3e81573eb983c510d763b548a24

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 32 ++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
>   3 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7c2a9555b7cc..f18d050a14cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -626,6 +626,13 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   
> +	/*
> +	 * Some ASICs need to reserve a region of video memory to avoid access
> +	 * from driver
> +	 */
> +	adev->mman.stolen_reserved_offset = 0;
> +	adev->mman.stolen_reserved_size = 0;
> +
>   	/*
>   	 * TODO:
>   	 * Currently there is a bug where some memory client outside
> @@ -640,6 +647,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>   	case CHIP_RENOIR:
>   		adev->mman.keep_stolen_vga_memory = true;
>   		break;
> +	case CHIP_YELLOW_CARP:
> +		if (amdgpu_discovery == 0) {
> +			adev->mman.stolen_reserved_offset = 0x1ffb0000;
> +			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> +		}
> +		break;
>   	default:
>   		adev->mman.keep_stolen_vga_memory = false;
>   		break;
> @@ -760,25 +773,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
>   	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
>   }
>   
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
> -{
> -	/* Some ASICs need to reserve a region of video memory to avoid access
> -	 * from driver */
> -	adev->mman.stolen_reserved_offset = 0;
> -	adev->mman.stolen_reserved_size = 0;
> -
> -	switch (adev->asic_type) {
> -	case CHIP_YELLOW_CARP:
> -		if (amdgpu_discovery == 0) {
> -			adev->mman.stolen_reserved_offset = 0x1ffb0000;
> -			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_bo *vram_bo = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 93505bb0a36c..032b0313f277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
>   			      bool enable);
>   
>   void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
>   
>   void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>   uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f60b7bd4dbf5..3c1d440824a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
>   		return r;
>   
>   	amdgpu_gmc_get_vbios_allocations(adev);
> -	amdgpu_gmc_get_reserved_allocation(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);

