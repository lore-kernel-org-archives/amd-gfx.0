Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F07C3ABB7
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 09:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E2210E043;
	Sun,  4 May 2025 09:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=nordisch.org header.i=@nordisch.org header.b="OgXCRqGn";
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="FaQAbq0L";
	dkim-atps=neutral
Received: from tengu.nordisch.org (unknown [138.201.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98EF10E0B7
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 02:57:29 +0000 (UTC)
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
 by tengu.nordisch.org (Postfix) with ESMTPSA id F12CE766F09;
 Sat, 03 May 2025 04:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_rsa; t=1746241038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77+U92Nliwz1Y9GhB5zaSrT5PC13YSpJb05RufmfIic=;
 b=OgXCRqGnBA7LCVp6wi2rlnkuXwt2xBs8XiwlH+IoaiiSMVHcG+RoFEZnvx5tprgyox5O/v
 owY2xf3KlcB3cy7gkda14vYa7ECtpxJU3OFuZltVGhiYy4LCbXQ/87Oj1+5N8LrPcY3Df+
 Cc3jQaccTvspPH/rBsuIK3JLbkKIyf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_ed25519; t=1746241038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77+U92Nliwz1Y9GhB5zaSrT5PC13YSpJb05RufmfIic=;
 b=FaQAbq0L51nyN/eBHsYihtZ5XMO3yrIo7XTVV/BSWhymLwUcuGghYRaT9/mHZSmFc2Lq/+
 xP1kyB/GZUdjGABQ==
Message-ID: <70453a8d3eb51477c49170db87b2397d02d12b15.camel@nordisch.org>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <amd@nordisch.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Date: Sat, 03 May 2025 04:57:17 +0200
In-Reply-To: <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
 <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
 <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 04 May 2025 09:20:06 +0000
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

On Thu, 2025-05-01 at 09:32 -0400, Alex Deucher wrote:
> On Wed, Apr 30, 2025 at 7:28=E2=80=AFPM Marcus R=C3=BCckert <amd@nordisch=
.org>
> wrote:
> >=20
> > On Wed, 2025-04-30 at 09:55 -0400, Alex Deucher wrote:
> > > please make sure your kernel has these three patches:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D4408b59eeacfea777aae397177f49748cadde5ce
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dafcdf51d97cd58dd7a2e0aa8acbaea5108fa6826
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D366e77cd4923c3aa45341e15dcaf3377af9b042f
> >=20
> > I am kinda sure that's the patches Takashi backported into our
> > 6.14.3.
> > They are already part of 6.15.rc4 no?
>=20
> Yes, I think so.

FWIW: I could trigger another flip_done timeout.

https://gitlab.freedesktop.org/drm/amd/-/issues/4201

video stream (might even be using hardware decoding) seems like a good
trigger for this. I think most of my flip_done issues had twitch
running while doing something.

> > > soft recover kills stuck shaders, so I'd suggest trying a newer
> > > version of mesa and LLVM.=C2=A0 If that doesn't help, please file a
> > > ticket
> > > here:
> >=20
> > Newer Mesa is building although I didnt see anything radv related.
> >=20
> > I am curious in
> > https://gitlab.freedesktop.org/drm/amd/-/issues/4192
> > there is a lot more details about the crash than what I see. with
> > what
> > kind of flags/environment variables do I have to run to get the
> > same?
> >=20
>=20
> That issue is directly related to suspend and resume.=C2=A0 I.e., the
> issues only happen after a suspend cycle.=C2=A0 Is that also what you are
> seeing?

Nope. I am just referencing it as it contains more details than I see,
and I wonder what I have to do to get the same amount of extra details
to provide more useful information for you.

> > An observation from my latest crash:
> >=20
> > ```
> > May 01 01:05:59 steam[223306]: radv/amdgpu: The CS has been
> > cancelled
> > because the context is lost. This context is guilty of a soft
> > recovery.
> > May 01 01:06:05 steam[223306]: Game Recording - game stopped
> > [gameid=3D2357570]
> > May 01 01:06:05 steam[223306]: Removing process 352353 for gameID
> > 2357570
> > ```
> >=20
> > Is the game launched by steam inheriting that context or could it
> > really be the steam process triggering it? As 223306 would be
>=20
> The kernel driver stops accepting commands from a process if it
> caused
> a hang unless the process recreates its context.=C2=A0 I'm not really sur=
e
> what's going on here based on the limited context, but I suspect the
> game causes a GPU hang so the recording process stopped because of
> that.

on the front of the ring timeout bug: I saw that dxvk had at least one
issue with RDNA4 and ring timeout.

https://github.com/doitsujin/dxvk/issues/4756

So i switched from glorrious eggroll's build to proton experimental
from valve. I have not seen any more ring timeout bugs since.

Which made me wonder why the context shows a steam binary as the owner
of the context and now the wine/game process underneath and if this
could be improved.

hth

   darix

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.


