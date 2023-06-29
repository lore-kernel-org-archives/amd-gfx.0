Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D9BEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17D410E3DA;
	Thu, 29 Jun 2023 14:37:09 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE2210E3DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:37:07 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so1148710e87.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688049425; x=1690641425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqOrfB3nX1jZJ4uzfN1fClbwfs+HlEk2Zbi9cPctxsw=;
 b=eYnnXVm482EOwn4DV+l3lMgpyAdju7DoGL6vwszgQPd8cKyM3nAWaDgEkw0cqUnWQG
 rerFTGakvaOACd81dg86Xvb0HH1ku+S8B65U2p7+T5haynlTP8lSSRE7u3X2Jl/V+WVH
 65EWtUDeWsUkCzBvyGCnfN/2VsdS5VifuFfCvPzMRm87z2i06/CN7MCbZHO5tAc6u6Nm
 TgLZYTKO72c2I866TDarNzLaxIIla38TYoL0hexCU4V+ZZo7EB9yYGmiO2zzCRpKX7G7
 nRfHRfJUGcq+OpUxNhUW3ToEg39tHkRYt5w5UX5iVV8J2L5PEL/556tGMkYtt5K0jXB7
 0G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688049425; x=1690641425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqOrfB3nX1jZJ4uzfN1fClbwfs+HlEk2Zbi9cPctxsw=;
 b=aQ412CBxCINUgH6vnPHP2zofmy02+dT5CGNZ4TBN9iU3rqcKCWMWrpsHTnO/5F/Aif
 8eYizD+fkpYpmM1HSCRKPjHlhHoeN810n+LTfc4MpQnYEitMSe8owzqndgf+GtnIOtma
 0+IQz1jTORxU04GKLq52kdd4haC5d1vOW5L92zb1gxBs2b2PoF7FQtiexESvAxU9rCGM
 mQJzJciukvi2sQZYMZctzXDtz4nnDGGEE5Sv7damaVlI23E0T4YLV882Bcs4GEqTWWRu
 OaWXzpfA9ccmH+a2hdeIKm37gvPJBlOwgOgX9mqkDhCZ+g6MvSktZ4lkKl4wdszDCIWk
 J0yg==
X-Gm-Message-State: AC+VfDy0DYnpeqOLhr46qSOQ4BNQM0iJn8HZ0+xMtrLIZADb/2qbmJCW
 Wncpjv1w/yfoowPJnkiAxUw=
X-Google-Smtp-Source: ACHHUZ4o75v/wLcAIUGdMVKIA0x9tNmLVIytYB99ziVFoi6kzUG2AtqFRnZxgD17oAH0Ccg7VVzdfQ==
X-Received: by 2002:a05:651c:1206:b0:2b6:c465:b6cb with SMTP id
 i6-20020a05651c120600b002b6c465b6cbmr2476068lja.42.1688049424477; 
 Thu, 29 Jun 2023 07:37:04 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15af:8a00:54e3:8652:e343:aef4?
 ([2a00:e180:15af:8a00:54e3:8652:e343:aef4])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a056402078a00b0051de38eb925sm492616edy.93.2023.06.29.07.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 07:37:03 -0700 (PDT)
Message-ID: <e72a7ddf-e6b8-0c03-eabe-ba4ce445a061@gmail.com>
Date: Thu, 29 Jun 2023 16:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv4] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230619173825.1461932-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230619173825.1461932-1-mukul.joshi@amd.com>
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
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.06.23 um 19:38 schrieb Mukul Joshi:
> Update the invalid PTE flag setting with TF enabled.
> This is to ensure, in addition to transitioning the
> retry fault to a no-retry fault, it also causes the
> wavefront to enter the trap handler. With the current
> setting, the fault only transitions to a no-retry fault.
> Additionally, have 2 sets of invalid PTE settings, one for
> TF enabled, the other for TF disabled. The setting with
> TF disabled, doesn't work with TF enabled.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> v1->v2:
> - Update handling according to Christian's feedback.
>
> v2->v3:
> - Remove ASIC specific callback (Felix).
>
> v3->v4:
> - Add noretry flag to amdgpu->gmc. This allows to set
>    ASIC specific flags.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 31 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  1 +
>   9 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 56d73fade568..fdc25cd559b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -331,6 +331,8 @@ struct amdgpu_gmc {
>   	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[16];
>   	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[16];
>   	u64 MC_VM_MX_L1_TLB_CNTL;
> +
> +	u64 noretry_flags;
>   };
>   
>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index eff73c428b12..8c7861a4d75d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2604,7 +2604,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
> +		flags = AMDGPU_VM_NORETRY_FLAGS;
>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9c85d494f2a2..b81fcb962d8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
>   /* PDE Block Fragment Size for VEGA10 */
>   #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
>   
> +/* Flag combination to set no-retry with TF disabled */
> +#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
> +				AMDGPU_PTE_TF)
>   
> +/* Flag combination to set no-retry with TF enabled */
> +#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
> +				   AMDGPU_PTE_PRT)
>   /* For GFX9 */
>   #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
>   #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index dea1a64be44d..24ddf6a0512a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -778,6 +778,27 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   					1, 0, flags);
>   }
>   
> +/**
> + * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
> + *
> + * @adev - amdgpu_device pointer
> + * @flags: pointer to PTE flags
> + *
> + * Update PTE no-retry flags when TF is enabled.
> + */
> +static void amdgpu_vm_pte_update_noretry_flags(struct amdgpu_device *adev,
> +						uint64_t *flags)
> +{
> +	/*
> +	 * Update no-retry flags with the corresponding TF
> +	 * no-retry combination.
> +	 */
> +	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
> +		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
> +		*flags |= adev->gmc.noretry_flags;
> +	}
> +}
> +
>   /*
>    * amdgpu_vm_pte_update_flags - figure out flags for PTE updates
>    *
> @@ -804,6 +825,16 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		flags |= AMDGPU_PTE_EXECUTABLE;
>   	}
>   
> +	/*
> +	 * Update no-retry flags to use the no-retry flag combination
> +	 * with TF enabled. The AMDGPU_VM_NORETRY_FLAGS flag combination
> +	 * does not work when TF is enabled. So, replace them with
> +	 * AMDGPU_VM_NORETRY_FLAGS_TF flag combination which works for
> +	 * all cases.
> +	 */
> +	if (level == AMDGPU_VM_PTB)
> +		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
> +
>   	/* APUs mapping system memory may need different MTYPEs on different
>   	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>   	 * to be on the same NUMA node.
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 0c8a47989576..13b89f78d07d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -751,6 +751,7 @@ static int gmc_v10_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index c571f0d95994..c68ecb7dfa39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -651,6 +651,7 @@ static int gmc_v11_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index acd2b407860f..027b14603037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -942,6 +942,7 @@ static int gmc_v7_0_early_init(void *handle)
>   		adev->gmc.shared_aperture_end + 1;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 85dead2a5702..581ed922dbe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1056,6 +1056,7 @@ static int gmc_v8_0_early_init(void *handle)
>   		adev->gmc.shared_aperture_end + 1;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 67e669e0141c..ebdbc823fae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1622,6 +1622,7 @@ static int gmc_v9_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }

