Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB4ECAAD1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 07:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E272110E212;
	Wed, 31 Aug 2022 07:28:01 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F1510E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 23:37:03 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHNxh72DBz4x1J;
 Wed, 31 Aug 2022 09:36:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1661902617;
 bh=hHoJRNkgJskuDqFVMFnPKFEtUwqf/41b/lXXmFXq2/s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h/l6fKnIoVnF9idoKrm088G3Fm1yYMALPPr1XJpz5vR6HJuBTbbUdEl43QjTwqfRw
 iGWUSoszrFRGZuklbOhFCbljlNPGMfFgRL/lNw0L42k/MWfsnii2k85Rfq5C3isqKD
 sDZKsf0R8T11zmICO/ir97/SWUaB4631E3RWiTi5UsC57+kMEk7nGHvZdtOySGbk90
 10aYc9f1TyMsWzmagsQuSYw/KZvgKwmcjj8PwY82zF83H7S497lZhyaBe6jfDNXdEk
 AgMJzMMr0i1VGKKs7sFV90jj+xniaK/UsrUdt/2+oHrM55R5C1UlDaOeqHxl2hGU7p
 p1vxMJqKZlYnQ==
Date: Wed, 31 Aug 2022 09:36:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix documentation for
 amdgpu_dm_update_freesync_caps()
Message-ID: <20220831093655.299c982d@canb.auug.org.au>
In-Reply-To: <20220830215752.26536-1-alexander.deucher@amd.com>
References: <20220830215752.26536-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_6LwBUAAitCnAwZwKeSXZok";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Mailman-Approved-At: Wed, 31 Aug 2022 07:27:51 +0000
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--Sig_/_6LwBUAAitCnAwZwKeSXZok
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, 30 Aug 2022 17:57:52 -0400 Alex Deucher <alexander.deucher@amd.com>=
 wrote:
>
> Document missing parameter.
>=20
> Fixes: 8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgp=
u_dm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> ---
>=20
> v2: fix aconnector too.
>=20
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, looks good.

--=20
Cheers,
Stephen Rothwell

--Sig_/_6LwBUAAitCnAwZwKeSXZok
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOnxgACgkQAVBC80lX
0GzLXwf7B/o0iE7tfxajJBIYsYTm+xrvw7oNb8rHGt+NT3aHEM/h29Vqg4SZXnx4
kAoEc46SG+yhFTF6FlxyqWSi3KjcENKTFOJJBYh/gZamLN2/1NVXMOhlapMNo/Ei
huIwXusPFEhmoXSupIduwCMq9jIVmopxgipT4xamQJgYCVADIVal5xYh3Y+6sZ/U
lQSupXg3j8zg5zw32bS3AUXj6t5wM6gD180G+qni5N9p174X5LVue6tGNmdMAl+9
iuYgN2gSmObSGjW4mtHTFPGTsaAp5wJ+Pa3nACTRRt8FC0yYGEGX9HX39+Mu7q59
9m2XZaIJz/HAkHAu1K1BuTRAtScH+g==
=lsp+
-----END PGP SIGNATURE-----

--Sig_/_6LwBUAAitCnAwZwKeSXZok--
