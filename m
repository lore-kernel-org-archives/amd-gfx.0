Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA34C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 19:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C6310E59B;
	Fri,  7 Jan 2022 19:51:38 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3433110E59B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 19:51:37 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id t204so9624646oie.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jan 2022 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vlRc5NhtMjiKdzpPMCANUFGvyRstifrYCNetZhEMuBg=;
 b=XbjVpLy3Rk9lFRvc4ZTQo5DSxbJ4NYiD8JA3a04Shxm0dipJvTKXbp+3kE1Tb23+SH
 z4kAtiT19l1K3mTageSpCHVAvNTYO3aVOip8XbLXxUV1Fgoz9a2U4CbB1sW/DbZ0ZM+b
 0V97thi4BHxsVUPVLCHTzTeo3UvaOKhiydhsBuci/D+E+q2eEljaYdTZPLK/Pdv5Mmg9
 Mj1GjZ87nsQF4+RmyRHeiI7pAAh2qTzN9uUeQbA9WtJ1520XHtylllh5KyUvwmbyiC3X
 bH4K5kDoBh/i+RSnSC4tvnFGeBeUoH9Cq6XX+aIMhY7g+OIsoPyVnnVYXSDLvJGkiRQy
 lKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vlRc5NhtMjiKdzpPMCANUFGvyRstifrYCNetZhEMuBg=;
 b=kV+6pAAcb/AVPqGvQlmJDUYKL3ReSMAf3PnGpKHADqEdN/jxwnPgoKDigima1ZCFNk
 pVJLl7976fXpcOYWsTjd6SC2bkp4163BJH/lVZM6cNeAcOOA6vQYM5PDxmHjEsum+t18
 aj3SlGv46Xiu1DCzcOQVVy2rx18gOb3SKT04zJO9ZKk4LtYIgCm0QC7ZOgNm1ZNEv10z
 lYVIOHcb3R5q+VKtVuj0DILqIEfNRFNgIBq5ojMPY3eV2DuDtgbkZZ2nawOwSDkUYIYs
 sUwgQPFibe56/zTqKRGcKaRoeZtu7e/Xg2mznUiUBuHgkzZaC5Gg8NIRMvVAjfS+ay0y
 DDPA==
X-Gm-Message-State: AOAM531KUtX9hPsZYTlW7HAgHQcvEBcM3f+hu2S+IGxvuLy8qY4hNg+X
 fz9wE2KA2YOa7uEttWq6faf2ZN0SKCzVaS5ZDurbOlST
X-Google-Smtp-Source: ABdhPJzNV0HZFkhYXldObHjOv/yDSy6Lt4xZUOYtmhbBab2x80wpAwurCfDT3CvytklJaZEFiW2GLvZD+1PiuHkkoZs=
X-Received: by 2002:a05:6808:4c3:: with SMTP id
 a3mr11085212oie.123.1641585096407; 
 Fri, 07 Jan 2022 11:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20211230050019.18402-1-jsg@jsg.id.au>
 <cb3ed5ea-4f20-2cec-2e66-1931f210342d@amd.com>
In-Reply-To: <cb3ed5ea-4f20-2cec-2e66-1931f210342d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Jan 2022 14:51:24 -0500
Message-ID: <CADnq5_M8u4acQAmatbp_S_fyCUK2fCkNxJz52N-jFg7UP_EW2w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: use kernel is_power_of_2 rather than local
 version
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 tbullock@comlore.com, Jonathan Gray <jsg@jsg.id.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Dec 30, 2021 at 11:32 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 30.12.21 um 06:00 schrieb Jonathan Gray:
> > Follow the amdgpu change made in
> > 7611750784664db46d0db95631e322aeb263dde7
> > and replace local radeon function with is_power_of_2().
> >
> > Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_device.c | 19 +++----------------
> >   1 file changed, 3 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index 4f0fbf667431..15692cb241fc 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1085,19 +1085,6 @@ static unsigned int radeon_vga_set_decode(struct=
 pci_dev *pdev, bool state)
> >               return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
> >   }
> >
> > -/**
> > - * radeon_check_pot_argument - check that argument is a power of two
> > - *
> > - * @arg: value to check
> > - *
> > - * Validates that a certain argument is a power of two (all asics).
> > - * Returns true if argument is valid.
> > - */
> > -static bool radeon_check_pot_argument(int arg)
> > -{
> > -     return (arg & (arg - 1)) =3D=3D 0;
> > -}
> > -
> >   /**
> >    * radeon_gart_size_auto - Determine a sensible default GART size
> >    *                         according to ASIC family.
> > @@ -1126,7 +1113,7 @@ static int radeon_gart_size_auto(enum radeon_fami=
ly family)
> >   static void radeon_check_arguments(struct radeon_device *rdev)
> >   {
> >       /* vramlimit must be a power of two */
> > -     if (!radeon_check_pot_argument(radeon_vram_limit)) {
> > +     if (!is_power_of_2(radeon_vram_limit)) {
> >               dev_warn(rdev->dev, "vram limit (%d) must be a power of 2=
\n",
> >                               radeon_vram_limit);
> >               radeon_vram_limit =3D 0;
> > @@ -1140,7 +1127,7 @@ static void radeon_check_arguments(struct radeon_=
device *rdev)
> >               dev_warn(rdev->dev, "gart size (%d) too small\n",
> >                               radeon_gart_size);
> >               radeon_gart_size =3D radeon_gart_size_auto(rdev->family);
> > -     } else if (!radeon_check_pot_argument(radeon_gart_size)) {
> > +     } else if (!is_power_of_2(radeon_gart_size)) {
> >               dev_warn(rdev->dev, "gart size (%d) must be a power of 2\=
n",
> >                               radeon_gart_size);
> >               radeon_gart_size =3D radeon_gart_size_auto(rdev->family);
> > @@ -1163,7 +1150,7 @@ static void radeon_check_arguments(struct radeon_=
device *rdev)
> >               break;
> >       }
> >
> > -     if (!radeon_check_pot_argument(radeon_vm_size)) {
> > +     if (!is_power_of_2(radeon_vm_size)) {
> >               dev_warn(rdev->dev, "VM size (%d) must be a power of 2\n"=
,
> >                        radeon_vm_size);
> >               radeon_vm_size =3D 4;
>
