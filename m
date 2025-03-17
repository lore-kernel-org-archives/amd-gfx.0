Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77254C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3CF10E422;
	Mon, 17 Mar 2025 14:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLUybJ40";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E2B10E422
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:59:05 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff7cf59a8fso688105a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742223545; x=1742828345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1I+uIF3LUbAkhpkojUihyHPTVXsRHFQeQYHH3Lw/ViY=;
 b=NLUybJ40EDK/g/BZqq8wx7zj3UE8e4AG9ZSYQWuP3eEVdm35xIv4N5s2QeXGDyXWPg
 cXbbwYr3jXrlS3KD8g25jmeoSLytXimkpZn7nePuO5/5cTcG9PaOAb0ilnN2gAe02nFg
 3/Ld/PQfnpCGfHENfOKYV1dLFRIHSh0193c68VuwCOAygihY1GPv1DDa5JgvJxj7KKfK
 6I10bd5Ba1SLC7HItRfr9CmXHnKc4UYa1WnmBcF2wlyOytBjhCu0G46ux9zwx0DzzpJZ
 3lEk9jlhv9G6k3ZqsTmelpxZK97USP9Njjwb4c+M+LqWj0jq3oO/a5Y03mUUpsHRtxZ8
 aoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223545; x=1742828345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1I+uIF3LUbAkhpkojUihyHPTVXsRHFQeQYHH3Lw/ViY=;
 b=kdS6qlXbe/gfynadT0YEXp4NEO3AmGOs2LKWVrkRimLENuVZtEc/a4A0Ng/EBS5eau
 fXv5RoVki0xT8AjL1vpuppzqnSscKLZX1Sd7310KSUSuhjsSQTQXgxIExIQCck7dOYiw
 o0Lgk7vtCiTaeH6NlCePNCR9ypE/Z+QIU4SKt06fh5bbegwhfbSSlaMc7neJeQOF8yoA
 s53fLs5RebHHnHj2CtQa9U/Q6QrGr95w4+JMVwQ9vfaT/EFmVAyuz6SLN1+DC/tq521b
 fPCUaIoDQYW+P4MEuyRyTHo/bNpjWuab9Qlot3t8PHZ8dgkyniw5wJGwH035RWSD8x3l
 sEuA==
X-Gm-Message-State: AOJu0Yw7YLpVdkYc4j4KedTXy6wwiDdWKDRSm38yOGtmAS3K89bEz1cK
 ibkbt6rFDG1J/HGJJnWyEbZer7XB3GnAYtJV2gJwj9OY5YD2NwzWZgbWPThuX5UXh9fVOcItxfi
 aj/aEYe35jZsI432TdTnugfutiTFdPA==
X-Gm-Gg: ASbGncuOv4yGxZcvK4s9L5uZ+DhdVCSTl4oP0fJcQtNBb8Ka2GMxba+QFZBana4uQAg
 T7CrZAN18Qfl6dfNdIANLzq/UzNlQZQk76nbY05MU2PFPuRbB6HanQM4iVuTaRF/kAIn0ohQiZn
 o+kP78MHO8a1BlDBDrB9KB8Bas0g==
X-Google-Smtp-Source: AGHT+IEIDpN+NgqPzMb878FcawHTRcbaF96SCmzmzIwgwKqZeZ/E42StDA4FF1vcuKofGwkq1WznoA4J3HGi6LmNDM0=
X-Received: by 2002:a17:90b:2250:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-30151d693camr6024771a91.4.1742223545361; Mon, 17 Mar 2025
 07:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
 <20250317060702.5297-4-alexandre.f.demers@gmail.com>
In-Reply-To: <20250317060702.5297-4-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 10:58:53 -0400
X-Gm-Features: AQ5f1JrIBn7FU1dvvFhhS0zdrs0_7W8aZU1HyB3ZO2XxqGZwzKej6pkGux2Ofj4
Message-ID: <CADnq5_OHUgk_ABFa=mjWy2-qK1+nvQf_PCqwDO-js4KauxqR1A@mail.gmail.com>
Subject: Re: [PATCH 03/18] drm/amdgpu: use proper defines, shifts and masks in
 DCE6 code
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 17, 2025 at 2:08=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> By replacing VGA_VSTATUS_CNTL by VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MAS=
K,
> we also need to fix its usage in GMC6.
>
> Note: VGA_VSTATUS_CNTL's binary value was inverted in dce_6_0_sh_mask.h,
> so we need to invert its value where it was used.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 18 ++++++++---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/si_enums.h         |  5 -----
>  drivers/gpu/drm/amd/amdgpu/sid.h              | 20 -------------------
>  .../include/asic_reg/dce/dce_6_0_sh_mask.h    |  4 +++-
>  5 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index e1b0779e835f..a9a087a841ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -383,7 +383,7 @@ static void dce_v6_0_set_vga_render_state(struct amdg=
pu_device *adev,
>  {
>         if (!render)
>                 WREG32(mmVGA_RENDER_CONTROL,
> -                       RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
> +                       RREG32(mmVGA_RENDER_CONTROL) & ~VGA_RENDER_CONTRO=
L__VGA_VSTATUS_CNTL_MASK);
>
>  }
>
> @@ -2078,7 +2078,7 @@ static void dce_v6_0_set_interleave(struct drm_crtc=
 *crtc,
>
>         if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>                 WREG32(mmDATA_FORMAT + amdgpu_crtc->crtc_offset,
> -                      INTERLEAVE_EN);
> +                       DATA_FORMAT__INTERLEAVE_EN_MASK);
>         else
>                 WREG32(mmDATA_FORMAT + amdgpu_crtc->crtc_offset, 0);
>  }
> @@ -2132,7 +2132,7 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc =
*crtc)
>         WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
>                ((0 << DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT) |
>                 (0 << DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT) |
> -               ICON_DEGAMMA_MODE(0) |
> +               (0 << DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT) |
>                 (0 << DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT)));
>         WREG32(mmGAMUT_REMAP_CONTROL + amdgpu_crtc->crtc_offset,
>                ((0 << GAMUT_REMAP_CONTROL__GRPH_GAMUT_REMAP_MODE__SHIFT) =
|
> @@ -2908,12 +2908,12 @@ static void dce_v6_0_set_crtc_vblank_interrupt_st=
ate(struct amdgpu_device *adev,
>         switch (state) {
>         case AMDGPU_IRQ_STATE_DISABLE:
>                 interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> -               interrupt_mask &=3D ~VBLANK_INT_MASK;
> +               interrupt_mask &=3D ~INT_MASK__VBLANK_INT_MASK;
>                 WREG32(mmINT_MASK + reg_block, interrupt_mask);
>                 break;
>         case AMDGPU_IRQ_STATE_ENABLE:
>                 interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> -               interrupt_mask |=3D VBLANK_INT_MASK;
> +               interrupt_mask |=3D INT_MASK__VBLANK_INT_MASK;
>                 WREG32(mmINT_MASK + reg_block, interrupt_mask);
>                 break;
>         default:
> @@ -2943,12 +2943,12 @@ static int dce_v6_0_set_hpd_interrupt_state(struc=
t amdgpu_device *adev,
>         switch (state) {
>         case AMDGPU_IRQ_STATE_DISABLE:
>                 dc_hpd_int_cntl =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_of=
fsets[type]);
> -               dc_hpd_int_cntl &=3D ~DC_HPDx_INT_EN;
> +               dc_hpd_int_cntl &=3D ~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN=
_MASK;
>                 WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_=
int_cntl);
>                 break;
>         case AMDGPU_IRQ_STATE_ENABLE:
>                 dc_hpd_int_cntl =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_of=
fsets[type]);
> -               dc_hpd_int_cntl |=3D DC_HPDx_INT_EN;
> +               dc_hpd_int_cntl |=3D DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_=
MASK;
>                 WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_=
int_cntl);
>                 break;
>         default:
> @@ -3018,7 +3018,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *=
adev,
>         switch (entry->src_data[0]) {
>         case 0: /* vblank */
>                 if (disp_int & interrupt_status_offsets[crtc].vblank)
> -                       WREG32(mmVBLANK_STATUS + crtc_offsets[crtc], VBLA=
NK_ACK);
> +                       WREG32(mmVBLANK_STATUS + crtc_offsets[crtc], VBLA=
NK_STATUS__VBLANK_ACK_MASK);
>                 else
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n")=
;
>
> @@ -3029,7 +3029,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *=
adev,
>                 break;
>         case 1: /* vline */
>                 if (disp_int & interrupt_status_offsets[crtc].vline)
> -                       WREG32(mmVLINE_STATUS + crtc_offsets[crtc], VLINE=
_ACK);
> +                       WREG32(mmVLINE_STATUS + crtc_offsets[crtc], VLINE=
_STATUS__VLINE_ACK_MASK);
>                 else
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n")=
;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index ca000b3d1afc..2942fe8f80ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -248,7 +248,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device =
*adev)
>
>                 /* disable VGA render */
>                 tmp =3D RREG32(mmVGA_RENDER_CONTROL);
> -               tmp &=3D ~VGA_VSTATUS_CNTL;
> +               tmp &=3D VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK;
>                 WREG32(mmVGA_RENDER_CONTROL, tmp);
>         }
>         /* Update configuration */
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/=
amdgpu/si_enums.h
> index b44a32bacd5c..f6804c9b7a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
> +++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
> @@ -23,23 +23,18 @@
>  #ifndef SI_ENUMS_H
>  #define SI_ENUMS_H
>
> -#define VBLANK_INT_MASK                (1 << 0)
> -#define DC_HPDx_INT_EN                 (1 << 16)
>  #define VBLANK_ACK                     (1 << 4)
>  #define VLINE_ACK                      (1 << 4)
>
>  #define CURSOR_WIDTH 64
>  #define CURSOR_HEIGHT 64
>
> -#define VGA_VSTATUS_CNTL               0xFFFCFFFF
>  #define PRIORITY_MARK_MASK             0x7fff
>  #define PRIORITY_OFF                   (1 << 16)
>  #define PRIORITY_ALWAYS_ON             (1 << 20)
> -#define INTERLEAVE_EN                  (1 << 0)
>
>  #define LATENCY_WATERMARK_MASK(x)      ((x) << 16)
>  #define DC_LB_MEMORY_CONFIG(x)         ((x) << 20)
> -#define ICON_DEGAMMA_MODE(x)           (((x) & 0x3) << 8)
>
>  #define GRPH_ENDIAN_SWAP(x)            (((x) & 0x3) << 0)
>  #define GRPH_ENDIAN_NONE               0
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index cbf232f5235b..00eb40d4c1a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -787,26 +787,6 @@
>  #       define LATENCY_LOW_WATERMARK(x)                                (=
(x) << 0)
>  #       define LATENCY_HIGH_WATERMARK(x)                       ((x) << 1=
6)
>
> -/* 0x6bb8, 0x77b8, 0x103b8, 0x10fb8, 0x11bb8, 0x127b8 */
> -#define VLINE_STATUS                                    0x1AEE
> -#       define VLINE_OCCURRED                           (1 << 0)
> -#       define VLINE_ACK                                (1 << 4)
> -#       define VLINE_STAT                               (1 << 12)
> -#       define VLINE_INTERRUPT                          (1 << 16)
> -#       define VLINE_INTERRUPT_TYPE                     (1 << 17)
> -/* 0x6bbc, 0x77bc, 0x103bc, 0x10fbc, 0x11bbc, 0x127bc */
> -#define VBLANK_STATUS                                   0x1AEF
> -#       define VBLANK_OCCURRED                          (1 << 0)
> -#       define VBLANK_ACK                               (1 << 4)
> -#       define VBLANK_STAT                              (1 << 12)
> -#       define VBLANK_INTERRUPT                         (1 << 16)
> -#       define VBLANK_INTERRUPT_TYPE                    (1 << 17)
> -
> -/* 0x6b40, 0x7740, 0x10340, 0x10f40, 0x11b40, 0x12740 */
> -#define INT_MASK                                        0x1AD0
> -#       define VBLANK_INT_MASK                          (1 << 0)
> -#       define VLINE_INT_MASK                           (1 << 4)
> -
>  #define DISP_INTERRUPT_STATUS                           0x183D
>  #       define LB_D1_VLINE_INTERRUPT                    (1 << 2)
>  #       define LB_D1_VBLANK_INTERRUPT                   (1 << 3)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> index bd8085ec54ed..942098af5655 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> @@ -5242,6 +5242,8 @@
>  #define DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT 0x0000000c
>  #define DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE_MASK 0x00000003L
>  #define DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT 0x00000000
> +#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE_MASK 0x00000300L    // (((x) =
& 0x3) << 8)

You can drop the comment here.

> +#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT 0x00000008
>  #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE_MASK 0x00000030L
>  #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT 0x00000004
>  #define DENORM_CONTROL__DENORM_MODE_MASK 0x00000007L
> @@ -9554,7 +9556,7 @@
>  #define VGA_RENDER_CONTROL__VGA_LOCK_8DOT__SHIFT 0x00000018
>  #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL_MASK 0x0200=
0000L
>  #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL__SHIFT 0x00=
000019
> -#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L
> +#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L  // Intere=
stingly, it was flipped from 0xFFFCFFFF

Same here.

>  #define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL__SHIFT 0x00000010
>  #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RES=
ET_MASK 0x00000001L
>  #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RES=
ET__SHIFT 0x00000000
> --
> 2.48.1
>
