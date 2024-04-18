Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAB4C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41E510FCB6;
	Thu, 18 Apr 2024 14:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="miNPxCca";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEB210FCB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 14:38:03 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-418c979ddf3so7546845e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713451082; x=1714055882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ad94529QpCZZbAEpgDhN8WlgdJcXjtKHvISQDvLJdKM=;
 b=miNPxCcaaHO4ovtDeA27KdeupyKVgLTc2q0WbjOJIbQe++5yU3mnnnfcNBbbP2nKTR
 Wtqb1duKXdAeYWLk1Ogd8QWpVN0r0Q82zWDiHo/1R+XSkU+/WgL1k3lIzKUmyrNCS0K2
 Lbjc3jKSJ5hqAsZfmFLe8Y41rx7t7e8Gx7m72ewyMaiHR7S5dzlAYd6Pd+v6mwh8z8G0
 74iJ3sLNBFBOPMdXMfOfElwB1Q7VORmwFd+QLSrBfxGGDKbgfMGJPb6a6O2NjK/lxbfR
 HE7gek7RA1o32moknlzRWnH+yDNB0dsmjEykA5QhVJsF+nvrxPV2b3msDSqmOeEW/q7H
 ysvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713451082; x=1714055882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad94529QpCZZbAEpgDhN8WlgdJcXjtKHvISQDvLJdKM=;
 b=h32zmZnlW5pjT4KK/s5Hbm0rmti4j5xejZucVh1R8cmpFz1T85tNVZFz4AG/90kKit
 /CxtSKhhR0qtTkFvzhDGroArRfdmxLzTpRM53xQL3JvL9p8qwDSHgWtWvES+B9mI+7pz
 6AhRNqBFrn3RvuGhTgvIcyY2JeUJl9H9vOjY1Fne9Fg0eE6mTVqeRxJvF3di3Zo+sKGr
 oHWy6FkTn6wG5Aecayf/C81XHIVX8Vou2Q6Mc09hAH32bXqjGuOU51jie9SyyqJ/76tU
 p1FQmeR37GHyw4BykKdklNB/n2/5Vd5TqUi7sSkJfNUYwSxq0xIySqEc52f/3c59lPYV
 7WYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbytpPrzliv+vE/bTP6H7z8KccJwQdvcPRkJ6iPhpihraGHW/CBFHo47AkpVD4XyyXX6R9tyHYSqg+hn6+op6E2j1jW7/0T4rxyEWzkQ==
X-Gm-Message-State: AOJu0YzRtkO0BUySIBchjaNW2iRZYBdDz12G1+H2bDtuANijtKxEAiVE
 V/PfVTpg1KBpQEDfr2CEig46Z883HBkyLGMTJCMKu6U95EByvUtPopbGM7eF
X-Google-Smtp-Source: AGHT+IGeU/2AFD/DH322uJOdarzMMpwIGI4vmw+iTDyJe57EDDFtz/Mhc4aWLtFNmo4IIc71N1jLbg==
X-Received: by 2002:adf:fc0c:0:b0:343:74c9:51a8 with SMTP id
 i12-20020adffc0c000000b0034374c951a8mr1621587wrr.68.1713451081777; 
 Thu, 18 Apr 2024 07:38:01 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g30-20020adfa49e000000b00343f662327bsm2000457wrb.77.2024.04.18.07.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 07:38:01 -0700 (PDT)
Message-ID: <dbc3534e-dc5c-42bb-8e83-66d047481f9a@gmail.com>
Date: Thu, 18 Apr 2024 16:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/amdgpu: Support contiguous VRAM allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com,
 Arunpravin.PaneerSelvam@amd.com
References: <20240418135803.17365-1-Philip.Yang@amd.com>
 <20240418135803.17365-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240418135803.17365-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 18.04.24 um 15:57 schrieb Philip Yang:
> RDMA device with limited scatter-gather ability requires contiguous VRAM
> buffer allocation for RDMA peer direct support.
>
> Add a new KFD alloc memory flag and store as bo alloc flag
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
> peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
> VRAM buddy allocator to get contiguous VRAM.
>
> Remove the 2GB max memory block size limit for contiguous allocation.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c     | 9 +++++++--
>   include/uapi/linux/kfd_ioctl.h                   | 1 +
>   3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..ef9154043757 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
> +
> +			/* For contiguous VRAM allocation */
> +			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
> +				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		}
>   		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
>   					0 : fpriv->xcp_id;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 4be8b091099a..2f2ae7177771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -532,8 +532,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   
>   		BUG_ON(min_block_size < mm->chunk_size);
>   
> -		/* Limit maximum size to 2GiB due to SG table limitations */
> -		size = min(remaining_size, 2ULL << 30);
> +		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +			size = remaining_size;
> +		else
> +			/* Limit maximum size to 2GiB due to SG table limitations
> +			 * for no contiguous allocation.
> +			 */
> +			size = min(remaining_size, 2ULL << 30);

Oh, I totally missed this in the first review. That won't work like that 
the sg table limit is still there even if the BO is contiguous.

We could only fix up the VRAM P2P support to use multiple segments in 
the sg table.

Regards,
Christian.

>   
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>   				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 2040a470ddb4..c1394c162d4e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *

