Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062A4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 01:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC6110E19C;
	Thu, 24 Mar 2022 01:09:24 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9825F10E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 01:09:22 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id 185so3339266vsq.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=wKA3ekedOIhTei5Vb6g+2SdNLTD927v4cfDYPY1S6WA=;
 b=QSD5vvRlGfsp90pdiYg8tEdXGKq/pLAcGHbxL+zKnAm8LVmSXNhJ6O3T2rQd9qNl49
 IURrm/WAQk1U8t7Bp9ILQpV1jlJjclXU2rneRyo7jCeVkGWd/QzP0RHFliGo2o0kIXTc
 WhDjkTbBWAcY9R/SVou/+7BSA3ztS4yZkwTGSD4kpa7iAWew3JKSwN62V8q8LGWKFUBy
 N5B09OAf9elbjZm+W6OZ8IMGDrekNLyd9KK3joLw0Wlkhpl7E7B0j55lHW904AFsB8r8
 px2EKyrz+IXFQHOfIxw1xaeNLNkQBbpNURAaVXHW+9Oe70Q3Fw5ThytNr3p6stHcDsob
 v+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=wKA3ekedOIhTei5Vb6g+2SdNLTD927v4cfDYPY1S6WA=;
 b=KdMCiRFIzt7Snr1EPJg8LOJ4rcpBlhoGGoRVLJm4uQSNNf3xSKLUmDApsGooPc/gHk
 UEz+0eFosGLglmsCZTvLMm7lp+aHt2IzpXZxQmdc0UYgQJ1Zz8tiJ54LYuRfoWlUgunb
 aVdxBG521sCwzPml+4NuKY7AufSsDmTuWFW1lu2bAzi9/CsefoLxQl/NAsDp+l9fnwrC
 TPv/HEx8cMd+2rUKsVbTuzutl/3+dY6J1mGoPj4xtzd5EeJ7lOvLgO2m0R0j3LK+2I4z
 B8hK1xBiLmOcWNkzvHLxnHplnzBuVjXTo3+yVV/DV6Tb9sct3NpaBDvwS5Uy1xgptRFj
 eZ+w==
X-Gm-Message-State: AOAM531yvAD+rNQ9+SoDshx2d3p/GRaKtVRIuGe34uPU9i12KEcivcLe
 3JOY7o5BmXZMecDJpVPsifnn9JwUncgqvloym4UIg0/IEzM=
X-Google-Smtp-Source: ABdhPJzOy6VdUi9QSU2WyZHxgCiMigYFAdDaL7/ejTHAQbxTbnxRfAffY1W1nflcCm/rCxdbzCItqn7dN7+YLn+1P04=
X-Received: by 2002:a05:6102:a90:b0:31b:6ed9:7702 with SMTP id
 n16-20020a0561020a9000b0031b6ed97702mr1600731vsg.70.1648084161570; Wed, 23
 Mar 2022 18:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:2287:b0:28d:c775:b69f with HTTP; Wed, 23 Mar 2022
 18:09:21 -0700 (PDT)
In-Reply-To: <CAHtRFGvj1DuYzUUL1P5bvfMpT1WkwUL2ZpZQt1iYf-XH=fJP0Q@mail.gmail.com>
References: <CAHtRFGvj1DuYzUUL1P5bvfMpT1WkwUL2ZpZQt1iYf-XH=fJP0Q@mail.gmail.com>
From: Craig M <cmroanirgo@gmail.com>
Date: Thu, 24 Mar 2022 12:09:21 +1100
Message-ID: <CAHtRFGvDmdMkc4r5Ko8osJPeGiWQnPwcABY=4WzweYz50WQQMg@mail.gmail.com>
Subject: Re: ATI Radeon Mobility 3470 fails with Kernel 5
To: amd-gfx@lists.freedesktop.org
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

I should add some further information:

I have tried using Manjaro KDE, Kubuntu 20 and Kubuntu 18.03 live
disks and all exhibit this 'tearing' issue.

The problem begins rather early on in the boot sequence while the TUI
is logging the startup information and continues to be a problem as
the screen becomes graphic.

I feel that I should be able to rectify this with a setting change.

Again, Thanks for any help.
Craig.

On 3/24/22, Craig M <cmroanirgo@gmail.com> wrote:
> Hi,
>
> I'm trying to track down a problem with an ancient graphics device ATI
> Radeon Mobility 3470.
>
> Ubuntu/Kubuntu 18 is shipped kernel 4.18 and the radeon drivers work well=
.
> With 18.02 and later it ships with kernel 5.0 and the radeon drivers don'=
t.
>
> What I'm seeing is hard to describe. It looks a lot like the scan
> lines are interleaved and there's a lot of noise. It's not the typical
> screen tearing, nor is it just snow (black and white noise). I can
> *just* make out what it being displayed onscreen, but hurts the eyes a
> lot to try and do so!
>
> If I hold the kernel back at 4.18 things are just fine.
>
> Some detailed info (from a working 4.18 kernel). Note that the
> returned information from a 5.x kernel isn't all that much different:
>
> $ lshw -c video
> *-display
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0description: VGA compatible controlle=
r
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0product: RV620/M82 [Mobility Radeon H=
D 3450/3470]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vendor: Advanced Micro Devices, Inc. =
[AMD/ATI]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0physical id: 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus info: pci@0000:01:00.0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0version: 00
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0width: 32 bits
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock: 33MHz
>       capabilities: pm pciexpress msi vga_controller bus_master
> cap_list rom =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configuration: driver=3D=
radeon latency=3D0
> resources: irq:26 memory:c0000000-c7ffffff ioport:9000(size=3D256)
> memory:c8020000-c802ffff memory:c0000-dffff
>
>
> $ modinfo radeon
>
> filename:
> /lib/modules/4.18.0-17-generic/kernel/drivers/gpu/drm/radeon/radeon.ko
> license: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPL and additional rig=
hts description: =C2=A0=C2=A0=C2=A0ATI Radeon
> author: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Gareth Hughes, Ke=
ith Whitwell, others.
>
> ...
> name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0radeon
> vermagic: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04.18.0-17-generic SMP mod_u=
nload
> signat: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PKCS#7
> signer:
> sig_key:
> sig_hashalgo: =C2=A0=C2=A0md4
> ....
>
>
>
> I'm just trying to track down the driver changes between 4.18 and 5.0
> to see what I can do to change settings. Any help  would be greatly
> appreciated. I've had a quick look through
> https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati but I don't
> know where to start (as there's no correlation between releases and
> kernels, from what I can see).
>
> Regards,
> Craig.
>
