Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E50F60FC0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E50F60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961166E441;
	Thu, 21 Oct 2021 16:08:12 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D6F6E441
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:08:11 +0000 (UTC)
Date: Thu, 21 Oct 2021 16:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634832488;
 bh=PjzLQbkDeTspeM+lvAlGyy3VwRm3FlDmOgNgAeozuQw=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=nfD+74yrGZAdClXrQ24m1DIXljkQpsZJnm7OR5L27JGum0z5LH0j3MvTqWWWPCyFe
 kgRct57YXrSPGhWHSHOJHj3Y9QNs30EK18iHPW4LcFHS02CDMnhPnZ2dmnXaBJbJPs
 vpqHnfs0sfxk6Rm3ljnEYsoOZh3zX45aGvd9U5MSYORPJH3+vK9i3Q2XXpw52Csh8h
 RJfgGsB5iyuczCnzV3InL3Na0sLP79n1fZPkAYUJ3uHuTMtH13aQCj6YJZ7DQMCVaD
 7NEOg76BDFRcdR/vPmnrC+wif3cfN4q+yOPHbcI8joqvDOkOlyDIma/uqG57gLq1uL
 XTZ0b1J/g9ylw==
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
Message-ID: <efB1psbYCe4-s-z3dSVSYSX4IOsO5f7WiaTKoMuJP-efh_KmRNiN1AyqY_4UB21nMTAVdkW1XjuLOPEYRI8aW52SRcrEB9XoTNaYL3KxLh0=@emersion.fr>
In-Reply-To: <6610f563-0693-54c3-c905-efabf1d4d524@molgen.mpg.de>
References: <20211014153433.169454-1-contact@emersion.fr>
 <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
 <83v0yDp6ECf071d9soan6ioi2tnd6POWo1kem9kUb08Vdlf1cMkYQlKp-mD5M1e7Vnr9Y-XBdP4R8CcvuAUOZWTod-KI3DdoNhAN-hnOfss=@emersion.fr>
 <9e6e9cbc-676d-4b2e-4a45-16f6f82d96e4@molgen.mpg.de>
 <IbTspowQBQlcRaVOdJ40EaV2xtWsqFXO1SbYF4AXqpDPehiAwIWyuMOBmuItYsLAHxbI2wAk5vxE2ydg_WeXoehmP51XBoiHnOPlqdl1tOg=@emersion.fr>
 <6610f563-0693-54c3-c905-efabf1d4d524@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi again,

On Tuesday, October 19th, 2021 at 10:25, Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> Dear Simon,
>
>
> Am 19.10.21 um 10:10 schrieb Simon Ser:
> > On Tuesday, October 19th, 2021 at 01:21, Paul Menzel <pmenzel@molgen.mp=
g.de> wrote:
> >
> >> Am 19.10.21 um 01:06 schrieb Simon Ser:
> >>> On Tuesday, October 19th, 2021 at 01:03, Paul Menzel wrote:
> >>>
> >>>> Excuse my ignorance. Reading the commit message, there was a Linux
> >>>> kernel change, that broke Chrome OS userspace, right? If so, and we =
do
> >>>> not know if there is other userspace using the API incorrectly,
> >>>> shouldn=E2=80=99t the patch breaking Chrome OS userspace be reverted=
 to adhere
> >>>> to Linux=E2=80=99 no-regression rule?
> >>>
> >>> No. There was a ChromeOS bug which has been thought to be an amdgpu b=
ug. But
> >>> fixing that "bug" breaks other user-space.
> >>
> >> Thank you for the explanation. I guess the bug was only surfacing
> >> because Chrome OS device, like Chromebooks, are only using AMD hardwar=
e
> >> since a short while (maybe last year).
> >>
> >> Reading your message *amdgpu: atomic API and cursor/overlay planes* [1=
]
> >> again, it says:
> >>
> >>> Up until now we were using cursor and overlay planes in gamescope [3]=
,
> >>> but some changes in the amdgpu driver [1] makes us unable to use plan=
es
> >>
> >> So this statement was incorrect? Which changes are that? Or did Chrome
> >> OS ever work correctly with an older Linux kernel or not?
> >
> > The sequence of events is as follows:
> >
> > - gamescope can use cursor and overlay planes.
> > - ChromeOS-specific commit lands, fixing some ChromeOS issues related t=
o video
> >    playback. This breaks gamescope overlays.
>
> I guess, I am confused, which Chrome OS specific commit that is. Is it
> one of the reverted commits below? Which one?
>
> 1.  ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication
> when using overlay")
> 2.  e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by
> considering cursors"")

ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overl=
ay")
is the commit which introduced the validate_overlay logic fixing ChromeOS a=
nd
breaking gamescope.

Later, 33f409e60eb0 ("drm/amd/display: Fix overlay validation by considerin=
g
cursors") relaxed validate_overlay. This breaks ChromeOS and partially fixe=
s
gamescope (when the overlay is used and the cursor plane is unused).

Finally, e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by
considering cursors"") has reverted that change, fixing ChromeOS (again) an=
d
breaking gamescope completely again.

> > - Discussion to restrict the ChromeOS-specific logic to ChromeOS, or to=
 revert
> >    it, either of these fix gamescope.
> >
> > Given this, I don't see how the quoted statement is incorrect? Maybe I'=
m
> > missing something?
>
> Your reply from August 2021 to commit ddab8bd788f5 (drm/amd/display: Fix
> two cursor duplication when using overlay) from April 2021 [2]:
>
> > Hm. This patch causes a regression for me. I was using primary + overla=
y
> > not covering the whole primary plane + cursor before. This patch breaks=
 it.
> >
> > This patch makes the overlay plane very useless for me, because the pri=
mary
> > plane is always under the overlay plane.
>
> So, I would have thought, everything worked fine before some Linux
> kernel commit changed behavior, and regressed userspace.

I've tried to explain the full story above. My user-space went from working=
 to
broken to partially broken to broken. The quoted reply is a complaint that =
the
commit flipped gamescope from partially broken to completely broken. At the
time I didn't realize that ddab8bd788f5 caused some pain too.

Does that clear things up?
