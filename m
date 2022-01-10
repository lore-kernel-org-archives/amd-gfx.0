Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EBEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 22:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7D810E1DC;
	Mon, 10 Jan 2022 22:05:03 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA56A10E1DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 22:05:01 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q186so15111327oih.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UXhKTZ4OmGBgXBdJL0PZRRw2ubmb4jJBTwXOgNZ8A90=;
 b=X2L2lkhAJJf8PQOu8rul77EN8CMf9uins0JWD0AM9eGDgLeHUP+trxehOq5EoF+KaJ
 4ibiE7afHrDr75OrcpIaruIGoDgypdYwFaaEhMLdy9y3pjT36qRLhac/IavU/kRU/dHl
 Ekvar5nEGXu4vtLu6tau/TiWs8Cs6HNZH9PE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXhKTZ4OmGBgXBdJL0PZRRw2ubmb4jJBTwXOgNZ8A90=;
 b=Dq2D7NH0HjE8UroCk4CgGJQCzIVDs4/YRdvUvjdxMNNjXXpM5CjnXVxaHtRv4HpsRf
 CMBUObNVdD/YuEHSCNZh+UijZo4KhbuYTHe2Yi8I7HmMAfYjX4pQK1kSjqiomZdjB6/c
 yFxLB4ZpXyJes0JhZcHIdGCg7duQiuyJ3gq/58LkTUOSmRvo6wj7hSVcdcfbweOJk/hP
 T1TX0wBkxG7jELJK5UvwACbJbI4mylTOjTbt2scN65QZ54mjN3HuXtdi9ObVMPwHyCpF
 7MKZbMtyQBNQVRFAmlfE4ffkk6dUkPYuJXIFJcx6Ggmbv+ibK8gs4TR6MCiruMzQ2PzJ
 y0+Q==
X-Gm-Message-State: AOAM5306wCJhZvFJeBWyrHVQ0WPplWu632NvZi2C70AFSyeXWzSPZp7g
 e0KMCORP77n7UoKUGRA6mFThVtC90hvBWCPDiOKIwQ==
X-Google-Smtp-Source: ABdhPJw1mAmmTWAyagLxfDd96trE4G+y2z1zCFYZwKPClOuJcQEAyqFg88OvuNfI5qTIiUq15pTeY5AbNDh4aioWP2M=
X-Received: by 2002:a54:410a:: with SMTP id l10mr1047264oic.128.1641852298114; 
 Mon, 10 Jan 2022 14:04:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
In-Reply-To: <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 10 Jan 2022 23:04:46 +0100
Message-ID: <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexdeucher@gmail.com>, 
 "Wentland, Harry" <harry.wentland@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, "Koenig,
 Christian" <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 10, 2022 at 10:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 6, 2022 at 10:12 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> >   git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07
>
> Gaah. I merged things and it built cleanly, and I pushed it out.
>
> But then I actually *booted* it, and that's not pretty.
>
> It *works", but it's almost unusable because of random scanline
> flickering.  I'm not sure how to explain it, but it's as if there
> wasn't quite enough bandwidth on the scan-out, so you get these lines
> of noise and/or shifted output. They are temporary - so the
> framebuffer contents themselves is not damaged (although I don't know
> how the compositor works - maybe the problem happens before scanout).
>
> This is on the same Radeon device:
>
>    49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
>
> with dual 4k monitors.
>
> Any idea?

Since Christian is mostly the compute/memory side, adding some display
folks for this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
