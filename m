Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0529C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 13:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC1210E5BC;
	Mon, 27 Mar 2023 13:14:39 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Sat, 25 Mar 2023 20:23:35 UTC
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B76C10E21C
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 20:23:35 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 6BD481C0AB2; Sat, 25 Mar 2023 21:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
 t=1679775383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqv+LYcfzddHbULRn10F7Da1YwCj3m98d7oAQjoYGQo=;
 b=B5AZEG43iNeUPKu79Eo0CyI08wIXEWhIqsBeBT8D/Izq7a3qF/JxexeD1HGPBp23uIqfM5
 pFwP/gCaqs2IO5IaSXoynKbGcwvjOF4N+5gRT3lwqd4gMW1TmShm+H1r4PI9pdqQHJOKyy
 FJFPY7MuiYNHvvUBmRScLVNbDrSz7Zs=
Date: Sat, 25 Mar 2023 21:16:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/display: Add missing OLED Vesa brightnesses
 definitions
Message-ID: <ZB9Wltd9jiI7ktse@duo.ucw.cz>
References: <20230322160513.1438881-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vZOsuThjzQLN1+xx"
Content-Disposition: inline
In-Reply-To: <20230322160513.1438881-1-Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Mon, 27 Mar 2023 13:14:38 +0000
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
Cc: Felipe Clark <felipe.clark@amd.com>,
 Iswara Negulendran <iswara.nagulendran@amd.com>, airlied@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Harry Wentland <Harry.Wentland@amd.com>, Anthony Koo <anthony.koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--vZOsuThjzQLN1+xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-03-22 10:05:13, Rodrigo Siqueira wrote:
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Iswara Negulendran <iswara.nagulendran@amd.com>
> Cc: Felipe Clark <felipe.clark@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some changelog would be useful.


> +++ b/include/drm/display/drm_dp.h
> @@ -977,6 +977,8 @@
>  # define DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP		(1 << 5)
>  # define DP_EDP_DYNAMIC_BACKLIGHT_CAP			(1 << 6)
>  # define DP_EDP_VBLANK_BACKLIGHT_UPDATE_CAP		(1 << 7)
> +#define DP_EDP_OLED_VESA_BRIGHTNESS_ON      0x80
> +# define DP_EDP_OLED_VESA_CAP				(1 << 4)
> =20

Are you fixing a compile problem? Otherwise this should go in with the
user...

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--vZOsuThjzQLN1+xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZB9WlgAKCRAw5/Bqldv6
8hNeAJ9Z6iHpiX7M02eWAO5DogqxZDen0gCffJw9G0L8fNgcM6poGr+ycBvtTFw=
=pb8n
-----END PGP SIGNATURE-----

--vZOsuThjzQLN1+xx--
