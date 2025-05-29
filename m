Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F458C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 13:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C04810E103;
	Thu, 29 May 2025 13:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgElWYVO";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFE710E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 13:13:57 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-234eaea2e4eso1111615ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748524437; x=1749129237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jEv+mQ0WOOfmKvTEOwZ2hdYC8JrK8vgAJJDGX4y/oU=;
 b=CgElWYVOTSjGmCbQq7bNIBxIDtmnHhacNT8Np1rzq4bEI3ifojMbWcsGs1EFMjcIvp
 Z3CeNSQtK93p7b6PDvCljd5EkWJs3xBHhvQbZf0lK5q+rOtJmNOijWFIGinOMQWszuSg
 IPxKISwniRsZ1I0QNzC5/txgr9iwABsmq5WusdWIxsh0JAqKw6Zv7BBQKJsklPUOJDpo
 /l/N1yXvFNe9dKLlbVcJUofQfJ+IApQTG9EKo6e1S50utK/DtiabBp7WYCeagVIZph8b
 4eyR+ztZWQ1b2FpK/6HeKyukAMCUjcFGooExS+rDH/N6szc0nR+uC+S2cYeQqMRDXkXl
 UG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748524437; x=1749129237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jEv+mQ0WOOfmKvTEOwZ2hdYC8JrK8vgAJJDGX4y/oU=;
 b=Da0DBhe9mYCTxidExzwgbUIKSrqAbAi7qi2OrfN+PR2xGFPBReVmfnUB6MYPXw4u1T
 ms6sUosLbMP+VO3LyBGaKtE/Jj2VgtlxIxoX0pa3VML3REtgDRhfC+CRPLlclp82J5zq
 Eir5FQdKeP5zOF2r9N7n532pqoORsninF9gdXiItL1MjC6N3mzW6wHEfGDb6x7al8K5w
 ytD0qPhgWKu9svkW/YMKUz98MjUjZFwtRAz/NuWIzF4VtJyhUXWiBLz9x3upI5OvPgLe
 WF5LQw28+ZXlKW9LPl8eiWYjne/byx1uNrl/lDCo0Y0eEsVMkjmCqZUCq4pf7ZebqYcR
 1r+A==
X-Gm-Message-State: AOJu0YyarDwwNPGiZhmM6DKDXkAa0g+0IWAcnwXO+4J/011IYVkulklQ
 Wi8VRUMt4iFPskXh5+z3scH+Z0h7+TUD84Gma7ykQqr296Vnd0ItJGDE3UWILuHv8XQu+7kQZkZ
 IqH8zkKzMY7eYQRSytRwT/NpavnxhEMU=
X-Gm-Gg: ASbGncsK24fRRj7hS3cwUUDN8+ATrZ4X+vWEGwX5OjsfywwbO8TX36aWgmWXQ6w+vcZ
 sGJBlYxBsYM/soBqF0z0EIasoWkEiP7Xo0j/4Jp8p83HfWDD920nFmY/dZCfnJO/rkPvxn3VGQu
 atELZr7nFdycOpP74s14tH/PlvwO/kKsr/ag==
X-Google-Smtp-Source: AGHT+IGuYLWiQXRHT7NrUJ2Y7a7pywxRgVHwVz7IJpGQrDShIWz1EaZhmu7vEXIlPcFoKEBSXei/Uv4Jehv+cEf5U1w=
X-Received: by 2002:a17:903:228f:b0:234:d14c:50ff with SMTP id
 d9443c01a7336-234d14c5265mr37391825ad.6.1748524436754; Thu, 29 May 2025
 06:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250528083756.847677-1-Prike.Liang@amd.com>
 <CADnq5_MRsoGeKDhNHuKZbAbjRM9WNAc20q_T60y8kN1biBL0Lg@mail.gmail.com>
 <DS7PR12MB6005CC481C03A04628CD56CFFB66A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005CC481C03A04628CD56CFFB66A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 May 2025 09:13:45 -0400
X-Gm-Features: AX0GCFsN_nk1Qk_Qg8RhKrrU91XxZHt-I0J6j9Zf22_Mqxe4s71jD59WXyP6qGA
Message-ID: <CADnq5_OgcCiJGPFEymQC4+JAvYxAc5j9DfKNV6zYU=zBDReN4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Wed, May 28, 2025 at 10:05=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, May 28, 2025 9:11 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa fo=
r enabling
> > kq|uq
> >
> > On Wed, May 28, 2025 at 4:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > The kernel driver only requires exporting available rings to the mesa
> > > when the userq is disabled; otherwise, the userq IP mask will be
> > > cleaned up in the mesa.
> >
> > The logic should work correctly as is.  There are three possible states=
:
> > 1. KQ only
> > 2. Both KQ and UQ
> > 3. UQ only
>
> Yeah, but when the kernel driver tries to enable KQ and UQ at the same ti=
me by setting user_queue=3D1,while kernel driver will report available ring=
s to Mesa, and Mesa will further clean up the userq mask, which makes user =
queue enablement fail. Without this change, the userq can only be enabled s=
uccessfully separate from the kernel queue.
>

That needs to be fixed in mesa.  I thought mesa defaulted to KQs if
both were enabled, but you could test UQ with an env var.  Also, UQs
can be enabled independently for each engine type so each engine type
can set no_user_submission independently if it wants to not advertise
KQs.

Alex

> Thaks,
> Prike
>
> > Alex
> >
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index d2ce7d86dbc8..43d86c09d8bb 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -409,7 +409,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> > >                 type =3D AMD_IP_BLOCK_TYPE_GFX;
> > >                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> > >                         if (adev->gfx.gfx_ring[i].sched.ready &&
> > > -                           !adev->gfx.gfx_ring[i].no_user_submission=
)
> > > +                           adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 ib_start_alignment =3D 32;
> > >                 ib_size_alignment =3D 32; @@ -418,7 +418,7 @@ static =
int
> > > amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                 type =3D AMD_IP_BLOCK_TYPE_GFX;
> > >                 for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > >                         if (adev->gfx.compute_ring[i].sched.ready &&
> > > -                           !adev->gfx.compute_ring[i].no_user_submis=
sion)
> > > +                           adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 ib_start_alignment =3D 32;
> > >                 ib_size_alignment =3D 32; @@ -427,7 +427,7 @@ static =
int
> > > amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                 type =3D AMD_IP_BLOCK_TYPE_SDMA;
> > >                 for (i =3D 0; i < adev->sdma.num_instances; i++)
> > >                         if (adev->sdma.instance[i].ring.sched.ready &=
&
> > > -                           !adev->sdma.instance[i].ring.no_user_subm=
ission)
> > > +                               adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 ib_start_alignment =3D 256;
> > >                 ib_size_alignment =3D 4; @@ -439,7 +439,7 @@ static i=
nt
> > > amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                                 continue;
> > >
> > >                         if (adev->uvd.inst[i].ring.sched.ready &&
> > > -                           !adev->uvd.inst[i].ring.no_user_submissio=
n)
> > > +                           adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 }
> > >                 ib_start_alignment =3D 256; @@ -449,7 +449,7 @@ stati=
c
> > > int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                 type =3D AMD_IP_BLOCK_TYPE_VCE;
> > >                 for (i =3D 0; i < adev->vce.num_rings; i++)
> > >                         if (adev->vce.ring[i].sched.ready &&
> > > -                           !adev->vce.ring[i].no_user_submission)
> > > +                           adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 ib_start_alignment =3D 256;
> > >                 ib_size_alignment =3D 4; @@ -462,7 +462,7 @@ static i=
nt
> > > amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >
> > >                         for (j =3D 0; j < adev->uvd.num_enc_rings; j+=
+)
> > >                                 if (adev->uvd.inst[i].ring_enc[j].sch=
ed.ready &&
> > > -                                   !adev->uvd.inst[i].ring_enc[j].no=
_user_submission)
> > > +                                   adev->gfx.disable_uq)
> > >                                         ++num_rings;
> > >                 }
> > >                 ib_start_alignment =3D 256; @@ -475,7 +475,7 @@ stati=
c
> > > int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                                 continue;
> > >
> > >                         if (adev->vcn.inst[i].ring_dec.sched.ready &&
> > > -                           !adev->vcn.inst[i].ring_dec.no_user_submi=
ssion)
> > > +                           adev->gfx.disable_uq)
> > >                                 ++num_rings;
> > >                 }
> > >                 ib_start_alignment =3D 256; @@ -489,7 +489,7 @@ stati=
c
> > > int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >
> > >                         for (j =3D 0; j < adev->vcn.inst[i].num_enc_r=
ings; j++)
> > >                                 if (adev->vcn.inst[i].ring_enc[j].sch=
ed.ready &&
> > > -                                   !adev->vcn.inst[i].ring_enc[j].no=
_user_submission)
> > > +                                   adev->gfx.disable_uq)
> > >                                         ++num_rings;
> > >                 }
> > >                 ib_start_alignment =3D 256; @@ -505,7 +505,7 @@ stati=
c
> > > int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >
> > >                         for (j =3D 0; j < adev->jpeg.num_jpeg_rings; =
j++)
> > >                                 if (adev->jpeg.inst[i].ring_dec[j].sc=
hed.ready &&
> > > -                                   !adev->jpeg.inst[i].ring_dec[j].n=
o_user_submission)
> > > +                                   adev->gfx.disable_uq)
> > >                                         ++num_rings;
> > >                 }
> > >                 ib_start_alignment =3D 256; @@ -514,7 +514,7 @@ stati=
c
> > > int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >         case AMDGPU_HW_IP_VPE:
> > >                 type =3D AMD_IP_BLOCK_TYPE_VPE;
> > >                 if (adev->vpe.ring.sched.ready &&
> > > -                   !adev->vpe.ring.no_user_submission)
> > > +                   adev->gfx.disable_uq)
> > >                         ++num_rings;
> > >                 ib_start_alignment =3D 256;
> > >                 ib_size_alignment =3D 4;
> > > --
> > > 2.34.1
> > >
