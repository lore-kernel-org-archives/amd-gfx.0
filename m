Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CA0C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 12:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8313710E2B4;
	Thu, 20 Apr 2023 12:43:10 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0E810E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 12:42:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A31AF60915;
 Thu, 20 Apr 2023 12:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7ADC433EF;
 Thu, 20 Apr 2023 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1681994552;
 bh=J08Sn7rYTVyGUhrfk6mEoex3lK0bQFm0tFA0bQAHwTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lfpIDrHDJZBE2DCtkIPlLBUXRxiJv4FNUWgymd+cHHjhkMmYyIQ6SpFCd9GmNEN8R
 1G6QGtCS1yS2fyCX6Uooe91MQ9c/bViQ3KbmfmtSv4ZFooJBqyZS5HCaTSKNXqFLWw
 3S38BEi2AvRFS5hzh2Auz22DiKvOScuRLzJ0acU0=
Date: Thu, 20 Apr 2023 14:42:29 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Message-ID: <ZEEzNSEq-15PxS8r@kroah.com>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
 <BL1PR12MB51443694A5FEFA899704B3EBF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com>
X-Mailman-Approved-At: Thu, 20 Apr 2023 12:43:08 +0000
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 20, 2023 at 09:36:28AM -0300, Guilherme G. Piccoli wrote:
> On 19/04/2023 17:04, Deucher, Alexander wrote:
> > [...]
> >> So, let me check if I understood properly: there are 2 trees (-fixes a=
nd -next),
> >> and the problem is that their merge onto mainline happens apart and th=
ere
> >> are kind of duplicate commits, that were first merged on -fixes, then =
"re-
> >> merged" on -next, right?
> >>
> >=20
> > Each subsystem works on new features, then when the merge window opens,=
 Linus pulls them into mainline.  At that point, mainline goes into RCs and=
 then mainline is bug fixes only.  Meanwhile in parallel, each subsystem is=
 working on new feature development for the next merge window (subsystem -n=
ext trees).  The trees tend to lag behind mainline a bit.  Most developers =
focus on them in support of upcoming features.  They are usually also where=
 bugs are fixed.  If a bug is fixed in the -next tree, what's the best way =
to get it into mainline?  I guess ideally it would be fixed in mainline and=
 them mainline would be merged into everyone's -next branch, but that's not=
 always practical.  Often times new features depend on bug fixes and then y=
ou'd end up stalling new development waiting for a back merge, or you'd hav=
e to rebase your -next branches regularly so that they would shed any patch=
es in mainline which is not great either.  We try and cherry-pick -x when w=
e can to show the relationship.
> >=20
> >> Would be possible to clean the -next tree right before the merge, using
> >> some script to find commits there that are going to be merged but are
> >> already present? Then you'd have a -next-to-merge tree that is clean a=
nd
> >> doesn't present dups, avoiding this.
> >=20
> > There's no real way to clean it without rewriting history.  You'd basic=
ally need to do regular backmerges and rebases of the -next trees.  Also th=
en what do you do if you already have a feature in -next (say Dave or Danie=
l have already pulled in my latest amdgpu PR for -next) and you realize tha=
t one of those patches is an important bug fix for mainline?  If the drm -n=
ext tree rebased then all of the other drm driver trees that feed into it w=
ould need to rebase as well otherwise they'd have stale history.
> >=20
> > You also have the case of a fix in -next needing to land in mainline, b=
ut due to differences in the trees, it needs backporting to apply properly.
> >=20
> >>
> >> Disclaimer: I'm not a maintainer, maybe there are smart ways of doing =
that or
> >> perhaps my suggestion is silly and unfeasible heh But seems likely tha=
t other
> >> maintainers face this problem as well and came up with some solution -
> >> avoiding the dups would be a good thing, IMO, if possible.
> >=20
> >=20
> > No worries.  I agree.  I haven't seen anything so far that really addre=
sses handles this effectively.
> >=20
> > Alex
>=20
> Thanks a bunch Alex, I appreciate your time detailing the issue, which
> seems...quite complex and annoying, indeed =3D{

And it drives me crazy, I hate seeing drm patches show up in my stable
queue and I put them at the end of the list for this very reason.  I've
complained about it for years, but oh well...

> @Greg, can you pick this one? Thanks!

Which "one" are you referring to here?

confused,

greg k-h
