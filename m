Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB13C2BBD4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 12:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFA822249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj5Me/5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFA822249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EC58800A;
	Wed, 21 Oct 2020 12:59:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F536EACC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 12:59:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id n18so3001417wrs.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I3ZJXMvtpHWSS4gMJVPgQcquqrOTfNWwkrqTpBqZ0FI=;
 b=Tj5Me/5LgS8ZVPnrpa/1IxAJ84DgqiPXjw3NchKc+MTxim/57IxyKqp2V5dA6PLPRE
 yBwyN1C/XH/0+9tMMo23s2yi9DRl+xsrFav+DPyRl3vv9ogxMlz3717WthgxDS8A/jmO
 bt7MK5xQezuui8yLBT6wnlnCiQaO+Huy8RzBfmCVkCeDIhuQ/z72Qvg9Z+2Ddc+ZdWot
 jQh5K+As5Dy1B1/ZrXU+Wwc5Uhi2GaXvdl7Tsv8QqGGFplvl3KSndTMaxo+/Ud/PaTVg
 sD+dEufSRFnR+8Adl6QElEACHWfRmEK2HF0MvffIWN5QKDFu2FQloexL4oAav9Jrmt/H
 vwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I3ZJXMvtpHWSS4gMJVPgQcquqrOTfNWwkrqTpBqZ0FI=;
 b=JP5VYE9QefM6Bn002VyfaFqwgrcO905mxnEQb1wxwIRmwyQsg7u5NuvvKUG14Fg2V5
 hHMH3nuMxa7y9vKwVn8LeIPKDHxJdaCBSb/v/mbJ/irnwe16PAPto4sON+5iSeRyyb8q
 BO1zbrJGk+VHN9x24tb8mAWDi6vu2Rpg4dAvcsxhAmwbG7wjExlVc53GLUQWpnp9tmZH
 oSi6LT6HV75u8WGQy01b7/yfhv4p8EOSCU1lE9rrcZ732ADLcn84AMpZgMYX8hJLRQVo
 yuV9eEoxwlFAg0hvc/IVRLVEe48GDYGe1bPsvpRy8DNBL6CcxoyKC2bxcv66bzixYQKp
 bUWQ==
X-Gm-Message-State: AOAM531jA93g43YyI9x1DPD8W5H9Au5zJfd3L4AmdJOepM8v70vOAimr
 kuTZeUKXPc23UCLoaeBdzf2Jv7PLQ+ZTnnaVimk=
X-Google-Smtp-Source: ABdhPJyTvS+Hugbi2Ogu1bYReXYyaYozq4vMlU7zqdlygv8ehfqeobLuHjeUVJPHcUEaj1l6FN68LI0/i/dChlRa9XY=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr4794503wrm.419.1603285159355; 
 Wed, 21 Oct 2020 05:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201021075608.16785-1-tianci.yin@amd.com>
 <20201021075608.16785-2-tianci.yin@amd.com>
In-Reply-To: <20201021075608.16785-2-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 08:59:07 -0400
Message-ID: <CADnq5_Ox5eJrPb3g-EW7dambjJ7fyXm8zd0kQAWjEjk451cq=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 3:56 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display support, so the DCN ip
> block should be disabled. Add DID/RID as display
> supporting dependence, it potentially disable DCN block.

Wouldn't it be cleaner to just not add the DCN block like you did in patch 3?

Alex

>
> Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 +++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f8f3e375c93e..04e906386b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1051,7 +1051,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>                                    u32 pcie_index, u32 pcie_data,
>                                    u32 reg_addr, u64 reg_data);
>
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>
>  int emu_soc_asic_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c567f20b9d1f..fa522cffdd64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2958,11 +2958,12 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer of pci_dev instance
>   *
>   * Check if there is DC (new modesetting infrastructre) support for an asic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev)
>  {
>         switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -2998,7 +2999,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>         case CHIP_VEGA20:
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         case CHIP_RAVEN:
> -       case CHIP_NAVI10:
>         case CHIP_NAVI14:
>         case CHIP_NAVI12:
>         case CHIP_RENOIR:
> @@ -3011,6 +3011,20 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  #endif
>                 return amdgpu_dc != 0;
>  #endif
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +       case CHIP_NAVI10:
> +               if (pdev->device == 0x731E &&
> +                   (pdev->revision == 0xC6 ||
> +                    pdev->revision == 0xC7)) {
> +                       DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n",
> +                                amdgpu_asic_name[asic_type], pdev->vendor, pdev->device,
> +                                pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
> +                       return false;
> +               } else {
> +                       return amdgpu_dc != 0;
> +               }
> +#endif
> +
>         default:
>                 if (amdgpu_dc > 0)
>                         DRM_INFO("Display Core has been requested via kernel parameter "
> @@ -3031,7 +3045,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>         if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>                 return false;
>
> -       return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +       return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev);
>  }
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 9e92d2a070ac..97014458d7de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
> +           amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev)) {
>                 switch (adev->asic_type) {
>                 case CHIP_CARRIZO:
>                 case CHIP_STONEY:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 13723914fa9f..97fda825e0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         bool supports_atomic = false;
>
>         if (!amdgpu_virtual_display &&
> -           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
>                 supports_atomic = true;
>
>         if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
