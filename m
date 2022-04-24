Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A81C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F6B10E803;
	Mon, 25 Apr 2022 07:33:14 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B78E11259C
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 01:41:13 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 92C625C00DC;
 Sat, 23 Apr 2022 21:41:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 23 Apr 2022 21:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650764470; x=
 1650850870; bh=e+6OarHZjF7VeIuLhJpBS/ixjxeHJ0rorSOLd8kcr7g=; b=F
 WXbGSV3Sb0ttnGE4XrM9Rmg4ud3P+uHer9pomMzZTI7RePF9NTggteVAtJeg9Tdj
 KAHykVkprq7/fOX8qUnNys0nRkxUgFa1jYnoliNpdrDkzVxy6oRh+9DDIsr4kP4n
 7xEwes9TUTf6zqB+98TWYP2CQRmLW98L6/Ymx9UKGFITmpdqjeyF1PYv0h3SHH9T
 TG7oI7zR6M9I9MAk8uJWvbI3HT1B9bop8mTX6r81GeNYs6dk0bJ7UnxubGBEGXnM
 dAlaLXrmuCXTh2VFB/X1iXjghK5gJOJtEGADwR4QbIuQOu2llBXsgHEWHejZMT+K
 oRIyYyFG8eA9MhOvRkIOA==
X-ME-Sender: <xms:tqpkYnuYpbkVcvWg-YGOjLGvQXu0gvxw_bNkbbSSteaELp5r4ZwW6Q>
 <xme:tqpkYoeK2lXN8Q5WWV50uas_Us9ko-EBNelLJs7Vr7l-kse8U-dQyGdM7nipHaxyN
 oCy5LtTV64tPrU>
X-ME-Received: <xmr:tqpkYqydVqT9ZdXovFge52OXlYRtlU8yBERaXTGIO38JW-IBmjzbmFoYMp9p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdehudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
 dttddvnecuhfhrohhmpeffvghmihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpe
 ekteehjeetjeegteelgfdtffffgfevheeuteevveehgeevhfeghfekfffggedttdenucff
 ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
 sgdrtghomh
X-ME-Proxy: <xmx:tqpkYmMW_ZH5jlJ4zBdKBOpnP35z6AdL7eJrOyMhov2oPFKVn6EX5Q>
 <xmx:tqpkYn8-Z0Su2Bf2dttiEWxPd-C4HlSQ2bzTP1qljjYg9BGYESXQdQ>
 <xmx:tqpkYmVSFiLXkbrV5eyDscok3T7w2kKBM1X4CJJbAsQzmuAOqFmcWg>
 <xmx:tqpkYkLnfBsZFv8FUTUntZMIwhwTwmciYr4xcAHPC9DtPBmFYEEf6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 21:41:10 -0400 (EDT)
Date: Sat, 23 Apr 2022 21:40:42 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmSqs30gTIU6/InZ@itl-email>
References: <YmQi7ajZpZ4W7BJL@itl-email>
 <YmQkCXZEqp6TKrhJ@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7NC5YPD/KeDDtiW/"
Content-Disposition: inline
In-Reply-To: <YmQkCXZEqp6TKrhJ@itl-email>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--7NC5YPD/KeDDtiW/
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 Apr 2022 21:40:42 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4

#regzbot introduced: v5.17.3..v5.17.4

(as per
https://github.com/QubesOS/qubes-issues/issues/7462#issuecomment-1107679532)

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--7NC5YPD/KeDDtiW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJkqrQACgkQsoi1X/+c
IsF7Nw/+K0ziW+BR2DNtZid8FbxiLtCSrcC9ga6G2bRAkTPNxw4QSm9fASopuojE
3rVXMDSTYzUaoPKPo8KyUjDuJgIa5zr2b7gIIFDXcGsPmbxE0yFEFRO+zHGu77PA
aDiAyNhLJ925mckbuddGOiV6VMmBEr4OuFKWtB2lQMe0p9wKTddsr5UaFpO1slXx
VvPa+aINOA6XtygllU+pXcr82ag35IfxNjhl2/Gg+e1XzFikN1/t1ziptkCgmwJw
5jqGX0dI0dLlwoAV8QVid4W7LSUjUdvwKZVFhId1JiqhIv9l9UKxhmJUHnXMhTm7
6t91zMgaRTtuMGPhmuIGUDy2tHQD/T1BOss5or29r2tsca/rZaj0oUE6t+JXlD0o
z18JOYZqsf004eEWgRA6viE73+QPcV2e+sMgQ82pl4Xtn8cdKeS1YBKQcwtqbaMN
ik9v3gDubDeSlM6AM3rqiKXVxicKcaEzhsiBnTR+dADYW5zLizUg62d9inH2oZAB
84tmOEIYKN/FH/Fffun5tsIEFyv3iQPBnMj9UGxIGaikUOMcCdTsCrGfUaRhdy3K
YSJsSjuBGDZp6LdkMfjp1zEduBbHX4VumTOYf70dRucz9JkNoboJ2ib3RY3lvClJ
d6N1GNhVgQsx/yGQv2tbY4P+v9+Kyjm8v+lhIKphRIkyUDC3LKc=
=LcBF
-----END PGP SIGNATURE-----

--7NC5YPD/KeDDtiW/--
