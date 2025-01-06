Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC52E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 08:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8683710E5B9;
	Mon,  6 Jan 2025 08:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=panix.com header.i=@panix.com header.b="Fi2UU51g";
	dkim-atps=neutral
X-Greylist: delayed 711 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jan 2025 04:31:34 UTC
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1C710E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 04:31:34 +0000 (UTC)
Received: from panix2.panix.com (panix2.panix.com [166.84.1.2])
 by mailbackend.panix.com (Postfix) with ESMTP id 4YRLq93lF6z45Hg;
 Sun,  5 Jan 2025 23:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1736137893; bh=6qHr8IEARPNhqSU1wZBWFqlZVqZ63jCI8dv0qaCgp3c=;
 h=Date:To:Cc:Subject:References:In-Reply-To:From;
 b=Fi2UU51g5Rf4hWPRSEi2OcfjSIJJ9bIAyiL9QpQoJiVrrlnCzaAqE5TRGYkn4R8Zg
 yf08mo2eTtmmTbzFyDSI/KOcY/5rz5KnLo3SqtAj7WZa26+Z8jkjlgsIjCalGr2FP+
 bWHBbFdwT5Tcs3EiJdpG0PMuIaeshIXSsjeF1jdE=
Received: by panix2.panix.com (Postfix, from userid 19171)
 id 4YRLq93qSpz1ZSy; Sun,  5 Jan 2025 23:31:33 -0500 (EST)
Date: Mon, 06 Jan 2025 04:31:33 +0000
To: me@svmhdvn.name, alexdeucher@gmail.com
Cc: pa@panix.com, Xinhui.Pan@amd.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
 <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
In-Reply-To: <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <4YRLq93qSpz1ZSy@panix2.panix.com>
From: Pierre Asselin <pa@panix.com>
X-Mailman-Approved-At: Mon, 06 Jan 2025 08:41:41 +0000
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

Alex Deucher <alexdeucher@gmail.com> wrote:

> On Mon, Dec 23, 2024 at 4:08 AM Siva Mahadevan <me@svmhdvn.name> wrote:
> >
> > #regzbot introduced: 99a02eab8
> >
> > Observed behaviour:
> > linux-stable v6.12.5 has a regression on my thinkpad e495 where
> > suspend/resume of the laptop results in my backlight brightness settings
> > to be reset to some very high value. After resume, I'm able to increase
> > brightness further until max brightness, but I'm not able to decrease it
> > anymore.
> >
> > Behaviour prior to regression:
> > linux-stable v6.12.4 correctly maintains the same brightness setting on
> > the backlight that was set prior to suspend/resume.
> >
> > Notes:
> > I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
> > titled "drm/amdgpu: rework resume handling for display (v2)".
>
> Odd.  That commit shouldn't affect the backlight per se.
>
> >
> > Hardware:
> > * lenovo thinkpad e495
> > * AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
> > * VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >   Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
> >   (rev c2)
>
> Please file a ticket here:
> https://gitlab.freedesktop.org/drm/amd/-/issues
> and attach your full dmesg output and we'll take a look.
>
> Thanks,
>
> Alex

Alex, Siva: I see the same thing on 6.6.69 .
Hardware:
  HP EliteBook 745 G6
  VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
  Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)

It bisects to 2daba7d857e48035d71cdd95964350b6d0d51545 .
Upstream commit is 73dae652dcac776296890da215ee7dec357a1032 ,
same as in Siva's case.

I'll see if I can create an account at gitlab and file an issue.

I can test patches, preferably off a mainline kernel.
Otherwise, I'll need hand holding with git.

--Pierre Asselin <pa@panix.com>

