Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740E3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC13F10E613;
	Thu, 21 Apr 2022 14:19:29 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853DB10E613
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 14:19:28 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-e5c42b6e31so5483300fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pv83t+Wfa0RgkWq5oP2jQnVOPHkxsO+psRKQH5BQ4io=;
 b=GY6dZIFlF5OFajBs1ZM5ympEdmDszfW5v/hLyu9yjhYCHOsWi2rkPDL4l6B4RXBKRF
 KIXe8ZWcqlQ8jRKs5RoPVgAnzgvd3caxzL1e5CjljotL++YW6K/WshkWKeG3g2QvXSkF
 YN7iHfrPf6eOlyQOv9AYZutYGHYNBEO6ioA403+2YHix3zoUETYnsvwWon4n+0RvbsKE
 zC3r7K6azKa9ENKjDlL+J7iTngeKHHDvtUTSX2L0mjvGb0OptFTnYVcFm57Qq1aqEnSt
 smXq2ORfhsWzFbtG+/ieTvJDPHOGWWCrOyQMJgDpdet+jgKkeud/UbENM0Mu+L8iIeq0
 wjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pv83t+Wfa0RgkWq5oP2jQnVOPHkxsO+psRKQH5BQ4io=;
 b=2BIjwpcLlQUTHMWsDP4nH9rDGMpCvMcNXARBs6A9CBod2Af700kqqCZqzY1ehMsUiR
 n6WRhpn78m6e6g3zWKOx619SyXEH73dn6wCa6ge/2uzHc9JlDJNr+o1xsxbH0AnvSlhO
 bJuvVihupi1n0m1+WehKh1qc9fC4ZdmYF+5vGmxvZmRSTMr9mWKJ/jlLgOYnqQ6LGjal
 FDwc1SH6ConqFpiLmoSmCIIBA4GYXG+lxPUgCqIEkXhjNEzAHzch3LWroIg5l3fwf4XC
 WVu4a5fegMB675CKTcq9YJrE/m1SHLO0Q0k81Zc6jbpoNLZGSM+XJfaNStYJSAxoXEO0
 ZhsA==
X-Gm-Message-State: AOAM532p5YFPVrpcYugc+4vtEX84uMOV2r1jAHvOAc3PU+tyj85MjoS3
 UW1yW1Cun9cTwACiD4G8FoDYYxmwCd/3QSL7Zz8=
X-Google-Smtp-Source: ABdhPJw8wsi02jdIMjhzivObtRyt45FyVBVW9xIt0/AgOHSagaj9PdnsrZsXpuoXVkhbdLBHVw1SoyCH2+Kh7n6MFe0=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr4072907oap.253.1650550767782; Thu, 21
 Apr 2022 07:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220421031607.1745623-1-alexander.deucher@amd.com>
 <550cf7fc-47fa-777d-892d-8ec0b9d15445@leemhuis.info>
In-Reply-To: <550cf7fc-47fa-777d-892d-8ec0b9d15445@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 10:19:16 -0400
Message-ID: <CADnq5_Ng=3meBGW=scQrKh1e5D4KsPTt8y07SSbWKvv3EmATQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
To: Thorsten Leemhuis <regressions@leemhuis.info>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Michele Ballabio <ballabio.m@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 21, 2022 at 9:06 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 21.04.22 05:16, Alex Deucher wrote:
> > We normally runtime suspend when there are displays attached if they
> > are in the DPMS off state, however, if something wakes the GPU
> > we send a hotplug event on resume (in case any displays were connected
> > while the GPU was in suspend) which can cause userspace to light
> > up the displays again soon after they were turned off.
> >
> > Prior to
> > commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
> > the driver took a runtime pm reference when the fbdev emulation was
> > enabled because we didn't implement proper shadowing support for
> > vram access when the device was off so the device never runtime
> > suspended when there was a console bound.  Once that commit landed,
> > we now utilize the core fb helper implementation which properly
> > handles the emulation, so runtime pm now suspends in cases where it did
> > not before.  Ultimately, we need to sort out why runtime suspend in not
> > working in this case for some users, but this should restore similar
> > behavior to before.
> >
> > v2: move check into runtime_suspend
> > v3: wake ups -> wakeups in comment, retain pm_runtime behavior in
> >     runtime_idle callback
> >
> > Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> > Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > [...]
>
> Hi Alex, how can I bribe you to start placing "Link:" tags in
> submissions that fix regressions (like this one), as explained in the
> Linux kernels documentation (see
> 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'). E.g. in this case like this:
>
> "Link:
> https://lore.kernel.org/r/20220403132322.51c90903@darkstar.example.org/"
>

Done.  Thanks.

Alex

> This concept is not new (Linus and quite a few other developers use them
> like this for a long time), I just recently improved those documents to
> clarify things, as my regression tracking efforts rely on them -- that's
> why it's making my work a lot harder if they are missing most of the
> time. :-/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>
> #regzbot ^backmonitor:
> https://lore.kernel.org/lkml/20220403132322.51c90903@darkstar.example.org/
