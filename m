Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA26C5AC67
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AA610E136;
	Tue, 11 Aug 2026 12:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2UU/DQpj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BC510EABC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A811403D2;
 Tue, 11 Aug 2026 08:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B544C1F00A3A;
 Tue, 11 Aug 2026 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786435823;
 bh=Qia2GBLa3uGfOENajCCh3ErjQV0Nz7IBPzM4Q9K25uU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=2UU/DQpjA9BD4KjeO3nbAmvwmTDS3PNec+0I0gKwYZ5aTXFT/s/4h5FmCLXz2Mlm6
 g346zWPl2Y8TnuNFGH4TebaylOsUmN3aXVKKH/0VRbDjCSiYpCZV2iyvIm4urFkG66
 4EmUvS0jq29JGY3qXu7xX7u5N2V+iSZQcQXG7b94=
Date: Tue, 11 Aug 2026 17:08:49 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <2026081151-reabsorb-calamari-7442@gregkh>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:58:16 +0000
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

On Tue, Aug 11, 2026 at 09:28:52AM +0200, Sergio Callegari wrote:
> On 11/08/2026 07:24, Thorsten Leemhuis wrote:
> >
> > And yes, 6.18.y seems affected, too, according to a comment in the
> > ticket linked below.
> >
> 
> Yes, my bad I only mentioned 7.1.6 to be quick. My actual concern is that
> the troublesome commit got to the LTS kernels, which I think is the biggest
> issue right now. People may find their display completely black or almost
> black as soon as their DE starts. Getting to the conclusion that they need
> to /reduce/ the brightness to recover is not totally obvious and is not
> applicable at all if you have a system that is touchscreen only (since you
> won't be able to see where to press).
> 
> >> It needs to be reverted in Linus's tree first, otherwise the regression
> >> will be hit when you update to 7.2.
> 
> Indeed, but I think the biggest issue is with the LTS kernels right now.
> 
> > Normally I'd agree, but according to one reporter that problem does not
> > happen with 7.2-rc:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/5562#note_3603131
> 
> I'll see if I can try myself the 7.2 RCn series. From my superficial
> analysis of the commits that brought us to the current situation, the
> troublesome commit actually tried to patch on a true issue, namely that the
> user facing brightness data is not mapped symmetrically to the hardware
> data, but that the correct solution involves some more thorough rework of
> the brightness coordinate system. So there may well be some larger activity
> on it on upstream.
> >
> > Given all that I wonder if dropping that commit for now might be the
> > best move.
> 
> Personally, I think that dropping on the stable series would be beneficial,
> unless upstream can now offer a correct solution to pick. Behavior you get
> by dropping is not 100% ideal but certainly not as bad as what you get with
> the problematic commit.

We aim to be "bug compatible" with Linus's branch, otherwise the
"pressure" to fix those bugs goes down.  But I defer to the maintainers
of the code involved if it is being worked on, and they want it
reverted, great, we can do that.  Otherwise we prefer to leave it as-is.

thanks,

greg k-h
