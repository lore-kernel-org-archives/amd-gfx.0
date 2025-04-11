Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC76C369A9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3491010EBA0;
	Fri, 11 Apr 2025 12:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWKHMnek";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3257010EB9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:52:59 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301a6347494so315782a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744375979; x=1744980779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT9xXNn7PePvrkHgG0pmncA+6zYeFJ/eSdx6rw/AVUY=;
 b=UWKHMnekwdHez+PAMkkVnzJ8ob3er2YZZdvolDA7/eDSWzMU6p2IE7bcWhqtT78XO8
 8sx5yvvkKQ5w32Hm6tsKbplJD/x1pX7vcumBQbKwpV1kQly7F56FupAISRiX22KTuPvY
 6KJYRmM8VxiCzK9xQaOhXWIbU2BsM2bqshQXMrJFRURNl9/ejPZAd3f/DE2YyW7ymL4W
 /OjXufSKhA+aopL9mNwA8s/Ml/nHi4XRiwLeFIOgZt/1vBk/Y1I8sCjK5IjgAXGcaLnB
 fOzzgJIsFreGiAhDzuqJ+2GMwk9+Wrv7/tbQV7FulPKdScZ8xwa0hP4O3aiXKAJFYTw2
 L9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375979; x=1744980779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HT9xXNn7PePvrkHgG0pmncA+6zYeFJ/eSdx6rw/AVUY=;
 b=cpmvp971c/sAILyW3f2Dg4FVTS4X7Vl2+5NquJNm+GFAe0sK3RCxLgi9pTh314S1fu
 tl5HbkHG5RPjyT8rYLdi0fIVdZwtTnb2hnWpcULYSSC11epvt9vEONPfnIVXtVZ0JiRr
 IakyfDSd8l0qud+1YhwaVoeWZTsxWNtBYNafrHoxAHyKnGhRUrlTOTfrY2Zout9C+dcw
 AbJZCouat3R9bpZ45n2yjecks7mT229rw2tIUFIbcO3C4MDQV7rV5WNsuZgHaXxoPTZQ
 YAMC2dZiwBfLBUsN6E1u0FUJW19/Q4GVcAw8bcol0rej2EzSCEhE9PrS/BjDWqTrcjg5
 Nnbw==
X-Gm-Message-State: AOJu0YwyAEa8pRgkPL23zzeAxlzlr4vzkXzKN73WHesrK++gWg/25R3r
 LYfvyDmKm6L3628OetsFOJAnF+/fhyRK+VxRZz4+9mAnYeHwNNNt5PAfR9GBoxthGDqBNWPLIEc
 IgxGZZVNmAiGYqbb+HoY2yR/jZhk=
X-Gm-Gg: ASbGncthl4fhzSm5zKAhYh7Wbb0ZIi3kneWvVy0ZeyqdBp0UkU7+weDaGDdM3CkCSkO
 I67LsPMnszYCRs0FWcMNEa9Sk2gLqE9UuJV2KFzuqM2ber4+ktosMkd/mVJ65A/Wv15wNoqUCaf
 vFJjljFTvKTqQVV14QYTWRVQ==
X-Google-Smtp-Source: AGHT+IF+o0ie7SyzW9I3Vgm8TgAGXxam4BVYIh26p4jxKK1IGdRwvV0UPZLzVkCZ1cGoR+dAw0BIlv+0azk5+9IiJao=
X-Received: by 2002:a17:90b:3845:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3082354e1ccmr1465014a91.0.1744375979118; Fri, 11 Apr 2025
 05:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250411121524.589317-1-lijo.lazar@amd.com>
In-Reply-To: <20250411121524.589317-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 08:52:47 -0400
X-Gm-Features: ATxdqUGrfcfD8KRvRsxGQ2TeN9H8_U83jY7auTT6CsyHhL3VOyU7JyksmBx2C0Y
Message-ID: <CADnq5_Pg3GQhQPAusPP_dDiFQArhvp2=PEzXGfELEmbdRh9=VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use generic hdp flush function
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Apr 11, 2025 at 8:42=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Except HDP v5.2 all use a common logic for HDP flush. Use a generic
> function. HDP v5.2 forces NO_KIQ logic, revisit it later.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 +------------
>  drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 +------------
>  drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 +------------
>  drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 +------------
>  6 files changed, 27 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.c
> index b6cf801939aa..7fd8f09c28e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -22,6 +22,7 @@
>   */
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
> +#include <uapi/linux/kfd_ioctl.h>
>
>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>  {
> @@ -46,3 +47,23 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>         /* hdp ras follows amdgpu_ras_block_late_init_default for late in=
it */
>         return 0;
>  }
> +
> +void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> +                             struct amdgpu_ring *ring)
> +{
> +       if (!ring || !ring->funcs->emit_wreg) {
> +               WREG32((adev->rmmio_remap.reg_offset +
> +                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> +                              2,
> +                      0);
> +               RREG32((adev->rmmio_remap.reg_offset +
> +                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> +                      2);
> +       } else {
> +               amdgpu_ring_emit_wreg(ring,
> +                                     (adev->rmmio_remap.reg_offset +
> +                                      KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL)=
 >>
> +                                             2,
> +                                     0);
> +       }
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.h
> index 7b8a6152dc8d..4cfd932b7e91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -44,4 +44,6 @@ struct amdgpu_hdp {
>  };
>
>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
> +void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> +                             struct amdgpu_ring *ring);
>  #endif /* __AMDGPU_HDP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v4_0.c
> index f1dc13b3ab38..e6c0d86d3486 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -36,17 +36,6 @@
>  #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
>  #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
>
> -static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
> -                               struct amdgpu_ring *ring)
> -{
> -       if (!ring || !ring->funcs->emit_wreg) {
> -               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> -               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> -       } else {
> -               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -       }
> -}
> -
>  static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
>                                     struct amdgpu_ring *ring)
>  {
> @@ -180,7 +169,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  };
>
>  const struct amdgpu_hdp_funcs hdp_v4_0_funcs =3D {
> -       .flush_hdp =3D hdp_v4_0_flush_hdp,
> +       .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .invalidate_hdp =3D hdp_v4_0_invalidate_hdp,
>         .update_clock_gating =3D hdp_v4_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v4_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v5_0.c
> index 43195c079748..8bc001dc9f63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> @@ -27,17 +27,6 @@
>  #include "hdp/hdp_5_0_0_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> -static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
> -                               struct amdgpu_ring *ring)
> -{
> -       if (!ring || !ring->funcs->emit_wreg) {
> -               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> -               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> -       } else {
> -               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -       }
> -}
> -
>  static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
>                                     struct amdgpu_ring *ring)
>  {
> @@ -217,7 +206,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_dev=
ice *adev)
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v5_0_funcs =3D {
> -       .flush_hdp =3D hdp_v5_0_flush_hdp,
> +       .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .invalidate_hdp =3D hdp_v5_0_invalidate_hdp,
>         .update_clock_gating =3D hdp_v5_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v5_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v6_0.c
> index a88d25a06c29..ec20daf4272c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> @@ -30,17 +30,6 @@
>  #define regHDP_CLK_CNTL_V6_1   0xd5
>  #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
>
> -static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
> -                               struct amdgpu_ring *ring)
> -{
> -       if (!ring || !ring->funcs->emit_wreg) {
> -               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> -               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> -       } else {
> -               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -       }
> -}
> -
>  static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
>                                          bool enable)
>  {
> @@ -149,7 +138,7 @@ static void hdp_v6_0_get_clockgating_state(struct amd=
gpu_device *adev,
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v6_0_funcs =3D {
> -       .flush_hdp =3D hdp_v6_0_flush_hdp,
> +       .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .update_clock_gating =3D hdp_v6_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v6_0_get_clockgating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v7_0.c
> index 49f7eb4fbd11..ed1debc03507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> @@ -27,17 +27,6 @@
>  #include "hdp/hdp_7_0_0_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> -static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
> -                               struct amdgpu_ring *ring)
> -{
> -       if (!ring || !ring->funcs->emit_wreg) {
> -               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> -               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> -       } else {
> -               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -       }
> -}
> -
>  static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
>                                          bool enable)
>  {
> @@ -137,7 +126,7 @@ static void hdp_v7_0_get_clockgating_state(struct amd=
gpu_device *adev,
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v7_0_funcs =3D {
> -       .flush_hdp =3D hdp_v7_0_flush_hdp,
> +       .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .update_clock_gating =3D hdp_v7_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v7_0_get_clockgating_state,
>  };
> --
> 2.25.1
>
