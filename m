Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A534BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 19:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461C910E357;
	Thu, 24 Mar 2022 19:32:42 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C721E10E357
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 19:32:41 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id t21so1049949oie.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZLDoXtxzLXNABwcFLETn83t4o2M6MLDJpJw02fY5vh4=;
 b=JOLXApP+VEDQbZGdxfDMxliKkDn8PnWYwZXfrt8aTpw60eoQk93YFqltRsXCMfBlcg
 3i35WEZvngjYA+iOoyahqlmnDYaMXYDU14pxs4nIilir73J6PsIcm0Kc7y5XiXtkzSgm
 yopQ1CBixs/bxvIuhByVcg47YrkASgFOmatv+RLtS9iKUnwnadrFZOj8JU2i/dMfwRaJ
 uLcJWD5XkYUNJWQBPvZOxpPTiHOUU/kDEA9VOMlx//ShrRzn5w9g5YBtJzcZKll3taDp
 bH29K+k9G3MhluBbl5slM9yXnoR0YfLaFtU6dhBz8qKXtV5cBc1LSlcFmAcW6v2TKOig
 vCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZLDoXtxzLXNABwcFLETn83t4o2M6MLDJpJw02fY5vh4=;
 b=oS+cnocdDNwZaoZsseWCKtk9V+PNbptPKyvr1wC74DUOuQCJ40wOK4r8Nd6O4KTmhu
 D3tT/nt8+9Y9xFMBEbFKZUv2a+LariDr6SRrN0cL34tRjmU5nns7rQk0t4dItDt8VPrS
 pOYX9D0PyeyxqxNGgnSJhIQrvhVbFUZKc6vR+QzIzI0TMRicL8pqFJCp3wqqVLKgMADD
 P3Djl2Zx33TQTK/DLaG4adUUA+GWg//R6CJTi4FX/GaLTAk2OYJJPijxDHYP8GuGBI1M
 ULgh92/E/dt1zcXwmX5zQ+TRjLzjbE57BEytc9kRQHjbGqzFpY2P+kwT7WCH2s5ajFMH
 AK8w==
X-Gm-Message-State: AOAM530AW7qJBn39d9zi65GtU3R1J2KPHkc776zLI2oSC5thPZqLoZEO
 SYFmV4hS1gmt9KfVKUiOExKZB+0B+lLvPv5Tp4c=
X-Google-Smtp-Source: ABdhPJzTVIriERJiN43Oj0zgvyifAoVcqs+BQczUJdlfRq84EaxmBfpH5ag3ZtVJCcVz7lvXa+1cTe/u6D8B2fMdPlc=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr7731857oic.200.1648150360679; Thu, 24
 Mar 2022 12:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHtRFGvj1DuYzUUL1P5bvfMpT1WkwUL2ZpZQt1iYf-XH=fJP0Q@mail.gmail.com>
 <CAHtRFGvDmdMkc4r5Ko8osJPeGiWQnPwcABY=4WzweYz50WQQMg@mail.gmail.com>
 <b49b4bc2-d4fc-4992-c616-3192a641fdd7@molgen.mpg.de>
In-Reply-To: <b49b4bc2-d4fc-4992-c616-3192a641fdd7@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Mar 2022 15:32:29 -0400
Message-ID: <CADnq5_PUWWtWSZWDxZFmddGw06UyXs4k1hSY8r=53vUXNa1RSA@mail.gmail.com>
Subject: Re: ATI Radeon Mobility 3470 fails with Kernel 5.0
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: Craig M <cmroanirgo@gmail.com>, regressions@lists.linux.dev,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 24, 2022 at 2:07 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Craig,
>
>
> Am 24.03.22 um 02:09 schrieb Craig M:
> > I should add some further information:
> >
> > I have tried using Manjaro KDE, Kubuntu 20 and Kubuntu 18.03 live
> > disks and all exhibit this 'tearing' issue.
> >
> > The problem begins rather early on in the boot sequence while the TUI
> > is logging the startup information and continues to be a problem as
> > the screen becomes graphic.
> >
> > I feel that I should be able to rectify this with a setting change.
> >
> > Again, Thanks for any help.
> > Craig.
>
> In the future, it=E2=80=99d be great if instead of top-posting you used
> interleaved style.
>
> > On 3/24/22, Craig M <cmroanirgo@gmail.com> wrote:
> >> Hi,
> >>
> >> I'm trying to track down a problem with an ancient graphics device ATI
> >> Radeon Mobility 3470.
> >>
> >> Ubuntu/Kubuntu 18 is shipped kernel 4.18 and the radeon drivers work w=
ell.
> >> With 18.02 and later it ships with kernel 5.0 and the radeon drivers d=
on't.
> >>
> >> What I'm seeing is hard to describe. It looks a lot like the scan
> >> lines are interleaved and there's a lot of noise. It's not the typical
> >> screen tearing, nor is it just snow (black and white noise). I can
> >> *just* make out what it being displayed onscreen, but hurts the eyes a
> >> lot to try and do so!
> >>
> >> If I hold the kernel back at 4.18 things are just fine.
> >>
> >> Some detailed info (from a working 4.18 kernel). Note that the
> >> returned information from a 5.x kernel isn't all that much different:
> >>
> >> $ lshw -c video
> >> *-display
> >>        description: VGA compatible controller
> >>        product: RV620/M82 [Mobility Radeon HD 3450/3470]
> >>        vendor: Advanced Micro Devices, Inc. [AMD/ATI]
> >>        physical id: 0
> >>        bus info: pci@0000:01:00.0
> >>        version: 00
> >>        width: 32 bits
> >>        clock: 33MHz
> >>        capabilities: pm pciexpress msi vga_controller bus_master
> >> cap_list rom       configuration: driver=3Dradeon latency=3D0
> >> resources: irq:26 memory:c0000000-c7ffffff ioport:9000(size=3D256)
> >> memory:c8020000-c802ffff memory:c0000-dffff
> >>
> >>
> >> $ modinfo radeon
> >>
> >> filename:
> >> /lib/modules/4.18.0-17-generic/kernel/drivers/gpu/drm/radeon/radeon.ko
> >> license:        GPL and additional rights description:    ATI Radeon
> >> author:         Gareth Hughes, Keith Whitwell, others.
> >>
> >> ...
> >> name:           radeon
> >> vermagic:       4.18.0-17-generic SMP mod_unload
> >> signat:         PKCS#7
> >> signer:
> >> sig_key:
> >> sig_hashalgo:   md4
> >> ....
>
> Looking at the output of `dmesg` might also help.
>
> >> I'm just trying to track down the driver changes between 4.18 and 5.0
> >> to see what I can do to change settings. Any help  would be greatly
> >> appreciated. I've had a quick look through
> >> https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati but I don't
> >> know where to start (as there's no correlation between releases and
> >> kernels, from what I can see).
>
> As switching the Linux kernel version works, you need to look at the
> driver in the Linux kernel. As you can easily reproduce your problem,
> and you are most likely alone with this old hardware, bisecting will
> probably the way to go. First you can try the packages from Ubuntu=E2=80=
=99s
> Kernel PPA [1]. Figuring out, in what version the regression occurs, you
> then build the Linux kernel yourself, for example with `make
> bindeb-pkg`, and try to find out the exact commit. There should be some
> guides on the WWW explaining all this in detail.

Yeah, as Paul said, bisecting is probably your best bet.  The radeon
driver has largely been in maintenance-only mode for the last few
years so it hasn't really seen any changes other than misc bug fixes
or cross component API changes.

Alex

>
>
> Kind regards and good luck,
>
> Paul
>
>
> PS: It would also be nice to know, if the problem is still present in
> Linux 5.17.
>
>
> [1]: https://kernel.ubuntu.com/~kernel-ppa/mainline/
