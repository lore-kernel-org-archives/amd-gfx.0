Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A7C4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8A610F31D;
	Thu, 16 Jul 2026 13:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWU5YkBw";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D2310F31E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:36:45 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cab1f435afso13002285ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 06:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784209005; cv=none;
 d=google.com; s=arc-20260327;
 b=IJ9LojqIZxs1YaIQul0i5Jd95Iqr78YkQL2nDm9NTvRxpNOahB/eGw7UwXCz/uCPw2
 le92OLSHPUgQXYCYsq8LP3CtM9XVF2XYf1wi0rlKtr4J1F1VVGKHAoQocs/yzRwsFTrl
 CsdiJag7PDhlm03tzBHOTc0k7N3kpqXAPSaWSLBc2fKB5IeLjuceub3hNjUfERomREz6
 Bt5+aZVnVn7ZgazzE++Uz/bb+7boHAW6X+d3Acxtf27/2BMgSaztXAFyn0Pig1Ot7PJ8
 Rb9lIhkLL7Dueb/nbwyerIvflaJo834U7KGHhSU6oTNyMPKIOOSi0PQ7tf0YzD8zkmUd
 FC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3k33WIextkyJdwnrh1ZNf4QmV7aDLl0J8tljMyRAcno=;
 fh=RVbr5Ty/y8k/x9IeAJ3WcJpdqqkV6MC1BFxxvomoSkk=;
 b=eyPHDc0zWfqsPCfuniZMOQ2RhS9XmBzrLMMvQuFYX1eycA8Yc9ZrA10o4IMRJXsZyA
 UGINUWr1MGaaw5yQchMJRDi9dkvK37Ei08vSrZNEpyouRp4El021sNE4rQYbw6Xnj914
 gEkRIjEq0+nYDi5KwV4y5RHW7+GnRv5t+QjoQry1MpDAfoyvMIuAZIqfpp2YPGSnsDnA
 g3I25uu6mq2ylCqjpfVeWcgyDB4gKxtkpCxiE9uXY9M04nMPnyVSVmt5H+K72AVl49tT
 shi1pyY6ntqM1q2fGLcDgV32vYych/yWqettICNxF9/qrof4tLF65IxlMow6SJSkf/Sp
 4tFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784209005; x=1784813805; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3k33WIextkyJdwnrh1ZNf4QmV7aDLl0J8tljMyRAcno=;
 b=jWU5YkBwXbNerEPRhzsh2kC66W+NxQYSi1hrGOt+o9k+osYStN17SCW0IbkNYBByiF
 kZohX91einSX/7JkPx+V0waxeoyQ77aKqnIs0SuOIrDmZUNRdCwVEp/wG73b17RP4a5r
 YC06G9AaKUViX4qilzLW+i8DTwhSQyeIvez4iZgWTxw900bLXas2JlGYw8NFiOVyYW/V
 x8rMCdrUq6SQQcAo1kEzAIKmtA0s1iw9aaFiAQplvbSPaszET6Oh1voCz+oCIJ6r5Oea
 fsvTN0AhzLbr1yrU7sPREq8XnzwAmRv+JKR4ZlBOB4jSLhIamwCfYkxdGpd5F77sH7JX
 ArEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209005; x=1784813805;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3k33WIextkyJdwnrh1ZNf4QmV7aDLl0J8tljMyRAcno=;
 b=l3A2/oZGNf156I3mjkNcDK77V7w+iW2vPJkaYMvdID13+GVEnwMMNWKH2pdTNdNRYD
 aW7Ntzs0uJUfEhul4d2d21K1wDzKb071+TdH7qd4bpnF9K4Larx5uO8MGGhgIgK6Tt4B
 hxWyNpuD+eYv+ErC/wb2MR4DvPl81JaserYeOn1BkuDHMllB/juEeP5zorxO2gLhaGL9
 DxJnly3L6ow8Jxz4mcS/4B66N7ZU126KA/CBJttJBmH9MGAltUEUqb81sAOz5XronC46
 NKUL/h6kW7yLvbmy9uSkTT+jhLmP3H78EsIa03h6pivg/ZbIek/Rer1KEd9wpPrXU8or
 cS4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFT2rDbW8cB1SdRpCvsTwJSfIGThiWNOxJzT5yEuu0srBRMLbwWu8w+HFCnZqEkxmXFUlUoROw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfEsrvQqjilzQ+upxKsxCjQJRyIPwhty3ZDLQmRMc2TLWwtItR
 P7kAJs5/oEScJv4g+QlgWP7OycZpN0oHF91xPKt/2UMAJjZov9NCYL/3vnsQwjP1kbD+isdv6WL
 RhHSb2r1h1Qfihiz8K1P/C/+0UDE7zWk=
X-Gm-Gg: AfdE7ck/m+yU8nkC+2UgJgX3pMo99PZOElY1gxmfEbWjC/E9WIHPl/Bh1lq3mUhBCkF
 FGCNL/+KUPdqY6of6OUyZt6xvwJ9teJ2GyRKSIIVNswGmjk8LVjfsA6AGU/6sd9OFw1txczka55
 d2aGj9iqdo2u06rHfuL73AjvkeMZmKhYFSsQ76hvvR7S8MvWGsWu0vXmqiHsRSMlxJcITXkXzua
 GCggFoOL8XngQQzjBCnuA107VaMNl+PbuusytQXVRAnU/1awsbqMgLIOvoUlLYEGAnAV5Df/9mL
 M0Mt26sbyrIPv4MBo53eb1b+x7IG47Zghb1Hcy6nzTWZ0r1RTHutJfJaeYw=
X-Received: by 2002:a17:902:e551:b0:2ca:d344:7752 with SMTP id
 d9443c01a7336-2ce9f18746amr171788715ad.8.1784209005117; Thu, 16 Jul 2026
 06:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260708193518.702584-1-mario.limonciello@amd.com>
 <20260708193518.702584-2-mario.limonciello@amd.com>
 <aljQlgDxiRrtMJti@monoceros>
 <6f4ec487-6cb8-412c-ac1a-b0710c79c584@amd.com>
In-Reply-To: <6f4ec487-6cb8-412c-ac1a-b0710c79c584@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 09:36:33 -0400
X-Gm-Features: AUfX_mwOy3oW7f81kDe0rN3AUeokJ5T5CERVwo_v8d_1CiIAr5vkdjULMKBC-ss
Message-ID: <CADnq5_M_soaFDLBsp-kZFf_AB=Q9erXYHaNvHG-YJVgZa9BbXA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix VFCT bus number matching with soft
 filter
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Oz Tiram <oz@shift-computing.de>
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

On Thu, Jul 16, 2026 at 9:21=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 7/16/26 07:41, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > On Wed, Jul 08, 2026 at 02:35:14PM -0500, Mario Limonciello wrote:
> >> On systems where PCI bus renumbering occurs (e.g. pci=3Drealloc,
> >> resource conflicts), the runtime bus number may differ from the
> >> BIOS POST bus number recorded in the VFCT table. This causes
> >> amdgpu_acpi_vfct_bios() to fail finding the VBIOS even though
> >> the correct device entry exists.
> >>
> >> Introduce amdgpu_acpi_vfct_match() which treats the bus number
> >> as a soft filter: vendor/device/function identity is the hard
> >> requirement, while exact bus match is the preferred path. When
> >> bus numbers disagree but device identity matches, accept the
> >> VFCT entry and log a dev_notice for diagnostics.
> >>
> >> Reported-by: Oz Tiram <oz@shift-computing.de>
> >> Closes: https://lore.kernel.org/amd-gfx/20260621173211.28443-1-oz@shif=
t-computing.de/
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++++++++++++++++++++-=
--
> >>   1 file changed, 40 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bios.c
> >> index 3ebdd792feec1..d8fd047295d9d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >> @@ -377,6 +377,45 @@ static bool amdgpu_read_disabled_bios(struct amdg=
pu_device *adev)
> >>              false : amdgpu_asic_read_disabled_bios(adev);
> >>   }
> >>
> >> +/**
> >> + * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the devic=
e
> >> + * @adev: AMDGPU device
> >> + * @vhdr: VFCT image header to check
> >> + *
> >> + * VFCT entries contain the PCI bus number as recorded during BIOS PO=
ST.
> >> + * On systems where the kernel renumbers PCI buses (e.g. pci=3Dreallo=
c or
> >> + * resource conflicts), the runtime bus number may differ from the PO=
ST
> >> + * value.  Match by device identity (vendor + device + function) and =
use
> >> + * the bus number as a preference: exact bus match is preferred, but =
when
> >> + * the bus numbers disagree we accept the entry if the device identit=
y
> >> + * matches.
> >> + *
> >> + * Returns: 0 on match, -ENODEV on no match
> >> + */
> >> +static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> >> +                              VFCT_IMAGE_HEADER *vhdr)
> >> +{
> >> +    /* Vendor and device IDs must always match */
> >> +    if (vhdr->VendorID !=3D adev->pdev->vendor ||
> >> +        vhdr->DeviceID !=3D adev->pdev->device)
> >> +            return -ENODEV;
> >> +
> >> +    if (vhdr->PCIDevice !=3D PCI_SLOT(adev->pdev->devfn) ||
> >> +        vhdr->PCIFunction !=3D PCI_FUNC(adev->pdev->devfn))
> >> +            return -ENODEV;
> >> +
> >> +    /* Exact bus number match - preferred */
> >> +    if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
> >> +            return 0;
> >> +
> >> +    /* Bus mismatch but device identity matches (PCI renumbering case=
) */
> >> +    dev_notice(adev->dev,
> >> +               "VFCT bus number mismatch: table %u !=3D runtime %u, m=
atching by device identity (vendor 0x%04x device 0x%04x)\n",
> >> +               vhdr->PCIBus, adev->pdev->bus->number,
> >> +               adev->pdev->vendor, adev->pdev->device);
> >> +    return 0;
> >> +}
> >> +
> >>   #ifdef CONFIG_ACPI
> >>   static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> >>   {
> >> @@ -413,11 +452,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_d=
evice *adev)
> >>              }
> >>
> >>              if (vhdr->ImageLength &&
> >> -                vhdr->PCIBus =3D=3D adev->pdev->bus->number &&
> >> -                vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) &&
> >> -                vhdr->PCIFunction =3D=3D PCI_FUNC(adev->pdev->devfn) =
&&
> >> -                vhdr->VendorID =3D=3D adev->pdev->vendor &&
> >> -                vhdr->DeviceID =3D=3D adev->pdev->device) {
> >> +                !amdgpu_acpi_vfct_match(adev, vhdr)) {
> >>                      adev->bios =3D kmemdup(&vbios->VbiosContent,
> >>                                           vhdr->ImageLength,
> >>                                           GFP_KERNEL);
> >
> > For the record to hopefully make it easier for others to find the fix:
> >
> > This patch became 33a18ecd2fbf in
> >
> >       https://gitlab.freedesktop.org/agd5f/linux.git drm-next
> >
> > and thus next and it introduces a build failure for !CONFIG_ACPI builds=
:
> >
> >       drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98rade=
on_acpi_vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function=
]
> >         614 | static int radeon_acpi_vfct_match(struct radeon_device *r=
dev,
> >             |            ^~~~~~~~~~~~~~~~~~~~~~
> >
> > Patch available at https://lore.kernel.org/all/20260716123646.1933293-2=
-u.kleine-koenig@baylibre.com/
> >
> > Best regards
> > Uwe
>
> Thanks.  Alex can you squash that in, or has the merge request already
> gone out?

Already out.  I've picked up Uwe's patch.

Alex
