Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C36C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 09:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CC961A2D
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CC961A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA816EE67;
	Fri, 26 Mar 2021 09:14:39 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C74E6EE67
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 09:14:39 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id jy13so7340031ejc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=P8U7VZpB0RiWvNs/jTD5Hf7xWe3ur++CLYXMWXNC8hQ=;
 b=fpzdQrGiwlh4ECwFLUPQlpGbu7ZWh8Hht84R6UC9PjQ7UKhfgZ/uq9XnD5+QQDGOPN
 bU4OlUyT1bcCEM5TutLoN/iC9guI8i3fnumFn/KoYbkkBOimuK6oDSzvFuPWWOHiByFQ
 hg/YUQRXuHF03fvauXRLHnNzhv7IhNQXZFVZxm1maScw5i0Ei3h03KROGrUnvydv2EmC
 0iAKFxBrn+GUldmDYPZGx1c33DMG3zInv5ANs6OziIOf8iP9gUUKHJqWBfASLfUBeSJD
 i9NJFiSUeyF8e9lwxQ4wGOXZbLd8gK7bIPv55+t20sWMs6nx9b8FD1SS3Rn26z06o/IC
 nyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=P8U7VZpB0RiWvNs/jTD5Hf7xWe3ur++CLYXMWXNC8hQ=;
 b=EQo2OXY9a2ItQRuQJpGkdY0b++GWexeL55zETyqlI9hgcdwqFii5uwsTe4V7Mnnumj
 815wu9h5i/trNUBeuXjmd4vmfP4S1EDRJ6yBIeZv7OY6KOF5U7idKVPNaLxnZaSCYCF8
 f+OKLpeqYhCBbX5JhXniasfhKZmYHzebzMi2vgWGuQdhtSFAwBLJ7GQ2qaTy9yJb8cff
 QUmLgC7RQ+Mwn5bRqURsUwtwA9eK69adycLYi5bErLNnSFqCNEPEy8yAMH8siq+tmhM7
 OAKwLZhvrNiilXlaVM6MY9hQiiasYnv0/4QLHvxoQr04SuLp2fLUJRx3ip6nrmVjvHMM
 fG2g==
X-Gm-Message-State: AOAM530IS6gtWJULlWWvisKRSI6LPFAx5TRseF8Y6LFfyuXvIkhf+udJ
 QNVZ5piFizfugwfB5hWclA0=
X-Google-Smtp-Source: ABdhPJwREDTkODk5PRVsaIoHRZ48w7qLji9umrjCLU+hbequ/i+4ParVuKSXb9m3Xh/WNW/pAcZJwg==
X-Received: by 2002:a17:906:8583:: with SMTP id
 v3mr14453106ejx.361.1616750077636; 
 Fri, 26 Mar 2021 02:14:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f5e9:4efc:3566:86b9?
 ([2a02:908:1252:fb60:f5e9:4efc:3566:86b9])
 by smtp.gmail.com with ESMTPSA id jx22sm3561708ejc.105.2021.03.26.02.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 02:14:37 -0700 (PDT)
Subject: Re: [PATCH 3/4] Revert "drm/amdgpu: workaround the TMR MC address
 issue (v2)"
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
 <1616690318-3555-3-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e90c376e-0fcc-cccb-e2d6-8371e8a141e1@gmail.com>
Date: Fri, 26 Mar 2021 10:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616690318-3555-3-git-send-email-Oak.Zeng@amd.com>
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.03.21 um 17:38 schrieb Oak Zeng:
> This reverts commit 34a33d4683cba7ba63c894132efb1998c0217631.

We need a single sentence here why we do the revert and I think you need 
to reorder the patches.

E.g. patch #3 should be #4 and #4 should be #3, otherwise you break the 
driver in between.

Apart from that looks like a nice cleanup to me.

Christian.

>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
>   4 files changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 7cd9d34..a9e0bba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -217,15 +217,6 @@ struct amdgpu_gmc {
>   	 */
>   	u64			fb_start;
>   	u64			fb_end;
> -	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
> -	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
> -	 * for now. To temporarily workaround the PSP FW issue, added below two
> -	 * variables to remember the original fb_start/end to re-enable FB
> -	 * aperture to workaround the PSP FW issue. Will delete it after we
> -	 * get a proper PSP FW fix.
> -	 */
> -	u64			fb_start_original;
> -	u64			fb_end_original;
>   	unsigned		vram_width;
>   	u64			real_vram_size;
>   	int			vram_mtrr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 5c71c5c..1005124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -410,16 +410,6 @@ static int psp_tmr_init(struct psp_context *psp)
>   				      AMDGPU_GEM_DOMAIN_VRAM,
>   				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
>   
> -	/* workaround the tmr_mc_addr:
> -	 * PSP requires an address in FB aperture. Right now driver produce
> -	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
> -	 * for PSP. Will revert it after we get a fix from PSP FW.
> -	 */
> -	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
> -		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
> -		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
> -	}
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index 7beef4c..8c8f0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -154,21 +154,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	 * FB aperture and AGP aperture. Disable them.
>   	 */
>   	if (adev->gmc.pdb0_bo) {
> -		if (adev->asic_type == CHIP_ALDEBARAN) {
> -			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
> -			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
> -			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
> -			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
> -			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
> -			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
> -		} else {
> -			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
> -			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
> -			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
> -			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
> -			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
> -			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
> -		}
> +		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
> +		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
> +		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
> +		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
> +		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
> +		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 8862ac2..8bb36d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -51,8 +51,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
>   
>   	adev->gmc.fb_start = base;
>   	adev->gmc.fb_end = top;
> -	adev->gmc.fb_start_original = base;
> -	adev->gmc.fb_end_original = top;
>   
>   	return base;
>   }
> @@ -148,10 +146,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
>   	if (adev->gmc.pdb0_bo) {
>   		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
>   		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
> -		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
> -		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
> -		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
> -		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
> +		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
> +		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
> +		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
> +		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
>   	}
>   	if (amdgpu_sriov_vf(adev))
>   		return;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
