Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D88E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F5A10E131;
	Tue, 14 Jan 2025 14:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/n0tcRn";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7BE10E080
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 14:25:05 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2162b5d2e1fso10780165ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736864645; x=1737469445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmPGAYMaPtRO8z/x/zhTW0P4yreB2869l6HBfDXHWx8=;
 b=L/n0tcRneTUZrXGalXowxowELzqn+OLitpYJ5Gr3JoOG+qTDT3itXUsTh4TRyBhn0l
 y9G/c7OYUhDXbHgkGeuT3iKt2GXYNi6JkpTpYmykCGV7WUdGm/EEIC1nOsaTxzMFv9gH
 YCBDxif/j327AYBmONSs1UCRAvPKO1zhRDj6lLcaA7bhkxgnOZJUSNbDfEhMa8sa2f7y
 +GB53pXpRioEGha1yN50kfYxKKUOrtYsx88cWiMSM9QCR5Alq6v9gSCdJVf9eXsccHxP
 UwnMKQgm2tG5z8FsIWtVAfrZUcWZ2BOyFWLVf3Ksw/Z1AKmdu7Est3Rk3oXpTg6Mm4fi
 Q08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736864645; x=1737469445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmPGAYMaPtRO8z/x/zhTW0P4yreB2869l6HBfDXHWx8=;
 b=IybPiHZp6/9lpiAhzKt/xCkE/cSteZAdUQfnKWlINj5XCVhWj+6IO8alrhCxASFcuU
 3CXrcYdQrRsgygw7Qkcio3E5qI5SBrQwx2JGqsO1H0ukLl8k1crmubZ+z08iO9AbUwvI
 eRuazBbEaWjrY0bvqG7wpWbKX8t0ksxDWdFRvsdYXReYUsCvsoVr0LpY/xFnGy+uPz8o
 qIyjaKWsP5zRE6yTDoshenk2LhZW5I7hw2V292HC/gAe6X4u6CX08ntcD9fIphL4vHbe
 f2yAsM8ZOIey0t69BNn/YAwfipD6Y9gryhyOGsRNlRUq8s2Wu2+dlnLl2IFBS7ugIYTl
 tKmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUthM2wjlI+IpFae4HZrNAxE4oR0afJCCfgg7mv8qG5tX/RWd9wck+s39stOl++fTRk2R6pfrjr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxePBnMHFizYSUefr2Nt0mSYpdVukNsp1QCtJb2t6gPOqN1NNB1
 hXoOoyz3ohbpIQ79PNrT+rUoKh1M2ZFDOEPS52rrXl/VhR/i/lHth0Heh6oA9VbO+FrEH8nVQVN
 AZ/8xPCV2hLzi2fyOOeOMB1t58Lg=
X-Gm-Gg: ASbGncsHmJAY7ojDsz6uaBymx4Kuaw411rH3LJ61hsW1HiY5iWwjlQhDnXKzjuVjMgK
 rO8nhm/zrK9upaD0xAy9e4obTQdsf/cATr9Vw2Q==
X-Google-Smtp-Source: AGHT+IFAx4PIuocVV1k3/hRNVuxRCFzXiFA2GSiuh1YAbOzV3d9CHaMJQN7sVQc2SdvlkdJOJ5UnEhqXW3cA5z/q+E0=
X-Received: by 2002:a17:902:e74e:b0:215:7113:d82e with SMTP id
 d9443c01a7336-21a83f72ce7mr140150535ad.8.1736864643341; Tue, 14 Jan 2025
 06:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20250107161024.73371-1-alexander.deucher@amd.com>
 <CADnq5_OO=vUVNfDoQdMCJC1+MXNOv+X1RUtRyv57orhDQ0GJ_Q@mail.gmail.com>
 <PH7PR12MB5997EECCD8BF3616E2A75D4582182@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997EECCD8BF3616E2A75D4582182@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2025 09:23:51 -0500
X-Gm-Features: AbW1kva7W9si2Ib7S8LtoW64nbqcyBo6WWYGIQeXMCkHIuuJc67fa6jnKQrcNYY
Message-ID: <CADnq5_MAJ9rGmCVcX3bMhgP9jJ5HG0nY3+SUJhJTWeBgP3q=0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: cache gpu pcie link width
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
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

On Mon, Jan 13, 2025 at 9:20=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Tuesday, January 14, 2025 01:08
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: cache gpu pcie link width
>
> Ping on this series?
>
> Alex
>
> On Tue, Jan 7, 2025 at 11:17=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Get the PCIe link with of the device itself (or it's integrated
> > upstream bridge) and cache that.
> >
> > v2: fix typo
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3820
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 152 ++++++++++++++++-----
> >  drivers/gpu/drm/amd/include/amd_pcie.h     |  18 +++
> >  2 files changed, 138 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 90eb92c4c2800..72aff70464ed7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6162,6 +6162,44 @@ static void amdgpu_device_partner_bandwidth(stru=
ct amdgpu_device *adev,
> >         }
> >  }
> >
> > +/**
> > + * amdgpu_device_gpu_bandwidth - find the bandwidth of the GPU
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @speed: pointer to the speed of the link
> > + * @width: pointer to the width of the link
> > + *
> > + * Evaluate the hierarchy to find the speed and bandwidth
> > +capabilities of the
> > + * AMD dGPU which may be a virtual upstream bridge.
> > + */
> > +static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
> > +                                       enum pci_bus_speed *speed,
> > +                                       enum pcie_link_width *width) {
> > +       struct pci_dev *parent =3D adev->pdev;
> > +
> > +       if (!speed || !width)
> > +               return;
> > +
> > +       parent =3D pci_upstream_bridge(parent);
> > +       if (parent && parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> > +               /* use the upstream/downstream switches internal to dGP=
U */
> > +               *speed =3D pcie_get_speed_cap(parent);
> > +               *width =3D pcie_get_width_cap(parent);
> > +               while ((parent =3D pci_upstream_bridge(parent))) {
> > +                       if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> > +                               /* use the upstream/downstream switches=
 internal to dGPU */
> > +                               *speed =3D pcie_get_speed_cap(parent);
> > +                               *width =3D pcie_get_width_cap(parent);
> > +                       }
> > +               }
> > +       } else {
> > +               /* use the device itself */
> > +               *speed =3D pcie_get_speed_cap(parent);
> > +               *width =3D pcie_get_width_cap(parent);
> > +       }
> > +}
> > +
> >  /**
> >   * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
> >   *
> > @@ -6173,9 +6211,8 @@ static void amdgpu_device_partner_bandwidth(struc=
t amdgpu_device *adev,
> >   */
> >  static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
> > {
> > -       struct pci_dev *pdev;
> >         enum pci_bus_speed speed_cap, platform_speed_cap;
> > -       enum pcie_link_width platform_link_width;
> > +       enum pcie_link_width platform_link_width, link_width;
> >
> >         if (amdgpu_pcie_gen_cap)
> >                 adev->pm.pcie_gen_mask =3D amdgpu_pcie_gen_cap; @@
> > -6197,11 +6234,10 @@ static void amdgpu_device_get_pcie_info(struct
> > amdgpu_device *adev)
> >
> >         amdgpu_device_partner_bandwidth(adev, &platform_speed_cap,
> >                                         &platform_link_width);
> > +       amdgpu_device_gpu_bandwidth(adev, &speed_cap, &link_width);
> >
> >         if (adev->pm.pcie_gen_mask =3D=3D 0) {
> >                 /* asic caps */
> > -               pdev =3D adev->pdev;
> > -               speed_cap =3D pcie_get_speed_cap(pdev);
> >                 if (speed_cap =3D=3D PCI_SPEED_UNKNOWN) {
> >                         adev->pm.pcie_gen_mask |=3D (CAIL_ASIC_PCIE_LIN=
K_SPEED_SUPPORT_GEN1 |
> >
> > CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2 | @@ -6257,51 +6293,103 @@ stati=
c void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
> >                 }
> >         }
> >         if (adev->pm.pcie_mlw_mask =3D=3D 0) {
> > +               /* asic caps */
> > +               if (link_width =3D=3D PCIE_LNK_WIDTH_UNKNOWN) {
> > +                       adev->pm.pcie_mlw_mask |=3D AMDGPU_DEFAULT_ASIC=
_PCIE_MLW_MASK;
>
> In this condition, we already know this variable (adev->pm.pcie_mlw_mask)=
 is 0, so it seems no reason to use "|=3D" in this case.
> So, it better to change it from "|=3D" to "=3D" , right?

Sure.  I did it for consistency with the pcie gen code and to avoid
someone accidently adjusting the code later and missing the |=3D and
overwriting the previous values with =3D.  If you feel strongly about it
I can change it.

>
> The rest of the parts look fine, Series is
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Thanks!

Alex

>
> Best Regards,
> Kevin
> > +               } else {
> > +                       switch (link_width) {
> > +                       case PCIE_LNK_X32:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X32 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X16 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X16:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X16 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X12:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X8:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X4:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X2:
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_=
PCIE_LINK_WIDTH_SUPPORT_X2 |
> > +                                                          CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X1);
> > +                               break;
> > +                       case PCIE_LNK_X1:
> > +                               adev->pm.pcie_mlw_mask |=3D CAIL_ASIC_P=
CIE_LINK_WIDTH_SUPPORT_X1;
> > +                               break;
> > +                       default:
> > +                               break;
> > +                       }
> > +               }
> > +               /* platform caps */
> >                 if (platform_link_width =3D=3D PCIE_LNK_WIDTH_UNKNOWN) =
{
> >                         adev->pm.pcie_mlw_mask |=3D AMDGPU_DEFAULT_PCIE=
_MLW_MASK;
> >                 } else {
> >                         switch (platform_link_width) {
> >                         case PCIE_LNK_X32:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X32 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X16 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X12 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X8 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X4 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X32 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X16 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X16:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X16 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X12 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X8 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X4 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X16 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X12:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X12 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X8 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X4 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X12 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X8:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X8 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X4 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X8 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X4:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X4 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X4 |
> > +                                                          CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X2:
> > -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_L=
INK_WIDTH_SUPPORT_X2 |
> > -                                                         CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1);
> > +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_=
LINK_WIDTH_SUPPORT_X2 |
> > +
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
> >                                 break;
> >                         case PCIE_LNK_X1:
> > -                               adev->pm.pcie_mlw_mask =3D CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X1;
> > +                               adev->pm.pcie_mlw_mask |=3D
> > + CAIL_PCIE_LINK_WIDTH_SUPPORT_X1;
> >                                 break;
> >                         default:
> >                                 break; diff --git
> > a/drivers/gpu/drm/amd/include/amd_pcie.h
> > b/drivers/gpu/drm/amd/include/amd_pcie.h
> > index a1ece3eecdf5e..a08611cb80411 100644
> > --- a/drivers/gpu/drm/amd/include/amd_pcie.h
> > +++ b/drivers/gpu/drm/amd/include/amd_pcie.h
> > @@ -49,6 +49,17 @@
> >                                       |
> > CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3)
> >
> >  /* Following flags shows PCIe lane width switch supported in driver
> > which are decided by chipset and ASIC */
> > +
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1          0x00000001
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2          0x00000002
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4          0x00000004
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8          0x00000008
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12         0x00000010
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16         0x00000020
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X32         0x00000040
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_MASK        0x0000FFFF
> > +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_SHIFT       0
> > +
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X1          0x00010000
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X2          0x00020000
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X4          0x00040000
> > @@ -56,6 +67,7 @@
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X12         0x00100000
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X16         0x00200000
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X32         0x00400000
> > +#define CAIL_PCIE_LINK_WIDTH_SUPPORT_MASK        0xFFFF0000
> >  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT       16
> >
> >  /* 1/2/4/8/16 lanes */
> > @@ -65,4 +77,10 @@
> >                                       | CAIL_PCIE_LINK_WIDTH_SUPPORT_X8=
 \
> >                                       |
> > CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
> >
> > +#define AMDGPU_DEFAULT_ASIC_PCIE_MLW_MASK (CAIL_ASIC_PCIE_LINK_WIDTH_S=
UPPORT_X1 \
> > +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_=
SUPPORT_X2 \
> > +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_=
SUPPORT_X4 \
> > +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_=
SUPPORT_X8 \
> > +                                          |
> > +CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16)
> > +
> >  #endif
> > --
> > 2.47.1
> >
