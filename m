Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFF9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C162E10E089;
	Mon, 25 Apr 2022 07:33:10 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1823110E684
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 15:58:13 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 669645C00AC;
 Sun, 24 Apr 2022 11:58:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 24 Apr 2022 11:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650815892; x=
 1650902292; bh=cEAURrI/DbqfdaG0MmrORHTjJszJibbIWpItKpjzfQ4=; b=f
 NrnFdnq0PACm+IQ8PxrrOxEMucfnmLxoCPT34MT4+pdhxI+EniRHuk+hyiwqTPd9
 OJ70nePx3HLR9yYrddOICpQG1bxb4eoQwrxxjuCQxlsvTBBSl/+1QaF5Ft1O4Dpw
 11pdE6Kkcoe/wmRtPhuGVJynNOfoS2h9sUvIaOYnITpfmDVEHi0k5HcJCuFHFX6n
 mnjmemJoOjA3xtuoBFNCRiGVSFxfsc49gtW0uUU4V4wVyYksgybSc+yern+r4w8H
 Bed41yAnq+CQFSpQnK/mtmeL5GVJmuXt8QyWiAx8uGE59AUpgIJ58mZcug1SVZSp
 o00rHSvmpX3AHcaV6bWCQ==
X-ME-Sender: <xms:lHNlYh8CRRmqTEJNaZlZxKWVkr9m5IJnuVc25YqEhfNgE_4KwDlENg>
 <xme:lHNlYlvd0-B874g5blupP765j13x5iRmWk09WYs_AwPZWndkQxg1u45vdtJH3-BCJ
 uBkGisf1IEHbAg>
X-ME-Received: <xmr:lHNlYvBZWQQG5YWz8PjnRNSzv_haHX0nQVj2pA8clt7PBPzCR3hwn1q1DEgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdeljecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
 ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
 hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffegfffg
 uddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
 rggsrdgtohhm
X-ME-Proxy: <xmx:lHNlYldX_G7xancctIpSThaGe0A0Q1SoXdMujQjoumAkvicLNineJA>
 <xmx:lHNlYmMeYSp-u6s3fNMx2p0Qx38uJlaeIgqF9v85bsQ70mmlhDxQOA>
 <xmx:lHNlYnl-0ao1YYsKTJr6o4pTmJcCiQ6TVdvdeIqKtwMhBZpSUbOYUQ>
 <xmx:lHNlYt3Y4mErSMgTkwiBza1_arPfBNcNfL77ayjo-pHLNgmTZZgd8Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 11:58:11 -0400 (EDT)
Date: Sun, 24 Apr 2022 11:58:06 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmVzks1LR88douen@itl-email>
References: <YmQi7ajZpZ4W7BJL@itl-email> <YmQkCXZEqp6TKrhJ@itl-email>
 <YmTqYkGEqiz1o2o6@kroah.com>
 <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
 <YmVyQJlV4Bs827V5@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hkd2LlQVfWnzONvX"
Content-Disposition: inline
In-Reply-To: <YmVyQJlV4Bs827V5@itl-email>
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
Cc: regressions@lists.linux.dev, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--Hkd2LlQVfWnzONvX
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Apr 2022 11:58:06 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4

On Sun, Apr 24, 2022 at 11:52:05AM -0400, Demi Marie Obenour wrote:
> On Sun, Apr 24, 2022 at 11:02:43AM +0200, Thorsten Leemhuis wrote:
> > CCing the amdgpu maintainers
>=20
> Also CCing Marek Marczykowski-G=C3=B3recki as Qubes OS Project Lead.

For real this time (whoops!).

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Hkd2LlQVfWnzONvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJlc5EACgkQsoi1X/+c
IsHHJQ/9HpuBw+4Rd3Erqlc+hY9NQGtLql81cwqIDIYM3t3nsD2Z/JSLPJz63f9T
pHU6l6TO2yc5q+5SvQWfTCWwrNhSVYYlC8qg5qrYumR8iGgBLi1Deaj5JcW4rPb6
VPBgaXMCpB5/rYkoGQGHm25rfldEfp5fX48esWJQUCij5UII8rHxgfIBsA8BhS2N
N6SKGvzKVJdRpwB/771yEJQly9SPs6i2lBTLDNiUXkxkQvBNxHz0B9NR7X6hBtHh
y/LmbTC014bYXRmo1/o5wY1Ne7kTgX5HtlXaKuhOp549dEaKi6TrrPr0GVXnOiYV
uLkGmZMUd/wakHvPMBt2VrH+sxt9/TsnAIy7LYlDE0ok+u1Jkoa2Mz1q/7GWy49o
7GbOnzaIGND1UWVp3dqj7Tz5CvsNj808uVzEo2g9RSx0qjus99wWGIe22lKuFy+B
jgVZzIbTm1okE/+dwz+0q/nRaB43sbDmoCnvbPL7UOf0XBrQYKA5jc3/gPTtJA2B
kabDg31PCcwjy+kHBru2Vyqy6YbU/j6RbdpSW9+8ShYjkCq7+WUcAUT/wMQLaoz1
aL9RYqBRNiMkJmdVQ9IhDU62c1Bzis7ZTsfVoRf7qtuOKL4mQ9tWpz6mpK75vveL
2aRRnNMN3P+BUG5AfHQsk59DVDygi9i+VfJNlSQ8vScRx6eiDFY=
=mUgq
-----END PGP SIGNATURE-----

--Hkd2LlQVfWnzONvX--
