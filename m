Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381DAE77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94AD10E5BA;
	Mon,  6 Jan 2025 08:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=panix.com header.i=@panix.com header.b="W/aAM+2j";
	dkim-atps=neutral
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D560710E141
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 04:35:53 +0000 (UTC)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
 (No client certificate requested)
 by l2mail1.panix.com (Postfix) with ESMTPS id 4YRLZ510knzDRP
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 23:20:13 -0500 (EST)
Received: from panix3.panix.com (panix3.panix.com [166.84.1.3])
 by mailbackend.panix.com (Postfix) with ESMTP id 4YRLYT55sMz458J;
 Sun,  5 Jan 2025 23:19:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1736137181; bh=r3dtWKXRz1KNKZxrk6TB1OlhYKVUIYZOxvLK32sjf9s=;
 h=Date:To:Cc:Subject:References:In-Reply-To:From;
 b=W/aAM+2jDx7/02ZGeiMmVADfC4U6mLxz0CwzzYdqtd759C5HV2BN9i90NNFduZr15
 h0r+au5KB0ThOjn7OdITMOhSk3EowKkXvfIw3WbrtOARn22rXp6VVx1rCTG4OmLkko
 NVe8+iLotN8HEtVsfoeWwkIuHdf3Dda9/9cbOZyA=
Received: by panix3.panix.com (Postfix, from userid 19171)
 id 4YRLYT4ft9z1QXM; Sun,  5 Jan 2025 23:19:41 -0500 (EST)
Date: Mon, 06 Jan 2025 04:19:41 +0000
To: me@svmhdvn.name, alexdeucher@gmail.com
Cc: Xinhui.Pan@amd.com, stable@vger.kernel.org,
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
Message-Id: <4YRLYT4ft9z1QXM@panix3.panix.com>
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

