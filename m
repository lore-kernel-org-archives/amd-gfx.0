Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93392606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrwFffhv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0C910E786;
	Tue, 10 Nov 2026 08:41:46 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C009E10EEA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 08:41:39 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so15157595e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300098; x=1794904898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G1jOgzefUXoA+fYiJs/2DmdGIk23hLtCPpw9AAspviA=;
 b=XrwFffhvzhBHT7s+EPtjbXTAk9kglkHbXyG6O1UMTYLcXUggcaF+qvmMnqteydk683
 Jrh0OiWk4bpOOXQG8gdy4Svr5ZmIHJqsguaFI95JeMPFhUbqY2umJN52JgPVNSWMkYHv
 YtDmUTHzcMBzxkaMTqpMcXdiUl3e0uVmtI/AQGw9hRvHZiAlNpqjzwf//v5Fn+QtQxAV
 TA0yQRPCxuf87fLsyVXaahZGF0tzeGqXO2179P4tP4rKK7RsOciWQA7KeN97QK5SnEEE
 X/OmYGadwpuAL03eIhvL50eMl66f1oG4pUxtGo6YTHfe5XqRMpf2sXDx9nqjEIuXBt0r
 J6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300098; x=1794904898;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G1jOgzefUXoA+fYiJs/2DmdGIk23hLtCPpw9AAspviA=;
 b=JeZS0ul05npc9TGnIcSKsi87muHySmYpq9nWgxtIjRgEq8AMAYscdwgWI+0ekgZdnF
 NMeN3eQILkPWh8i8MRvQwmAoNP0Ei+fP68R8rpjUfrdmnw6tf/r6ao7rj4kYkh3E9VWd
 w+e1OTB93LJOTc6A54NI2hogeNK0BZsupm2qwtJM0bw6lAL/9/1IbDOGf+Phiq6oDAq1
 dgIFMJDxfNhLsdOljsH/52Fp8JFDGrG5H0GOAMxVEywEkAwKMa20FnPn7u1bXX08fNUz
 mdkXQruZH2Z7wTvf3jZFARdcBk70aUPqfZla9aEE4ozN93SxgWYmvUgnLUiFe38CFDNy
 mwUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFQ9wKGkKsCgbT+47nudT2Jk1SXZyc9WAH8A8iLI4jWiewExxsAq68yWwY2cYxDJDwwxdj5sL/J@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+u8ObTMQbInUk0L/3XWxak3jQN5KiKTLAZHazypSBFyElrU0O9
 4dodA2NJ6K0I/dMfpbLzakIsLVbwCPcXHhKQHIgdPDkEKE/Tai9qoZOJ
X-Gm-Gg: AYBFou1SY938x6TRHMLDTUhLEFAm5srB03HDxu2Gg10BOWBHW2SrWVvd3l6c89VFCKm
 7LihZ07Q4xNZn+gbas8ceH8rK49SScxwDl5RBK12EY6QiZgFEdzEdQl6srhAh0wrYMm9lNn/j7w
 Dm0RIhBBH01IPKH0bI8I6ZlHokfGNFiYvGREacLKvoZd3nKPgmWfO8sF/A5/+Z0za5gfrvuFKC/
 1YmQ3/KRFzJ38+OvddoOr6g+wQRldPQuu02OHLnPjb2eWVeM9pNozg2SoOzic6xxEl3+BnsKSEW
 WGrwmKKZTAdIYJvvNIJb/oWHwbeL96gi73nvYwUKjFSw4Jd3Xn83uWUlQ+oSaqxVguKAdBjVBTr
 rIHJYG3dT9XnZj8mwXP/gZVHAviUi1OIFPYjIWu86/zR6xNblULaBnNCRlLAZKfPMIxtuCfS03F
 bYDaKBYYsr1oCdRPCYl42LS2BK+ZqK22HRom6yrWs6bzcZPFX458jD3b6sgmhe1y5x236QjB9XV
 bf+JWFQM0UH5l+/Dsdfn5R4edrieN/3VHz1E0yk88OdBja9LTXa1T1kFxP1nb0wRaDwyL07aW93
 SVueVwinR+baEI5tC0Zgy6iODW/72FgymhgeYEMgmPZ+fI7tAJ12IKNEb3rIasckRwl1aiuQBse
 +/pI=
X-Received: by 2002:a05:600c:354a:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ba022ca8f6mr29569675e9.0.1794300097582; 
 Tue, 10 Nov 2026 00:41:37 -0800 (PST)
Received: from [10.254.154.46] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe64bcsm49083155e9.8.2026.11.10.00.41.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Nov 2026 00:41:37 -0800 (PST)
Message-ID: <3f830f36-bc35-460d-9780-24bf03cb4fdc@gmail.com>
Date: Tue, 10 Nov 2026 09:41:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20261109162615.167236-1-Zhigang.Luo@amd.com>
 <20261109162615.167236-3-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261109162615.167236-3-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 17:26, Zhigang Luo wrote:
> gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
> address and skips that conversion when AMDGPU_PTE_SYSTEM is already
> set. Set the bit after the translation so the address stays physical.
> 
> gmc_v12_1_get_vm_pte() covers the graphics and SVM PTE paths. SVM
> VRAM ranges call it with a NULL buffer object, so set the bit there
> before the NPA flags, which still clear it.
> 
> PDB0 is written directly and does not go through get_vm_pde(). Set
> AMDGPU_PTE_SYSTEM on the SPM VRAM entries and the GART PDE. NPA
> still requires PTE.S=0, so clear the bit in gmc_v12_1_get_npa_flags()
> and amdgpu_ualink_peer_remote_init().
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     | 10 ++++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 659e89e5e78f..f76da74abfec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1281,6 +1281,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
>  	flags |= AMDGPU_PTE_WRITEABLE;
>  	flags |= AMDGPU_PTE_SNOOPED;
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		flags |= AMDGPU_PTE_SYSTEM;

Yeah again, hacks like that are a pretty big NO-GO.

We should probably start to use amdgpu_gmc_get_vm_pde() here as well. The reason we haven't done that previously is potentially because the address parameter is in the wrong address space.

Old HW generations expected the MC address space in the PDEs, so that is what amdgpu_gmc_get_vm_pde() takes as parameter. But newer generations expect the PA and because of this we call amdgpu_gmc_vram_mc2pa() in the get_vm_pde callback.

So that results in a PA->MC->PA conversion which doesn't make to much sense.

This needs to be restructured to completely support VRAM domain in system memory as well.

>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> @@ -1300,6 +1302,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 * pointing to a 4K system page
>  	 */
>  	flags = AMDGPU_PTE_VALID;
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		flags |= AMDGPU_PTE_SYSTEM;

Same here.

>  	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
>  	/* Requires gart_ptb_gpu_pa to be 4K aligned */
>  	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 3bb426b33af9..11f022c56667 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -6171,6 +6171,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>  	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
>  	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_ATOMICS;
>  	flags &= ~AMDGPU_PTE_VALID;
> +	flags &= ~AMDGPU_PTE_SYSTEM;

And that here actually breaks thing, clear NAK to that!

>  	/* PTE.X=0 turn off RPC checks for RBs, wptr and doorbell NPA address */
>  	flags &= ~AMDGPU_PTE_EXECUTABLE;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 76391fca6c62..3bd86028f304 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
>  		*addr = adev->vm_manager.vram_base_offset + *addr -
>  			adev->gmc.vram_start;
>  
> +	/* SPM VRAM is reached at a system physical address. Set S after the
> +	 * translation above so that translation is not skipped.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +

That looks correct to me.

>  	if (*addr & ~adev->gmc.pte_addr_mask) {
>  		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
>  		*addr = 0;
> @@ -616,6 +622,7 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
>  	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
>  		   AMDGPU_PTE_BUS_ATOMICS;
>  	*flags &= ~AMDGPU_PTE_VALID;
> +	*flags &= ~AMDGPU_PTE_SYSTEM

That should be superflous.
;
>  	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>  }
>  
> @@ -756,6 +763,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  		break;
>  	}
>  
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +

Here you need to check if the destination is actually VRAM and not NPA.

Regards,
Christian.

>  	if (bo) {
>  		mem = bo->tbo.resource;
>  		if (mem && mem->mem_type == AMDGPU_PL_NPA) {

