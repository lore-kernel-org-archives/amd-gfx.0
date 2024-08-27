Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07805C5472D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 07:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927B610E4BD;
	Wed, 28 Aug 2024 07:30:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9367810E08A;
 Tue, 27 Aug 2024 12:29:56 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id A0D701C0082; Tue, 27 Aug 2024 14:22:07 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:22:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ma Jun <Jun.Ma2@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.10 034/121] drm/amdgpu: Fix out-of-bounds read
 of df_v1_7_channel_number
Message-ID: <Zs3E7w1dSdxC7XoT@duo.ucw.cz>
References: <20240801000834.3930818-1-sashal@kernel.org>
 <20240801000834.3930818-34-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OqRI4MIqpBt9dQxF"
Content-Disposition: inline
In-Reply-To: <20240801000834.3930818-34-sashal@kernel.org>
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


--OqRI4MIqpBt9dQxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit d768394fa99467bcf2703bde74ddc96eeb0b71fa ]
>=20
> Check the fb_channel_number range to avoid the array out-of-bounds
> read error

We can still have array out-of-bounds, right? As soon as that function
returns 0x8000 0000.

drivers/gpu/drm/amd/amdgpu/amdgpu_df.h: u32 (*get_fb_channel_number)(struct=
 amdgpu_device *adev);

int fb_channel_number should really be u32.

Best regards,
								Pavel
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu=
_device *adev)
>  	int fb_channel_number;
> =20
>  	fb_channel_number =3D adev->df.funcs->get_fb_channel_number(adev);
> +	if (fb_channel_number >=3D ARRAY_SIZE(df_v1_7_channel_number))
> +		fb_channel_number =3D 0;
> =20
>  	return df_v1_7_channel_number[fb_channel_number];
>  }

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OqRI4MIqpBt9dQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3E7wAKCRAw5/Bqldv6
8l6xAKCvBvtdsPWLS+2akXJN38ECL3P8nQCcCKMijsSiArutJxOsPYklJw/UZZg=
=fM5x
-----END PGP SIGNATURE-----

--OqRI4MIqpBt9dQxF--
