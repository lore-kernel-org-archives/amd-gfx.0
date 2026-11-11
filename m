Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9097606A33B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlvU4NQc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D0DF10EA8F;
	Wed, 11 Nov 2026 16:41:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A0E10FC42
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:41:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E6EE40396;
 Wed, 11 Nov 2026 16:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10AF1F00A05;
 Wed, 11 Nov 2026 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794415300;
 bh=wANOiiKjW/qxgOjivfXeHivizU1b5gZ1N2dFw0ft0dI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FlvU4NQc12rxI9uqQ8F0nP4NqkoI8fJgUgazUFAD/7pUcydeWm7sxiam7wAsFC8QW
 icifKHsodJq4XOqFvLkaa3jjp+wfDvVdh4NYpA8u5Y4TB1yfqHGWzuivr/bUK9d542
 8pRuQzkbj7U6TOlY3+QWP8c20KVTYDv6kpmgP8gOMFExUA979LF4pylhj37iY0O7tk
 vd/VzRc17KVzKzItCY70ltTUSkAlLij4ck7jwW6IWkmhPCuFyLYb1/1CJNKHzLwzpu
 ASS+Cv11uDSJBu/nSGSsdmy9TYUjdJqMlwbG0F24SFJ36hujiXCtKG1no5Sd6fP9/e
 3IWHKjGYRuz0w==
Date: Wed, 11 Nov 2026 16:41:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH linux-next] drm/amd/display: give the dprx CRC test its
 connector state back
Message-ID: <7602a3b1-225c-4262-9336-c7c1913ee60d@sirena.org.uk>
References: <avNxxfHK_Zh2GN2o@sirena.org.uk>
 <20261111161427.3274232-1-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WqOsds+BakThmrX7"
Content-Disposition: inline
In-Reply-To: <20261111161427.3274232-1-sashal@kernel.org>
X-Cookie: Do not pick the flowers.
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--WqOsds+BakThmrX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 11:14:27AM -0500, Sasha Levin wrote:
> The merge fixup in commit c62c2736d82f ("amdgpu: Merge merge merge
> cherry-pick cherry-pick cherry-pick") dropped the call to
> drm_atomic_helper_connector_reset(), which drm-misc removed. But that
> call is what gave the test's connector a state, so the assert right
> after it always fails now.

> Create the state with drm_atomic_helper_connector_create_state()
> instead, and check it before storing it: cleanup would choke on an
> error pointer in connector->state.

Yeah, that fixup was obviously just a build fixup rather than an attempt
to actually get things working.

--WqOsds+BakThmrX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0mr8ACgkQJNaLcl1U
h9CE8QgAhJWQI2k3RC2lcfC2jUckW0yU+e4yAoHkrAdZnRIbB+sf/pUgYNmQbCqP
Sc46MRT/fR2pFUABhg6E/ZV/oPY6jzbZmrE+OwCX0HF/czujDiXvuUqpjXANUZ2a
Wns/LsAGuEQLxYD+3g4B1s/1L/HAmFycKquloPQ7NIp9HM9Z5+FAQCtSOKzf+Q05
6WNw8hm2Fxfr/87Ouoql2chhHW2hzRIRVXkCR6IrmhIvOjcpU0+ylgFJjSGEtXfA
/YMsDVHGRY2gwpJKVqNjTKKysrK3q8QwYw5qhASw0+ChDe5ZvDs7daVJA+FBvFXR
QneFm9L3SyBwL9OhvIrF5+5ss2BOIQ==
=dFTH
-----END PGP SIGNATURE-----

--WqOsds+BakThmrX7--
