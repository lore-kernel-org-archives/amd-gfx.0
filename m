Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C08C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 19:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D6912B83E;
	Wed, 13 Jul 2022 19:53:36 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA5F12B3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:53:35 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id l23so21707482ejr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l/Aa2i/NI4m1X4kDhlcdt3Xuwk3YVyAJSEMRolDuwOA=;
 b=qiaNyi8gZbGRch/EC5OIQUoxCWCSrVioaObBXX79HXG2BJYmQfyYBkJp8dltsZ6qHB
 7BYRLE1rgxaG/xHfdYJEows6S6wzSvLzSyU8rzJD1WMoSq070XIxwgMpQ9rJKYJ6vG2q
 fJ201m2Z8ViUVWCmPsMieh9XzhEwQTOYUvr7D/cYC5c7g3l7WBHvs1dWlDNZM1LL87I6
 Nr9RzTTN+m3JHMGJMeVRhSHYjiWzhBrPooLBFzhckw8XTr/ZR3+hd9Fa2UdEU4y7swvi
 NI0tBE574JkpgAXpXwXtX5QjtZzYS4oZD0kiMHZ/Um5fHa8RMHfsIq8+kQ405nIQQERm
 tG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l/Aa2i/NI4m1X4kDhlcdt3Xuwk3YVyAJSEMRolDuwOA=;
 b=1bMSX79PFbXmOpkmYgXU2nhz7etUSum4g2i5BDLYJkPP6N4G9t6Cq9IiDFif0+eU42
 3SmWnNdmNjiF3vxcJi2UGVVxzTOa9vlFrqdwKyV3+Wds97wXXBO/m23JOzbKtMMOFHbM
 PEXKI29K/rOXq2EfkSHctCWnAPmg3lUI9FJq9qD1L/Iu47BaKbUMSdb3TQFcUvfmoYAW
 JOKpSoavoMZrNHnqBW4xJKXIcoPzr9deHyNcVV8BWC+sEe8FfkMI98qxVc4ls6072ZoH
 cHTp/gC5MpbeR09oQlaY3UWPogngCZmJIwmKvBBepH8hC1Qlxa96jbdSvKfc7i5xL/xU
 BEtA==
X-Gm-Message-State: AJIora9taIY2k0CbxLMlG1hKRsqg/g7/VLSGve/tpF9PcPhPYiejTJPA
 Y3A4oESe5UP1KOPgzc1vrQy6/LR/hoLrRbJAQHM=
X-Google-Smtp-Source: AGRyM1uBA9rYKWyS3Q9KrdsjlMnntUrL2Kqp2HZq2hLys6YhMbT1RuIVmkQvn48D4AnLbW4aesEal694MksFCwDvDQk=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr5085294ejc.185.1657742013675; Wed, 13
 Jul 2022 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jul 2022 15:53:21 -0400
Message-ID: <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 3:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Same problems as every week.
> >
> > Building powerpc:allmodconfig ... failed
>
> Ok, this has been going on since -rc1, which is much too long.
>
> From your patch submission that that was rejected:
>
> > The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> > 64-bit outline-only KASAN support") which adds support for KASAN. This
> > commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> > KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> > compiled which lack the selection of hard-float.
>
> And considering that neither the ppc people nor the drm people seem
> interested in fixing this, and it doesn't revert cleanly I think the
> sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> entirely.

Does this patch fix it?
https://patchwork.freedesktop.org/patch/493799/

Alex

>
> IOW, does something like this (obviously nor a proper patch, but you
> get the idea) fix the ppc build for you?
>
>   @@ -6,7 +6,7 @@ config DRM_AMD_DC
>           bool "AMD DC - Enable new display engine"
>           default y
>           select SND_HDA_COMPONENT if SND_HDA_CORE
>   -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>   +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> KCOV_ENABLE_COMPARISONS)
>           help
>             Choose this option if you want to use the new display engine
>             support for AMDGPU. This adds required support for Vega and
>
> > OF: amba_device_add() failed (-19) for /amba/smc@10100000
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> > refcount_t: underflow; use-after-free.
>
> This too has been going on since -rc1, but it's not obvious what caused it.
>
> At a guess, looking around the amba changes, I'm assuming it's
>
>   7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>
> Does reverting that commit make it go away?
>
>                     Linus
