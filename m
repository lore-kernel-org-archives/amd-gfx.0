Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6152606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGQ1O3hb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5450D10E0CE;
	Tue, 10 Nov 2026 08:42:02 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E4410E2C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 08:41:55 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso16745185e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300114; x=1794904914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XNkCQILAXP1Eo9beHnDt/Q1b8ghx6MubpuM7dfUl1+I=;
 b=nGQ1O3hbbUXNeE3RyBAUWI1HetBtQl5LepaN7QPDJsfEage87RyInW3aDkdC7UuYv4
 D35EUZNyFPp4B08APx+dqp+qZXin55s5mQRZU6Ec0+VfRSLvlsAMQxgwI6zogkzwsTpU
 SbQJg4HEfXy2M5/yOyG5IsFmU+tH30YyFDY/OoAqClDsAAZkw0z6woPAYDUU4FoiAfrk
 Oh8OaDy6TjJLxSrS/12pr2RHT4gcOFHA5lfi3RkmAIBMF20Od4pEVUYtD63jWk8o90a6
 KEBwLTBlEy5wuKeookkqNWJS6x7Wgyf2z+xPh4cnWHY2eBZnBl5ieMJve5JNle1SyulP
 FgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300114; x=1794904914;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XNkCQILAXP1Eo9beHnDt/Q1b8ghx6MubpuM7dfUl1+I=;
 b=CE2LCqhaMPS2u/4JbEPbCkmpu4nUWuQocBkGjQbeK7u0qI05ZaUPTq0b7wtVNjvVJF
 fU3QW+ryE5/z+SLl//Crb+sqWmFIME6nksJMiiootfYrOLEMltzfUQc4x6b7CSyYcJjq
 atIPXT+FEcruGF46xs3DKPYVbL2qDnpnU1a6WU3GTzC7bzoK1D7/yxWfrMncS+zK1C10
 FbSnM7GnpUd06kgOtV2V/byose3Wb7F2x5YVREyHepznCbQDTsGq/aBeqhkqKnDp9fQX
 DE+2eUw1CN/Ccu+e+WdqVIUrnpR9Wrznmfm3JVMOl5d0m95J0Pu5LMQU7FmU8d3sIVLP
 2Gsw==
X-Forwarded-Encrypted: i=1;
 AL+hErGGJ3vpUEIuvaeMKt8ZPNvZjr9v4UFnxbUSQANgp8dwdD8eEsPIo/wfgsl7+anR088eQRHBaOp9@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+22JgeaF6zV7nJM6Cp7WA9790SAZeG2ocRC+2zKHRDUJ0mmVo4
 tiKvWiushzud4fhCh+rOpCV9IGmsyJYQPJCJI24eARjSfyLcqmKwbZc1
X-Gm-Gg: AYBFou09AIxXIR32JwtFa+oPR85aq2zbKsE992q6ahbeflxm3vBfHAueJVuI9WUpAr4
 uxx7BJeuE5hQGclAIgx9Ml8L3PA4k6Y3r0DBqSqMxgUKQDrq1KIXBS+0QCZJ+0dQJ3LxGtd8Dpm
 Wvi6TMBsKezTP2C+Pnd39sKdWdKf+eQeXyMWvU6Np9hykANr04PDkDdazJ+w/xSKQw9OGp5hLlJ
 PwebiN1qLeKniNuVw6AntIfAADIH+FjyECA5hUMLeRN8G5aanyokwTuYKBI19NiZkhx208akIFE
 6JrQan2h38eBrY8DMIB6HbRZ584U5hAETZDiumDthjWVgc18WW1rHKdIx/xOy2VxGrnHS9wzoEm
 YV54bOgKH1mTULVxiOLLz5bzMCY030Vp6wa7lcEFGPJuszQ9wwB5eMcvypvJuXBe03MagkU4aNK
 kJqYZQSEYZXy+ttWGTLS2RsSZZ8T5lQVkFOhyuNwXpNL2WDPaOGomXMCxOY8icqA8VzO8xnhhMQ
 FAabgT9zc4VzyltYn4g5uINo2cgVZ9M4DWi9A+FwAfvyt1zFXCbi7triov0kmudsL4UHaeomVZV
 TVJGhCya6O9wwqTHQYWSx/cvH2Rt1PpU9rDx+zHm1n7I+QBt+QiRKuujzg==
X-Received: by 2002:a05:600c:4e55:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4ba023050eamr30232295e9.2.1794300113964; 
 Tue, 10 Nov 2026 00:41:53 -0800 (PST)
Received: from [10.254.154.46] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02387ad9sm57325905e9.5.2026.11.10.00.41.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Nov 2026 00:41:53 -0800 (PST)
Message-ID: <15ad805c-2b0e-4c83-9d79-323442c3a239@gmail.com>
Date: Tue, 10 Nov 2026 09:41:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: keep the A+A VF VRAM base at the SRAT
 address
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261109162615.167236-1-Zhigang.Luo@amd.com>
 <20261109162615.167236-4-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261109162615.167236-4-Zhigang.Luo@amd.com>
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
> On the A+A VF the hypervisor reports each VF's VRAM address in the
> ACPI SRAT table, and that address is stored in aper_base. The XGMI
> node segment does not describe the VF, so physical_node_id *
> node_segment_size is not a valid VRAM starting address.
> 
> gmc_v12_0_vram_gtt_location() and amdgpu_virt_resume() still added
> that offset on top of aper_base, which moved the SPM PDB0 system PTEs
> off the VF's HBM. Leave vram_base_offset at aper_base on both paths.
> Size PDB0 from the VF's local VRAM and place GART after that window,
> aligned to 8GB. That alignment is one PDB0 entry when
> vmid0_page_table_block_size is 12, and it applies to every PDB0
> placement.
> 
> v2:
> - Explain that the SRAT address is already the VF VRAM base and must
>   not be adjusted by the XGMI node segment.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 22 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  6 ++++--
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9326f811c500..7a664b7b1ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4677,9 +4677,15 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>  		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
>  
> -	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> -	adev->vm_manager.vram_base_offset +=
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;
> +	} else {
> +		adev->vm_manager.vram_base_offset =
> +			adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id *
> +			adev->gmc.xgmi.node_segment_size;

This is a massive NAK. That needs to be handled in get_mc_fb_offset().

See how aper_base is initialized on APUS as well:

#ifdef CONFIG_X86_64
        if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
                adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
                adev->gmc.aper_size = adev->gmc.real_vram_size;
        }               
#endif



> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index f76da74abfec..96075db3b9ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -42,6 +42,8 @@
>  #include <drm/ttm/ttm_tt.h>
>  
>  static const u64 four_gb = 0x100000000ULL;
> +/* PDB0 block size 12 covers one 8GB entry. */
> +static const u64 eight_gb = 0x200000000ULL;
>  
>  bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
>  {
> @@ -60,7 +62,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
>  {
>  	int r;
>  	struct amdgpu_bo_param bp;
> -	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
> +	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
> +		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;

Same here. I need to double check but we probably need a new callback for this.

Regards,
Christian.

>  	uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size + 21;
>  	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) - 1) >> pde0_page_shift;
>  
> @@ -261,16 +264,21 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> -	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
> +	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> -	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) ||
> +	    amdgpu_virt_vram_is_spm(adev)) {
>  		/* set mc->vram_start to 0 to switch the returned GPU address of
>  		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
>  		 */
>  		mc->vram_start = 0;
>  		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>  		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
> +		if (amdgpu_virt_vram_is_spm(adev)) {
> +			mc->gart_start = ALIGN(mc->vram_end + 1, eight_gb);
> +			mc->gart_end = mc->gart_start + mc->gart_size - 1;
> +		}
>  	} else {
>  		mc->fb_start = hive_vram_start;
>  		mc->fb_end = hive_vram_end;
> @@ -1269,7 +1277,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore NC/RW?
>  	/* Each PDE0 (used as PTE) covers (2^vmid0_page_table_block_size)*2M
>  	 */
> -	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
> +	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
> +		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
>  	u64 vram_addr, vram_end;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> @@ -1287,7 +1296,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
>  	vram_addr = adev->vm_manager.vram_base_offset;
> -	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev) &&
> +	    !amdgpu_virt_vram_is_spm(adev))
>  		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>  	vram_end = vram_addr + vram_size;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..e37c84f10709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -734,8 +734,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
>  		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
>  	}
>  
> -	adev->vm_manager.vram_base_offset +=
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	if (!amdgpu_virt_vram_is_spm(adev))
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id *
> +			adev->gmc.xgmi.node_segment_size;
>  }
>  
>  /**

