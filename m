Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAB105A599
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 13:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4C410E9E2;
	Thu, 12 Mar 2026 13:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nUomNgrW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6CC10E056;
 Thu, 12 Mar 2026 13:10:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C852B60054;
 Thu, 12 Mar 2026 13:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27889C4CEF7;
 Thu, 12 Mar 2026 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773321018;
 bh=jTy3azf1PkKSF8ECAom0RzcO8nF02xVOKWaSXlmdTFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUomNgrWTZJDCgcW3vUf6Y71yr+fkMFPXgMDmIvQRPyzNQeriQYlorDDDcpltvFXD
 OK6O8djjJwJBc6WLfNmqK7x1f2pLvA8fBXwVYu5d6Xurl4aP/pRLzMA5AQWQ+YsnBf
 lHlonpkDMfdjAjCcTj3oySfxMtIaTvnECLvq8my0VzeRlUiejW578yyegVlmIoV7YY
 6LhEOCkIaCxVokNNxIGRMd1N2Ln5wjKlWWlNZnXDbTtIuEMh5r6AMHJ0EZpbBgC/qG
 bDDQ7IXXwLadMv5qcHOKVO2C20QrAum0ahyxKp6uhwcUztZBIJatBJVOUE/PcGm/hE
 PmSXhBbhmSbFQ==
Date: Thu, 12 Mar 2026 14:10:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v4 1/2] drm/connector: hdmi: Add a 'link bpc' property
Message-ID: <20260312-refreshing-sponge-of-calibration-29ec8c@houat>
References: <20260311-link-bpc-v4-0-51775e964720@collabora.com>
 <20260311-link-bpc-v4-1-51775e964720@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ccimwwc2aro3kxhc"
Content-Disposition: inline
In-Reply-To: <20260311-link-bpc-v4-1-51775e964720@collabora.com>
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


--ccimwwc2aro3kxhc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] drm/connector: hdmi: Add a 'link bpc' property
MIME-Version: 1.0

Hi,

On Wed, Mar 11, 2026 at 12:30:55PM +0100, Nicolas Frattaroli wrote:
> Display drivers may degrade from higher bit depths to lower bit depths
> for reasons such as bandwidth constraints. Userspace applications, such
> as compositors, may wish to know that this has occurred transparently,
> instead of assuming that the "max bpc" they requested could be reached.
>=20
> Introduce a new immutable DRM property called "link bpc" that reflects
> the current display link's bits-per-component. An uevent is fired when
> the link bpc value changes.
>=20
> Set the new link_bpc member in the HDMI state helper to its HDMI output
> bpc, so that during the next commit, the property is updated accordingly
> and the uevent is fired.
>=20
> Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I feel like this should be two separate patches: one to create the
property, and another to hook it into the HDMI helpers.

With that fixed, and for both patches that will come out of this one,
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ccimwwc2aro3kxhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabK7MwAKCRAnX84Zoj2+
dsAVAYDDeWvVkOl778C3UeLo88r6LSN0rlD+2CmTHXJI5Aa9EXRmgvr/BSZyrWWN
W9fGWTABgIeDdOAwSmlbUc4h0baNmdgXAcIjKVRUJ2TBehnRoltC2i7Kl0tdyC34
8Kp06y81EA==
=NgY1
-----END PGP SIGNATURE-----

--ccimwwc2aro3kxhc--
