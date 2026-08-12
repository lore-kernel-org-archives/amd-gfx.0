Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C5DC5B567
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 07:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0E010EE8F;
	Wed, 12 Aug 2026 07:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcQXNkR+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D57D10E185
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 00:14:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E32060A88;
 Wed, 12 Aug 2026 00:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD1D1F00A3A;
 Wed, 12 Aug 2026 00:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786493638;
 bh=K906TWK3NX4+ZpiFv6QQYIMRy2gKRZnzgTB4Few++Ms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YcQXNkR+vw9/ibatGK4jbM+armsihiYQcgu0F8rBYfWGFc3ssBu9PAHUsf3+YcUB2
 V2kjLAJ6wOpgawDKeBuGyQHgdNGOJtUtLH5tLrN0atHfblBZ6+RN44V6UjPxWc+2hI
 WhLndLDlrVN6p1nxN/dUFF0m1xMsry/Le1sdMIcE=
Date: Wed, 12 Aug 2026 09:12:26 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <2026081216-goon-nicotine-6d62@gregkh>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
 <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:26:23 +0000
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

On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
> On Tue, Aug 11, 2026 at 11:25 AM Sergio Callegari
> <sergio.callegari@gmail.com> wrote:
> >
> > On 11/08/2026 10:08, Greg KH wrote:
> > > We aim to be "bug compatible" with Linus's branch, otherwise the
> > > "pressure" to fix those bugs goes down.  But I defer to the maintainers
> > > of the code involved if it is being worked on, and they want it
> > > reverted, great, we can do that.  Otherwise we prefer to leave it as-is.
> >
> > I understand. Sorry for asking about things that might be obvious to
> > most people here. My expectation was that only a selected subset of the
> > patches on the Linus' tree were to enter in stable, so do we really need
> > to have stable "bug compatible" wrt this bug? The original behavior was
> > not free of issues, but they were rather minor (a reporting issue). Now
> > we have this very bad behavior where the display remains dark.
> >
> > To make the matter worse, on systems that have encrypted root the screen
> > remains dark also on that password prompt (observed with plymouth).
> >
> > In any case, I managed testing 7.2.0RC7 and it is fine again.
> >
> > Looks like the Linus' tree has more changes wrt backlight, and the
> > interesting ones are probably those in the cumulative fix
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
> >
> 
> Thanks for testing.  It sounds like we should revert the change from
> stable.  There must be some dependency we are missing in stable.

Great, can someone send a revert?

thanks,

greg k-h
