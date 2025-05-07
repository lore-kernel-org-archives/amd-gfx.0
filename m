Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B32CC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCDF10E819;
	Wed,  7 May 2025 15:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bcnASS97";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E8010E819
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:14:03 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso4698a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 May 2025 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746630843; x=1747235643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNx8mDfn84ycdFUDDMV1mJFYIiodZ9G2qynP0EjxV04=;
 b=bcnASS97W7ir7ROk7ot258mQJkvuIUbXWyOUamAjrD8gHh6woWeHfYAWsf+53zAEfg
 lLwGn6MuFY8XP+h5rlNEQH0Pfq0oBVMQwIBYwwgP6mEVmlE1uKl4ZU1mKVjyh+kIxQH0
 ptT4n4W+nnYbu84wlVo8XhyYYzQOhOBDMMFsshIoI+E1oYMoQUnS9952m9bF4Fly0I3f
 VlKa13C7p3lHNgkRAn0A2zsZUZrJ3AQvWQW4OcBCvhK4ZF9P4+VBgu3fwmQHPleV+xD0
 Um+l+Ss6YYPwYE1TOUVSuZUyQ4E4RiTka5qimswN2+hT/0Mj6H6YAnL76cdDd5iKzPIE
 9+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630843; x=1747235643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNx8mDfn84ycdFUDDMV1mJFYIiodZ9G2qynP0EjxV04=;
 b=sWxg5IDSrUyrnFeLDULMaRexnXORNHU2F5CwEU8XSVqyejbp3M4gXLsLjkSKhh+Esv
 8cW3gCL9lMTVouqTaNUuEjCI3Z77fWSeyXCh6hMvqp8UQkPojtiZWLv2XD0OBtU572+z
 xj+pVuVuZ5SiHQFOzF/iFvMI/svTb2DSwock3EU1vLJCLdSJiG0uE/sEJn2vd26ex6jC
 16t9BF96UqRjpvuaYLg2fnzryma+RdYqOeCnHecTlfxmJpbNMG5SvqLLyjNxjmfOJx2Y
 dMR9BYLhe+fvtfJXOLzd45nZ+vkA5ByNATSSxbYcm7JgatbioDRvqn59tweB6yvzHFyA
 6k0g==
X-Gm-Message-State: AOJu0YzFxlwJzzA0ET2rbWGilCerqd3NcSP/HCsaMqOcsDyIUoTReNT5
 AmRg0zehYTCsQtVTbWtE8VF9vpY1q0rsksCmOzgtoZnzsSkUnleGDYoMc027o0Z7wF5CGNc76HT
 aCGXVdZHPg6K5AnG/zz5nNu3E1nQ=
X-Gm-Gg: ASbGnctV8gzAqCQu6ymWkkfLOvWMf8J0LmVtMzu/We46qyaXtrUJmy1aqd64TgNRUQT
 zM1lYEHv1LMBFhTurczTbqP+qGxAU3UJ5z5QQp2/54qcSfsk25jYOl96IA9smVUfIQ4os+foZFZ
 c5zECas/OVa+BMKtGpEcGjKw==
X-Google-Smtp-Source: AGHT+IFQgVajCaUYuCG7svwRGARyW/SKCrtLGj++aEZXyrZs4jcMhldj8ngU/HXmCoNt6cWvADjH31i71EtYC8CA8Bo=
X-Received: by 2002:a17:90b:3882:b0:30a:a51c:5f48 with SMTP id
 98e67ed59e1d1-30aac26b85fmr2042430a91.8.1746630842829; Wed, 07 May 2025
 08:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
 <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
In-Reply-To: <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 May 2025 11:13:51 -0400
X-Gm-Features: ATxdqUG2cTXq0fDb9WRSK0Vo19NMpRDQDGLKwdCX18DSVNpgvTXB9rsKDF068PE
Message-ID: <CADnq5_OmDfhxAJNbMcuHG+LfrHBVSw6EOfu1Jp7V_DWykuGchA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
To: Alex Deucher <alexander.deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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

Ping again on this series?

Alex

On Tue, May 6, 2025 at 11:17=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping on this series?  This fixes a regression.
>
> Alex
>
> On Mon, May 5, 2025 at 9:05=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.
> >
> > Revert this temporarily to make it easier to fix a regression
> > in the HDP handling.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
> >  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
> >  6 files changed, 48 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_hdp.c
> > index 7fd8f09c28e66..b6cf801939aa5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > @@ -22,7 +22,6 @@
> >   */
> >  #include "amdgpu.h"
> >  #include "amdgpu_ras.h"
> > -#include <uapi/linux/kfd_ioctl.h>
> >
> >  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
> >  {
> > @@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *ade=
v)
> >         /* hdp ras follows amdgpu_ras_block_late_init_default for late =
init */
> >         return 0;
> >  }
> > -
> > -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> > -                             struct amdgpu_ring *ring)
> > -{
> > -       if (!ring || !ring->funcs->emit_wreg) {
> > -               WREG32((adev->rmmio_remap.reg_offset +
> > -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> > -                              2,
> > -                      0);
> > -               RREG32((adev->rmmio_remap.reg_offset +
> > -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> > -                      2);
> > -       } else {
> > -               amdgpu_ring_emit_wreg(ring,
> > -                                     (adev->rmmio_remap.reg_offset +
> > -                                      KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNT=
L) >>
> > -                                             2,
> > -                                     0);
> > -       }
> > -}
> > \ No newline at end of file
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_hdp.h
> > index 4cfd932b7e91e..7b8a6152dc8d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> > @@ -44,6 +44,4 @@ struct amdgpu_hdp {
> >  };
> >
> >  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
> > -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> > -                             struct amdgpu_ring *ring);
> >  #endif /* __AMDGPU_HDP_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/am=
d/amdgpu/hdp_v4_0.c
> > index e6c0d86d34865..f1dc13b3ab38e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > @@ -36,6 +36,17 @@
> >  #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
> >  #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
> >
> > +static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
> > +                               struct amdgpu_ring *ring)
> > +{
> > +       if (!ring || !ring->funcs->emit_wreg) {
> > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2, 0);
> > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2);
> > +       } else {
> > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offs=
et + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > +       }
> > +}
> > +
> >  static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
> >                                     struct amdgpu_ring *ring)
> >  {
> > @@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
> >  };
> >
> >  const struct amdgpu_hdp_funcs hdp_v4_0_funcs =3D {
> > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > +       .flush_hdp =3D hdp_v4_0_flush_hdp,
> >         .invalidate_hdp =3D hdp_v4_0_invalidate_hdp,
> >         .update_clock_gating =3D hdp_v4_0_update_clock_gating,
> >         .get_clock_gating_state =3D hdp_v4_0_get_clockgating_state,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/am=
d/amdgpu/hdp_v5_0.c
> > index 8bc001dc9f631..43195c0797480 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> > @@ -27,6 +27,17 @@
> >  #include "hdp/hdp_5_0_0_sh_mask.h"
> >  #include <uapi/linux/kfd_ioctl.h>
> >
> > +static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
> > +                               struct amdgpu_ring *ring)
> > +{
> > +       if (!ring || !ring->funcs->emit_wreg) {
> > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2, 0);
> > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2);
> > +       } else {
> > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offs=
et + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > +       }
> > +}
> > +
> >  static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
> >                                     struct amdgpu_ring *ring)
> >  {
> > @@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_d=
evice *adev)
> >  }
> >
> >  const struct amdgpu_hdp_funcs hdp_v5_0_funcs =3D {
> > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > +       .flush_hdp =3D hdp_v5_0_flush_hdp,
> >         .invalidate_hdp =3D hdp_v5_0_invalidate_hdp,
> >         .update_clock_gating =3D hdp_v5_0_update_clock_gating,
> >         .get_clock_gating_state =3D hdp_v5_0_get_clockgating_state,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/hdp_v6_0.c
> > index ec20daf4272c5..a88d25a06c29b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> > @@ -30,6 +30,17 @@
> >  #define regHDP_CLK_CNTL_V6_1   0xd5
> >  #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
> >
> > +static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
> > +                               struct amdgpu_ring *ring)
> > +{
> > +       if (!ring || !ring->funcs->emit_wreg) {
> > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2, 0);
> > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2);
> > +       } else {
> > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offs=
et + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > +       }
> > +}
> > +
> >  static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
> >                                          bool enable)
> >  {
> > @@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct a=
mdgpu_device *adev,
> >  }
> >
> >  const struct amdgpu_hdp_funcs hdp_v6_0_funcs =3D {
> > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > +       .flush_hdp =3D hdp_v6_0_flush_hdp,
> >         .update_clock_gating =3D hdp_v6_0_update_clock_gating,
> >         .get_clock_gating_state =3D hdp_v6_0_get_clockgating_state,
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/hdp_v7_0.c
> > index ed1debc035073..49f7eb4fbd117 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> > @@ -27,6 +27,17 @@
> >  #include "hdp/hdp_7_0_0_sh_mask.h"
> >  #include <uapi/linux/kfd_ioctl.h>
> >
> > +static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
> > +                               struct amdgpu_ring *ring)
> > +{
> > +       if (!ring || !ring->funcs->emit_wreg) {
> > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2, 0);
> > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_H=
DP_MEM_FLUSH_CNTL) >> 2);
> > +       } else {
> > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offs=
et + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > +       }
> > +}
> > +
> >  static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
> >                                          bool enable)
> >  {
> > @@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct a=
mdgpu_device *adev,
> >  }
> >
> >  const struct amdgpu_hdp_funcs hdp_v7_0_funcs =3D {
> > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > +       .flush_hdp =3D hdp_v7_0_flush_hdp,
> >         .update_clock_gating =3D hdp_v7_0_update_clock_gating,
> >         .get_clock_gating_state =3D hdp_v7_0_get_clockgating_state,
> >  };
> > --
> > 2.49.0
> >
