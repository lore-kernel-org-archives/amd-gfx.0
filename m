Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE17C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 10:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4AD2073D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 10:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB3dE3hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4AD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6C06E30E;
	Fri, 13 Dec 2019 10:15:30 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD826E30E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 10:15:29 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f4so5625680wmj.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H4fcYORjcDKMoYDVfJjLZFZ/WIysXGCfY9GPfTbDflg=;
 b=HB3dE3hAUku4p9hCdh3pBluTKdZkJOZVFIBCK7GO+fJ7/nwwHKPqESCXnqTaUyIuOI
 xittJNuAr0T4G8Weg2rx4sPjXMsHPUj1MxHxBn4L+Sf2hleJYtGE1NnmQnn9GXmYKZhN
 m/egeHtvNM4VNFBRJpbSAFdVLJEtszT9JM8MEmuIe4PaayIyK6f63392rPSHhNgwbxpM
 WneiLkAr0m5Z6pdljIbC+UHpvXiR0zE9iBS+R1buynAeKEW6Kz+2GROlqZ/6K+K1sSb8
 aqvMuZkXhC36xi2eBFwn4DOBSHbVPbkpDEF5sbD/jaVzmxVOV0pRD8FQT1zmjchlz3zY
 47+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H4fcYORjcDKMoYDVfJjLZFZ/WIysXGCfY9GPfTbDflg=;
 b=oyWy5dIldMxPD5WmQTeI8vf3nEem7+5vljPEKw/6GVpHTiV8BbYNdAA2pFUc4JSBPi
 gkKkSO9f47ItqfsGSq4K9tDTj+wnyPE19W6BoXRk0GpWKvGz8k534l7QBlf9x9lXe92T
 09pzmT2dJq2OpdTHyCTHuwk0HSNMfvMZtb3eZdgBeXS5Bb0fZlCC8X/+h84i+RAwHdQJ
 DVUen9K25NOwemf1ExaX2N9YxSWm8t+IwnhpgkpNw1qaF0h+ICMEqRRL75KtoHzvRe+q
 G5sK8vmHdm5Psu++hPbuSgE7voCFVFIRzM3b8T8SrJ3N0kHhe+Fvf9E53FjPrTTKVZh3
 CYEg==
X-Gm-Message-State: APjAAAVfWGnCNGES6fDX+H4Kl1GQKTTpeubr/lt2xL7tzYBF/O8ikhIq
 p5W0uQkIXxRHZZmzZaY6VPiu0DIS
X-Google-Smtp-Source: APXvYqxJm6KMKc9prWF6DWi7bKIpuzPEkU89mqLeJ8bSiykHbVHNUCkJLcdI5TG4Cm33Zfd9Y8IIaQ==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr12482896wmn.171.1576232128097; 
 Fri, 13 Dec 2019 02:15:28 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g7sm9495572wrq.21.2019.12.13.02.15.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Dec 2019 02:15:27 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn1.0: use its own idle handler and begin
 use funcs
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191211194824.11146-1-leo.liu@amd.com>
 <20191212160649.20375-1-leo.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <229885da-a5bc-5d12-f7a3-bcbbbe4bc57f@gmail.com>
Date: Fri, 13 Dec 2019 11:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212160649.20375-1-leo.liu@amd.com>
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

Am 12.12.19 um 17:06 schrieb Leo Liu:
> Because VCN1.0 power management and DPG mode are managed together with
> JPEG1.0 under both HW and FW, so separated them from general VCN code.
> Also the multiple instances case got removed, since VCN1.0 HW just have
> a single instance.
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 88 ++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h   |  2 +
>   5 files changed, 96 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 428cfd58b37d..e962c87d04cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -39,9 +39,6 @@
>   #include "vcn/vcn_1_0_offset.h"
>   #include "vcn/vcn_1_0_sh_mask.h"
>   
> -/* 1 second timeout */
> -#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
> -
>   /* Firmware Names */
>   #define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
>   #define FIRMWARE_PICASSO	"amdgpu/picasso_vcn.bin"
> @@ -71,7 +68,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	unsigned char fw_check;
>   	int i, r;
>   
> -	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> +	/* For VCN2.0 and above */
> +	if (adev->asic_type >= CHIP_ARCTURUS)
> +		INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);

Initializing the work structure twice is indeed not a good idea, but I 
think we could just override the work function in vcn_v1_0_sw_init() 
after calling vcn_v1_0_sw_init().

Apart from that the series looks good to me,
Christian.

>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 402a5046b985..3484ead62046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -56,6 +56,9 @@
>   #define VCN_VID_IP_ADDRESS_2_0		0x0
>   #define VCN_AON_IP_ADDRESS_2_0		0x30000
>   
> +/* 1 second timeout */
> +#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
> +
>   #define RREG32_SOC15_DPG_MODE(ip, inst, reg, mask, sram_sel) 				\
>   	({	WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
>   		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index a141408dfb23..0debfd9f428c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -25,6 +25,7 @@
>   #include "amdgpu_jpeg.h"
>   #include "soc15.h"
>   #include "soc15d.h"
> +#include "vcn_v1_0.h"
>   
>   #include "vcn/vcn_1_0_offset.h"
>   #include "vcn/vcn_1_0_sh_mask.h"
> @@ -561,7 +562,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
>   	.insert_start = jpeg_v1_0_decode_ring_insert_start,
>   	.insert_end = jpeg_v1_0_decode_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = jpeg_v1_0_decode_ring_emit_wreg,
>   	.emit_reg_wait = jpeg_v1_0_decode_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 652cecc030b3..7395286540e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -25,6 +25,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vcn.h"
> +#include "amdgpu_pm.h"
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "soc15_common.h"
> @@ -51,6 +52,8 @@ static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_sta
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				struct dpg_pause_state *new_state);
>   
> +static void vcn_v1_0_idle_work_handler(struct work_struct *work);
> +
>   /**
>    * vcn_v1_0_early_init - set function pointers
>    *
> @@ -101,6 +104,7 @@ static int vcn_v1_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> +	INIT_DELAYED_WORK(&adev->vcn.idle_work, vcn_v1_0_idle_work_handler);
>   	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
> @@ -1758,6 +1762,86 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>   	return ret;
>   }
>   
> +static void vcn_v1_0_idle_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	unsigned int fences = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
> +
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		struct dpg_pause_state new_state;
> +
> +		if (fences)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +
> +		adev->vcn.pause_dpg_mode(adev, &new_state);
> +	}
> +
> +	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
> +	fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_dec);
> +
> +	if (fences == 0) {
> +		amdgpu_gfx_off_ctrl(adev, true);
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		else
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +			       AMD_PG_STATE_GATE);
> +	} else {
> +		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	}
> +}
> +
> +void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +	if (set_clocks) {
> +		amdgpu_gfx_off_ctrl(adev, false);
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, true);
> +		else
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +			       AMD_PG_STATE_UNGATE);
> +	}
> +
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		struct dpg_pause_state new_state;
> +		unsigned int fences = 0, i;
> +
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +			fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
> +
> +		if (fences)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +
> +		adev->vcn.pause_dpg_mode(adev, &new_state);
> +	}
> +}
> +
>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>   	.name = "vcn_v1_0",
>   	.early_init = vcn_v1_0_early_init,
> @@ -1804,7 +1888,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.insert_start = vcn_v1_0_dec_ring_insert_start,
>   	.insert_end = vcn_v1_0_dec_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
> @@ -1836,7 +1920,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.insert_end = vcn_v1_0_enc_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = vcn_v1_0_enc_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v1_0_enc_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> index 2a497a7a4840..f67d7391fc21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> @@ -24,6 +24,8 @@
>   #ifndef __VCN_V1_0_H__
>   #define __VCN_V1_0_H__
>   
> +void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
> +
>   extern const struct amdgpu_ip_block_version vcn_v1_0_ip_block;
>   
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
