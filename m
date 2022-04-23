Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA11C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B6510EAB6;
	Mon, 25 Apr 2022 07:33:14 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF1210E9D9
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 16:01:55 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 7FA373200C6B;
 Sat, 23 Apr 2022 12:01:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 23 Apr 2022 12:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1650729711; x=1650816111; bh=YDksKwqWIKNlt
 34SLbnMDH445KGkZXi3f/U3DAOZUMU=; b=AEP3gJTpRI9FIimWwFBAarUoE3EGT
 DHAA9ydv9CdYEJ9lIJS+fMYkwhlzewJsMX3kYtXPoQO49etiq3eA0RUHGmm87vIS
 hW+9kZRFtdxQPJ/hyGSFdPMm2TLJEPLr4MW4QVpm50ngW5yOmpQk1uK1ceL6oKTg
 cR3gx90EQpW8gMja/bTiBuZp61RUbHgQ6HbzIavSqXbtmjYR+z9guxwvtk8j1sTs
 PmUPt7OyGLnguiCHjL7TjXcKMGeO9VeHgu5DllEr6NchzAniIUs74MWztEb392Zi
 tSvFLMc1l/sFbbsRMefXYyMlkynS1R/gPaq15z1I/myAGxvqquis5EGnA==
X-ME-Sender: <xms:7yJkYvdfY72g2mPy9vM-Q33pTZDyRuqGkye8ZfSlqPDzB8GnoDmwvA>
 <xme:7yJkYlPiMd3FuM5Rpv_eotfGDwQB7loH9eHq3drpFfHst6O7gFrLWbHtWv0Mzo6Lk
 Ipoi3kRRYfhxms>
X-ME-Received: <xmr:7yJkYohHeJVsSgxGWGdt5Ey1COAsYP8VKkXkl4Bu4as89VL7s7adgt6E3MuP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
 ejnecuhfhrohhmpeffvghmihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhn
 vhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiue
 ekkeejteduhfduteehhfeggfevkefgveejudegtedvudelteekkeevvdetveenucffohhm
 rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdr
 tghomh
X-ME-Proxy: <xmx:7yJkYg8RvtoUtcIzPOtUxctG2XSm8EdwUW5yUHGf3-R-ia-HAnJcEg>
 <xmx:7yJkYruBWN7O_JB-Nl70fDzbPyPEIMredenu009mx7KYal3xf7QICQ>
 <xmx:7yJkYvHah3MYDgHlfjxk5jBmlKTXyTZAMgsoWdEMUA4mA2GIh_QH3g>
 <xmx:7yJkYo7swjGc4S3-B62a5XiwG1g2Lk-qQtZUCgcg9TjvHz_Xe1hTyA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 12:01:51 -0400 (EDT)
Date: Sat, 23 Apr 2022 12:01:24 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmQi7ajZpZ4W7BJL@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kv6tUGJJ6rzKIW1c"
Content-Disposition: inline
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


--Kv6tUGJJ6rzKIW1c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 Apr 2022 12:01:24 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: AMD GPU regression in 5.16.18..5.17.4

Two Qubes OS users reported that their AMD GPU systems did not work on
5.17.4, while 5.16.18 worked fine.  Details can be found on
https://github.com/QubesOS/qubes-issues/issues/7462.  The initial report
listed the GPU as =E2=80=9CAdvanced Micro Devices, Inc. [AMD/ATI] Renoir
[1002:1636} (rev d3) (prog-if 00 [VGA controller])=E2=80=9D and the CPU as
=E2=80=9CAMD Ryzen 5 PRO 4650U with Radeon Graphics=E2=80=9D.

#regzbot introduced: v5.16.18..v5.17.4
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Kv6tUGJJ6rzKIW1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJkIu0ACgkQsoi1X/+c
IsHKiBAAm8lW6omdTh1vgPDmbyXkNj4tqe1izvq3culWVP0Bjkl5pVUX87WUQ9r/
xqmy5seDhWVGI/hofBxs/RxB339GsJR8t9aVO6qWBc8grapHocDdmxkD5o8iksTD
CZ8C8Q3lqs1lLi/WXMy2rrcBdO7N1xaPOLtZacoiUtCXtMHM2pHhXq+Y5gyAZWQF
y5t8D2EDcrYJJ3v77MWinL4cgIE4k+o+gT+IqvHsmIPxxFk/ooRE2R4myuziGLpv
QsbWdpUMJJcFWHXKE8LC4YPkv3KautpUIdunIJ5l8shUm/WtsWYadbPE5eRxMnEF
EmrcTGMJjizWIAkMDrkeNpM5/AqaRqlfbNa/Et3ktE8NtRWeU/MqhWLdydD3wrkC
uNG5HGKi36fB6VGOwMauMTDLCLyggGkGISJvt/lyBHN4CA7va2TIYO/70DCSxVps
pxk6CmSwt7hu+affJChVLLZoymAIG+5RcLR5sblWLuvxWLL7EQohl9hhxgknxXEA
L+wTxB9AWoil3fPFVPOcQI325BEGHNRA4PFOA8LrtflFkKJ2cc/CW3PZIgjUTvUx
6PRYM3oOG3w2h+Wls3QVovWqbhxzr+RQk/zDs7EyR426S6rQ9i6fTphb8YC7IEFK
nTD51WvWDBeS5OtZFpal1iHveYLJgoeuNoDxEG8CVYvyLcEMVlw=
=Vik0
-----END PGP SIGNATURE-----

--Kv6tUGJJ6rzKIW1c--
