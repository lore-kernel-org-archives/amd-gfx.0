Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3878CCCF9E4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC0210EA5B;
	Wed, 25 Sep 2024 15:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gW28iDlS";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB81E10EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:53:59 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-20563b0264dso3088765ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727279639; x=1727884439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfZpVANn+KENV9Ub8dThEfUDGpE9iVPjQkDhWSeg1IA=;
 b=gW28iDlSpKL8CsOwuB2QMP/zJWubwQwkeekeanlAL3y7tZ227n2jo9cK0KCrhjWC/h
 qoAT9NXXAk0fO+dWYtIa3B+2I7MG19U9DvtzeyEePE7iPAw94NNCjK50p+d+gA/vO+LZ
 HePWy1h36y1FeVf8RLgSS0hEKyX0DPhAGkjIB/+E9qXjDlvdGLg6Q07L3ESdNVCKvzsT
 9TOwH7H4emNV7MzCjgHMEOIFxq0LE+rMk5Dy1feEkneybKSdshn7/oO2dnwkKZo+QAOb
 ODQFBtOwZnf3XenDA6aSQvuQbxP0yTlgJrbCVW6rNIqF8TgYMAN7X+BGloQpAnUWI1vd
 YZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727279639; x=1727884439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfZpVANn+KENV9Ub8dThEfUDGpE9iVPjQkDhWSeg1IA=;
 b=BZ5Qm+DH4H6GBmugkMw0nO3A9/1mDbzHfJxY8l+n6hoAEtqi5jbJRDHE+SPLVbunZF
 i3/C4MVlK7/c7lOSiZh2MXGB7H8aHBuR4BgK3t7r35BE8qqo2owTP16Yq3KgxhWhz+J/
 oP4/y8ezWGl9bdhZEcgCh5ktrc9k8Tex+jIHPVOY+TnU9Cnrwih+/tt2IszAccPIp4rN
 LixA5mDMroRdo91FbBqlbphI5RHxLgvCIjL9sNI8bOvjdnSdkcT/mBG3chc9xRdzmJE/
 DNUhQwVdTJ4ixHdIQwAOxkzI5u3ab8qfTcQy+003G5Kteoq8UDG5JHsihYDmr0hu0Ggy
 dCGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHw2ijycYUtydYwg+g7Sw5Dc4Y7N0q3an0volzdvVfKWlA7amVlbcmXRWd3btTxXro9aPhDdIk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxogMa8ANf3iIDlGuR2M1sgEgr4l+vVFmDS2mzP8YkshB3sq2ah
 E6IlYYb5XjeIpJ/JV0WzFmhnyRpRQUalIn71FIMsK4AsgErLL+hAjviZnRk8etjeGd7RAmvz4cy
 HC0yDUHgzjI2Lv7Q4d28C9B2Z9r2MuQ4J
X-Google-Smtp-Source: AGHT+IGM7TrWi1HMfO80QMDUBFHLiT/PXnxqiphfISOXCY8Bu+J+yhwvI5Yv5TkeZ6Dwt8PflIW/Nv+/7wLj/UjedIE=
X-Received: by 2002:a17:902:e2c2:b0:20b:9aa:efca with SMTP id
 d9443c01a7336-20b09aaf1d5mr11082775ad.9.1727279639340; Wed, 25 Sep 2024
 08:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240812044942.1670218-1-lijo.lazar@amd.com>
 <9c91d15357e30fb41af9f54fe85da5bb7d0d79a3.camel@declera.com>
In-Reply-To: <9c91d15357e30fb41af9f54fe85da5bb7d0d79a3.camel@declera.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Sep 2024 11:53:47 -0400
Message-ID: <CADnq5_NxDVkLN3ywXNUCdpOX4EZ23Vc=YHMP=uXaJmXkFjjLFA@mail.gmail.com>
Subject: Re: 6.12-rc0/regression/bisected - 9c081c11c621 drm/amdgpu: Reorder
 to read EFI exported ROM first - breaks connector enumeration and discovery
To: Yanko Kaneti <yaneti@declera.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Sep 25, 2024 at 11:46=E2=80=AFAM Yanko Kaneti <yaneti@declera.com> =
wrote:
>
> Hello,
>
> This commit in mainline (9c081c11c621) breaks connector enumeration and
> discovery for me here so my  PC->HDMI-to-DP->monitor stops showing
> anything after amdgpu starts.   Fedora rawhide 6.12 pre rc0 kernels.

Fixed in this commit:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/375b035f689735fd7a87ff3=
1ccac3a42717252bf
Which is already in my pending PR from last week.

Alex

>
> There is some
>   ...
>   amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from platform
>   amdgpu: ATOM BIOS: 13-CEZANNE-019
>   ...
>   ... UBSAN splat ....
>   kernel: UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/=
../display/dc/resource/dcn21/dcn21_resource.c:1312:29
>   ....
>   kernel: [drm:amdgpu_dm_init [amdgpu]] *ERROR* KMS: Failed to detect con=
nector
>
>
> Reverting the commit on top of mainline restores the video situation to
> normal. Without the UBSAN splat showing up.
>
>   amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from ROM BAR
>   amdgpu: ATOM BIOS: 13-CEZANNE-019
>   ...
>
>
>   Ryzen 7 5700G  IGP
>   Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Ra=
deon Vega Mobile Series] [1002:1638] (rev c8) (prog-if 00 [VGA controller])
>   Fairly old Gigabyte MB , but with BIOS from March this year.
>
> Regards
> - Yanko
>
> On Mon, 2024-08-12 at 10:19 +0530, Lijo Lazar wrote:
> > On EFI BIOSes, PCI ROM may be exported through EFI_PCI_IO_PROTOCOL and
> > expansion ROM BARs may not be enabled. Choose to read from EFI exported
> > ROM data before reading PCI Expansion ROM BAR.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> > index 618e469e3622..42e64bce661e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -431,6 +431,11 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
> >               goto success;
> >       }
> >
> > +     if (amdgpu_read_platform_bios(adev)) {
> > +             dev_info(adev->dev, "Fetched VBIOS from platform\n");
> > +             goto success;
> > +     }
> > +
> >       if (amdgpu_read_bios(adev)) {
> >               dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
> >               goto success;
> > @@ -446,11 +451,6 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
> >               goto success;
> >       }
> >
> > -     if (amdgpu_read_platform_bios(adev)) {
> > -             dev_info(adev->dev, "Fetched VBIOS from platform\n");
> > -             goto success;
> > -     }
> > -
> >       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >       return false;
> >
>
