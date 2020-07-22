Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB009C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964C12065E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee2EcSN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964C12065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A20F6E7FE;
	Wed, 22 Jul 2020 08:15:57 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFE26E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 08:15:55 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id dm19so946594edb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9IEq9tWCUP8fezriiQiYOqy3teCaoHHnhLzbm5aVXFA=;
 b=Ee2EcSN+Xj2qWlNE5oULXNOBeyaEreG8w39SmO6xWIQT/3frCef+61FZ2Kx8kfGaUl
 E0yWukm3O1b1O1sJfGU/fVzqtyKIQCcShOCrXx//aMLsRQM+QuH86+xpavP2c6Ml5uuA
 dlADUeYiYendeoUh+Fcyke0ZM0B8oACW+8sYM2HK8YROP4BuzZCK5z9KZYT986MFTJke
 6qzYQhHuYtxNZKMYwfmN01bY0Oc/1rgmZptU4ufhDNHtlmp7S5ioWAX/4xgTlmCnwiBw
 eU31YSgyCrdQ4eAAD/GeZfiJURx2UVSAwblXO3S83ryKOTHUcaJSTDbCRPxoSajR50Wy
 vddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9IEq9tWCUP8fezriiQiYOqy3teCaoHHnhLzbm5aVXFA=;
 b=r/WG8E8ZnTK/G9zVhT8iMSNvrhcc3sgWDcGABRBDvcqs81LiBXbU2uCNSh+fdgs9ni
 TvTUN1ePfrfJQ+ovi3L6fvr9jw+iCWx7v3w87axeHCLRS7Ney24WdXsJxan2QvX89Lul
 /Zp3mRAyka1mMTaki3O1p+OA0iXfhTbg2BTSEaRtMunAGGAj/skvQsP3pGNXss0kUUim
 wK1HLRkuGpAZ674pxZtJNK1qmVILDc4oAu+RDDfaPj280+gTie+t0nMG0esfXSseeoc9
 MBpb0Qq0bt+EOMdu/Jpud5W7qacObhLwtb+2qY7Fs5V/GVe9vQpNM0W3j9/niuusz8LI
 EhkQ==
X-Gm-Message-State: AOAM532NyPEy6UFIMYtps4f2RtPlm3E7IhdFEKRUwJaCSC4zv3UevWDi
 8brX8S6VwLXNIfim1tw9iDX/Z88n
X-Google-Smtp-Source: ABdhPJyPtKPpbrp9rak5j8D3sS2VmQkSnh2tYDszrzk0xXW5fMQ2O0xqqaE/GLaGdbJX/H6Zo0Wc7A==
X-Received: by 2002:a50:fb06:: with SMTP id d6mr12379530edq.165.1595405754266; 
 Wed, 22 Jul 2020 01:15:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o14sm18237102eja.121.2020.07.22.01.15.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Jul 2020 01:15:53 -0700 (PDT)
Subject: Re: [PATCH 3/5] drm/amdgpu: add vmhub funcs helper
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
 <1595327359-120379-4-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <80dbf286-39f8-4db2-cda4-29e6db4fc3df@gmail.com>
Date: Wed, 22 Jul 2020 10:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1595327359-120379-4-git-send-email-ray.huang@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.07.20 um 12:29 schrieb Huang Rui:
> This patch is to introduce vmhub funcs helper to add following callback
> (print_l2_protection_fault_status). Each GC/MMHUB register specific programming
> should be in gfxhub/mmhub level.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 34 ++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 34 ++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 25 ++---------------------
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 34 ++++++++++++++++++++++++++++++++
>   5 files changed, 111 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 1785a0e..bbecd87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -74,6 +74,11 @@ struct amdgpu_gmc_fault {
>   /*
>    * VMHUB structures, functions & helpers
>    */
> +struct amdgpu_vmhub_funcs {
> +	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
> +						 uint32_t status);
> +};
> +
>   struct amdgpu_vmhub {
>   	uint32_t	ctx0_ptb_addr_lo32;
>   	uint32_t	ctx0_ptb_addr_hi32;
> @@ -94,6 +99,8 @@ struct amdgpu_vmhub {
>   	uint32_t	eng_addr_distance; /* include LO32/HI32 */
>   
>   	uint32_t	vm_cntx_cntl_vm_fault;
> +
> +	const struct amdgpu_vmhub_funcs *vmhub_funcs;
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 993185f..14268ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -31,6 +31,33 @@
>   
>   #include "soc15_common.h"
>   
> +static void
> +gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
> +					     uint32_t status)
> +{
> +	dev_err(adev->dev,
> +		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> +		status);
> +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> +}
> +
>   u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
>   {
>   	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
> @@ -360,6 +387,10 @@ void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>   }
>   
> +static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
> +	.print_l2_protection_fault_status = gfxhub_v2_0_print_l2_protection_fault_status,
> +};
> +
>   void gfxhub_v2_0_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -398,4 +429,7 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
>   		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> +
> +	if (hub->vmhub_funcs == NULL)
> +		hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 07cae64..45fbce7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -31,6 +31,33 @@
>   
>   #include "soc15_common.h"
>   
> +static void
> +gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
> +					     uint32_t status)
> +{
> +	dev_err(adev->dev,
> +		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> +		status);
> +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> +}
> +
>   u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
>   {
>   	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
> @@ -359,6 +386,10 @@ void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>   }
>   
> +static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
> +	.print_l2_protection_fault_status = gfxhub_v2_1_print_l2_protection_fault_status,
> +};
> +
>   void gfxhub_v2_1_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -397,6 +428,9 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
>   		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> +
> +	if (hub->vmhub_funcs == NULL)
> +		hub->vmhub_funcs = &gfxhub_v2_1_vmhub_funcs;
>   }
>   
>   int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e6c8526..8f35e13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -121,29 +121,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   			task_info.task_name, task_info.pid);
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   			addr, entry->client_id);
> -		if (!amdgpu_sriov_vf(adev)) {
> -			dev_err(adev->dev,
> -				"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> -				status);
> -			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> -			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -			dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> -			dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> -			dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> -			dev_err(adev->dev, "\t RW: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> -		}
> +		if (!amdgpu_sriov_vf(adev))
> +			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 48134b9..fb634c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -36,6 +36,33 @@
>   #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
>   #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
>   
> +static void
> +mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
> +					     uint32_t status)
> +{
> +	dev_err(adev->dev,
> +		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> +		status);
> +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, CID));
> +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> +		REG_GET_FIELD(status,
> +		MMVM_L2_PROTECTION_FAULT_STATUS, RW));
> +}
> +
>   void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
>   				uint64_t page_table_base)
>   {
> @@ -351,6 +378,10 @@ void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
>   	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL, tmp);
>   }
>   
> +static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
> +	.print_l2_protection_fault_status = mmhub_v2_0_print_l2_protection_fault_status,
> +};
> +
>   void mmhub_v2_0_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
> @@ -389,6 +420,9 @@ void mmhub_v2_0_init(struct amdgpu_device *adev)
>   		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>   		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> +
> +	if (hub->vmhub_funcs == NULL)
> +		hub->vmhub_funcs = &mmhub_v2_0_vmhub_funcs;

Please assign that unconditionally here.

Apart from that the series looks good to me as well.

Christian.

>   }
>   
>   static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
