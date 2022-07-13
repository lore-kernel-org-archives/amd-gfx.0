Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544FCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 21:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8799121F;
	Wed, 13 Jul 2022 21:01:13 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB159121F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 21:01:12 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id m16so15649218edb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kbIu/poYX3pcBRKw4rWzgBK7lbECGzr212jL4ni35Ho=;
 b=AtG4IkPgTHTpMOC2ZaVbLGwklzeeYCkSobIUg+wLPqmDM/EP68Zf2UaEi3lCCa3HSF
 elEUtK4updH7BuSxzT3/RHGXRG2/7d7ChVwuh0HliLbnqLLDBeVj4Q+MITKt1hxGA6WH
 uUAOMlXj+leugjBrhlUgu0zzMeN/vO6lHDahiSxdq8MSGtyi8J3xnogdpunfORYkp7l6
 XmM+jftVjFwUOHdTYwSxxzzrRgNA77x5d99SUwyjFmf88troHfbTAo0YYSloa9rwCTVE
 fF4128kbfxA2Gd3LuXZHCEYX2O6giQlNMMCqwgiz3cUHz8ZXIJ3LN4FgS6dwyGC/zlpf
 vZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kbIu/poYX3pcBRKw4rWzgBK7lbECGzr212jL4ni35Ho=;
 b=6MgVQxmLQSCkdG+bvqW1NyP8jhPz0xQzr9yHRCvyUVWHnOPGggc/TMYRDfUeYswh8v
 rNzUEfLfByIWRkXH1/MH6s7TZLoDINb415s2SWDq0oBinvAMKKUjp48UZhawPoyAM8cm
 uU5WC7HBR6fbN4CSxZ1d3rzmKuI1X/HTp7uccPx+b4vtyXGTgYGKUJKzDZW7Sg3b0vSf
 7c4y82Yr5VCV18SO2tvzf1T/CbuNJlmHjh14cOMtp0HWshlUFrTDCJR43NZYtrx6edzV
 HG2CaDo6pMYW8vbgTlQq67/27CnRah8Ge/hPL+1G7d/mkmJqzkOgd11YAcZYWbB932SO
 iJSQ==
X-Gm-Message-State: AJIora9GDIYL0d4OatgOymkAuYSOhlvbEjenYnoaotAg6jmC4yGDNjFg
 82GBv/zkWaMhYm+YHMarMwYdZ8AK/Hr+xoOhAqI=
X-Google-Smtp-Source: AGRyM1u+KjIBAW04aIMbzYtbKQ1e5saRu8r0r/mIv48udUXeFG75Z/LC+D2+ip4Z1OCCCzpQDRSSeUjdCCLnrqqrQtg=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr7648986edu.297.1657746069894; Wed, 13
 Jul 2022 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
In-Reply-To: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jul 2022 17:00:58 -0400
Message-ID: <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 4:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/13/22 12:36, Linus Torvalds wrote:
> > On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Same problems as every week.
> >>
> >> Building powerpc:allmodconfig ... failed
> >
> > Ok, this has been going on since -rc1, which is much too long.
> >
> >>From your patch submission that that was rejected:
> >
> >> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> >> 64-bit outline-only KASAN support") which adds support for KASAN. This
> >> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> >> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> >> compiled which lack the selection of hard-float.
> >
> > And considering that neither the ppc people nor the drm people seem
> > interested in fixing this, and it doesn't revert cleanly I think the
> > sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> > entirely.
> >
> > IOW, does something like this (obviously nor a proper patch, but you
> > get the idea) fix the ppc build for you?
> >
> >    @@ -6,7 +6,7 @@ config DRM_AMD_DC
> >            bool "AMD DC - Enable new display engine"
> >            default y
> >            select SND_HDA_COMPONENT if SND_HDA_CORE
> >    -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> > !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> >    +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> > KCOV_ENABLE_COMPARISONS)
> >            help
> >              Choose this option if you want to use the new display engine
> >              support for AMDGPU. This adds required support for Vega and
> >
>
> It does, but I can't imagine that the drm or ppc people would be happy
> about it.

If you want to apply Guenter's patch original patch:
https://patchwork.freedesktop.org/patch/490184/
That's fine with me.  It just kind of slipped off my radar.  We can
dig deeper on a better fix next cycle.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Guenter
