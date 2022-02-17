Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD7BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BD710EAF4;
	Thu, 17 Feb 2022 14:56:53 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D5B10EAF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:56:51 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 j8-20020a056830014800b005ad00ef6d5dso2867719otp.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y+TAhGiubsj5R3nWL5oLl84Iaz6mSkj3I86l2w+6p1I=;
 b=gLB4kuB8ti4LrTo8UGI+kkIsCs8xWvM15b/hLo/ejkSS5ndgUBwKP4f5CYZL86qg/f
 cTsBNCHkKv+AjWH0qc79yKXW6wqReKwTmOmiOm3EFdmPvyvHwO3d20pYvaNMSdyUUsRD
 4sV45ENn73aikHRuReLJJClk0U3TX+wv3p/IXgDdevrjV0NR8iey+lE1lv/xbgjStp4V
 WW+T3k5tnYtXL2Fav69GnCeRJcNDK2QaBsrNCUs63g4YeE0IleRbR5IYdp8D89wYsXOB
 4TDo6UtjEGU2BQ5AUV+h3fbZWs7q9AGgyCxnsS8kYr3bYJtbLLHxrTNOzyjkWkIKkEKS
 xDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y+TAhGiubsj5R3nWL5oLl84Iaz6mSkj3I86l2w+6p1I=;
 b=pHh851csgfRBieJI5tpmMyw3F0KPS8WgzQ9tVEBrsSsF86Wt6syw26DxMZ2ZgHZL2d
 uwXu0d7pAOGemOk+nIVLRFfItXUoWd83zd+6m7N9HDDKAPxtvCp40j0pW7qhBiw9e4L0
 kIBReWv/9AZTddBkDI/w80HT3U2vu1yeEuZdgmvr3ORlzlirqzg+5T/VWcDzngZhAbgg
 aAyXRmcJrHdmyH3tbmcnUZ3OwrchUACv+/czUJUbue8mcwXNiSaSSy084QLhtWn8b43E
 XkRmO6Kz6w23HFgv4TDv7eaJdpcqzUC4ERU9+gfNAN9d+4BLqJuSv4RMylV6lddiDgDd
 NTtQ==
X-Gm-Message-State: AOAM533pTr1bDHHi3ZKvAASWxqA8j+6UvmOx61vDdMf3Ii3IyOZKOBhO
 myIRCkBgeW2wT8szMnMw0r1K+qLfOKNbmS7Ys9Q=
X-Google-Smtp-Source: ABdhPJy0gP5+ojYt7HjpSmQLACZ0CfnwL1zniaPSZlrN1XPPeODEJtjO2hcYhMod5fwvf4US9I7tV7GlE6MwtzLOYic=
X-Received: by 2002:a05:6830:54a:b0:5ac:f770:5ac5 with SMTP id
 l10-20020a056830054a00b005acf7705ac5mr982311otb.200.1645109810522; Thu, 17
 Feb 2022 06:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217054504.10535-1-mario.limonciello@amd.com>
In-Reply-To: <20220217054504.10535-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Feb 2022 09:56:39 -0500
Message-ID: <CADnq5_PjDeGP7vmgz3NtFJAYZ+MVJUULN82L_b=e9+v=6LhCGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Refactor `amdgpu_aspm` to be evaluated per
 device
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Feb 17, 2022 at 12:44 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Evaluating `pcie_aspm_enabled` as part of driver probe has the implication
> that if one PCIe bridge with an AMD GPU connected doesn't support ASPM
> then none of them do.  This is an invalid assumption as the PCIe core will
> configure ASPM for individual PCIe bridges.
>
> Create a new helper function that can be called by individual dGPUs to
> react to the `amdgpu_aspm` module parameter without having negative results
> for other dGPUs on the PCIe bus.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 ---
>  drivers/gpu/drm/amd/amdgpu/cik.c              |  2 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c               |  2 +-
>  drivers/gpu/drm/amd/amdgpu/si.c               |  2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c               |  2 +-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
>  9 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3a126dce8a2f..f0a34aa4af78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1297,6 +1297,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
> +bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
>
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
>                                   u64 num_vis_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4667c992a4cc..283d7a7a5249 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1318,6 +1318,31 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>         return true;
>  }
>
> +/**
> + * amdgpu_device_should_use_aspm - check if the device should program ASPM
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Confirm whether the module parameter and pcie bridge agree that ASPM should
> + * be set for this device.
> + *
> + * Returns true if it should be used or false if not.
> + */
> +bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
> +{
> +       switch (amdgpu_aspm) {
> +       case -1:
> +               break;
> +       case 0:
> +               return false;
> +       case 1:
> +               return true;
> +       default:
> +               return false;
> +       }
> +       return pcie_aspm_enabled(adev->pdev);
> +}
> +
>  /* if we get transitioned to only one device, take VGA back */
>  /**
>   * amdgpu_device_vga_set_decode - enable/disable vga decode
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d2548fab51c5..5acd0473ed01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2008,9 +2008,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                         return -ENODEV;
>         }
>
> -       if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> -               amdgpu_aspm = 0;
> -
>         if (amdgpu_virtual_display ||
>             amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>                 supports_atomic = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index f10ce740a29c..de6d10390ab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1719,7 +1719,7 @@ static void cik_program_aspm(struct amdgpu_device *adev)
>         bool disable_l0s = false, disable_l1 = false, disable_plloff_in_l1 = false;
>         bool disable_clkreq = false;
>
> -       if (amdgpu_aspm == 0)
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (pci_is_root_bus(adev->pdev->bus))
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 8a5642f2daa6..ebed9c84db04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -520,7 +520,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device *adev)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)
>  {
> -       if (!amdgpu_aspm)
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e6d2f74a7976..7f99e130acd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2453,7 +2453,7 @@ static void si_program_aspm(struct amdgpu_device *adev)
>         bool disable_l0s = false, disable_l1 = false, disable_plloff_in_l1 = false;
>         bool disable_clkreq = false;
>
> -       if (amdgpu_aspm == 0)
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (adev->flags & AMD_IS_APU)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 99a88f4d8050..fe21397323b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -670,7 +670,7 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
>
>  static void soc15_program_aspm(struct amdgpu_device *adev)
>  {
> -       if (!amdgpu_aspm)
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 6645ebbd2696..039b90cdc3bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1140,7 +1140,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
>         bool bL1SS = false;
>         bool bClkReqSupport = true;
>
> -       if (!amdgpu_aspm)
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (adev->flags & AMD_IS_APU ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 4f0bc1841283..d9d634ce9575 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -348,7 +348,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>         if (smu->dc_controlled_by_gpio)
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
>
> -       if (amdgpu_aspm)
> +       if (amdgpu_device_should_use_aspm(adev))
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
>
>         return 0;
> --
> 2.25.1
>
