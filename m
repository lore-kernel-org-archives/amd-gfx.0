Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947D606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgZpwmOp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B97112880;
	Fri, 30 Oct 2026 14:55:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85CA112880
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BF01415D1;
 Fri, 30 Oct 2026 14:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D431F000C1;
 Fri, 30 Oct 2026 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793372121;
 bh=nHkDZPb69+uTPpEwG2sgAEgHzwtN/SsqxRJ2qzJHpoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cgZpwmOpQUBBjHKu7ypMVPNVJD5+hfvw1dikmX1fKSIDuMth4ApCaelzuodAFqH4B
 BsS36is5IXIczywHSOHiZsFCUOi70W9OGKiQAmAuY7MqZXsZk2joQm5HWLvOsJeOWv
 /tDQDuvOnjz4/D8P4PsHUGecmo3BUK3Cy4oGY0/8bfX+UgzI4gJJOMClccxP/AqodK
 QaLgCDNC+pC6GU5TGFYJvd91KOBiGeJKaWo04wWR7d5LMphWMwWix/oksCl/cYwSwG
 2VPUCni26FgaX8OnUloumN+BDJ+jmR1Aru4n3fawq8EqtljN+I6m3kM5wozfpXuoQv
 l2TY6OcwSZRyw==
Date: Fri, 30 Oct 2026 14:55:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH linux-next] drm/amd/pm: fix up the amdgpu merge of the
 smu 14.0.2 zero fan restore
Message-ID: <f3a400f2-93cc-49cb-aaaa-41c978b0b842@sirena.org.uk>
References: <auNVlhF6DGyFYx10@sirena.org.uk>
 <20261030104101.3496560-1-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGs0dLWYcmH7SmvC"
Content-Disposition: inline
In-Reply-To: <20261030104101.3496560-1-sashal@kernel.org>
X-Cookie: Orders subject to approval.
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


--pGs0dLWYcmH7SmvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2026 at 06:41:01AM -0400, Sasha Levin wrote:

> Mark, this applies on top of next-20261029 and is meant to be folded into
> the amdgpu merge resolution.

Thanks, I rolled this in today.

--pGs0dLWYcmH7SmvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrkr9QACgkQJNaLcl1U
h9DptAf9G463TVnL+fB4xIKzLw46Xsj1UfKTW6zWoQR1gH9GPUNqxxncia+YulrV
t1niT1wOmpSVXqag+y5YtwXT5ov1tuSyklpVLBHG8wyqer4E7vjkn25/eXVEs///
k6tZfaqruBdDkesUmWrMV53mhTp2iwrX5jhnFAnuiaaQdJNWNVJXQH1vTF9xc6GE
9Qt3Zy8jf0r127arHRrG4lVoEbL4RqpaLoJrYm9fvm8hxULtRQWyRj9zwgd4EtS1
znnMHt2Yf7fX7oN2Hd2SZ1MTNPKTx7FVKBwGxYUguHlhr1/zibXCDkebIUzho7wh
f21Ez5buaCNFqUGrLYn1sMH1qqXL7A==
=9GUG
-----END PGP SIGNATURE-----

--pGs0dLWYcmH7SmvC--
