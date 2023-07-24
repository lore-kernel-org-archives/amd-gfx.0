Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E2C001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F9F10E306;
	Mon, 24 Jul 2023 12:59:06 +0000 (UTC)
X-Greylist: delayed 467 seconds by postgrey-1.36 at gabe;
 Mon, 24 Jul 2023 10:24:48 UTC
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CB410E2CE;
 Mon, 24 Jul 2023 10:24:48 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id E72C61C0A92; Mon, 24 Jul 2023 12:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
 t=1690193818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2+McpDfsYpwZYH+MJBkwRRarEXjcvPMu7pbH7YtmA8=;
 b=E9S+BZL3KPxBs6CDkplLSGg/QQJ/0h1//H2ReveJgvfYdNehkAIndTpzIrjGpYHr/xNK0r
 H5eHBqkeiIKqOy5sBmo6vjUMBonlGkJVUnJ3ms7xzlHPjbci2iJC20sSIV3L+ksq5lckHB
 AfJ9mW8yQLfyYxgEZRF9jQ5+c9RMVL0=
Date: Mon, 24 Jul 2023 12:16:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 1/9] drm/radeon: Fix integer overflow in
 radeon_cs_parser_init
Message-ID: <ZL5PmleXslwGqwr1@duo.ucw.cz>
References: <20230724012450.2320077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+r/USItxKtE2w0t+"
Content-Disposition: inline
In-Reply-To: <20230724012450.2320077-1-sashal@kernel.org>
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:55 +0000
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 hackyzh002 <hackyzh002@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--+r/USItxKtE2w0t+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: hackyzh002 <hackyzh002@gmail.com>
>=20
> [ Upstream commit f828b681d0cd566f86351c0b913e6cb6ed8c7b9c ]
>=20
> The type of size is unsigned, if size is 0x40000000, there will be an
> integer overflow, size will be zero after size *=3D sizeof(uint32_t),
> will cause uninitialized memory to be referenced later

I only got the first patch of the series via lkml, rest seems to have
been lost somewhere :-(.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+r/USItxKtE2w0t+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZL5PmgAKCRAw5/Bqldv6
8oUOAJ4njNirimaFu4/gfUrc8WlC9GYNkQCfetCwTrc84IdGOfyYeVmrgQY1xI8=
=Pe6p
-----END PGP SIGNATURE-----

--+r/USItxKtE2w0t+--
