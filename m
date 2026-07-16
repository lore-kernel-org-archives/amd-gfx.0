Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A7C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6771310F319;
	Thu, 16 Jul 2026 13:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+ZMlhej";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB5010F319
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:33:28 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cea3ab2479so10146605ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 06:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784208808; cv=none;
 d=google.com; s=arc-20260327;
 b=WA9o1BO0Kt3Ej6a8MqPg4UFhNpZZmLy1VcamUx5udkISYKpWso+bSYPmLQghv5cW4H
 suTiD1LWwUVi0m1yftBKDVJDhNJYE0dseXhSKGgIYJJHGLH68bZPJqL7GKVf0Rbd0exO
 10ImvYQHVKnY8JNQIiOJWR3RD1Lxy4KicgWFB726B2pWBIU2fVLuODFricwy48Kx8wXf
 Fc1e+qXOzdOwXsrugrvJrDmmoiK4sCoHqkD59pOo6HG59mnGpWF+EYHJIRxVX5Vk2ngs
 GVTLrJawdwuhAmkeW3HJKXCGWoZBwe4HCN/BvYgDaAb5ATQK3tPPRWzeBt8hUicEy90x
 H1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f8yv4qD35geRLtq8pJco7GfkkIQxQmFXYGbVyYE6z1Q=;
 fh=JqOLfMY5LB9Slo8AIcrkURUJY4ehlat4FPm2r2PXdko=;
 b=i9pzB6xdjwQbxVpgvikmSpUt8vhT/7SDAHkhYlXxsDeKqId0e1k3TerwaB5vWPdEpJ
 M/RiCpWbkVAUigBvAg2/lbRjuWy0QnxGQAkGW2Yg9pWHbSUSNcWyoD+8spjnw1ZsXgkx
 2TJQ6cQrp6lJkCsrI2GOa5MTEdsnDKTxSOgYh44nALupKSAulBVVS779ZItUNY0+hdKx
 yEW6WSVmwGdN6Cu/RQHpRPhun1sQJF9tsyZnsuMerJb2J6TfB9mM0KILUFnJ3hdWRBVR
 ye5ZdH8FtjQyE7tEVmx7y0Yglj8HgxEQPp6NOjNFeXFpnFXc6LyYxk46/flUSItcyaB6
 JFDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208808; x=1784813608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f8yv4qD35geRLtq8pJco7GfkkIQxQmFXYGbVyYE6z1Q=;
 b=Q+ZMlhejA8QloDZ06Pry6BDdnQN+Br8CV3ZdpPivi2VT21HNxsxJphZGjIkik2K6/F
 CVGAhRYbH8Eb6uFxCl0Iql2zTwJwRS9bKyujDYHBHQQL9TWDNChoRXyeBCz6Lmf3eyjP
 /WFtE8ZSXfrKJv0/7vnCVY3WGXglVxu0iPFKOKI/ckgrQTNs3nWZpLH0IeNM/N1IuT1G
 nZxg9MtFvquiMm3Gm2As45ITyTIsCYVuhzy11kXK9WcuZI5XPLKqoMp9KOBe437yi1Bz
 ANnMo6t3Gba1luMIFUTfVT1FygtLuXQ2E5RsefRL7EbJXzP79t1hGv8upAMZ5o0Bik2R
 C6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208808; x=1784813608;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8yv4qD35geRLtq8pJco7GfkkIQxQmFXYGbVyYE6z1Q=;
 b=gKFv8XraT9DuFGkG7Q97rbm+3uKWl3IGU/cUqTK+6qpGKMlvMmWajy++STlQMjo6s5
 2jis/J6dC2zxOZ4pOxxXFI1AdfZgNI4KAKudPC65byKplvJt/GuGUHUIsJArQcBJ9UI3
 Zk/p6jS3xhj62eePYUrOChDhHA6ibuzE49ld/UiWu/fitkJX7u/e/2CxoA8rkHpWVwpC
 ih02qeN3SrGLH4rpelsqpSKeyaUGiQukpOJ/uGACigH+NnTasHkYBDpsuixtIf6sxoR3
 bvXmahqVXMSUU+zNrhigVRHOzZopIR7GrGYfTHxDi/PlVgLhyFcsDCs6BOh46HE7KPFE
 ingw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9fnWDt6AKpgZGu8g4URiVtJmI1NcyAiOADvIA0fwFOUoJY+fHcOFouAoU9hkPGMui4HQ3c+JX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJJPrzgIdoCyx3+UMARLHwpz54uedaR1sE4BXqbFJuDLH6q1MB
 QWfqYJ80rv3dx3BoFkWA9GEpxqb7sb45gmK00holG0LmttJ6NSpiYmNnTTp8U34CD0LlJxIho3H
 zvZDkogVVzcOzHi/JdV5vPruXQtbCsXo=
X-Gm-Gg: AfdE7cniEJzzgR6T2+Vbx3pNF8okyLWMTmZYTmXBHy2hDm80KIQB2gqHcv4tJl+bACa
 RH/7uInWbDMtfRoQF5aEatvs/NhhGiyE1tHbACerLoCGPDanqJ93Iec6Ez63Ug0KSulG4fZfGxF
 ylXrIiktbLD2gdM2ycE6TrRO9Fs2r4Hy0uo/FgBLbnTNlQ3mS5XzSYPGxc3H+pBRaN679KNizOJ
 Jf24AC//3iT5upF8OVkPuV5+IiW+yuvEbLDgqQGm0pC+b/q9Z9PZMYCcSkc7OLMMHW/RvtRdvR7
 otyW+PwdNCPfNvidj8pGMIaMMqIydUuMaFbzVqJMeZbzPRq1
X-Received: by 2002:a17:902:ef06:b0:2c9:cf5d:d9b2 with SMTP id
 d9443c01a7336-2ce9ef1bd20mr175656995ad.4.1784208807743; Thu, 16 Jul 2026
 06:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260708193518.702584-1-mario.limonciello@amd.com>
 <20260708193518.702584-5-mario.limonciello@amd.com>
 <b7f32505-25bb-494e-b574-f0dee575b991@leemhuis.info>
In-Reply-To: <b7f32505-25bb-494e-b574-f0dee575b991@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 09:33:15 -0400
X-Gm-Features: AUfX_myfFwb_s1zBkbFPg0YTFDt-_sghTLpwmt04S546GeM9wb2Xaxi8OHqt8HA
Message-ID: <CADnq5_N+oJgevSwx1SV0eOWvyu4WJ=ZBt7ra4Z5RTeC3W8kaLQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/radeon: Fix VFCT bus number matching with soft
 filter
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Oz Tiram <oz@shift-computing.de>
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

On Thu, Jul 16, 2026 at 9:24=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> On 7/8/26 21:35, Mario Limonciello wrote:
> > On systems where PCI bus renumbering occurs (e.g. pci=3Drealloc,
> > resource conflicts), the runtime bus number may differ from the
> > BIOS POST bus number recorded in the VFCT table. This causes
> > radeon_acpi_vfct_bios() to fail finding the VBIOS even though
> > the correct device entry exists.
> >
> > Introduce radeon_acpi_vfct_match()
>
> This patch showed up in -next yesterday and from a very quick look seems
> likely to be the reason for a ppc64le build error I ran into:
>
> """drivers/gpu/drm/radeon/radeon_bios.c:614:12: error:
> =E2=80=98radeon_acpi_vfct_match=E2=80=99 defined but not used [-Werror=3D=
unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289:
> drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: ***
> [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.=
0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228:
> .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2
> """
>
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-ppc64le/10721545-next-next-all/builder-live.log.gz
>

Fixed with this patch:
https://patchwork.freedesktop.org/patch/740649/?series=3D170572&rev=3D1

Alex

> Ciao, Thorsten
>
> > drivers/gpu/drm/radeon/radeon_bios.c:6> drivers/gpu/drm/radeon/radeon_b=
ios.c:614:12: error:
> =E2=80=98radeon_acpi_vfct_match=E2=80=99 defined but not used [-Werror=3D=
unused-function]
> >   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon=
_bios.o] Error 1
> > make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error=
 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-2026=
0715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: =
.] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
>
> 14:12: error: =E2=80=98radeon_acpi_vfct_match=E2=80=99 defined but not us=
ed
> [-Werror=3Dunused-function]
> >   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon=
_bios.o] Error 1
> > make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error=
 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-2026=
0715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: =
.] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
>
> > drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acp=
i_vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon=
_bios.o] Error 1
> > make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error=
 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-2026=
0715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: =
.] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
>
> > drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acp=
i_vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon=
_bios.o] Error 1
> > make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error=
 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-2026=
0715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: =
.] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
>
>
> > drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acp=
i_vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon=
_bios.o] Error 1
> > make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error=
 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-2026=
0715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: =
.] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
>
>
>
> > which treats the bus number
> > as a soft filter: vendor/device/function identity is the hard
> > requirement, while exact bus match is the preferred path. When
> > bus numbers disagree but device identity matches, accept the
> > VFCT entry and log a dev_notice for diagnostics. This mirrors the
> > equivalent amdgpu change.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > Cc: Oz Tiram <oz@shift-computing.de>
> >  drivers/gpu/drm/radeon/radeon_bios.c | 45 ++++++++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/rad=
eon/radeon_bios.c
> > index c6df799c3cf4a..cc10880af096b 100644
> > --- a/drivers/gpu/drm/radeon/radeon_bios.c
> > +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> > @@ -596,6 +596,45 @@ static bool radeon_read_disabled_bios(struct radeo=
n_device *rdev)
> >               return legacy_read_disabled_bios(rdev);
> >  }
> >
> > +/**
> > + * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
> > + * @rdev: Radeon device
> > + * @vhdr: VFCT image header to check
> > + *
> > + * VFCT entries contain the PCI bus number as recorded during BIOS POS=
T.
> > + * On systems where the kernel renumbers PCI buses (e.g. pci=3Drealloc=
 or
> > + * resource conflicts), the runtime bus number may differ from the POS=
T
> > + * value.  Match by device identity (vendor + device + function) and u=
se
> > + * the bus number as a preference: exact bus match is preferred, but w=
hen
> > + * the bus numbers disagree we accept the entry if the device identity
> > + * matches.
> > + *
> > + * Returns: 0 on match, -ENODEV on no match
> > + */
> > +static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> > +                               VFCT_IMAGE_HEADER *vhdr)
> > +{
> > +     /* Vendor and device IDs must always match */
> > +     if (vhdr->VendorID !=3D rdev->pdev->vendor ||
> > +         vhdr->DeviceID !=3D rdev->pdev->device)
> > +             return -ENODEV;
> > +
> > +     if (vhdr->PCIDevice !=3D PCI_SLOT(rdev->pdev->devfn) ||
> > +         vhdr->PCIFunction !=3D PCI_FUNC(rdev->pdev->devfn))
> > +             return -ENODEV;
> > +
> > +     /* Exact bus number match - preferred */
> > +     if (vhdr->PCIBus =3D=3D rdev->pdev->bus->number)
> > +             return 0;
> > +
> > +     /* Bus mismatch but device identity matches (PCI renumbering case=
) */
> > +     dev_notice(&rdev->pdev->dev,
> > +                "VFCT bus number mismatch: table %u !=3D runtime %u, m=
atching by device identity (vendor 0x%04x device 0x%04x)\n",
> > +                vhdr->PCIBus, rdev->pdev->bus->number,
> > +                rdev->pdev->vendor, rdev->pdev->device);
> > +     return 0;
> > +}
> > +
> >  #ifdef CONFIG_ACPI
> >  static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
> >  {
> > @@ -633,11 +672,7 @@ static bool radeon_acpi_vfct_bios(struct radeon_de=
vice *rdev)
> >               }
> >
> >               if (vhdr->ImageLength &&
> > -                 vhdr->PCIBus =3D=3D rdev->pdev->bus->number &&
> > -                 vhdr->PCIDevice =3D=3D PCI_SLOT(rdev->pdev->devfn) &&
> > -                 vhdr->PCIFunction =3D=3D PCI_FUNC(rdev->pdev->devfn) =
&&
> > -                 vhdr->VendorID =3D=3D rdev->pdev->vendor &&
> > -                 vhdr->DeviceID =3D=3D rdev->pdev->device) {
> > +                 !radeon_acpi_vfct_match(rdev, vhdr)) {
> >                       rdev->bios =3D kmemdup(&vbios->VbiosContent,
> >                                            vhdr->ImageLength,
> >                                            GFP_KERNEL);
>
