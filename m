Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C914AC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4463410E782;
	Wed,  6 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PeDGo5p4";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C2210E782
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:17:53 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24286ed452fso3144385ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754489873; x=1755094673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3LPY/81KXieUVYiFG3PY1qu1vLcGv0lEqSbz8J5vLI=;
 b=PeDGo5p4M78NE7AfkLyrLmwNkrrXOkvVBSvlkhqrNXpWlkRBtVcnVNME4DPDguoHt0
 +QGLgBVNR6VLFGyMZw3GQXH8Ii+qw6x1ktm5ff+s0ltbGVDFzzkrLFyHmWuBQTqZIQKB
 4EGa4q1uZ9kexSW+HXkctsoHgqYjoNKzks7rGNDl/qHpW9x8NkRt+ccWPqgIT1U4OF63
 UCZRS9VZl0B/OycHI4CaGditXcXVV9t+ZcO3a2camtMlcSzeSkYU9SGPaBjTttHFEb1o
 OrxFawHfAj/H0BNWygLE/wzpiJzbPRDMYYa6CTTgCX/UABYP+mt/7sNfxCnZMWeTViiH
 fx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754489873; x=1755094673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3LPY/81KXieUVYiFG3PY1qu1vLcGv0lEqSbz8J5vLI=;
 b=UGqyH16bblInq8SYZqknm1/9jTZnhfLauAXPuotaGxttC0gp4pMCmBuSdXpok32buB
 IdDhubjK9d7xNgMPOkb3g5eYjIffmMpxyR9zx3jLX0jHOrI5LPNEsOuelTeXL0sx8dIp
 gcjOcFissBQY0KZtzifPq0Kj8IhpVt3lns4UcOCpP4rbSVQ+DGnPVydz0gP64I4VhOYB
 rfYmWF/Dqqc6VBq87WaVh7+QeHsPqz8YoM6CBSh8XYcZQOwdMKbJedaYE80k4Yhggmqf
 hBj0T7Lo2NjvanKZzn4hwYn/wiawBGcY8p1+jn88gGQ/k4Kwa5MxAA0NBcryiOo6+e4z
 sh2g==
X-Gm-Message-State: AOJu0YyM3jPnbI6xzjpVU5IcG+iaXpoS9qlcjqDdJNamFpj4y4IIXQiW
 mBWRypArKgQT5yvTpVVy0mUQc9aNY/8xtDuFb81K8eyGLt6Jxme/+X/7WrGDa0cPHsZrHNzapRD
 VMx4d2vXBLoZ1a+qFWfyCto+7OZKRXXSW5w==
X-Gm-Gg: ASbGncvMURB54YrjS6LB12+lmmU8Q34xNjKhDn5pmpYMNA+oyZH+vJqJ0BRIRVERQ57
 VVxD1/ttfvf++wR/E3z99ItnE0ssye/UFiPFA2KrQw9SR6+zXm1EmCzEl2y6c3DotpJ1WNqyrux
 spuTKJpkm4bcwGTVlYBrRj84HmZ9n2sPvp1uPDyBVcrRMaRU5gSfjA7nlCFSKXGtTcZKjB2e8+X
 BBzARVr
X-Google-Smtp-Source: AGHT+IEN8SEaZvlVUbHBJqpO/+smtaHmp/81y33jQCaqZcY6BwNdZq6aCdw91kNZLRtdwnkm5npEeUOoLN8Pt1Xl3AU=
X-Received: by 2002:a17:902:d484:b0:240:b417:e197 with SMTP id
 d9443c01a7336-2429f2e1570mr25178115ad.2.1754489872659; Wed, 06 Aug 2025
 07:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250730155900.22657-1-alexander.deucher@amd.com>
 <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
In-Reply-To: <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Aug 2025 10:17:40 -0400
X-Gm-Features: Ac12FXzHrf7AS93DJl29_XDnXeiA8pOhM6VT7nJdi1YZ2A4BfrCtHMyxcEo3Lmk
Message-ID: <CADnq5_M-CoMUr6dQbOMQLa6Td0i1m6UoUayEWZz8qofCj3d4zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

Ping again?  This fixes a regression.

Alex

On Mon, Aug 4, 2025 at 10:16=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> Alex
>
> On Wed, Jul 30, 2025 at 12:18=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > We only need the fw based discovery table for sysfs.  No
> > need to parse it.  Additionally parsing some of the board
> > specific tables may result in incorrect data on some boards.
> > just load the binary and don't parse it on those boards.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> > Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip =
discovery")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
> >  2 files changed, 41 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index efe98ffb679a4..b2538cff222ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct=
 amdgpu_device *adev)
> >
> >         adev->firmware.gpu_info_fw =3D NULL;
> >
> > -       if (adev->mman.discovery_bin)
> > -               return 0;
> > -
> >         switch (adev->asic_type) {
> >         default:
> >                 return 0;
> > @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct=
 amdgpu_device *adev)
> >                 chip_name =3D "arcturus";
> >                 break;
> >         case CHIP_NAVI12:
> > +               if (adev->mman.discovery_bin)
> > +                       return 0;
> >                 chip_name =3D "navi12";
> >                 break;
> >         }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 81b3443c8d7f4..27bd7659961e8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgp=
u_device *adev)
> >
> >         switch (adev->asic_type) {
> >         case CHIP_VEGA10:
> > -       case CHIP_VEGA12:
> > -       case CHIP_RAVEN:
> > -       case CHIP_VEGA20:
> > -       case CHIP_ARCTURUS:
> > -       case CHIP_ALDEBARAN:
> > -               /* this is not fatal.  We have a fallback below
> > -                * if the new firmwares are not present. some of
> > -                * this will be overridden below to keep things
> > -                * consistent with the current behavior.
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> >                  */
> > -               r =3D amdgpu_discovery_reg_base_init(adev);
> > -               if (!r) {
> > -                       amdgpu_discovery_harvest_ip(adev);
> > -                       amdgpu_discovery_get_gfx_info(adev);
> > -                       amdgpu_discovery_get_mall_info(adev);
> > -                       amdgpu_discovery_get_vcn_info(adev);
> > -               }
> > -               break;
> > -       default:
> > -               r =3D amdgpu_discovery_reg_base_init(adev);
> > -               if (r) {
> > -                       drm_err(&adev->ddev, "discovery failed: %d\n", =
r);
> > -                       return r;
> > -               }
> > -
> > -               amdgpu_discovery_harvest_ip(adev);
> > -               amdgpu_discovery_get_gfx_info(adev);
> > -               amdgpu_discovery_get_mall_info(adev);
> > -               amdgpu_discovery_get_vcn_info(adev);
> > -               break;
> > -       }
> > -
> > -       switch (adev->asic_type) {
> > -       case CHIP_VEGA10:
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 4;
> > @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 0)=
;
> >                 break;
> >         case CHIP_VEGA12:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 4;
> > @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 1)=
;
> >                 break;
> >         case CHIP_RAVEN:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 1;
> >                 adev->vcn.num_vcn_inst =3D 1;
> > @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 }
> >                 break;
> >         case CHIP_VEGA20:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega20_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 8;
> > @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 1, 0)=
;
> >                 break;
> >         case CHIP_ARCTURUS:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 arct_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 8;
> >                 adev->vcn.num_vcn_inst =3D 2;
> > @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[UVD_HWIP][1] =3D IP_VERSION(2, 5, 0);
> >                 break;
> >         case CHIP_ALDEBARAN:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 aldebaran_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 5;
> >                 adev->vcn.num_vcn_inst =3D 2;
> > @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0)=
;
> >                 break;
> >         default:
> > +               r =3D amdgpu_discovery_reg_base_init(adev);
> > +               if (r) {
> > +                       drm_err(&adev->ddev, "discovery failed: %d\n", =
r);
> > +                       return r;
> > +               }
> > +
> > +               amdgpu_discovery_harvest_ip(adev);
> > +               amdgpu_discovery_get_gfx_info(adev);
> > +               amdgpu_discovery_get_mall_info(adev);
> > +               amdgpu_discovery_get_vcn_info(adev);
> >                 break;
> >         }
> >
> > --
> > 2.50.1
> >
