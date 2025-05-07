Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2014C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 16:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0F010E865;
	Wed,  7 May 2025 16:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5a7L765";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277FA10E875
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 16:49:23 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22e19c71070so155245ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 May 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746636562; x=1747241362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmEy4vNQ6YwP0dBEIlWSHmd4vn+vw5VbjHoUur+RcE8=;
 b=Q5a7L765ltNm5CY2+38TE0KJJ6ImqXJOg/6Y5wY00mz9aq0LYMtAflHhwLBcDD0YJv
 QFln2FlpZCH3RzKTFSXXXkzsnniu7lexqCO9Gx1G9qNeEqf36upqxNrmnOlrUTQi0tti
 vmTNDX5M9Hrc00vwng+tOAOeYf1pL8O34bOQQovUQ8bX2epUtSm2ImlYZQcg2AssD+Xy
 Xu/irCeAIiVypy9MLbhK2bFBzXrJ5rdvtIgUZqH+Fvc2Uuw6v4pr6zZUqhcj/1cjg1aE
 3Sf74wURsuO7xsQhkxKiGhdCMT9wneoFSDa3c1bCMJ0xCgjpQ/l23UyJvq9BFsRHOjij
 vERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746636562; x=1747241362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmEy4vNQ6YwP0dBEIlWSHmd4vn+vw5VbjHoUur+RcE8=;
 b=GCiNYudeiwW6ic8JImrX1t2M1VkjIaOAl9FeDHexgzt9rWqZrpkj+dLS0/BeBjOzKe
 dDMb4SnQL2gldn5MNyc3+WftuF1Z8hqnrXO54QctRoD5alAlbF59qqp0cn82J7eGBizW
 bLkkiuwL5tuK9XGIKTGgyG7JXoc2yQoMQjFy8pNQAuLS1e/mvMCA5VjB/4qtSXobi5Gw
 hnZruN2BLTJ6HZHrmRo9f4vzqM7DZavOslRzywrMIuwgs9D185SYg7bw3431zHmzsxdS
 Si4I2lqwWHRF8KBLCtVPk2M53N8+pELQLRIZypkQ0weatGUkoO79x+rUnmlAdBhwbrZd
 bSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmHnZOCjM8O1ok+k7gW50k8gVlLINX3DU1yCmjZUiU+JehkIqQIiV7J0WjJcGLm5PMeQWTdw0v@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJrIxD/jUpgqhXGsg59W62gINj5hG+0ssxOxXWMyTRH3kIHUJt
 +IyiBCYA14faj1J/EYhwkeBsd52cMnZyZ/e0WZ+Oi013af6dfMd0qE7c2Au1wJJrxJsNeL/D6pO
 2rfTcim7qwf5C/mQvpYv/AY400Tc=
X-Gm-Gg: ASbGncvMBUiYnoZqk6KfwCs2TvycRJAJgYhAxxPVbpIWGHfqjg15Q++y3CnLv6uJ8jU
 Bg1ToDq5Np8dYmTNZMG+gPKq/x1KfxzyiRmZajoOzuz8noUaSQZ+RwcZey3oQC6ptpGRTX7d8YG
 +VN1bdmD1G6jST4D2HRljWDw==
X-Google-Smtp-Source: AGHT+IFyh28HoxRLCh13kwGuIT95+/aHCVAQvxK+bl4LRTP8RC0KukdPE/HNDy/MdatzBr6xSIkm0v/NN8cVGd+EM24=
X-Received: by 2002:a17:902:cf01:b0:224:1212:7da1 with SMTP id
 d9443c01a7336-22e5eded414mr21124715ad.13.1746636562530; Wed, 07 May 2025
 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
 <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
 <CADnq5_OmDfhxAJNbMcuHG+LfrHBVSw6EOfu1Jp7V_DWykuGchA@mail.gmail.com>
 <DS0PR12MB78049ED4B0E64E0F5BF7EE6D9788A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB78049ED4B0E64E0F5BF7EE6D9788A@DS0PR12MB7804.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 May 2025 12:49:10 -0400
X-Gm-Features: ATxdqUG1oV3gpmzyNezfmvQO-Hd-z_228z2SRbMb6Xslw9je8xkzwKMhvakvrLA
Message-ID: <CADnq5_OcQ5TY7iVMLw5Ok+Dd+e2yNU53sBG3XjQ=sprEAwC6=Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, May 7, 2025 at 12:43=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.com> wr=
ote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> The flush reg is read/write. If the reads are not working on those platfo=
rms, I think the writes may be dropped silently.

The problem only happens when we remap the register to the unused MMIO
space.  In that case, we end up with a PCI AER when reading the
remapped register.  Seems to happen on x86 platforms as well.  Writes
don't seem to be a problem.

Alex

>
> Thanks,
> Lijo
> ________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, May 7, 2025 8:43:51 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Laz=
ar@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush functi=
on"
>
> Ping again on this series?
>
> Alex
>
> On Tue, May 6, 2025 at 11:17=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > Ping on this series?  This fixes a regression.
> >
> > Alex
> >
> > On Mon, May 5, 2025 at 9:05=E2=80=AFAM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> > >
> > > This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.
> > >
> > > Revert this temporarily to make it easier to fix a regression
> > > in the HDP handling.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
> > >  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
> > >  6 files changed, 48 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_hdp.c
> > > index 7fd8f09c28e66..b6cf801939aa5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > > @@ -22,7 +22,6 @@
> > >   */
> > >  #include "amdgpu.h"
> > >  #include "amdgpu_ras.h"
> > > -#include <uapi/linux/kfd_ioctl.h>
> > >
> > >  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
> > >  {
> > > @@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *a=
dev)
> > >         /* hdp ras follows amdgpu_ras_block_late_init_default for lat=
e init */
> > >         return 0;
> > >  }
> > > -
> > > -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> > > -                             struct amdgpu_ring *ring)
> > > -{
> > > -       if (!ring || !ring->funcs->emit_wreg) {
> > > -               WREG32((adev->rmmio_remap.reg_offset +
> > > -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> > > -                              2,
> > > -                      0);
> > > -               RREG32((adev->rmmio_remap.reg_offset +
> > > -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> > > -                      2);
> > > -       } else {
> > > -               amdgpu_ring_emit_wreg(ring,
> > > -                                     (adev->rmmio_remap.reg_offset +
> > > -                                      KFD_MMIO_REMAP_HDP_MEM_FLUSH_C=
NTL) >>
> > > -                                             2,
> > > -                                     0);
> > > -       }
> > > -}
> > > \ No newline at end of file
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_hdp.h
> > > index 4cfd932b7e91e..7b8a6152dc8d9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> > > @@ -44,6 +44,4 @@ struct amdgpu_hdp {
> > >  };
> > >
> > >  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
> > > -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> > > -                             struct amdgpu_ring *ring);
> > >  #endif /* __AMDGPU_HDP_H__ */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/=
amd/amdgpu/hdp_v4_0.c
> > > index e6c0d86d34865..f1dc13b3ab38e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > > @@ -36,6 +36,17 @@
> > >  #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
> > >  #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
> > >
> > > +static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
> > > +                               struct amdgpu_ring *ring)
> > > +{
> > > +       if (!ring || !ring->funcs->emit_wreg) {
> > > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2);
> > > +       } else {
> > > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_of=
fset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +       }
> > > +}
> > > +
> > >  static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
> > >                                     struct amdgpu_ring *ring)
> > >  {
> > > @@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
> > >  };
> > >
> > >  const struct amdgpu_hdp_funcs hdp_v4_0_funcs =3D {
> > > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > > +       .flush_hdp =3D hdp_v4_0_flush_hdp,
> > >         .invalidate_hdp =3D hdp_v4_0_invalidate_hdp,
> > >         .update_clock_gating =3D hdp_v4_0_update_clock_gating,
> > >         .get_clock_gating_state =3D hdp_v4_0_get_clockgating_state,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/=
amd/amdgpu/hdp_v5_0.c
> > > index 8bc001dc9f631..43195c0797480 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> > > @@ -27,6 +27,17 @@
> > >  #include "hdp/hdp_5_0_0_sh_mask.h"
> > >  #include <uapi/linux/kfd_ioctl.h>
> > >
> > > +static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
> > > +                               struct amdgpu_ring *ring)
> > > +{
> > > +       if (!ring || !ring->funcs->emit_wreg) {
> > > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2);
> > > +       } else {
> > > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_of=
fset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +       }
> > > +}
> > > +
> > >  static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
> > >                                     struct amdgpu_ring *ring)
> > >  {
> > > @@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu=
_device *adev)
> > >  }
> > >
> > >  const struct amdgpu_hdp_funcs hdp_v5_0_funcs =3D {
> > > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > > +       .flush_hdp =3D hdp_v5_0_flush_hdp,
> > >         .invalidate_hdp =3D hdp_v5_0_invalidate_hdp,
> > >         .update_clock_gating =3D hdp_v5_0_update_clock_gating,
> > >         .get_clock_gating_state =3D hdp_v5_0_get_clockgating_state,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/hdp_v6_0.c
> > > index ec20daf4272c5..a88d25a06c29b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> > > @@ -30,6 +30,17 @@
> > >  #define regHDP_CLK_CNTL_V6_1   0xd5
> > >  #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
> > >
> > > +static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
> > > +                               struct amdgpu_ring *ring)
> > > +{
> > > +       if (!ring || !ring->funcs->emit_wreg) {
> > > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2);
> > > +       } else {
> > > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_of=
fset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +       }
> > > +}
> > > +
> > >  static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
> > >                                          bool enable)
> > >  {
> > > @@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct=
 amdgpu_device *adev,
> > >  }
> > >
> > >  const struct amdgpu_hdp_funcs hdp_v6_0_funcs =3D {
> > > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > > +       .flush_hdp =3D hdp_v6_0_flush_hdp,
> > >         .update_clock_gating =3D hdp_v6_0_update_clock_gating,
> > >         .get_clock_gating_state =3D hdp_v6_0_get_clockgating_state,
> > >  };
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/=
amd/amdgpu/hdp_v7_0.c
> > > index ed1debc035073..49f7eb4fbd117 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> > > @@ -27,6 +27,17 @@
> > >  #include "hdp/hdp_7_0_0_sh_mask.h"
> > >  #include <uapi/linux/kfd_ioctl.h>
> > >
> > > +static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
> > > +                               struct amdgpu_ring *ring)
> > > +{
> > > +       if (!ring || !ring->funcs->emit_wreg) {
> > > +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP=
_HDP_MEM_FLUSH_CNTL) >> 2);
> > > +       } else {
> > > +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_of=
fset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > > +       }
> > > +}
> > > +
> > >  static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
> > >                                          bool enable)
> > >  {
> > > @@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct=
 amdgpu_device *adev,
> > >  }
> > >
> > >  const struct amdgpu_hdp_funcs hdp_v7_0_funcs =3D {
> > > -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> > > +       .flush_hdp =3D hdp_v7_0_flush_hdp,
> > >         .update_clock_gating =3D hdp_v7_0_update_clock_gating,
> > >         .get_clock_gating_state =3D hdp_v7_0_get_clockgating_state,
> > >  };
> > > --
> > > 2.49.0
> > >
