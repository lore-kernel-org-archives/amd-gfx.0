Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7ABC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B80613B6
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B80613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E131D6E435;
	Wed, 14 Apr 2021 03:12:46 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089D96E435
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 03:12:46 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id b3so4401356oie.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z8xh5osW5mxnEW84G37T2MLucQX/v+o+LAi2ZABlNjU=;
 b=lpGVr37SC3ucAaGBaVWbxrwXrMR6/fRdIMcuQ/7yYy7TTYVHERodzoZrlKdXctL2K4
 wvyvy4xcGsfPTT7DywmB8eT8cA4CvNqWkkiwz1ig9cckRGnOxJsmDmIFxurTgEk107TM
 9vQMzSzGfKXaug2KWFzQEu6kwa4nnMVmm2BxC1YCBdYc+ssD5/igJyWK924nwntQunTh
 iZwrlmjO6EwAfxigmftQ47Lyp3Ra/1DyKIgRKN+MT0LMMZxkuKi2OKHpUi+P0QIFrRwG
 jqx9gffixEU4AV+bFAtaqGQukT2ykejlakFElQ0nMVLvIGf7gWkgc6qA9Jk1/7y16h1y
 qUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8xh5osW5mxnEW84G37T2MLucQX/v+o+LAi2ZABlNjU=;
 b=Lfz/HmzKB+99bT81oLf9PNzeoStExBDXR9VmGVLDxez88RgCxPJASJIGdtPmM2Z2R5
 8QxcbISAOxc6oqVOiqkUfDqrGwz84jCk7KQPV/0Kk6pHGWEFZKB67HpjPQyXFOehFw4y
 VTXVl1KEqbSAD0ECyo9WKdzmcwyXlTY1BneYdf9cAIK+xXlJThJRsYkgvChQseTWtoW5
 ibTZwOeWx4627lgFuDGVSVyNfOMwKlfm9oHZSk3gKE6cgeXnULq0/hr0JrdsKJDFa8qY
 tr34tiClg0EFpAJ7bFZ/WkmncJONhJKFjbNHImfRrP85hi5CVMFy+mQucLcdXKDfGlxl
 yY6A==
X-Gm-Message-State: AOAM533CQUrfLnozv43XSPc+nOJhGVz6ek3rLKe74tIixzl38IGlnU4j
 fD+4SqZOSm0ZRZSVZ4Uwy02MuOlQTYliEK+4V6Y=
X-Google-Smtp-Source: ABdhPJxOwR8VhuAqOCjZ+oINWobM1a6sO+1Zpe1wixXteqjAh4G3iQ3aaAM2Jb8fACkksmqdRozcUHnJgRBZJ9Y2oY0=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr711897oif.5.1618369965240;
 Tue, 13 Apr 2021 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210414030347.23655-1-kenneth.feng@amd.com>
In-Reply-To: <20210414030347.23655-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Apr 2021 23:12:34 -0400
Message-ID: <CADnq5_NSk7GQxgxt+XyGUt-sgxabMY65Ohi_O9DRdTbpJ4xJNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: enable ASPM on navi1x and vega
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 13, 2021 at 11:04 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> enable ASPM on navi1x and vega series

Please split this patch into two, one for vega and one for navi1x.
With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 128 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 125 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c     |   7 +-
>  4 files changed, 259 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> index 83ea063388fd..0d2d629e2d6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> @@ -31,6 +31,28 @@
>  #include "vega10_enum.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> +#define smnPCIE_LC_CNTL                0x11140280
> +#define smnPCIE_LC_CNTL3       0x111402d4
> +#define smnPCIE_LC_CNTL6       0x111402ec
> +#define smnPCIE_LC_CNTL7       0x111402f0
> +#define smnNBIF_MGCG_CTRL_LCLK 0x1013a05c
> +#define NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK       0x00001000L
> +#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK       0x0000FFFFL
> +#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK     0xFFFF0000L
> +#define smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL   0x10123530
> +#define smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2      0x1014008c
> +#define smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP      0x10140324
> +#define smnPSWUSP0_PCIE_LC_CNTL2               0x111402c4
> +#define smnRCC_BIF_STRAP2      0x10123488
> +#define smnRCC_BIF_STRAP3      0x1012348c
> +#define smnRCC_BIF_STRAP5      0x10123494
> +#define BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK                    0x0400L
> +#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK       0x0000FFFFL
> +#define RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK   0x00004000L
> +#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT     0x0
> +#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT   0x10
> +#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT     0x0
> +
>  static void nbio_v6_1_remap_hdp_registers(struct amdgpu_device *adev)
>  {
>         WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> @@ -256,6 +278,111 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
>                 WREG32_PCIE(smnPCIE_CI_CNTL, data);
>  }
>
> +static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
> +{
> +       uint32_t def, data;
> +
> +       WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, 0x75EB);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP2);
> +       data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP2, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
> +       data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +       data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +}
> +
> +static void nbio_v6_1_program_aspm(struct amdgpu_device *adev)
> +{
> +       uint32_t def, data;
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
> +       data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
> +       data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> +       data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL7);
> +       data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL7, data);
> +
> +       def = data = RREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK);
> +       data |= NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
> +       data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
> +       data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
> +       data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
> +       data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP5, data);
> +
> +       def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +       data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +
> +       WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
> +
> +       def = data = RREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2);
> +       data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
> +               PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
> +       data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL6);
> +       data |= PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK |
> +               PCIE_LC_CNTL6__LC_RX_L0S_STANDBY_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> +
> +       nbio_v6_1_program_ltr(adev);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
> +       data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
> +       data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
> +       data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP5, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
> +       data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> +       data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
> +       data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
> +       data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> +}
> +
>  const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
>         .get_hdp_flush_req_offset = nbio_v6_1_get_hdp_flush_req_offset,
>         .get_hdp_flush_done_offset = nbio_v6_1_get_hdp_flush_done_offset,
> @@ -274,4 +401,5 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
>         .ih_control = nbio_v6_1_ih_control,
>         .init_registers = nbio_v6_1_init_registers,
>         .remap_hdp_registers = nbio_v6_1_remap_hdp_registers,
> +       .program_aspm =  nbio_v6_1_program_aspm,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index af44aad78171..cef929746739 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -31,7 +31,26 @@
>  #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> +#define smnPCIE_LC_CNTL                0x11140280
> +#define smnPCIE_LC_CNTL3       0x111402d4
> +#define smnPCIE_LC_CNTL6       0x111402ec
> +#define smnPCIE_LC_CNTL7       0x111402f0
>  #define smnNBIF_MGCG_CTRL_LCLK 0x1013a21c
> +#define smnRCC_BIF_STRAP3      0x1012348c
> +#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK       0x0000FFFFL
> +#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK     0xFFFF0000L
> +#define smnRCC_BIF_STRAP5      0x10123494
> +#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK       0x0000FFFFL
> +#define smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2      0x1014008c
> +#define BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK                    0x0400L
> +#define smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP      0x10140324
> +#define smnPSWUSP0_PCIE_LC_CNTL2               0x111402c4
> +#define smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL   0x10123538
> +#define smnRCC_BIF_STRAP2      0x10123488
> +#define RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK   0x00004000L
> +#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT     0x0
> +#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT   0x10
> +#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT     0x0
>
>  /*
>   * These are nbio v7_4_1 registers mask. Temporarily define these here since
> @@ -567,6 +586,111 @@ const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
>         .ras_fini = amdgpu_nbio_ras_fini,
>  };
>
> +static void nbio_v7_4_program_ltr(struct amdgpu_device *adev)
> +{
> +       uint32_t def, data;
> +
> +       WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, 0x75EB);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP2);
> +       data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP2, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
> +       data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +       data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +}
> +
> +static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
> +{
> +       uint32_t def, data;
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
> +       data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
> +       data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> +       data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL7);
> +       data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL7, data);
> +
> +       def = data = RREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK);
> +       data |= NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
> +       data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
> +       data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
> +       data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
> +       data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP5, data);
> +
> +       def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +       data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +
> +       WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
> +
> +       def = data = RREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2);
> +       data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
> +               PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
> +       data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL6);
> +       data |= PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK |
> +               PCIE_LC_CNTL6__LC_RX_L0S_STANDBY_EN_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> +
> +       nbio_v7_4_program_ltr(adev);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
> +       data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
> +       data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP3, data);
> +
> +       def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
> +       data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnRCC_BIF_STRAP5, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
> +       data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> +       data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
> +       data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL, data);
> +
> +       def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
> +       data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +       if (def != data)
> +               WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> +}
> +
>  const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
>         .get_hdp_flush_req_offset = nbio_v7_4_get_hdp_flush_req_offset,
>         .get_hdp_flush_done_offset = nbio_v7_4_get_hdp_flush_done_offset,
> @@ -587,4 +711,5 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
>         .ih_control = nbio_v7_4_ih_control,
>         .init_registers = nbio_v7_4_init_registers,
>         .remap_hdp_registers = nbio_v7_4_remap_hdp_registers,
> +       .program_aspm =  nbio_v7_4_program_aspm,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 46d4bbabce75..d54af7f8801b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -601,8 +601,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
>         if (amdgpu_aspm != 1)
>                 return;
>
> -       if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> -           !(adev->flags & AMD_IS_APU) &&
> +       if (!(adev->flags & AMD_IS_APU) &&
>             (adev->nbio.funcs->program_aspm))
>                 adev->nbio.funcs->program_aspm(adev);
>
> @@ -934,12 +933,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
>         if (adev->gfx.funcs->update_perfmon_mgcg)
>                 adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
>
> -       /*
> -        * The ASPM function is not fully enabled and verified on
> -        * Navi yet. Temporarily skip this until ASPM enabled.
> -        */
> -       if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> -           !(adev->flags & AMD_IS_APU) &&
> +       if (!(adev->flags & AMD_IS_APU) &&
>             (adev->nbio.funcs->enable_aspm))
>                 adev->nbio.funcs->enable_aspm(adev, !enter);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 5c5eb3aed1b3..d80e12b80c7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -816,11 +816,12 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
>
>  static void soc15_program_aspm(struct amdgpu_device *adev)
>  {
> -
> -       if (amdgpu_aspm == 0)
> +       if (amdgpu_aspm != 1)
>                 return;
>
> -       /* todo */
> +       if (!(adev->flags & AMD_IS_APU) &&
> +           (adev->nbio.funcs->program_aspm))
> +               adev->nbio.funcs->program_aspm(adev);
>  }
>
>  static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
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
