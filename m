Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270EEC05052
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 08:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B157C10E48A;
	Fri, 18 Aug 2023 08:26:52 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2F110E4C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yM95MKXyMdhP9VKCS57sudGvBGbgtF+lzY/cGTQE4H4=; b=kuBFlrkvQD2+mYIgebWuvjnXJt
 TvOST8g80IWgPsBFxTY4vVGlCI9OmpGOP3VIxkLcFXmGugoFNiyG7EyJRk6hkkWhINmmhgIUMYT2D
 PurgnVhQdMakIQLl8Zmr1oQWR5VHBzDrYT6EGS5ifWB4bofUtuvbft0A5e3/Zpq6lfoHep1dogepX
 qX5FBvU3qIDrdtWqT8qw+6Rf/+qPNK4JFZlof0njF9+2pTOiAYkAG0v/Uov5288weHRbXS0jZdzvB
 rWCybbj8L558Jdbt9XpbeddxYaXh8+C0W7/08YxYusLBVGVd2hs5tidZ4dA5Uz4tWUZ7iTzKrxF60
 BjpM59Kw==;
Received: from [38.44.68.151] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qWuoi-002EIh-S5; Fri, 18 Aug 2023 10:26:49 +0200
Date: Fri, 18 Aug 2023 07:25:58 -0100
From: Melissa Wen <mwen@igalia.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH 6/7] Revert "drm/amd/display: Implement zpos property"
Message-ID: <20230818082558.y6no2dvvmzszelc7@mail.igalia.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
 <20230726193155.2525270-7-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zivhus4vjpgvgkq3"
Content-Disposition: inline
In-Reply-To: <20230726193155.2525270-7-aurabindo.pillai@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>, agustin.gutierrez@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, Joshua Ashton <joshua@froggi.es>,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--zivhus4vjpgvgkq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/26, Aurabindo Pillai wrote:
> This reverts commit 6c8ff1683d30024c8cff137d30b740a405cc084e.
>=20
> This patch causes IGT test case 'kms_atomic@plane-immutable-zpos' to
> fail on AMDGPU hardware.
>=20
> Cc: Joshua Ashton <joshua@froggi.es>
> Signed-off-by: Nicholas Choi <Nicholas.Choi@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 2198df96ed6f..8eeca160d434 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1468,15 +1468,6 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>  		drm_plane_create_blend_mode_property(plane, blend_caps);
>  	}
> =20
> -	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> -		drm_plane_create_zpos_immutable_property(plane, 0);
> -	} else if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> -		unsigned int zpos =3D 1 + drm_plane_index(plane);
> -		drm_plane_create_zpos_property(plane, zpos, 1, 254);
> -	} else if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> -		drm_plane_create_zpos_immutable_property(plane, 255);
> -	}

Hi Jay and Nicholas,

I'm examining this regression and, looking at the test code, I consider
this failure is caused by an incorrect assumption in the IGT test in
which any zpos values must be in the normalized range of 0 and N planes
per CRTC.

	for (int k =3D 0; k < n_planes; k++) {
		int zpos;
		igt_plane_t *temp;

		temp =3D &display->pipes[pipe->pipe].planes[k];

		if (!igt_plane_has_prop(temp, IGT_PLANE_ZPOS))
			continue;

		zpos =3D igt_plane_get_prop(temp, IGT_PLANE_ZPOS);

		igt_assert_lt(zpos, n_planes);  // test case fails here

		plane_ptr[zpos] =3D temp;
	}


I didn't find anything in the DRM documentation that imposes this
behavior. Also, the plane composition in the test is working correctly
with this patch and without this likely-misleading assert. In addition,
enabling zpos property increases the coverage of
`kms_atomic@plane-immutable-zpos` test (previously this part of the test
was just bypassed), so it's not a regression per se. Therefore, I'm
inclined to send a fix to IGT, instead of implementing a behavior that
fit the test but may not fit well AMD display machinery.

But first I wonder if you guys find any other test or visual check that
fail with this feature?

I checked other IGT KMS plane tests and AMD MPO tests (in `amd_plane`)
and results are preserved. If there are no other issues besides IGT
plane-immutable-zpos, I'll proceed with sending the change to IGT.

Thanks,

Melissa

> -
>  	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY &&
>  	    plane_cap &&
>  	    (plane_cap->pixel_format_support.nv12 ||
> --=20
> 2.41.0
>=20

--zivhus4vjpgvgkq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmTfKxEACgkQwqF3j0dL
ehyn+Q//Xm3txdvHfiB9VQArZJ79Yh/bLrVtYHZHz6/8ShvtvGUfLQt1E+XApAwR
5SSq8IwC7nga4iAaikyr9A79dk2pzle3nUZnXqc35U9czI7VFCbtLUOshcvQByjv
yv9OcUJIZq4MnA7/EQFvDbJYE+dMqH9cLocXuo27V2uUhePCOcozhYktXULFITfH
4wz1im44cBsfasU1WXO0dJ+PvfiPz6iUS2oi0lWxGXAEYaGgrXBdpaPyX5G3/wiC
y206cfa22z4ARqLbCDhUv0+US7SkAwBxMD654Yfs64XQDd6BAKnoSTVz1IzsASS9
OZfBbCoORGddP/5PtVQk2zrZ20Bd4XljfsmveTt8ILIqihpgzOjUDLFKsfcLWj1i
gOLqK1kex/eQby95rpEY94fuOqf7iUhSXoGg7rtKXxZS6tD9wG7rrJzGyKPwAiwc
8+4Cn4h7EmQpWBxtQ4HgV21kKMFodzMQ8yk3A3s4ObXxRrUJ/pwDHjMXIUQ2VQHS
tLijuJ4Zf9Kj4jFtOm9nbNlvRpgLvOABtnt2GCobg4TC/m52syT2DT9QNeb+oT6d
XW2T3R6M8DpbIzXg9KBvYk5t4u/EZJN+M6z1EBJwCAEjdlmpxmpVM6DZWQ0gbuC+
i8D7N5sglaRpUVumQrR6F/GBHvTwN7dgvbog+feW7g/myY0SSCs=
=Hpv6
-----END PGP SIGNATURE-----

--zivhus4vjpgvgkq3--
