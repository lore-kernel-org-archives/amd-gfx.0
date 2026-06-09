Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E73CD98D2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDC110E7F0;
	Wed, 10 Jun 2026 08:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="kkYgjhnK";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2BE10E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 15:41:19 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-46013161068so2874466f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2026 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781019677; x=1781624477;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eTQ0z82edx7izZ5M6HvScOeSVrCrfTYfKUwEx3Pk0Ts=;
 b=kkYgjhnKOrtDAC9kyiy5SqyFc4lP4BlXVNSFwfQ9Gnh2uhe+FUNkyJbd9c52JEsgbA
 MnOegkdpDSzMQ9asvhdk6ObAwOEadQbUDFpzU1CY7WZ8CDOFmrdMyImVI/xvkWweywb5
 OdQuGkcwYGOo7D72fIluce8X/qY14oubVVLKxNYz1hCI9JpZqbsJkOp0lwH8gLoGvRR4
 6dIWKn3mFGQXLQVykijZu5A9k1pmGecJXmv8UgPPhEaZvVMUMwZruniUmOzNnnT0Igjr
 hF2/jp0+UVKNfR3cWNRYitalqjefoKDwwinzpFsjhW1kFLhlLtkqH60RlzFkdqutJs/K
 yEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019677; x=1781624477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTQ0z82edx7izZ5M6HvScOeSVrCrfTYfKUwEx3Pk0Ts=;
 b=bNeUZlOIfrQEB2GtTY0lPAO4JRu4t0MVC9czsZDZjSJnDTUawrx0ovB1aE8BFKZK36
 9SYcAwq/LVleyvtO0Rd/znx+RTv61jB8Ym/pZrJsOcBnBOiWHFp1cHgXi9ONRuV2vTLm
 uYzEg4zYWzlbKRZsQF06Q2K/H2Y2HeQPyY9G/6DRKJxt17Nvu1HkmniNOY0o04EfyrL8
 bRDLGQUxqY1Bxk/Jvy68V9n00C1zKjTZwuEaK9BtxSUEoMC8GdRsHu9ySGZcIJegbMQY
 sqHgxnrgYqybOn1s/QhLZa1589T0YWwZ72BQArIqP4Kz/4NCUsWhf8bPBEIdJKZcVMut
 c29Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m5zT5CK3/JO7+9bVyrUMLFwCveP44untYlh6n5e2KKchaxlYy0cM783Bd3YMm4iFZwtw8Wrgu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA4qc6D0sc3Ml7+IwP1ogOTgmPHrGVhReTGYSURDzhySOKGue0
 rB4I0Lpwbnw+DRu7TCHjtOzIdl0BZxGxUDEFmlxo3K7GFeukNe9x5zlNdQyb79wawkg=
X-Gm-Gg: Acq92OH33xfE+7cA2adRb7XX5IbrF0GnFfVdIBJtFU3ydbXeFfYcPAI2qIPnMOU+I5T
 ThQHa7Fqu1nRGgQpegtQ4IcLypE+LCWQJ9IJT6dMVc3AV32/1w4YZ5eN8WoQgCa5VmjmPvxpzJm
 yliPk2U6YGwAXrlZF5UazY1eCmunhbZ4/UlADM0dbDKHK6FpIMtzpdSczmbeUMCRXGZNbus84yU
 bq9xnYVX4j5GnlV5dE2PS9xlKpSuJ8tRgRjRwR9VGxx1lu+XBycHl/h/0xiwMGnoeF7WcRa6/NP
 P7/gD5G6zvUiL7+UB0ms/azv/2OZgiyNDYhOsAgAHHRVE9DbGwSaezaTxaP3/0K7VHUMsFo5Vx4
 Xzty+VfvdOizS23JEF+ZISrMktNNJfPXk6TqcWAYu2Rr2+zVuIusPINysjUX9cjjvIBNTba+wg6
 TnYZ3ip+C+oKBxMXrEmVYjQOS7fSt0HdNM8ivWbCyJhdH0byMLo753/rWVPP1AQhR+3Q10jmvc/
 vQDNx1+F7sIa85Tzu9vP8XZ2Q==
X-Received: by 2002:a05:6000:4810:b0:460:31d1:74de with SMTP id
 ffacd0b85a97d-46031d17543mr30625012f8f.10.1781019677504; 
 Tue, 09 Jun 2026 08:41:17 -0700 (PDT)
Received: from localhost
 (p200300f65f47db045b0dbdd314d8a71f.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:5b0d:bdd3:14d8:a71f])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f2dcad5sm69142618f8f.5.2026.06.09.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:41:16 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:41:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v1 0/3] drm: Drop unused include of <drm/drm_pciids.h>
Message-ID: <aigzdDNPzW53C_qu@monoceros>
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="svfjk3dijitcjucq"
Content-Disposition: inline
In-Reply-To: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailman-Approved-At: Wed, 10 Jun 2026 08:41:55 +0000
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


--svfjk3dijitcjucq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] drm: Drop unused include of <drm/drm_pciids.h>
MIME-Version: 1.0

Hello,

On Thu, Apr 30, 2026 at 12:45:12PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Hello,
>=20
> <drm/drm_pciids.h> is only actually used in the radeon driver but
> included in several others. This series drops these includes.
>=20
> The obvious continuation would be to fold the definition of
> radeon_PCI_IDS into the only .c file using it. But I post-pone that
> until
> https://lore.kernel.org/all/20260430102958.136859-2-u.kleine-koenig@bayli=
bre.com/
> is out of the way.
>=20
> There are no dependencies between the patches, so I suggest that each
> maintainer team applies their material to their own tree at their own
> pace.
>=20
> To state the obvious: This is merge window material.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (The Capable Hub) (3):
>   drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
>   drm/gma500: Drop unused include of <drm/drm_pciids.h>
>   drm/mgag200: Drop unused include of <drm/drm_pciids.h>

Patches #2 and #3 are currently waiting in next for the merge window.
Can you please pick #1, too?

Best regards
Uwe


--svfjk3dijitcjucq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooNBcACgkQj4D7WH0S
/k66Kgf9F8X3amz6xSCSqPrDMUAfsE0yDZryfrIdD04Cwdr/eyrQRmK9SpBEjjbQ
cwNFLbQlMAXke0LlhXjXCILSp/BuqKUmH0q0GtJrkyaD8Odw9/Dnhlkq2RNaEIJ4
mEeP3FM+StpommN9gqQnLHa3qL2a9LZCZOpYEi7E4PlPe/5qohqfzsR3/baoSqnp
ckBO7qMZarO8OjK0n8yyIJ8gemk9LPZn2yA5NIw+qB2Eyi+3Uo/ks6LkKn0DAQw8
0lRBn3kdnepYx9gWzkV3CqkSQBOQN8NFe36aqLlXTQ+xgoaY4g+bV0EkWXV+PGY4
7F/irVgVhWjGPuHgDv6NOXCR+Jda/A==
=BDRz
-----END PGP SIGNATURE-----

--svfjk3dijitcjucq--
