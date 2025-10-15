Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D564CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D768310E813;
	Wed, 15 Oct 2025 14:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTw3r5lS";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA3510E2B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:48:53 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-27eda3a38ceso13359965ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760539733; x=1761144533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ocrgdlu130y1j7Gsegdwspu1faVvcrQmBexut2V9edw=;
 b=VTw3r5lSAsjfrfNbs/6bm4e/Hkn9DbaVCxqoDE1kHAerdzGVTUN16Mg9mfMvFNo+4e
 ZK6mI4ENnrWgBdZOGrWJ+khFO4D7losK14AX8ZB1YNCbaUJkIdgR7OI2rmGYL+W3+Iy9
 KZxtAKwDt1iPw+cFFC6+U/ce+4X06bGTNk3To3pM3KmCcplpwIGlWJRsJ6V7xOJc2yKp
 y5sg/4gmGw0Y+jMUFtzfleHgxT3Gs1IQ22N2Lbwt95tmQeovvHTPK2uDUVKn78zqsTIL
 WrzQ+Cghqg71X7skvTyUSyT+VJn6SbwkkIg/Nn4Rf+cBUIKNaAGP4hflJYr1MJ+Xjf2I
 JJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760539733; x=1761144533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ocrgdlu130y1j7Gsegdwspu1faVvcrQmBexut2V9edw=;
 b=AvuerevsgEogRxmd83XtbUDGsSvudFIVAoyll/6xTA6BFHrG17RXi9cD3Ol/KJvWcj
 8NDa8X0F9Je4pcg0v+iEKpG1E97tGHbcF7MbH24MXASG3u4Z0HhJaocCPTFnPP4RNCbt
 oJicB1ibKZsjch+s8iQ4EwOcLVBK2q207RQBxVS+y98w7AZA40E2cX+a9311w1VxwaF5
 xOrUuP7r7BFv2SlV/5LMlOjczgglH1ihEq+i0p3oievwPNtKeUlmttb0G1J04BJQJjG0
 sXcb3rUuM2uw76ymPbvCjwV58+ihq/IFKeYWDJy3M5fHWvMOW1TwD5Tx97xbeG3LYMkN
 teFw==
X-Gm-Message-State: AOJu0Yy1qwu+JMwh6YD4h4G4GsdE8zXo4QueX0ddTrEKOznRvYr2HoFI
 DxCgxwppnvuEMNlTi7iLv/oqEiD1FB14oPn8Ap8ewMsn1z+tMUtyG0HV3bpfvYLfXu9gm2IJKsq
 uRrup8sruXdCMsYDD94WjMs2/sjAnj8c=
X-Gm-Gg: ASbGncvbGpPPoLTXT/oNDZ5A92pO5NR3DKS933tXcfFtLTdkVvWKVudwAGyzTyBhgJ0
 V7q+IBk3CCMCOMs/bAh9IAXiJdQI8u2UdCB13XbrV0w5unQHMJhtAMiUzMJqn4t2NoUKvtj6kXW
 TuxVhClOZGcHT/ByX8bwGOp7nmRtiMiT7N7tmIaQbNYiWq8buhw/MqAZj/ALHOU60NBcsZCjvpD
 ZhSl+/K4W7HzW6jfK/lfJEZHw==
X-Google-Smtp-Source: AGHT+IFEOmbkw6qPtIcg0Y2tBmwQ467LBjfaPUfEKHsCXGxA2JZBaWk6p48QXuD288n9QcHdzuQnY9VBrg0d5stVTkE=
X-Received: by 2002:a17:902:f54b:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290273e1e23mr206099685ad.4.1760539733004; Wed, 15 Oct 2025
 07:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-4-yunru.pan@amd.com>
 <CADnq5_PKQYCBaOYpe-8CJdwwHb+3SMo12Sf+jivpiiBwbyNbOg@mail.gmail.com>
In-Reply-To: <CADnq5_PKQYCBaOYpe-8CJdwwHb+3SMo12Sf+jivpiiBwbyNbOg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 10:48:41 -0400
X-Gm-Features: AS18NWDoEv6GO_ALDufWrjBj1-wWcoeVAN6vRhBskilV-nNhG_gQsheYfAMHpCg
Message-ID: <CADnq5_N-qiZAu-ZUdN5uXUn7BgPzVPxm8tu1J5WHstgFcukYUw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com, Jeffrey.Chan@amd.com
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

On Wed, Oct 15, 2025 at 9:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Oct 14, 2025 at 4:21=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wro=
te:
> >
> > - During guest driver init, asa VFs receive PF msg to
> >         init dynamic critical region(v2), VFs reuse fw_vram_usage_*
> >          from ttm to store critical region tables in a 5MB chunk.
> >
> > Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 ++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
> >  3 files changed, 31 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > index c7d32fb216e4..636385c80f64 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > @@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struc=
t amdgpu_device *adev)
> >         u8 frev, crev;
> >         int usage_bytes =3D 0;
> >
> > -       if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &cre=
v, &data_offset)) {
> > -               if (frev =3D=3D 2 && crev =3D=3D 1) {
> > -                       fw_usage_v2_1 =3D
> > -                               (struct vram_usagebyfirmware_v2_1 *)(ct=
x->bios + data_offset);
> > -                       amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> > -                                       fw_usage_v2_1,
> > -                                       &usage_bytes);
> > -               } else if (frev >=3D 2 && crev >=3D 2) {
> > -                       fw_usage_v2_2 =3D
> > -                               (struct vram_usagebyfirmware_v2_2 *)(ct=
x->bios + data_offset);
> > -                       amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> > -                                       fw_usage_v2_2,
> > -                                       &usage_bytes);
> > +       /* Skip atomfirmware allocation for SRIOV VFs when dynamic crit=
 regn is enabled */
> > +       if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_=
enabled)) {
> > +               if (amdgpu_atom_parse_data_header(ctx, index, NULL, &fr=
ev, &crev, &data_offset)) {
>
> Do you need this check here?  Is vram_usagebyfirmware valid on V2
> systems?  If that table if not present on V2 systems, then you don't
> need to change anything here since amdgpu_atom_parse_data_header()
> will return an error.  Other than that, looks good to me.

Sorry, I missed your previous reply.  This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Alex
>
> > +                       if (frev =3D=3D 2 && crev =3D=3D 1) {
> > +                               fw_usage_v2_1 =3D
> > +                                       (struct vram_usagebyfirmware_v2=
_1 *)(ctx->bios + data_offset);
> > +                               amdgpu_atomfirmware_allocate_fb_v2_1(ad=
ev,
> > +                                               fw_usage_v2_1,
> > +                                               &usage_bytes);
> > +                       } else if (frev >=3D 2 && crev >=3D 2) {
> > +                               fw_usage_v2_2 =3D
> > +                                       (struct vram_usagebyfirmware_v2=
_2 *)(ctx->bios + data_offset);
> > +                               amdgpu_atomfirmware_allocate_fb_v2_2(ad=
ev,
> > +                                               fw_usage_v2_2,
> > +                                               &usage_bytes);
> > +                       }
> >                 }
> >         }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 96bd0185f936..b5148a33b6f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1944,19 +1944,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >                 return r;
> >
> >         /*
> > -        *The reserved vram for driver must be pinned to the specified
> > -        *place on the VRAM, so reserve it early.
> > +        * The reserved VRAM for the driver must be pinned to a specifi=
c
> > +        * location in VRAM, so reserve it early.
> >          */
> >         r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
> >         if (r)
> >                 return r;
> >
> >         /*
> > -        * only NAVI10 and onwards ASIC support for IP discovery.
> > -        * If IP discovery enabled, a block of memory should be
> > -        * reserved for IP discovey.
> > +        * only NAVI10 and later ASICs support IP discovery.
> > +        * If IP discovery is enabled, a block of memory should be
> > +        * reserved for it.
> >          */
> > -       if (adev->mman.discovery_bin) {
> > +       if (adev->mman.discovery_bin && !adev->virt.is_dynamic_crit_reg=
n_enabled) {
> >                 r =3D amdgpu_ttm_reserve_tmr(adev);
> >                 if (r)
> >                         return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
> > index 27235f3f3b81..820dab538164 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu=
_device *adev)
> >         adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].=
size_kb =3D
> >                 init_data_hdr->bad_page_size_in_kb;
> >
> > +       /* reserved memory starts from crit region base offset with the=
 size of 5MB */
> > +       adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit_regn.=
offset;
> > +       adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.size_kb =
<< 10;
> > +       dev_info(adev->dev,
> > +               "critical region v%d requested to reserve memory start =
at %08x with %d KB.\n",
> > +                       init_data_hdr->version,
> > +                       adev->mman.fw_vram_usage_start_offset,
> > +                       adev->mman.fw_vram_usage_size >> 10);
> > +
> >         adev->virt.is_dynamic_crit_regn_enabled =3D true;
> >
> >  out:
> > --
> > 2.34.1
> >
