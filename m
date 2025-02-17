Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03928C021AB
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 15:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F2A10E4FE;
	Mon, 17 Feb 2025 15:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IziUE/Tu";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A454910E4FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 15:46:02 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fc288da33eso696385a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739807162; x=1740411962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dPtYYNth/a64LIJH7c4OEDw+dSC4UYyJPpFlvHQ3Bo=;
 b=IziUE/TuFyT0HRRGp+tqDDfaNDH8fQjnwOW3UWFZOKJF2tCIbVCWNOUFAlRRdBUC2F
 ezxvl9fnbgHVs2CjsLrXGwbMEwVys61zKtyykux0zexNmvkZW3xTc+87Kg7/dkqPMyG/
 JHGbKqtr83yX87wl2BXupjge2bqdLUUaIA1PxuWZ0UtDFMcA3bIXK6ugAQs2AqfTdBt+
 oJPIWrvQ3tNMmOlvPm6f547w479xmo8Ur9Z3j8vzkh6lezqTdtH67ZacjIYY22Upv62z
 VGyQqrSHYYFFhikxSrOCo03NWO6Cc+K5KovydXip0RAjkWH674PGrr3tcnJ6lr7wkWey
 ny/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739807162; x=1740411962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dPtYYNth/a64LIJH7c4OEDw+dSC4UYyJPpFlvHQ3Bo=;
 b=Xod6KHnWOreDc/rr1SGTwFkkLXEF/K7x3VpJpcFCGiKxXgog04pgX1jxscp5iD76V/
 yK7TO7Pu6WUf8/2sgQR4R0ypydo8ZEAZsMZQ8i0acb269h4U6riynIW0da7DYrJch9QX
 bq/m2JaVVJwD6W9yTzeu0GOabs3iIEsk2ozpPeNXy5kyCwqtA0oQUzxEHHCMEqakNFyt
 usnGpOxE6gxAGi1l/2Eg1/CPhFnUxt7qKx4imuQq0tex9sBlz3RdemCxsaqUWMllK1QY
 GfSvB1AGxCicdI4zaYSFuHwA16n3Hfo/Fbr7g/d0WEwGdNJ+WK9kw2IoLPEQSOuD0R6e
 tv+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDfV9WXM7enhQbYYMMEZ7muglbgjdxsL2ob8ohy0UelvRtduFtE/raFmMLzp9zMDtNTtebol0q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvAyilcJ6kBRj2938ir1LhyEqozAUZRKD0TB5f44Wh2HVA3SzQ
 +kH8lPWjvjVPn6LBIECGsj7HNjOz+HZct6TK/LpNrn2RZbrktmoAMuaJeISy42g9aaLeFOuy44T
 mwmh57nfPHCPUuy3/Z4Jrgt7IHVE=
X-Gm-Gg: ASbGnctkWoCbbhAy51ulgpYF8aVB5e+MKf1SQ+wiMsn6rautZG49C9bwaF48miSi/Qm
 Cfe8rGS1ExUxpmPhtlefckwgDiO8QoOSrNAeF68YZ0of4s+4LAhKY4ds9spnNXuEih/8+XwCK
X-Google-Smtp-Source: AGHT+IFFWHytK57mGA99ICNsVDnMJMRw/i0z7QQunG4a6xJoh5vLQDs+r8+l/cO4cW4JhlRyc/yF+ZydD/oy4NjVr/o=
X-Received: by 2002:a17:90b:2fc3:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2fc41173deemr5813946a91.7.1739807162134; Mon, 17 Feb 2025
 07:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
In-Reply-To: <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 10:45:49 -0500
X-Gm-Features: AWEUYZmMaHIRFPjSC-GAve1xDgr6WT1YWCE5e7Iw0EX36gqQYc6WVYOgu2sZMdU
Message-ID: <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com, 
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 Mario.Limonciello@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>
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

On Mon, Feb 17, 2025 at 10:38=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.02.25 um 16:10 schrieb Alex Deucher:
> > There was a quirk added to add a workaround for a Sapphire
> > RX 5600 XT Pulse.  However, the quirk only checks the vendor
> > ids and not the subsystem ids.  The quirk really should
> > have checked the subsystem vendor and device ids as now
> > this quirk gets applied to all RX 5600 and it seems to
> > cause problems on some Dell laptops.  Add a subsystem vendor
> > id check to limit the quirk to Sapphire boards.
>
> That's not correct. The issue is present on all RX 5600 boards, not just =
the Sapphire ones.

I suppose the alternative would be to disable resizing on the
problematic DELL systems only.

>
> The problems with the Dell laptops are most likely the general instabilit=
y of the RX 5600 again which this quirk just make more obvious because of t=
he performance improvement.
>
> Do you have a specific bug report for the Dell laptops?
>
> Regards,
> Christian.
>
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

^^^ this bug report

Alex


> > Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 =
XT Pulse")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> > ---
> >  drivers/pci/pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 225a6cd2e9ca3..dec917636974e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *=
pdev, int bar)
> >
> >       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 *=
/
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=3D =
0x731f &&
> > +         pdev->subsystem_vendor =3D=3D 0x1da2 &&
>
>
>
>
> >           bar =3D=3D 0 && cap =3D=3D 0x700)
> >               return 0x3f00;
> >
>
