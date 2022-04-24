Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFD2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EADE10EB3A;
	Mon, 25 Apr 2022 07:33:14 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA0C10E574
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 15:52:36 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 6ED375C0109;
 Sun, 24 Apr 2022 11:52:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sun, 24 Apr 2022 11:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650815554; x=
 1650901954; bh=EFdVhizMeWP/hjRUjXRM1ALQJTyhDlxgnA50hKHYX+o=; b=k
 SgmHDUgtlsIX2LHm9DV+fb9GwwmHOHSPkPaMRU7A4qcGtVEVJBOcldU2kE2WaVZ5
 3k00Zpo93Yh+LbDik+dKHU3Dsko92JN43qrQyJCzZYkQwNdg6ZlpSG+5EnArtFfF
 rUUHNAWw0rf4ddxAhumUR3z5C43E87RzInVcd8J9l0dWJY2MtbPYZ6lYdHl6KufY
 9+N1OUiZ6ZXQHN+DRinv4OCu3SJ6kiBZRvh2DS3ivBZYWdUsSWEZnagtY72nZdZb
 aSZVpNCuG1g2L9eKm9B07fuULG2Hfo0FeKNmh49jICeCXfFFrJZ7aQB0NPK/ccq8
 gNj2QI5b0PvIOn2y5S5gA==
X-ME-Sender: <xms:QnJlYoqEeo0wErHysPpVJ5-Oy_4a0_P9UGuJlFqOC1CPA6mIIALV1Q>
 <xme:QnJlYuqGbHMY1lYxEtgu6uDh5pT_rgyqWdQFH--vDRiEbRedaEQWc2n0WyCuhjrnd
 yCjziIMg4MDqlM>
X-ME-Received: <xmr:QnJlYtMFhOmX9UtWczsQ6owvlnpA4WB5ClODEwwmtLnDtIYaBeZjJopSzrMP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
 ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
 hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdehhfdtvdfffeejjedvhedvjeei
 heffheekkeehgeelueelveeludetheetteenucffohhmrghinhepghhithhhuhgsrdgtoh
 hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggv
 mhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:QnJlYv542afTCMFZ04AUIZZxTdOsuERGJZwFOXbhmUrNEVPkNMRmHw>
 <xmx:QnJlYn58uOS3mxOyCDqhihSuOKppbf2G_WZejDKiKO0PYmgRwYbYFA>
 <xmx:QnJlYvjRdKvO1avQJntkivP6WeF4s7mPJyl27IKX4pFsSnYqWlhdfg>
 <xmx:QnJlYq38Kj2zxtpA1d6DPO3dkwT08XbrRk462t1Ow-yXCZrgf6rlDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 11:52:33 -0400 (EDT)
Date: Sun, 24 Apr 2022 11:52:05 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmVyQJlV4Bs827V5@itl-email>
References: <YmQi7ajZpZ4W7BJL@itl-email> <YmQkCXZEqp6TKrhJ@itl-email>
 <YmTqYkGEqiz1o2o6@kroah.com>
 <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oKeJaQplodLw4G8U"
Content-Disposition: inline
In-Reply-To: <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--oKeJaQplodLw4G8U
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Apr 2022 11:52:05 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4

On Sun, Apr 24, 2022 at 11:02:43AM +0200, Thorsten Leemhuis wrote:
> CCing the amdgpu maintainers

Also CCing Marek Marczykowski-G=C3=B3recki as Qubes OS Project Lead.

> On 24.04.22 08:12, Greg KH wrote:
> > On Sat, Apr 23, 2022 at 12:06:33PM -0400, Demi Marie Obenour wrote:
> >> Two Qubes OS users reported that their AMD GPU systems did not work on
> >> 5.17.4, while 5.16.18 worked fine.  Details can be found on
> >> https://github.com/QubesOS/qubes-issues/issues/7462.  The initial repo=
rt
> >> listed the GPU as =E2=80=9CAdvanced Micro Devices, Inc. [AMD/ATI] Reno=
ir
> >> [1002:1636} (rev d3) (prog-if 00 [VGA controller])=E2=80=9D and the CP=
U as
> >> =E2=80=9CAMD Ryzen 5 PRO 4650U with Radeon Graphics=E2=80=9D.
> >>
> >> #regzbot introduced: v5.16.18..v5.17.4
> >=20
> > That's a big range, can you use 'git bisect' to track it down?
>=20
> FWIW, in another mail in this thread and
> https://github.com/QubesOS/qubes-issues/issues/7462#issuecomment-11076811=
26
> it was clarified that the problem was introduced between 5.17.3 and
> 5.17.4, where a few amdgpu changes were applied. Maybe they are the reaso=
n.

I suspect they are, but I am not certain.  It could also be an
interaction between these changes and running as a PV dom0 under Xen.

> Anyway: Yes, as Gregkh said, a bisection really would help. But maybe
> the amdgfx developers might already have an idea what might be wrong
> here? The QubesOS ticket linked above has some more details.

I can=E2=80=99t provide a bisection myself as I don=E2=80=99t have the hard=
ware.  I
asked the user who reported the bug if they are comfortable doing a
bisection.

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--oKeJaQplodLw4G8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJlcj8ACgkQsoi1X/+c
IsGoyRAArNATB2Ll0ZBj8iHqOSGXtiY4lhvDdrNVDV6mTVrUt4iphN/H7evo8hUT
o/Uew8iwo7ulGWadnOc4anxB48q4w+MnFiMwrTHcDO0ieJuldP6fhNYwi6Xgfp42
YwIHzhk11aL2Ex9xLMqZtW2gkotaOi02Q+4EWnk/6yr5ebxkExYDA2KnDGweHWEu
ADird7wIdkKTViP8a3C03kbZ3GTbrm8skcIPmzmxG3hRSrO5cUSimxLvCkcIEK5Z
HeD278rfEIt8wQBp6MSGI6z+LICP/qj16LimfRSIJ/sH2V7FnFHG2ra31bTcQJOk
yOQIEEWI8OkXg9mFY9pWdsXWSqsbXKvfU82LzZoI0bZ/koFvhp1UuDlyU8EmkhcT
A+iaILZTTiseTQTzPECfjsV2kIPqIOBiKV9PmbGhB9+x8y6tnHv35LWz9n8td1QH
0vtzIXUZN8h2Dsf56S98Zo4piDfiZxlS9Bevz3uMwlPyHrAUkkwFMe6RT7DvyfFz
BxFaeFfEuBzuuZL/amAeGmzdKLl9508V+t0ZQq299i/jihZUIMZpKzNoW9kzsrY7
5N8X4n1j6GSGSDWWZCp3Ho4QtS878gx111VDXKPEyjfESUcjT7ALw+HGnlWfNmzb
Nz7B/p2Q5ZLeemMppQk0pwjsO1XKuxKfeN5nZ6mWjZVCalsmAEY=
=CQhZ
-----END PGP SIGNATURE-----

--oKeJaQplodLw4G8U--
