Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCFAC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 19:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB2910F2B9;
	Mon,  8 Aug 2022 18:59:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A91B1130B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zlPfiEaaSh4GB5OlegfJytA4MDQCveFJe1XZcL1J9A8=; b=HwvROzUCIunHUmdZJzDmBD7LBR
 uhmzHZ8W1c3RwarbJoamWQFETfnab58XMZFFOkkfZepOVMdUNBFxBKbOsXJyFE9EQgebZZOQ9vjFG
 VY2tCb7FlCq4Sn8vJCwXjpXJl13soZdtdohjxGl04WK6+7zGfrwGRhA2qOQraWpBVfhnkj7ogevG1
 KSCQaPaTBh+iVqnfEFyIEzDuXkJ/LHhgBJT9/tO+Ji+gDS36Ia7DC9z65BZdxxpI18WPnhh+HFbLI
 xNlB9s3yZAPDhpkLHidltJrSEIrxYtCGBGExmiXzJLvNqEzc19xp2vdwsRx8o22erBplWl581T4iA
 NRLFedNw==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oL7nr-0030DC-Lq; Mon, 08 Aug 2022 20:48:39 +0200
Date: Mon, 8 Aug 2022 17:48:26 -0100
From: Melissa Wen <mwen@igalia.com>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
Message-ID: <20220808184826.lhjwbbaos4vllmzi@mail.igalia.com>
References: <20220803162402.3412968-1-mwen@igalia.com>
 <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
 <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hxmf7ixklsqzofkg"
Content-Disposition: inline
In-Reply-To: <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
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
Cc: Leo Li <sunpeng.li@amd.com>, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.cornij@amd.com, Hans de Goede <hdegoede@redhat.com>,
 Sean Paul <seanpaul@chromium.org>, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--hxmf7ixklsqzofkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/05, Simon Ser wrote:
> Hi,
>=20
> Have you seen [1] and [2]? CC'ing Sean and Hans, it seems like there's
> a disagreement regarding probing early vs. setting the initial value to
> UNKNOWN.
>=20
> If a driver doesn't fetch EDIDs before exposing them to user-space,
> then there is an amount of time where the connectors are exposed as
> CONNECTED but their EDID and mode list isn't properly set. But maybe
> that's what the GETCONNECTOR IOCTLs is supposed to do: probe the
> connector, fetch its EDID, return the proper mode list. So maybe
> drivers shouldn't probe early and should let user-space request probes?
> In which case we could create the panel orientation prop with "Normal",
> and update it accordingly when probing.=20

Hi Simon,

I've followed these discussions but AFAIU the AMD display issue is not
exactly the same discussed in other drivers because here we are already
able to read EDID and get mode size needed for a quirk orientation
before drm device registration. So, I understand there isn't the need of
setting an initial value to the immutable property and update it later
(and all the issues this later update might cause). Am I missing
something?

>=20
> At any rate, I've tested v2 on the Deck and it works properly.
>=20
> Tested-by: Simon Ser <contact@emersion.fr>

Thanks for testing it!

Best regards,

Melissa

>=20
> Thanks,
>=20
> Simon
>=20
> [1]: https://lore.kernel.org/dri-devel/CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z9B=
AComm5JQoty=3DHPtJg@mail.gmail.com/
> [2]: https://lore.kernel.org/dri-devel/20220530081910.3947168-1-hsinyi@ch=
romium.org/

--hxmf7ixklsqzofkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLxWnUACgkQwqF3j0dL
ehx/pRAAlJCiCZ9tS1Bc8H6JtQKvbMkVcPsGQQYjnOmaeAya9nj/gBTl4kOqNXzU
Ps4fO7VB+OY3oT1zZvv2Hh/b9uVBFpMAg6W9IkuDEyItEXHzQTkGr33gQNKqVs06
DTccZTpBrb+Djfz2a3DEnHYo7XyFpBWHd43A2aYJthViPYHITVdfpQytwCGmSO7D
IXBmZRuoPbhxNX1k0m667YS0S1eJ+W7kv5GtY+SZ4MRR6u+m4NjfjV0bB7zxU6bA
22vTb5JxPyElhLSAMDwYKdVFZvX9tt35BfYhwC9S0siTBvajlIKpV1+a9FL4JrBe
y2rVS6l5oVYXQz6gMonIIna3zSwcx79vUcuFoep0+d6tQOy4WRq0ZwiawJ/faWXE
kZTW1m9pP9Omz+GQg/mJEqlN5evo0NktOLNwt0il6WaUrRImYWDspdB0cYcEuSmM
owMDSb4jPPxahMyzJuO61lYtB+ddURrAkgpm3uJrKWJwP+LwM6ni0T5sKNyLOFDh
xfunI5PEbZ+vsUEE5mR0+AfuMWhGP/4+XsaodHrzkIeEWwMKXKmV9x4gPXaYRK+B
66q+BIxB2hLjHQd6Rvkebt1wyYCpfHJRG15wfcOHTZo41UYTOwY9wrOAAPWfSpgU
muCql0TQUVpvR858D0vSBs5qx3j4BTUDvzhjfhl3Ylw5ehgKXmI=
=6N2O
-----END PGP SIGNATURE-----

--hxmf7ixklsqzofkg--
