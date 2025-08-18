Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3109CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3729D10E040;
	Mon, 18 Aug 2025 20:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SlPnKteL";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E531E10E4D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:30:41 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2447d607b70so2059635ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755549041; x=1756153841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FckRCdVl7RmnLtWNbL6m7HxXEcP96GnHXwtS86ccuU=;
 b=SlPnKteLMGxcoVxxp5vrhSSwSOwmkwqIMXrljftO/81ErYt+ddURyt2jwk30tP/fGn
 Fh0dZOEnBM7EEg/24x1YJ5XYQVtIfExPQ5nYudgRZzAlXt9Yjdt5bBmurxD5xxWrfYfa
 OVPPofK4zzab2JJx3VJiWvohEcH7iGt0eLFmu9hFVImP2G+CdaHqwbyAT7L3NuCgxkjj
 70q+Y5RpOBVBH8eoLTf6/5sT+pbTCf31vX8mxay8FwRzRBvOUMvaMudw/oQ6iAIy4e4r
 UZy5cFRbmQsCUGKsnANYaxW8xZ/5wfrAdc7SeudYheS+Zl8S8b+t3T5XWB8wrk4wzKJe
 ix9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755549041; x=1756153841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FckRCdVl7RmnLtWNbL6m7HxXEcP96GnHXwtS86ccuU=;
 b=t4aEdiG7kPvUuyLUdlwHrsfCjdXDnVC2NuD3dvhWJd4rUnbsOIaFNWRhOQbjYbJ0ex
 9QpeUtLaZHaVXNG0P9EW64oe+QhjfYCC2HShqqai0A7kjdbFHzMHzWkScjyguAtXxJS5
 nNG13InkS+joUU4pQSHxO5kEKTmu8pahUknXsNmHdH+rMro7Xqg/kFGEzcyL86nIcnUj
 8rBWZzdq4yVXmmgHLlOzNBk63SN/ybIh2ORHJ6LoB8FZTkgvRCLchZ8pF755JMdNXdhV
 QqgPPZOUqIvrbuukh+MqVK8EBMXJ35/99CU9l55sdAzAekSmK1/ITWjSuxcGxiKggb48
 B6Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtMojuXswinNuBAUTLCC86lfV+otEReXWkmuQEe94Np9GjbBuysr2XZK71P1xiUTprkkxot+3v@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmUZPHUUsxkgSEBXtFSqfVMvdUghAOmYuNc6j74esJjKJjClsI
 HO18XZnN9CgLad88Q8Tqv1Y16afJ67BhpWX987aIMmtnBBVl+uUrJIq6AED8/E5Qtnk2k1SegGg
 uy4IWkLo3wtxnG1ZeJ+G+Jmz240ItGeE=
X-Gm-Gg: ASbGncv01o5krDiXqQAtMwzeefHHkJomb7haIBaHD/yDfFHbstWKt+Z9UfYNveZkGVl
 7OreZF6fcpPCB7kRI9Ujwa8FtsLQU5xeQF0VZevbBUiV1xrUoFafQavKAWltJEIeXE8O/HIqfjC
 7eQD0faOzXvDUAqGx2sUUiF8y2UQTj+Nk+XxpCUqtxk/zTZvtDVhsOdyR9q7exkhq4mqkS0l6Eu
 p2cCz8bkPXVbxejLA==
X-Google-Smtp-Source: AGHT+IE/BxGrJKHai8C3CitYiqIHDDUZ9YVRKC2JyXBzDEOowSZ9GqJVeCTvTRNQTNZ88mZ26HEZHxzBm/7os05YujU=
X-Received: by 2002:a17:903:1ca:b0:240:8fd6:f798 with SMTP id
 d9443c01a7336-2446d77773bmr85970975ad.4.1755549041089; Mon, 18 Aug 2025
 13:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
 <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
In-Reply-To: <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 16:30:29 -0400
X-Gm-Features: Ac12FXzVyUZ5iWyLduoo-jFdG5ll50UJDvlP1Kgx-DzeV6HTylikZ6uISpd1XiQ
Message-ID: <CADnq5_MnTaM4U+UgnpEmFf6i1eyavgh9XAT20BajxJ0S2t_7Gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
To: Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Aug 18, 2025 at 4:11=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrote=
:
>
>
>
> On 8/2/25 10:06, Timur Krist=C3=B3f wrote:
> > The VUPDATE interrupt isn't registered on DCE 6, so don't try
> > to use that.
> >
> > This fixes a page flip timeout after sleep/resume on DCE 6.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++------=
-
> >   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
> >   2 files changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 470f831a17f7..e8d2ba58cbfa 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts(struc=
t amdgpu_device *adev,
> >                               drm_warn(adev_to_drm(adev), "Failed to %s=
 pflip interrupts\n",
> >                                        enable ? "enable" : "disable");
> >
> > -                     if (enable) {
> > -                             if (amdgpu_dm_crtc_vrr_active(to_dm_crtc_=
state(acrtc->base.state)))
> > -                                     rc =3D amdgpu_dm_crtc_set_vupdate=
_irq(&acrtc->base, true);
> > -                     } else
> > -                             rc =3D amdgpu_dm_crtc_set_vupdate_irq(&ac=
rtc->base, false);
> > -
> > -                     if (rc)
> > -                             drm_warn(adev_to_drm(adev), "Failed to %s=
able vupdate interrupt\n", enable ? "en" : "dis");
> > +                     if (dc_supports_vrr(adev->dm.dc->ctx->dce_version=
)) {
> > +                             if (enable) {
> > +                                     if (amdgpu_dm_crtc_vrr_active(
> > +                                                     to_dm_crtc_state(=
acrtc->base.state)))
> > +                                             rc =3D amdgpu_dm_crtc_set=
_vupdate_irq(
> > +                                                     &acrtc->base, tru=
e);
> > +                             } else
> > +                                     rc =3D amdgpu_dm_crtc_set_vupdate=
_irq(
> > +                                                     &acrtc->base, fal=
se);
> > +
> > +                             if (rc)
> > +                                     drm_warn(adev_to_drm(adev), "Fail=
ed to %sable vupdate interrupt\n",
> > +                                             enable ? "en" : "dis");
> > +                     }
>
> Hi Timur,
>
> There seem to be conflicts to amd-staging-drm-next. Could you please
> rebase and resend? This helps make sure new change fix the problem you
> observed.
>
> Really appreciate it. Thanks.

If it's just the first patch, you can skip that one as the conflict
solves the issue with DSC.

Alex

>
> >
> >                       irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;
> >                       /* During gpu-reset we disable and then enable vb=
lank irq, so
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 2551823382f8..f2208e4224f9 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank(struc=
t drm_crtc *crtc, bool enable)
> >
> >       irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crt=
c_id);
> >
> > -     if (enable) {
> > -             /* vblank irq on -> Only need vupdate irq in vrr mode */
> > -             if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> > -                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, true)=
;
> > -     } else {
> > -             /* vblank irq off -> vupdate irq off */
> > -             rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> > +     if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > +             if (enable) {
> > +                     /* vblank irq on -> Only need vupdate irq in vrr =
mode */
> > +                     if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> > +                             rc =3D amdgpu_dm_crtc_set_vupdate_irq(crt=
c, true);
> > +             } else {
> > +                     /* vblank irq off -> vupdate irq off */
> > +                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false=
);
> > +             }
> >       }
> >
> >       if (rc)
>
