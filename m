Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A7C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4902063A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEvUWxrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4902063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507246E08A;
	Thu, 22 Oct 2020 03:16:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F396E08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:16:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h5so174726wrv.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 20:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZZK3I1imeNOAgdDOynqUl3INmvvZZ5GgoxQzeUX121c=;
 b=jEvUWxrB29i2pBDOnjOn4tAGuTnXEr0EfE4qkFdsQ/5aFZCf64u54FFYlcmrdfpqqf
 OMBrcDTbiFJRa+TIB/5APs/Y/SwzsbY0oZKS0a7f90IGlGlK3RNl8jcy8FFiYWx5d+vA
 XH+hvDfQQh04ntUVXtyitYnvtHiDVXUVc1IM7zwSghryL7YlMG+b+BO83qt3J8jhSqE5
 pn7DF/qmZG6ow187Bz1wvSzRIc3VWdnkyK9my2EjBfxKBYN36FGwJN4mb+ezWBFshz4o
 jAS1YxpR4xKk++HVdRA+qE329lqSN4o7MhKwYnQm5nxCMybotRrenkFocRgoZBqphMkd
 nWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZZK3I1imeNOAgdDOynqUl3INmvvZZ5GgoxQzeUX121c=;
 b=rAllOphgu95uqE23q2QAUIOPQdRos2VrsdOY7iW5DF9TbDm8kGzfu0hiCQmbIO8dyg
 uzaUZqrIdPMupZqNuCGS/5rZCvZQSnaK4zruZPf6wyWY+tAOvqTvotRiYzo6VdxLpXsZ
 SURGcdFu/I1JtA7O6gqINY5xwAMzw8kbKbT3f/kb1v9AoPY2X1BaLxpN0p1fkscZ61rx
 w0OoqsG/4FRDboCVD0UjGQaG/OaXhhClK6xMefPGPfgniF7Xcus7qBlqjj0aoSpUdDfI
 UTJyw2KrwfEH4zOaF8NPn83+l0dRiVLPV+Z9KxOeY5Yv1W2WafxQfpJBHK1vWMfLzV1q
 QmQw==
X-Gm-Message-State: AOAM532pXKJul1mVnn8IfuDQ0iPRPsYoRiYBML+F4X+e/ZgJ552YKzbb
 GyTRwSD4oaQJfUzoJSB/CQJ+T0ya0q4uJwptvyQ=
X-Google-Smtp-Source: ABdhPJz23QKIQ4A63eU2SW+c2RD2CwWe9IgUTyfsDiQnbOxNQeBYGUNK3qXJD0KFuKVmDPT0a/kGXXKeX5hrvIFww44=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr313713wrn.362.1603336599775; 
 Wed, 21 Oct 2020 20:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201022030432.4011-1-tianci.yin@amd.com>
 <20201022030432.4011-2-tianci.yin@amd.com>
In-Reply-To: <20201022030432.4011-2-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 23:16:28 -0400
Message-ID: <CADnq5_PYoV2UmvjC4MJtr8tnREz7ZvsqvqfAKGogwok=MUOpGw@mail.gmail.com>
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

On Wed, Oct 21, 2020 at 11:04 PM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display support, remove it.
>
> Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  4 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f8f3e375c93e..3c63fb8904de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1051,7 +1051,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>                                    u32 pcie_index, u32 pcie_data,
>                                    u32 reg_addr, u64 reg_data);
>
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>
>  int emu_soc_asic_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c567f20b9d1f..5dd05e72ed9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2954,15 +2954,32 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
>         }
>  }
>
> +/**
> + * amdgpu_device_asic_is_blockchain_sku - determine if the asic is blockchain
> + * SKU
> + *
> + * @pdev: pointer to pci_dev instance
> + *
> + * returns true if the asic is blockchain SKU, false if not.
> + */
> +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev)
> +{
> +       if (pdev->device == 0x731E &&
> +           (pdev->revision == 0xC6 || pdev->revision == 0xC7))
> +               return true;
> +       return false;
> +}

I don't think this makes sense to have a navi specific function in
amdgpu_device.c.  Also, I said said previously, wouldn't it be easier
to just check in nv.c?  E.g.,

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1ce741a0c6a7..e661e796fb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -483,8 +483,12 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                        amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
-               else if (amdgpu_device_has_dc_support(adev))
-                       amdgpu_device_ip_block_add(adev, &dm_ip_block);
+               else if (amdgpu_device_has_dc_support(adev)) {
+                       if (adev->pdev->device != 0x731E ||
+                           (adev->pdev->revision != 0xC6 &&
+                            adev->pdev->revision != 0xC7))
+                               amdgpu_device_ip_block_add(adev, &dm_ip_block);
+               }
 #endif
                amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
                amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);


> +
>  /**
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer to pci_dev instance
>   *
>   * Check if there is DC (new modesetting infrastructre) support for an asic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev)
>  {
>         switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -2999,6 +3016,13 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         case CHIP_RAVEN:
>         case CHIP_NAVI10:
> +               if (amdgpu_device_asic_is_blockchain_sku(pdev)) {
> +                       DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n",
> +                                amdgpu_asic_name[asic_type], pdev->vendor, pdev->device,
> +                                pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
> +                       return false;
> +               }
> +               return amdgpu_dc != 0;
>         case CHIP_NAVI14:
>         case CHIP_NAVI12:
>         case CHIP_RENOIR:
> @@ -3031,7 +3055,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
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
