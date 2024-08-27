Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF7C5474E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 07:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D80810E4BF;
	Wed, 28 Aug 2024 07:30:50 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Tue, 27 Aug 2024 12:29:17 UTC
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD3610E300;
 Tue, 27 Aug 2024 12:29:17 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 2DAEB1C009E; Tue, 27 Aug 2024 14:29:16 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:29:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jesse Zhang <jesse.zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, kenneth.feng@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, Jun.Ma2@amd.com, mario.limonciello@amd.com,
 yifan1.zhang@amd.com, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 05/61] drm/amd/pm: Fix negative array index
 read
Message-ID: <Zs3Gm4KIIN6EMNYP@duo.ucw.cz>
References: <20240801002803.3935985-1-sashal@kernel.org>
 <20240801002803.3935985-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="scNabhc75NExd7rZ"
Content-Disposition: inline
In-Reply-To: <20240801002803.3935985-5-sashal@kernel.org>
X-Mailman-Approved-At: Wed, 28 Aug 2024 07:30:48 +0000
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


--scNabhc75NExd7rZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jesse Zhang <jesse.zhang@amd.com>
>=20
> [ Upstream commit c8c19ebf7c0b202a6a2d37a52ca112432723db5f ]
>=20
> Avoid using the negative values
> for clk_idex as an index into an array pptable->DpmDescriptor.
>=20
> V2: fix clk_index return check (Tim Huang)

>  	dpm_desc =3D &pptable->DpmDescriptor[clk_index];
> =20
>  	/* 0 - Fine grained DPM, 1 - Discrete DPM */
> -	return dpm_desc->SnapToDiscrete =3D=3D 0;
> +	return dpm_desc->SnapToDiscrete =3D=3D 0 ? 1 : 0;
>  }
>

Original code was already returning 0/1, no need for this. You could
use !!() to emphatise that, but really....

> +		if (ret) {
>  			soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
>  			soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);

Same here.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--scNabhc75NExd7rZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3GmwAKCRAw5/Bqldv6
8lzgAJ9HRFMKO7ykdGp/Lv4c4NpdGaVW4ACgqKiVFPb39w9n2HaoIoNKdgJiFJk=
=aWwY
-----END PGP SIGNATURE-----

--scNabhc75NExd7rZ--
