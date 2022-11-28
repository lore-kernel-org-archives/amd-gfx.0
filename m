Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ABFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8343B10E1CC;
	Mon, 28 Nov 2022 14:36:39 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD2010E1CC;
 Mon, 28 Nov 2022 14:31:22 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id b3so17653260lfv.2;
 Mon, 28 Nov 2022 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iSpv59tttGrFnQarvz1ddRNyFrisHWlF5c49Tt4CNeo=;
 b=T/WCAe0NNf/iPsLY4RjGtKFwG+sIGynW+pv1nMxzFjeFDafK12nwOSgn8vXCbwf7FX
 HR3+kuittkLy8xQ0DVAExjpv3TLHljz/BjX2zh8ndWuQ2605RgZe2F+MlP57cFrkmFMG
 NZ18tQ9/Vt7qKgLiZkPV+xXaOrdYs3dzHN4oRLPZQjgTCt9H+4PXPNKx+WUn2w6Pn1cS
 2y3eD2HmpcshHYgRPQWS904vpKqyk8zLd+QdPCTnCr/4V/L1+hXKoDeKKJTj6P/yZMfa
 g7Ab6dR2hcZSlqptFeIJe4w9j4cYpky7JqMYYXnzC6nyyOYPiLd2EBUJti/sh52dhiPL
 Irzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSpv59tttGrFnQarvz1ddRNyFrisHWlF5c49Tt4CNeo=;
 b=dDnO374nzkvgHXfRue8rI8NsjztEGAHhNxLAYJysyQMksNM5mDuSUtYokwAG4V9xxT
 QIaXKoFs2x+dta+o7gxLJAD4IWT1yKUiYHHLT/8ofMCsKGi2+3eSxwYujlF25575xuio
 gQVYtD6hdLQcC9AX8wworUAIiZYP4pyvoJvxHK6KYNFY6ZCuoa/t7xFqYybPmKwk5wSw
 iVBrc1mEsLuF3S0Fu/Y4M3xGXNpsRkoe2LJR6BzcJfWHNIUGQG1eDTs3OkdchavLS97O
 Ffk8Fu3Tr+4WjjTEKTF5weHi1JbVaI8IIpSjLVFSAEBp6mSWLqq4+GPSs36zBvPrLyo/
 J1wQ==
X-Gm-Message-State: ANoB5pmMthlJgexNjhaCiTDqjKlJDjPuo71xIabP+tshln9WWW3Gl0Nt
 JAem4jjMR6+PNixD/C07vxcMLfId7w==
X-Google-Smtp-Source: AA0mqf7KYls3jfc3HyAgQqrIKqpjtc5dEwgdUEnc3rw2A+D6VFQ7ycU7CckIYXBAYldLVmrwnsq/Ew==
X-Received: by 2002:ac2:5e7a:0:b0:4a2:6238:e7f9 with SMTP id
 a26-20020ac25e7a000000b004a26238e7f9mr16872764lfr.294.1669645879450; 
 Mon, 28 Nov 2022 06:31:19 -0800 (PST)
Received: from sqrt.uni.cx (0854358661.static.corbina.ru. [95.31.0.167])
 by smtp.gmail.com with ESMTPSA id
 d28-20020ac25edc000000b004946bb30469sm1749937lfq.82.2022.11.28.06.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 06:31:18 -0800 (PST)
Date: Mon, 28 Nov 2022 17:31:21 +0300
From: Mikhail Krylov <sqarert@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Screen corruption using radeon kernel driver
Message-ID: <Y4TGOb3UGmDslyYF@sqrt.uni.cx>
References: <20220423193145.3301ed06@desktop>
 <CADnq5_PXgFBXZ03LXE8qOdimzfKYGhzX1JnycJQcHWcMZdgJug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i8A/cMEvMM+OLlBa"
Content-Disposition: inline
In-Reply-To: <CADnq5_PXgFBXZ03LXE8qOdimzfKYGhzX1JnycJQcHWcMZdgJug@mail.gmail.com>
X-Mailman-Approved-At: Mon, 28 Nov 2022 14:36:37 +0000
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--i8A/cMEvMM+OLlBa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 01:22:04PM -0400, Alex Deucher wrote:
> + dri-devel
>=20
> On Mon, Apr 25, 2022 at 3:33 AM Krylov Michael <sqarert@gmail.com> wrote:
> >
> > Hello!
> >
> > After updating my Linux kernel from version 4.19 (Debian 10 version) to
> > 5.10 (packaged with Debian 11), I've noticed that the image
> > displayed on my older computer, 32-bit Pentium 4 using ATI Radeon X1950
> > AGP video card is severely corrupted in the graphical (Xorg and Wayland)
> > mode: all kinds of black and white stripes across the screen, some
> > letters missing, etc.
> >
> > I've checked several options (Xorg drivers, Wayland instead of
> > Xorg, radeon.agpmode=3D-1 in kernel command line and so on), but the
> > problem persisted. I've managed to find that the problem was in the
> > kernel, as everything worked well with 4.19 kernel with everything
> > else being from Debian 11.
> >
> > I have managed to find the culprit of that corruption, that is the
> > commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713 on the linux kernel.
> > Reverting this commit and building the kernel with that commit reverted
> > fixes the problem. Disabling HIMEM also gets rid of that problem. But it
> > also leaves the system with less that 1G of RAM, which is, of course,
> > undesirable.
> >
> > Apparently this problem is somewhat known, as I can tell after googling
> > for the commit id, see this link for example:
> > https://lkml.org/lkml/2020/1/9/518
> >
> > Mageia distro, for example, reverted this commit in the kernel they are
> > building:
> >
> > http://sophie.zarb.org/distrib/Mageia/7/i586/by-pkgid/b9193a4f85192bc57=
f4d770fb9bb399c/files/32
> >
> > I've reported this bug to Debian bugtracker, checked the recent verion
> > of the kernel (5.17), bug still persists. Here's a link to the Debian
> > bug page:
> >
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993670
> >
> > I'm not sure if reverting this commit is the correct way to go, so if
> > you need to check any changes/patches that I could apply and test on
> > the real hardware, I'll be glad to do that (but please keep in mind
> > that testing could take some time, I don't have access to this computer
> > 24/7, but I'll do my best to respond ASAP).
>=20
> I would be happy to revert that commit.  I attempted to revert it a
> year or so ago, but Christoph didn't want to.  He was going to look
> further into it.  I was not able to repro the issue.  It seemed to be
> related to highmem support.  You might try disabling that.  Here is
> the previous thread for reference:
> https://lists.freedesktop.org/archives/amd-gfx/2020-September/053922.html
>=20
> Alex

So, is there any progress on this issue? I do understand it's not a high
priority one, and today I've checked it on 6.0 kernel, and
unfortunately, it still persists...

I'm considering writing a patch that will allow user to override
need_dma32/dma_bits setting with a module parameter. I'll have some time
after the New Year for that.

Is it at all possible that such a patch will be merged into kernel?


--i8A/cMEvMM+OLlBa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEq9zNqT9shXHTn/gRzNfc0dbmrQAFAmOExjgACgkQzNfc0dbm
rQBVlwf+Mv6ieqjoEq93tRPefHq0N9I07QSU2xjXX+qIGQ1grq4IyDkKo75MtT/8
rzb4R6vXoltOzaYuEGPKxm1ih3Bwk7gw5qyWbKFuKxwp7r6nxq7n3F1VAQNupF0S
EOv9j84TmHUdlImezTr+1NgMEMsMx+4jjoLwLSG6Aci2TyWhuz+X0X7cj5J37Fjo
T2HxJmQ41g+iHeHD3UdODc7SzOnMHwCHbPVxdCCJwtOvlLqJXBLX59FvdyLRB+Oo
PgssIQOpXlNFDHqMDP2Wb0z9PG/HZEkIAZCHxb9bJJLboRcLpL7/0GOiv8wGuumt
kR30SB8z+qSAvHAWSDySFFN3kgqBiQ==
=WTzd
-----END PGP SIGNATURE-----

--i8A/cMEvMM+OLlBa--
