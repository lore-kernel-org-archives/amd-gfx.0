Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A341C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C78411288E;
	Wed, 24 Apr 2024 02:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDTwoZyr";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814A211288E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:35:04 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2a526803fccso4183942a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713926104; x=1714530904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGP1lKFHAb2FEWAKbOE0lth5Bwu42dX9dcgaWi844cQ=;
 b=VDTwoZyrjum9jyNc+x2NHkTVE/ALZI7FvDx3agJcuzTlMIIsjAMLGTwSb6t2ZxJYpT
 xfFGApUUag7cXEszGnjz4Wy3zDvuaOA7goO+nsaBrgmsEosESfcjk8usTVObmKwbf/X0
 075N7IFj9p4kU6/QxzLJFDYmJAbxav8MNeuMgg81HaYgvEOZto+cCfnrmxegsqlXxAVB
 vHRBuc5i4Hdnb15I9HIIuJ1qmkdDnKa7EHPr/6r8tD/0euSCpD8hHkGHc1A6lcOx9Jfj
 Tpi/uJxSrXyCGa48VGkxX4eVrHi3BVjRAG9yroZTJ6cDnJEpFbdqubMcHAgvtCR0Y8Az
 lx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713926104; x=1714530904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGP1lKFHAb2FEWAKbOE0lth5Bwu42dX9dcgaWi844cQ=;
 b=QOKSDwf/jbgJFgF4Nh5ADOK5ZkFC1p04Gkw8xelV0y54JNt96wW1D1Mrd/UAmIqCD1
 8WixT6MHh8qhjm/CJTlb65qAJNa4Hw5ZonMBdW4cnvGNf5gkOLgm+h3PiCs2Uv5Dwxq0
 eRMB97uJQO/B6q+G/c+Uhzq4wrEQ0+DOoN8viKy0/lfxRTYGzqEazDLwqGys3arvcztr
 iJo35NKMrYRKEfHjnwORY9edz8Hl7lJvGPyL2V+DuewREhW3agqZPL0D6I4VBrcOmnja
 aTOV0mNDgE1L+YggWDyub2xZRC4aHNSsIFTjhxRtKhJJD1p0l26aYWK3tgm/iEXkgDgk
 WyOA==
X-Gm-Message-State: AOJu0Ywo1xD0HVkBLG7eeI1nKS5XwK0PE/mqrNcz1DhePPgHaTLmF4xu
 J7ZXsc4H4vPszu7rZrgn5h+6EEJy0QV5VgQocP0c3xGCzsv/he7M4mfZPYHMsJLyuDPCQz7S4bV
 t+Pe4AIgdjyaOSa6XgMVZrgbgTTlEZQ==
X-Google-Smtp-Source: AGHT+IE5aU70rDu4lDFtOv8B4ix5cFFAGY2kdJau7oDqJCAvG9w/F/0Z/gjO9WCFzxmCj1kXPnxNmIztlDwRjkUW2Ws=
X-Received: by 2002:a17:90b:4c04:b0:2a2:3252:cb83 with SMTP id
 na4-20020a17090b4c0400b002a23252cb83mr1113181pjb.38.1713926103881; Tue, 23
 Apr 2024 19:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240424011940.723906-1-jesse.zhang@amd.com>
 <CADnq5_MZeCg3dUnkCmKXu-m1Kp01yR0h1uz2htKoWaQdbj-+_A@mail.gmail.com>
 <DM4PR12MB5152BC1A6ECE3A5F86B55667E3102@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_Pw+-jhwOMt0346aE6SFK=Wg6N=cFYGkYcFU7vx_nnkow@mail.gmail.com>
In-Reply-To: <CADnq5_Pw+-jhwOMt0346aE6SFK=Wg6N=cFYGkYcFU7vx_nnkow@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 22:34:52 -0400
Message-ID: <CADnq5_MQ3FgAmoJvHyWaTdFGMV2RpD6dEpUoJr-j1bgegh5z4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
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

Fix Leo's address.

On Tue, Apr 23, 2024 at 10:33=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Apr 23, 2024 at 10:04=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@a=
md.com> wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hi Alex,
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, April 24, 2024 9:46 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deuche=
r@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Huang, Tim <Tim.H=
uang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
> >
> > On Tue, Apr 23, 2024 at 9:27=E2=80=AFPM Jesse Zhang <jesse.zhang@amd.co=
m> wrote:
> > >
> > > Fix some variables not initialized before use.
> > > Scan them out using Synopsys tools.
> > >
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
> > >  drivers/gpu/drm/amd/amdgpu/atom.c       | 1 +
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 3 ++-
> > > drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 3 ++-
> > > drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 3 ++-
> >
> > Please split out the SDMA changes into a separate patch.
> >
> > More comments below on the other hunks.
> >
> > >  6 files changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > index 59acf424a078..60d97cd14855 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > @@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_par=
ser *p,
> > >         uint32_t destroyed =3D 0;
> > >         uint32_t created =3D 0;
> > >         uint32_t allocated =3D 0;
> > > -       uint32_t tmp, handle =3D 0;
> > > +       uint32_t tmp =3D 0, handle =3D 0;
> >
> > Can you elaborate on what the issue is here?  Presumably it's warning a=
bout size being passed as a parameter in the function?
> > [Zhang, Jesse(Jie)]  Using uninitialized value *size when calling amdgp=
u_vce_cs_reloc for case 0x03000001. Because uint32_t *size =3D &tmp;
> >                 I'm not sure if other commands initialize the size befo=
re running case 0x03000001.
>
> Yeah, I don't really see a cleaner way to handle this.  Maybe Leo has
> a better idea?
>
> Alex
>
> >
> > >         uint32_t *size =3D &tmp;
> > >         unsigned int idx;
> > >         int i, r =3D 0;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > index 677eb141554e..13125ddd5e86 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > @@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct =
work_struct *work)
> > >                         else
> > >                                 new_state.fw_based =3D
> > > VCN_DPG_STATE__UNPAUSE;
> > >
> > > +                       if (amdgpu_fence_count_emitted(adev->jpeg.ins=
t->ring_dec))
> > > +                               new_state.jpeg =3D VCN_DPG_STATE__PAU=
SE;
> > > +                       else
> > > +                               new_state.jpeg =3D
> > > + VCN_DPG_STATE__UNPAUSE;
> > > +
> > >                         adev->vcn.pause_dpg_mode(adev, j, &new_state)=
;
> > >                 }
> > >
> >
> > This should be a separate patch as well.
> >  Thanks for your reminder, Alex, I will.
> >
> >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> > > b/drivers/gpu/drm/amd/amdgpu/atom.c
> > > index 72362df352f6..d552e013354c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > > @@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(str=
uct atom_context *ctx, int index,
> > >         ectx.ps_size =3D params_size;
> > >         ectx.abort =3D false;
> > >         ectx.last_jump =3D 0;
> > > +       ectx.last_jump_jiffies =3D 0;
> > >         if (ws) {
> > >                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
> > >                 ectx.ws_size =3D ws;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > index 45a2d0a5a2d7..b7d33d78bce0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > @@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu=
_ring *ring)
> > >         r =3D amdgpu_ring_alloc(ring, 20);
> > >         if (r) {
> > >                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n=
", ring->idx, r);
> > > -               amdgpu_device_wb_free(adev, index);
> > > +               if (!ring->is_mes_queue)
> > > +                       amdgpu_device_wb_free(adev, index);
> > >                 return r;
> > >         }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > index 43e64b2da575..cc9e961f0078 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu=
_ring *ring)
> > >         r =3D amdgpu_ring_alloc(ring, 20);
> > >         if (r) {
> > >                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n=
", ring->idx, r);
> > > -               amdgpu_device_wb_free(adev, index);
> > > +               if (!ring->is_mes_queue)
> > > +                       amdgpu_device_wb_free(adev, index);
> > >                 return r;
> > >         }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > index 1f4877195213..c833b6b8373b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > @@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu=
_ring *ring)
> > >         r =3D amdgpu_ring_alloc(ring, 5);
> > >         if (r) {
> > >                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n=
", ring->idx, r);
> > > -               amdgpu_device_wb_free(adev, index);
> > > +               if (!ring->is_mes_queue)
> > > +                       amdgpu_device_wb_free(adev, index);
> > >                 return r;
> > >         }
> > >
> > > --
> > > 2.25.1
> > >
