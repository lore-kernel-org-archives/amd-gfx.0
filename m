Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B52BEA813A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 16:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CB910E5B8;
	Tue, 10 Feb 2026 16:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RMyQYHYN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F7D10E5B8;
 Tue, 10 Feb 2026 16:00:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 374C843EC3;
 Tue, 10 Feb 2026 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A011C116C6;
 Tue, 10 Feb 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770739208;
 bh=zldcbNbjmj+RA7A3DZ3ZkdfjMPm277Yz7u9u9p4QqjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RMyQYHYNpszMSJqmidkGX2NoEYtO7xOazdfZO2Q5iGJNTMCgJ+znXKLHV3wU+w5mU
 81P544GiPydpylxVo/SCUj9yY6feDstrxgJOuMw/pWJJz9ndZsgEC2zR4EHbObdpi4
 pfHL1KTzKa1NeezI3wv7aGc81F9plh/aKvv2RW9s5nFZ6rCp0yQ9DhjqSHhHQUn6L/
 vVP41AcOWSjY2uwX18XpLxfND6DbM5L4o9zj0y/UV6PtcPdBVM3ih+N1X0kYONwg9e
 3ymEssncp804w6MMxkU2DI6GfIPLf5S0gp9wgoKnhCAqL5W9wEcjZ0WXGGTtj4CcEz
 EB95D+CLtTCiQ==
Date: Tue, 10 Feb 2026 17:00:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 20/22] drm/tests: edid: Add __maybe_unused attribute
 to EDID definitions
Message-ID: <20260210-didactic-okapi-of-modernism-ff00d9@houat>
References: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
 <20260121-color-format-v7-20-ef790dae780c@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="km3cw6v2t5aytgoz"
Content-Disposition: inline
In-Reply-To: <20260121-color-format-v7-20-ef790dae780c@collabora.com>
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


--km3cw6v2t5aytgoz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 20/22] drm/tests: edid: Add __maybe_unused attribute
 to EDID definitions
MIME-Version: 1.0

Hi,

On Wed, Jan 21, 2026 at 03:45:27PM +0100, Nicolas Frattaroli wrote:
> It's normal for a test suite to need an EDID, but not all EDIDs across
> every test. Silence compiler warnings caused by unused definitions by
> using the appropriate attribute.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

It's not clear to me when the EDIDs could be compiled but the tests
wouldn't, and as far as I know it's all part of the same module.
Expanding a bit on how you can trigger that warning would be great.

With that fixed,
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--km3cw6v2t5aytgoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaYtWAAAKCRAnX84Zoj2+
dt2nAX0UsXzuusEYCVBCqgJwtZ264lcQWo9yWUlALQWTVuR932yQyPhy8y6N7uQn
emUBNQgBf2NvmzdJa+lE7RXY5eWBX5awNF8H76g5vlBxZXvOQkVir9drD30JTaPa
AhXIei7HvQ==
=9Hue
-----END PGP SIGNATURE-----

--km3cw6v2t5aytgoz--
