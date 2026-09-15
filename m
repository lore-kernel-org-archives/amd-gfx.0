Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6CAC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 15:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2634610FC26;
	Tue, 15 Sep 2026 15:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R3bODopJ";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C797910FC26
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 15:06:06 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-46435ddf8a0so286885fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 08:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789484766; cv=none;
 d=google.com; s=arc-20260327;
 b=b9QCRH0VnWR0CfxZy3jdnymlDP70ggnwk56buQhOcJaW2YOpBYB/1LATuIGY6mGG/m
 00e4t0b96QGZiEnc/QbIJsdC24Au436To/ozTwzeh0QiCu39JbC/esh2FrE8ZonljbZQ
 BQTKUzbbZWz/CK+B9OPxx72MnSY7esCHd6adD75i/ZD8X2eTqBrjLFMPrnT5b22fVcAO
 JbZRvGiDRZ4CQ0c+47rLUPC5+SHo5WA1+UbWRNixuqDene86bsFzcBMf2mwUv6+WLDWR
 FogB2q+wha4s1v14C+i5ZayQqfBPqBlJlwHy3D6bnXMKnMPfikrnWdQ/yIqL/ujhqe4q
 7C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c3yKHJW7TqZQFfaYx8GqZMZ6PG/DN+NkbXBKC76oMwQ=;
 fh=jEbZjR2Ffk+6+DSJuKBpLH53KeJpre3ANXPKxXzMV9w=;
 b=KiIY1FHJEXxzLzsUDaOa5h4wrtaCjVdScsR8fY8Ji5xhDd7nYphlyM9l3X8PKqYLbv
 BI3JJ42R1L3EQsNx/npHqH0C0OUBm/2bpQ5SU9ncYuglD9ieNLJcxGPMHX06on3yYi1h
 F1DBm/fg/uhIir4cJWg1ffKqnivlQ5wbw26/CZEU3ktGS8zLbxB//knrtOpS+h+YYOVF
 mcX7GKlK/tUnp5qTaEB2C4ijE/DOBkGLdqLjvCOm3ujn80Wfc8uR4X/s0Ot/BYcZ1SpO
 rpVZ/2eVHpC1j+nysuMKaiJmo2x1lvZ16/JeTUiGSh7uUCdaENPJd7TNIGxkZKz7nzAk
 bXUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789484766; x=1790089566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3yKHJW7TqZQFfaYx8GqZMZ6PG/DN+NkbXBKC76oMwQ=;
 b=R3bODopJFk2WbC223BIr6uh/owgYu/eJkrSBIWTTjG6q81BjFwN2Lc4npyjkaSOJWg
 tPjjiuCnJb54QLzftYN+3S0lnD47cHoGLFV31Fi6gkUTAevpJwjDXYB4JOb+yLM06x+S
 8grhJgwbXB4DXoW7OM+aiUtrbaIQaDhI98H+/553/LbM9j9/ivzX/gGA53t8V0Y9sm9d
 HxTVzfLFUJS9IQZ6Qx3rv8a971uN48Mv8TV0OzOK21hgWJIkLAv8ZKJjRKUKTrefIKb3
 45UsV2S6T6neZ/s58CUfMpoSIzOguduoCuK6A6dddCGpK+viD8DVOMtZh6fnDgvpAqjG
 gFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484766; x=1790089566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c3yKHJW7TqZQFfaYx8GqZMZ6PG/DN+NkbXBKC76oMwQ=;
 b=m4YALzorg79kiY9Fuf9BAC8c4qfHbFpDs1oPHjUVIpCKzAPvvkyCe7s4fDvri1zzET
 goh+cEYFsv0pZOfCLFN732GZJ5Wd3P6qg/BT8bmG7M7JkxLvRNo7i6C9mHkKFyAjchd3
 fsO+ouohje+9ADvsfhu1g+tIUO8FYzT+TZixsKdCnv5asx+gmqhimlX4jpvWjFlAjZWg
 zeqidkxMzaRdwE/NZL82SfJL05ffLQG2QLfQaYq4efVgYhxpAK1RSqBJiaLT9Ua0Li3I
 GME9JV5KHAmUGFOO3EhhyTQk0Y1nVErSAOrp22ZbZnx4pjvMSPrcIhOyyMPFN9TRRwEx
 Vtvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzffD+/v7q+2GG3lJnAmFdqG9A1y6CdC3oIPAZEJImaX5SPGDZRC2Yk9AS4R3bOmFQ/mOW+OmA4@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngEAtWQT9Um60K8jxLGygyxBTJmiBJPAj3BudUV/XpqpYIRe30
 s2+30sFrhJClr5cpWKR6sMsgjbiUxOEaSSgapP8KgkVz71YXcDAEs7EemrTDTPB4A7bu90OiwGG
 TzfLlS+NlMqrPsmgOTEeNOCKL3/vmo0E=
X-Gm-Gg: AYBFou2tq4tTe03Y3C0ivPktW0QYBVTJ8xNFPKkFww0iPDFZ4HM+rJHbPh61lPBucmz
 koTWli9VuwPmLqJXYWcs7jVfhfdwtOdvv9pWSoVjWhUf2OjtozX8RAkCtPlxz+hbZlFCrTxPqiS
 Hut+MbutG9FsAbyoUmFaDvja/q2S5ThKE3zW0rphKbPi8jf379n81rsxrUkgDbi+w1r46HstHbN
 VLZcSB2Y3oCvCovm+TALTs4m4+JnLt4N6eudOEr5SSu6LAJk+DoxpG+tIT0ESYYsPEwRyBMdhDg
 tXAAOvAdIV4Zhu3V5mbjDzNrenWe+nlj1vfNkQWoBkAZKCnj3jYJZBseyC1T31n1ZvpJkQ==
X-Received: by 2002:a05:6870:5154:b0:447:4cf0:eb19 with SMTP id
 586e51a60fabf-481fa138530mr4500973fac.4.1789484765496; Tue, 15 Sep 2026
 08:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260520154618.809699-1-mario.limonciello@amd.com>
 <20260520154618.809699-2-mario.limonciello@amd.com>
 <04a53629-d720-40ad-91fd-0a7995572a29@amd.com>
In-Reply-To: <04a53629-d720-40ad-91fd-0a7995572a29@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 15 Sep 2026 11:05:29 -0400
X-Gm-Features: AcwNN1Ve4Beg6u-Pog18heACSjWfs10xmeCuALzBVALigcOnOMJvxLYE-u-xL_E
Message-ID: <CAAxE2A4OD__G9c3xmfraB0nfX3Z0yjeAWFC=4eN4RevxbMbJWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Add dedicated helper for
 amdgpu_device_find_parent()
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
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

+Christian (re-sending for the list)

On Tue, Sep 15, 2026 at 1:11=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 20-May-26 9:16 PM, Mario Limonciello wrote:
> > There are a few cases that code walks up the topology to find the
> > link partner of the integrated switch in a dGPU.  Split this out
> > to a helper and call in all places.
> >
> > This does have a functional change that amdgpu_device_gpu_bandwidth()
> > doesn't cache the internal link but only the parent.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++----------=
-
> >   1 file changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 073f632f295a3..b6a24faaf78dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1913,6 +1913,19 @@ static void amdgpu_uid_fini(struct amdgpu_device=
 *adev)
> >       adev->uid_info =3D NULL;
> >   }
> >
> > +static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device =
*adev)
> > +{
> > +     struct pci_dev *parent =3D adev->pdev;
> > +
> > +     /* skip upstream/downstream switches internal to dGPU */
> > +     while ((parent =3D pci_upstream_bridge(parent))) {
> > +             if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> > +                     continue;
> > +     }
> > +
> > +     return parent;
> > +}
> > +
> >   /**
> >    * amdgpu_device_ip_early_init - run early init for hardware IPs
> >    *
> > @@ -5913,8 +5926,6 @@ static void amdgpu_device_partner_bandwidth(struc=
t amdgpu_device *adev,
> >                                           enum pci_bus_speed *speed,
> >                                           enum pcie_link_width *width)
> >   {
> > -     struct pci_dev *parent =3D adev->pdev;
> > -
> >       if (!speed || !width)
> >               return;
> >
> > @@ -5922,13 +5933,11 @@ static void amdgpu_device_partner_bandwidth(str=
uct amdgpu_device *adev,
> >       *width =3D PCIE_LNK_WIDTH_UNKNOWN;
> >
> >       if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> > -             while ((parent =3D pci_upstream_bridge(parent))) {
> > -                     /* skip upstream/downstream switches internal to =
dGPU*/
> > -                     if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> > -                             continue;
> > +             struct pci_dev *parent =3D amdgpu_device_find_parent(adev=
);
> > +
> > +             if (parent) {
> >                       *speed =3D pcie_get_speed_cap(parent);
> >                       *width =3D pcie_get_width_cap(parent);
> > -                     break;
> >               }
> >       } else {
> >               /* use the current speeds rather than max if switching is=
 not supported */
> > @@ -5955,22 +5964,15 @@ static void amdgpu_device_gpu_bandwidth(struct =
amdgpu_device *adev,
> >       if (!speed || !width)
> >               return;
> >
> > -     parent =3D pci_upstream_bridge(parent);
> > -     if (parent && parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> > -             /* use the upstream/downstream switches internal to dGPU =
*/
> > +     /* use the device itself */
> > +     *speed =3D pcie_get_speed_cap(adev->pdev);
> > +     *width =3D pcie_get_width_cap(adev->pdev);
> > +
> > +     /* use the link outside the device */
> > +     parent =3D amdgpu_device_find_parent(adev);
>
> This is for GPU device's bandwidth and not the parent device. Suggest to
> cache both pdevs separately as link_dev (device which is connected to
> actual physical link) and link_partner (the other end of link) one-time
> during init. That will avoid confusion.
>
> Thanks,
> Lijo
>
> > +     if (parent) {
> >               *speed =3D pcie_get_speed_cap(parent);
> >               *width =3D pcie_get_width_cap(parent);
> > -             while ((parent =3D pci_upstream_bridge(parent))) {
> > -                     if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> > -                             /* use the upstream/downstream switches i=
nternal to dGPU */
> > -                             *speed =3D pcie_get_speed_cap(parent);
> > -                             *width =3D pcie_get_width_cap(parent);
> > -                     }
> > -             }
> > -     } else {
> > -             /* use the device itself */
> > -             *speed =3D pcie_get_speed_cap(adev->pdev);
> > -             *width =3D pcie_get_width_cap(adev->pdev);
> >       }
> >   }
> >
>
