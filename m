Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F93C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 14:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA8910E8E5;
	Thu, 15 Feb 2024 14:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIwLgNql";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE1110E8E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 14:27:41 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2d0e521de4eso11299631fa.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708007260; x=1708612060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLpqhF8yw2QqFt8/7IC9oYG0MTWvHe5rh4/1xLxOh6o=;
 b=SIwLgNql5HTaEdV6gGYwpA1OecH9lRLwSPh2E95suouW+StPAj9ijsSpG9wa1OmKOy
 y1YgDNXAvAWa//mDd+fvgMPnpJ8v16P1IupuZbyh75qR5XArc0RZ1zcDf0uVloyxuz0p
 nRH5yPu784CxS9CLryD9ruDh/IyV5wgPiZcRH2YWj0IekGWRpPfk6czSD4xqmJY5jRXi
 exZI4L5goJ6vIgwHji4QQU97ZUTcVtvdY/E6JAqmlmoT/7UByuYvDSvgQL390Sakj6nH
 lC0Czd2JSnz1dV5dNLfvahlaEiEbkoCUzEicpl5npUKM3E71vmkT5sTPIF9SlC5wMtZC
 0t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708007260; x=1708612060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLpqhF8yw2QqFt8/7IC9oYG0MTWvHe5rh4/1xLxOh6o=;
 b=bqvUzRffAu826sy/vagX8SSao7uEC8pky+5RBY7SCElY78A0Eumu+MdO9v2K6q3oL7
 BMcMZuW8LY6WfsIP8lGDCN6i6NuroITg69fzjA3gQ0qEPQROP8jfdYfjqLjwuEwvPJbv
 PAdPV7y1NW4xkGGIYaHYmOdPgGn2fskhzN6dptwJZY6wvQERsn5zBhfOSVrpUZ0cnJoO
 DzdsuXvrdvRqS+3sOvpoiSidnNtHo7HVqF9OwXOWbZpa6D4iYqTl/8dkXOco3s11Ag3D
 aQKaPNVH81z4p74MSYr1J9EkqGidj2VNM4BqbrJwN1kQMijE+v/vnty+MWa37/e3vtbW
 68nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS8I/pJAzAEjF3ZxjCj0g68gsgk5izgrI/VvMVBOk0nlhQ4b4b9VuS88yuTaRyywQ1HtYbdBNqUG0Nj5jHR599zCUzEz3kQxPzT6ysqQ==
X-Gm-Message-State: AOJu0Yw+tDpkipWBgs7sOupWHHdtk+3tcaIZTOCvRU2DRJ/GJ89BcOTL
 WTv03NU6SbGKGMKTM0e7AHzvntCg+R/Qc4I89IL0YM2+qWlc2jKI
X-Google-Smtp-Source: AGHT+IEzAm9isWFpS+p98kSvlTZhDKECq9ZP2W9kRFZBOXDdN6xio13Cskv+RmgMdf/zlapExvY2Jg==
X-Received: by 2002:a2e:3c12:0:b0:2d0:8a78:9e69 with SMTP id
 j18-20020a2e3c12000000b002d08a789e69mr1597491lja.52.1708007259486; 
 Thu, 15 Feb 2024 06:27:39 -0800 (PST)
Received: from [192.168.178.25] ([134.19.20.240])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b00410ab50f70fsm5111710wmj.15.2024.02.15.06.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:27:39 -0800 (PST)
Message-ID: <fe55bafa-6c77-4c52-b426-f41daf25bade@gmail.com>
Date: Thu, 15 Feb 2024 15:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Relocate TBA/TMA to opposite side of VM
 hole
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, arunpravin.paneerselvam@amd.com,
 lang.yu@amd.com, Jay Cornwall <jay.cornwall@amd.com>
References: <20240213221230.3271736-1-felix.kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240213221230.3271736-1-felix.kuehling@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.02.24 um 23:12 schrieb Felix Kuehling:
> The TBA and TMA, along with an unused IB allocation, reside at low
> addresses in the VM address space. A stray VM fault which hits these
> pages must be serviced by making their page table entries invalid.
> The scheduler depends upon these pages being resident and fails,
> preventing a debugger from inspecting the failure state.
>
> By relocating these pages above 47 bits in the VM address space they
> can only be reached when bits [63:48] are set to 1. This makes it much
> less likely for a misbehaving program to generate accesses to them.
> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
> access with a small offset.
>
> v2:
> - Move it to the reserved space to avoid concflicts with Mesa
> - Add macros to make reserved space management easier
>
> v3:
> - Move VM  max PFN calculation into AMDGPU_VA_RESERVED macros
>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Can't full judge the KFD VI changes, but the rest looks good to me.

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  6 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 11 +++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 ++++++++++----------
>   4 files changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index 823d31f4a2a3..b0fb14a4b43c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -28,9 +28,8 @@
>   
>   uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>   {
> -	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
> +	uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(adev);
>   
> -	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>   	addr = amdgpu_gmc_sign_extend(addr);
>   
>   	return addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 3d0d56087d41..4b9afc4df031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -45,11 +45,7 @@
>    */
>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   {
> -	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
> -
> -	addr -= AMDGPU_VA_RESERVED_TOP;
> -
> -	return addr;
> +	return AMDGPU_VA_RESERVED_SEQ64_START(adev);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2c4053b29bb3..42f6ddec50c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -137,9 +137,18 @@ struct amdgpu_mem_stats;
>   
>   /* Reserve space at top/bottom of address space for kernel use */
>   #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_CSA_START(adev)	(((adev)->vm_manager.max_pfn \
> +						  << AMDGPU_GPU_PAGE_SHIFT)  \
> +						 - AMDGPU_VA_RESERVED_CSA_SIZE)
>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
> +						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
> +						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>   #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> -#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
> +#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
> +						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>   						 AMDGPU_VA_RESERVED_CSA_SIZE)
>   
>   /* See vm_update_mode */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 6604a3f99c5e..4a64307bc438 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -36,6 +36,7 @@
>   #include <linux/mm.h>
>   #include <linux/mman.h>
>   #include <linux/processor.h>
> +#include "amdgpu_vm.h"
>   
>   /*
>    * The primary memory I/O features being added for revisions of gfxip
> @@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>   	 * with small reserved space for kernel.
>   	 * Set them to CANONICAL addresses.
>   	 */
> -	pdd->gpuvm_base = SVM_USER_BASE;
> +	pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
>   	pdd->gpuvm_limit =
>   		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>   
> +	/* dGPUs: the reserved space for kernel
> +	 * before SVM
> +	 */
> +	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
> +	pdd->qpd.ib_base = SVM_IB_BASE;
> +
>   	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>   	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>   }
> @@ -339,18 +346,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
>   	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>   	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>   
> -        /* Raven needs SVM to support graphic handle, etc. Leave the small
> -         * reserved space before SVM on Raven as well, even though we don't
> -         * have to.
> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
> -         * are used in Thunk to reserve SVM.
> -         */
> -        pdd->gpuvm_base = SVM_USER_BASE;
> +	pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>   	pdd->gpuvm_limit =
>   		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>   
>   	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>   	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> +
> +	/*
> +	 * Place TBA/TMA on opposite side of VM hole to prevent
> +	 * stray faults from triggering SVM on these pages.
> +	 */
> +	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev);
>   }
>   
>   int kfd_init_apertures(struct kfd_process *process)
> @@ -407,12 +414,6 @@ int kfd_init_apertures(struct kfd_process *process)
>   					return -EINVAL;
>   				}
>   			}
> -
> -                        /* dGPUs: the reserved space for kernel
> -                         * before SVM
> -                         */
> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>   		}
>   
>   		dev_dbg(kfd_device, "node id %u\n", id);

