Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E081CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2DE10E6E0;
	Mon, 25 Apr 2022 07:33:13 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FB910F76D
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 23:39:26 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 5E5D75C01A6;
 Sun, 24 Apr 2022 19:39:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 24 Apr 2022 19:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650843564; x=
 1650929964; bh=TnzC/xewfks6siQR2OzUMgonZrv7KZx+dVNe8LLuhCc=; b=L
 M8JA2SwWTGr6LGXrFQ9NYpfhYDDamqXrrClVeoNa5w4cJqDfi634PGAcQrUNdW7z
 1Xv4LmgyopQcr/0FPOBZg19l2O7qL8MPYmfDGUa+GuavZ6Twzn680cM9ae1BmqmI
 TcJ4FyeCB5PTy3kL/zMECnLPhPIAWQTwdyEwy2qnd2g51krPQBpAWnhvZtOucGIn
 Cm1UHBAelbL/XqllwOnCKG1XqPkqMlilaHsmSKGWd9ffLqS6+YVHnN5NFxFMr1lE
 2AepO63Bl4/djYiwobt7jPVVxmm2gfmrR5z5+1tyeTpWax/7L+jvE6mqr4x4V58x
 3DhQEolRIs7VU+eNJVsmA==
X-ME-Sender: <xms:rN9lYipgpaU3-5aeL4nfjUGXztenvPV1JL5sklRhy5Wobr9xglrqTg>
 <xme:rN9lYgrKfXajtuHr5bbfZVS9Gt03q3Y0iWuOup74dQovq2iC4ZSWOqjKPDg6K8ddX
 w2uYtWlJc1IlrI>
X-ME-Received: <xmr:rN9lYnNarFv8ko65osE2R2Y0Md0VYZrkWJGtuaTQhSbU_MVcblZVoklxrXF3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgddviecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
 ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
 hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdehhfdtvdfffeejjedvhedvjeei
 heffheekkeehgeelueelveeludetheetteenucffohhmrghinhepghhithhhuhgsrdgtoh
 hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggv
 mhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:rN9lYh5BjUKBmJ_-sdFjgL38sJA8YNbqcRYrj5PJZp-0M_DR7n2Vog>
 <xmx:rN9lYh5ykYYP69Gb6K4gDzvOZkKrIc8vkuHQIT7Mkr5Bbdmcdrw5RA>
 <xmx:rN9lYhgnA7HeIp14WCiix89GC4o4ZK9PA0CBWPsusaeuzoqEKS3KIg>
 <xmx:rN9lYk0vpV53s2kpG3HYjfzH4jWpZvD26LuUvwefBndD7ScogIX7XA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 19:39:23 -0400 (EDT)
Date: Sun, 24 Apr 2022 19:38:47 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmXfqrktdufyYC4r@itl-email>
References: <YmQi7ajZpZ4W7BJL@itl-email> <YmQkCXZEqp6TKrhJ@itl-email>
 <YmTqYkGEqiz1o2o6@kroah.com>
 <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IWeqqwZPHTdMGABi"
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


--IWeqqwZPHTdMGABi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Apr 2022 19:38:47 -0400
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
>=20
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
>=20
> Anyway: Yes, as Gregkh said, a bisection really would help. But maybe
> the amdgfx developers might already have an idea what might be wrong
> here? The QubesOS ticket linked above has some more details.

The reporter was able to bisect the regression.  I am not surprised that
this commit caused problems for Qubes OS, as dom0 in Qubes OS is
technically a guest of Xen.

#regzbot ^introduced: b818a5d374542ccec73dcfe578a081574029820e

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--IWeqqwZPHTdMGABi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJl36kACgkQsoi1X/+c
IsEPKw//ZpF8oBPSG4UWxpHdK0OrWQrXuAVsZcZ6aE/zFMLaavcJo1BfUXbgEJ3Z
+10tyxLR0dllcWNPREcS90TJb2lUGny2fJ1C1NLCgH0WA4hocYUCpUGHaoE5g2/n
LyiXJVN0XV3Hbx7A4ZgBj5A9wnL5ybKJwGCVQu5XFBISPu7XSLhL6JQmsy97Vlxu
qrbCEbTLvOPnyp5r1ONOh2GrGkfh13s2ZSjh0HDZGWKIv/Hs4if2q2egGxiWVlHW
rx/e4RrBtommerw1GDUKmDP69j5GSU7QmwM5UEIGPZOsbfOlEEayc4zLE9Ha7WYW
0q4DgAHvAmUDUdBUeaiRCEMbmrDytHa6wqrzpPitW/rLkL5exA3eM4NiKS8J4oaD
5hOjgI9KkgE0y0NMCj/+QLBUkwWz7duIrdhkJyzYTUvd7gk9guPgTn2a9zbL/H7J
RnOeU5iqWmYsk50TS08Rq3RURWnlRBmOlsd0V0Yoo392oAhMV/rz1TIxx+PgyUE/
YAmiUBZtnUnP8HR05ti6G9aYJaMtnydQB3YDANGp44535AkRGeB+surqT0aMiHfk
cuydijqpnlBJTznvFEn8ZWTpXvgCIhdnA3XoRQbhGzezlVkUfOxaMgpwHiXmKuS7
oKI3Eis/Ljz2sgqRPdYJjSPkrTT+SdLS/IusoI/lN5oed3hescc=
=zcu0
-----END PGP SIGNATURE-----

--IWeqqwZPHTdMGABi--
