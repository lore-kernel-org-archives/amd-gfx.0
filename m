Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19778C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 14:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED9210E681;
	Wed, 17 Jan 2024 14:31:39 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F013410E6B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 14:31:37 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-3bbd6ea06f5so4813658b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705501837; x=1706106637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdWlULUSVmOqGo2Eus7UmJo1SDfF9+ujLChppEYFFDM=;
 b=B4QA+3a8K+UlMvOxSWK7evR69lfMhK3mDHimH6NNcGCHW/5DJDrChng9l7VMsUJYtE
 cenPlfJ97RhHNp9TZ79TGsu4EhsCzuEPGFY4/WqUn3AP0WKWC8QG/zWYmqM82uKm9eud
 u8tUIN2dJQod7BosH6B5qFcClSDEvphGb0s1ukWEHUni+Je2Rjm/wS9WkeHOB+IEm8Ns
 T+1mn7MsRE+YAFX0Fuf+AbQTmYy4pg5LHtsnMgDqMJYC2XWhVoeJz+Sq9fHSrwvKrr/h
 PLvoGS+2MQD9scvLk6NYj5uRI+DBJbSK2GzJj0BWUtCJ78OrImO4a8wAMt78MRyejdaT
 2h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501837; x=1706106637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdWlULUSVmOqGo2Eus7UmJo1SDfF9+ujLChppEYFFDM=;
 b=eoZUBgoqNq4IiClvz8S1ABMTfe27FQKd33Y/QVk053w2lNrd89knY3nWSicU337R0r
 mLfpSoXFta9edlbPoVAKkwqekWwvu1+6lFq2ITL7WKi8a/u9QuGam84Wma2psaTylw0u
 WBczV6eOI9blIKvbQqcxvn5jdRaUgPe3nWY0lfkraGJoJ2mUs237cFU6gp+i/NIxNKM3
 UZ240eJGoWHJujTNRGzTdVbbiNghnAly2IARJMRi+M9josWYfVLl4P0Yf9EjG1w9J3lt
 2Pbw1LWRHXOtpTBBDHmM3NbdZMF+RC8WkMXeoT75bXB5lyNETJrK5hxyifClFYT6FoZo
 I/Xg==
X-Gm-Message-State: AOJu0YxXxbKz58cHTQpAktVXWgQWbU+Kcw9WbZ9Nygg2HVyPlrCMWhjz
 Vqr5e1n+6X3pDG6Zi9WU9cO+goiLnQZGoYL/q68Gn23SxW1rWs81hIpvwJIAXtf3+WUU2+H+CF0
 Yb4ZaoY2wMjqs2y7VAwFVKLhyXMM=
X-Google-Smtp-Source: AGHT+IHGiCWxsZ7262Zj5NJtj0zJg6gCpTQc8MktJL4HOaSgdO3BoXBrhm7+nERKOEv6gRG0V08Nv17r7E1DA67FMho=
X-Received: by 2002:aca:1115:0:b0:3bd:21d6:778d with SMTP id
 21-20020aca1115000000b003bd21d6778dmr319594oir.27.1705501837122; Wed, 17 Jan
 2024 06:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20240116143914.2991405-1-alexander.deucher@amd.com>
 <c67fa6a6-5608-42cd-8568-e8a8d080726b@gmail.com>
In-Reply-To: <c67fa6a6-5608-42cd-8568-e8a8d080726b@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jan 2024 09:30:25 -0500
Message-ID: <CADnq5_PfN_-4DPt=cOfjpSfE2MnvhsR4wBe=qJ__DpcxiSXuOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: only remove existing FBs for devices with
 displays
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 17, 2024 at 2:42=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 16.01.24 um 15:39 schrieb Alex Deucher:
> > Seems calling drm_aperture_remove_conflicting_pci_framebuffers()
> > will take away the apertures for unrelated devices on some kernel
> > versions.  E.g., calling this on a PCIe accelerator with no display
> > IP may take the apertures away from the actual PCIe display adapter
> > on the system, breaking efifb, depending on the kernel version.
> >
> > Just do this if there is display IP present.
>
> I would have checked the PCI device type instead, because a system BIOS
> most likely has no idea that a VGA device doesn't has a connector.

True, but we have GPUs of PCI class PCI_CLASS_DISPLAY_OTHER that can
have efifb bound to it.  Unfortunately, the combinations of PCI
classes and displays is complicated:

PCI_CLASS_DISPLAY_VGA - boards both with and without display hardware
PCI_CLASS_DISPLAY_OTHER - boards both with and without display hardware
PCI_CLASS_ACCELERATOR_PROCESSING - no display hardware

>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 62772b58ef3d..353c38f008e8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4056,10 +4056,12 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >
> >       amdgpu_device_set_mcbp(adev);
> >
> > -     /* Get rid of things like offb */
> > -     r =3D drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev=
, &amdgpu_kms_driver);
> > -     if (r)
> > -             return r;
> > +     if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
>
> This certainly worth a comment why we do this.
>
> Apart from that I'm not sure we should upstream this, the customer
> kernel is most likely just missing this fix here:
>
> commit 5ae3716cfdcd286268133867f67d0803847acefc
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Thu Apr 6 15:21:07 2023 +0200
>
>      video/aperture: Only remove sysfb on the default vga pci device
>
>      Instead of calling aperture_remove_conflicting_devices() to remove t=
he
>      conflicting devices, just call to aperture_detach_devices() to detac=
h
>      the device that matches the same PCI BAR / aperture range. Since the
>      former is just a wrapper of the latter plus a sysfb_disable() call,
>      and now that's done in this function but only for the primary device=
s.
>
>      This fixes a regression introduced by commit ee7a69aa38d8 ("fbdev:
>      Disable sysfb device registration when removing conflicting FBs"),
>      where we remove the sysfb when loading a driver for an unrelated pci
>      device, resulting in the user losing their efifb console or similar.
>
>      Note that in practice this only is a problem with the nvidia blob,
>      because that's the only gpu driver people might install which does n=
ot
>      come with an fbdev driver of it's own. For everyone else the real gp=
u
>      driver will restore a working console.
>
>      Also note that in the referenced bug there's confusion that this sam=
e
>      bug also happens on amdgpu. But that was just another amdgpu specifi=
c
>      regression, which just happened to happen at roughly the same time a=
nd
>      with the same user-observable symptoms. That bug is fixed now, see
>      https://bugzilla.kernel.org/show_bug.cgi?id=3D216331#c15
>

yeah, that looks like the right fix.

Alex


> Regards,
> Christian.
>
> > +             /* Get rid of things like offb */
> > +             r =3D drm_aperture_remove_conflicting_pci_framebuffers(ad=
ev->pdev, &amdgpu_kms_driver);
> > +             if (r)
> > +                     return r;
> > +     }
> >
> >       /* Enable TMZ based on IP_VERSION */
> >       amdgpu_gmc_tmz_set(adev);
>
