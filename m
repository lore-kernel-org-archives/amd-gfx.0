Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7FBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD4410EC17;
	Mon, 25 Apr 2022 07:33:24 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480DD10FF99
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 16:06:37 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 6FF2A3200EAD;
 Sat, 23 Apr 2022 12:06:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sat, 23 Apr 2022 12:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650729995; x=
 1650816395; bh=Zq/2pkFhrvANrVxG+E62UALvcS+IzKjSuNatq+wsPGc=; b=N
 xXNm5E584Cy+LVj/B9gKBpyCfnH6I1IzJ8/Z50CHEHxFfHFppT6rqmBKm6QgzvRH
 co4Glf0gMudA2n/9HTddwjZk+/1G0l0UYEfEQ41fo/n1Zw7YrULjMzN1JgqhBbAT
 79v9AzNjp3AjkD2Z3Q6afUn6AbcGrZUFWC7KcUwWqQbYhC730dsXE5y8pBl0QHIo
 ko5rA70G2QfGWjXyN30frvPXJ8ORHDapadtxEMupZu4Su7kkGFDJijTChSUOt0ld
 ZvJ9Bao1WQ2OtVKE6OllEHi5Xs99X6ofzRI9uOxZPdgi8oTOmUAHn1pNnd8azx0c
 KWBaZrqzO3K5P62EzpLrA==
X-ME-Sender: <xms:CyRkYi8PaxXtmKoqqVZ-c8N247oHtJUCfatPkkVcoEBZRSZXPPoVmg>
 <xme:CyRkYivNg1fjQU10u1CCwGyUQtCO4zNE9Yci9DwGXlpPis-uZrFNeeDIm45cILdAD
 942YBpFE_ap0Vs>
X-ME-Received: <xmr:CyRkYoBVdxLY5g9JufJZ9Q76X1960qM8o-zQcapRv59wjYGOdIC34vQNxpRm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdelkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
 dttdejnecuhfhrohhmpeffvghmihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpe
 eukeeitedvfeffffehveelheeitdfgiedtueekieeuheejkefhtedttdevffejfeenucff
 ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
 sgdrtghomh
X-ME-Proxy: <xmx:CyRkYqfTgyq_JCF-oiJPa8t12VIYChvi-PPYtuyG0vTws5MeSqzpNA>
 <xmx:CyRkYnPsgLbNiZRCeVh5z88MaU9ZDTd263F_aIIV7CGix9ujLYjeeA>
 <xmx:CyRkYkmbPr5rwVQCDhfcOh3yj8SJzvAbPzbZtzci81Pq_xhIG571rg>
 <xmx:CyRkYmZaZvC9jxB_xLzhwkKHJw80hokGn0gGCjlLFNJ_i-bsaxRFtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 12:06:35 -0400 (EDT)
Date: Sat, 23 Apr 2022 12:06:33 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmQkCXZEqp6TKrhJ@itl-email>
References: <YmQi7ajZpZ4W7BJL@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fp+Cfkkmh+USsjTE"
Content-Disposition: inline
In-Reply-To: <YmQi7ajZpZ4W7BJL@itl-email>
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


--Fp+Cfkkmh+USsjTE
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 Apr 2022 12:06:33 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Subject: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4

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

--Fp+Cfkkmh+USsjTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJkJAoACgkQsoi1X/+c
IsGCUBAAl+q95fZbYNmxQWVR37DPr0HqsKZOEkNkfKguRRelPb7wIWfrlaDbnNLe
Gmt/X7DeROmR7k3WQc5k5Kk9TyABnz904tiHCJYfrhKk7G042tljPRj59/MNo/vV
Fl/muoUWQWD7QquxTFGilfKl4Peb3zx8N9hi/FcTdI88pdwuov/eAnAqi+d6JXI9
u8RAod1Y3xcC/Us+sbGZ4btxXCkcZ5DnpePK8tms8ThvtiVsoK6bDcQc4Db8jbSS
30K7kwlWSvDINKX+4frkFwsDSWzsL25YEdfeHXXqP3VWhbA2a7Ovb9KveKY2Ly7d
/xHhYqv+cFmmYTGW3PlORhH3zIC+9uoZb8rz1qhT/THIeT8PoA44Oj65hjHeMbcs
ufH7zlW3L3QLCkbKw3GUBuNB84BhxQ3b9rYywDBHnVc6U0OrBgj9I7sk5XELyiyy
3m7tG/N61BiHhVV/XUK0AFsg1yGMN/qy5f+bqjYw7Exaoeqd5x9/rNqwmxf18uqp
CRFsJz4+lqGzL+5mZ4sige7hJQgRoGbpMa5wkk6ZwRQAnKtSZZCwf40uoaDHMyhq
kKPqTqiLKJDgQcw9ALzJ9JAN+TtA6e/8t/5Dxt8BQkHbv49aRMh1FpPJ4mtaHKil
T96DybEvv7QX1UbQyOJOebx7JELl7Abjvc90e3Z88lReYQXqw6Q=
=rml6
-----END PGP SIGNATURE-----

--Fp+Cfkkmh+USsjTE--
