Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47710C61DB3
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAE710EA14;
	Fri, 13 Jan 2023 15:09:31 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9924010EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:09:30 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id r205so17899558oib.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qWsmA91njJFI48LoPfQPZEYK4lxRnEt8yXihY6/F4gM=;
 b=llvECa0G46ghb0PsZ8ielz3IwkKWjgB2dd4h2QnnzpSlaUGEC+ljKGZeiq+Tjip/d3
 tbuwTIkMnhUWtbyY0sQzv5HzPHQL3mLo/+oRdblbflsdPdFeEsEnFnqG911zCncvD85c
 s1aYr4W7h4cs5x2/McY+REOTMkfK1M/pItdmCtVZWEASqGBuH0aez/I8ZXDlrAW4PGT1
 pZYgCbhQgO8ZhShEdeTl0XMh7umay+INWF3gEp3jahM3vXZ0DLxIFSRWLY7/yrDd19pa
 7o6bpd3HvaJ/eOttGyubR8F3ZSEPmA5xw+vL6aJ9zsiDg9HRK/KxADDGyVaOX6Sah8PC
 KW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qWsmA91njJFI48LoPfQPZEYK4lxRnEt8yXihY6/F4gM=;
 b=eIFJJXpdYkoMj6ue+4ZKoVj77GAA13/skv7BfzpMhuqvXmO8j1P7gv1HQdr7Wp6Wl4
 nxcB/q6eP89n4jCjxu165enOVjNSJPHZuHetd0k7KjWgubcw6xOaIyC8ZrIkQGaHuTZG
 S9p2EAcIpoDU2+O8ggERg5r18oswUnGJROw+vvtsTJXETIxyw5ZgFJ9uVpRM/q/vmpdL
 A1eRrMqhjPloDa9MUXsNvJX9/RJH6XvchJw4QD3F2UmBpflAp4grVyJ1GoqdTJPOsGhm
 48U+VLmYV97FbOtjgqr79kNxUyx1ueJ6eTGvuzTiclTobMpBwt/dNGac4bRurvRjQVEy
 Mhzg==
X-Gm-Message-State: AFqh2krYHDKEMnJQqPx7vycGNCEpd8UAQh9yZveEpVaGQDEgABZmRxWi
 WTMgJsPu0SsiJ08rM+NemEu5YT3TUOacCkIjmROdTOfa
X-Google-Smtp-Source: AMrXdXtj1BRoQaKNxRRMM36k08WWjfD4tXW5wz6kMxW+Wvn3dcIZasEQIh99gnqfcntDaYM93FRnN+3DUDDOdLgsd9k=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr5260649oiw.96.1673622569839; Fri, 13 Jan
 2023 07:09:29 -0800 (PST)
MIME-Version: 1.0
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
 <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
 <CAG=7Bt8xY_SHQwNCDgFCSNczBPxjUwjf_yvR_Ox-_XS+DVuJxA@mail.gmail.com>
In-Reply-To: <CAG=7Bt8xY_SHQwNCDgFCSNczBPxjUwjf_yvR_Ox-_XS+DVuJxA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 10:09:18 -0500
Message-ID: <CADnq5_NEznbC8FDjaA+WPqTMLX7nuN7MdvdFWDYNXK_F3y=hQQ@mail.gmail.com>
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
To: Braiam <braiamp@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 10:05 AM Braiam <braiamp@gmail.com> wrote:
>
> AMD RX 590. Forgot to include it. How do I know the blanking period?

OK polaris falls into the first bucket.  Look at the full modelines.
E.g., xrandr --verbose.

> Would variable refresh rate mess up with that?

Probably.

Alex

>
> On Fri, Jan 13, 2023 at 10:57 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 9:47 AM Braiam <braiamp@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I have two monitors with the current following configuration:
> > >
> > > Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
> > > DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
> > > right x axis y axis) 597mm x 336mm
> > >    2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
> > > 143.97   120.00    74.97
> > > [snip]
> > > DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
> > > axis y axis) 597mm x 336mm
> > >    2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
> > > 50.01    48.01   144.00   119.99    99.99
> > > [snip]
> > > HDMI-A-0 disconnected (normal left inverted right x axis y axis)
> > > HDMI-A-1 disconnected (normal left inverted right x axis y axis)
> > > DVI-D-0 disconnected (normal left inverted right x axis y axis)
> > >
> > > The pp_profile_mode:
> > >
> > > NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
> > > SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
> > >   0   BOOTUP_DEFAULT:        -                -                -
> > >          -                -                -
> > >   1 3D_FULL_SCREEN *:        0              100               30
> > >         10               60               25
> > >   2     POWER_SAVING:       10                0               30
> > >          -                -                -
> > >   3            VIDEO:        -                -                -
> > >         10               16               31
> > >   4               VR:        0               11               50
> > >          0              100               10
> > >   5          COMPUTE:        0                5               30
> > >          -                -                -
> > >   6           CUSTOM:        -                -                -
> > >          -                -                -
> > >
> > > I have set their refresh rate to 72.01 which is a mode equal for both,
> > > and the MCLK wasn't downclocked either. They are branded HP and
> > > Scepter. Using a vtty doesn't help either.
> > >
> > > Is having the exact same monitor really required? If not, how can I
> > > check what is causing
> > > the memory clock to be pegged that high?
> >
> > It depends what GPU you have.  Older ones can only reclock memory
> > during the vertical blanking period assuming it's long enough as the
> > whole reclocking process takes a certain amount of time.  If it
> > doesn't happen during the blanking period you will get visible
> > glitches on the screen when the reclock happens.  If the vertical
> > blanking period is not long enough or if the vblank periods are not
> > aligned when using multiple monitors, the driver doesn't reclock.  The
> > mode lines (not just the refresh rate) have to be the exact same for
> > the vblanks to line up when using multiple monitors.  Your best bet is
> > to take the mode line you want to use from one monitor and apply it to
> > the other monitor.  Newer GPUs have more flexibility and can reclock
> > memory in more situations, but there are still some monitors where the
> > timing may not work out.
> >
> > What GPU do you have?
> >
> > Alex
>
>
>
> --
> Braiam
