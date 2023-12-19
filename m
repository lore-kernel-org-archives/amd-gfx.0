Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30EBC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 18:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1A710E0A9;
	Tue, 19 Dec 2023 18:47:06 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1D210E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 18:47:05 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-203fb334415so353570fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703011624; x=1703616424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbidS0bTvnEtHIOS3+H+m846/MioW8M24+Egl2sOK88=;
 b=Uiq+SEQyS8YVCd6tJbNZMw5bqfARx912xpuANQyl4Dra+7TpmsGvRDJAxJ+mL8Obj6
 /Gs55Sp/D4VVr40XmhAsLKDwXKwIJ0yS5Uxy+63N5zr+MdJDnjGVpNvnBP1ldemVwzj7
 6jcAjfkMZ8IMNFQm/5MF3CeIXdaxY9aQMmOwBJih4vdbIBUYUDc7cgmPlyLw3HZ75A17
 5G3TUZxO2lFmDR1Qp5Am9Net+PZmQu9eawKbKA04mu7tbsbZxKvgRW4IZ75eT5ZeJU89
 KSoupL7YggSCCYSgGVEzFd8k2oBowokd/Xb/pVu0fFqAmcxIiIrFgjw5syzDa9iQU+DX
 4d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703011624; x=1703616424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbidS0bTvnEtHIOS3+H+m846/MioW8M24+Egl2sOK88=;
 b=cGW7vZYPv+09xowZrfMnhjuXhBYO5GrxuoK1B4NZcavIfNagE9cTEk4280OFXe1tu2
 GHj7TpV2s5JoY7pfIqbgjn78Yu8OxwjvguHwX43R2MPFpXHznx0Pz4kseIFE2Yt+bRwA
 H5HS39idTprg/Ka+oGrFQM/QgyRQ8Q6bjTaHQEHBuKmwZcB+6ZgY5EWCryLbABUwDn+2
 bpEOo+bk9TUQksye1O8QJ+D8kjB3GUwELg4gAwudH7Rn12bqfgo8UFvYf8Qg6MtblFjE
 WMzALgIQy+nZ59eLKRnK7AekviUdAfgSiRYetPkQ96ejfw03jE8yTOVogImRT+hxF70V
 +uCw==
X-Gm-Message-State: AOJu0YxcUYSzxwXOmz6pbjlJzhaXDmB/yAljr+4t41LPz1PmsQVROufT
 9Wk9nYNJFAIPobsmQ4BnNiXmUNtw58IRGZO4pRdjf1rC
X-Google-Smtp-Source: AGHT+IFKT9F8fqw25vUhe7gUvgYI7wUbtQ+U5onSTbzkO3nw7iO4QrSYp6DK1nqq5Y0u8Flzk0tdTJ7CfpreTniCiJQ=
X-Received: by 2002:a05:6870:9a10:b0:203:e866:5141 with SMTP id
 fo16-20020a0568709a1000b00203e8665141mr2237931oab.56.1703011624668; Tue, 19
 Dec 2023 10:47:04 -0800 (PST)
MIME-Version: 1.0
References: <c31dc9e8-b969-c736-709c-382c032f4979@applied-asynchrony.com>
 <a67cb2d1-f02b-9998-01c5-e0e18729da82@applied-asynchrony.com>
In-Reply-To: <a67cb2d1-f02b-9998-01c5-e0e18729da82@applied-asynchrony.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Dec 2023 13:46:53 -0500
Message-ID: <CADnq5_MkYY+-_9XEWFOn_2G0zrd25+xMRbeCxXuDbu=7EX1Npw@mail.gmail.com>
Subject: Re: Regression in 6.6: trying to set DPMS mode kills radeon (r600)
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 18, 2023 at 1:52=E2=80=AFPM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2023-12-16 18:36, Holger Hoffst=C3=A4tte wrote:
>
> <snip>
> > The affected machine is an older SandyBridge dektop with a fanless
> > r600 Redwood GPU, using the radeon driver. "Recently" - some time
> > after the last few 6.6.x stable updates - it started to die with GPU
> > lockups. I first blamed this on standby/resume - because why not? - but
> > this turned out to be wrong; the real culprit is DPMS.
> >
> > I use xfce-power-manager as "screensaver" to turn off the display after
> > inacitvity. This can be configured in two ways: "suspend" and "poweroff=
".
> > I've been using "poweroff" since forever without problems, until now.
> >
> > The symptom is that everything works fine until the screensaver kicks i=
n
> > and tries to turn the monitor off, which sends the radeon driver and th=
e GPU
> > into a complete tailspin.
>
> <snip>
>
> > Eventually the screensaver tries to switch off the monitor via DPMS "po=
weroff" method and
> > this greatly upsets the GPU:
> >
> > Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: ring 0 stalled fo=
r more than 10140msec
> > Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: GPU lockup (curre=
nt fence id 0x0000000000000002 last fence id 0x0000000000000003 on ring 0)
>
> In the meantime I have confirmed that all this is still more complicated:
> even using the "suspend" method only works after boot, not after a system=
 suspend
> cycle. Yes, weird but reproducible.
>
> I have tried to chase down the problematic release, and as suspected this
> started to happen with 6.6.5; 6.6.4 is fine.
>
> Based on this information I found the offending commits and reverted them
> in order from 6.6.7, which fixes everything for me:
>
> b0399e22ada0 "drm/amd/display: Remove power sequencing check"
> 45f98fccb1f6 "drm/amd/display: Refactor edp power control"

Those patches are for amdgpu.  From the logs in your original post,
you are using the radeon driver.  They two are completely separate
drivers.  I don't see how those patches could be related.  That code
would never even execute.

Alex
