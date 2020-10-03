Return-Path: <SRS0=Wqu9=DK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C5C41604
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C2F206CA
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vE1fXTAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C2F206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE046E3B2;
	Sat,  3 Oct 2020 09:25:53 +0000 (UTC)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDF96EA05
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2020 01:11:59 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4C38310W9Rz9sSf;
 Sat,  3 Oct 2020 11:11:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1601687517;
 bh=XoaN3P5jnPla9ib682+fD/pchX2RuDH7ngOYA3Skz2w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vE1fXTANqHW8W7u5jPPfzIrt5zSPQihru0Ebh8U2HhQoyz+1D7dkk4QyFi4Xl+7N4
 f9pw3Kmwq/kXHE+RQ6p3RR1QAxTsm1XeQRSVkmF4Q/tUeyeHYpww1PWAnzTOweVxR2
 ZO0QaZajw/yuqphStJNey1clww0NtT0vsWhzIQgQvhcdRq2Q4e9mjTMLGoZzipfrS6
 wrw5Uq2qkjTQyUxTakzgFkbAfaKuybD3gaLbfZ+hoVRz5CA9dUlBVr/QrO7L0YNmnq
 nH2Ds0kRvS3UAXl2xx6XI1U3oIfrBVW1klbiQLv1RFONN8nOBUSfNHjgemS65ZMxHP
 3oBf0wxiYBDBQ==
Date: Sat, 3 Oct 2020 11:11:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
Subject: Re: [PATCH] drm/amd/display: [FIX] Compilation error
Message-ID: <20201003111155.0c3458a0@canb.auug.org.au>
In-Reply-To: <20201002235608.10953-1-qingqing.zhuo@amd.com>
References: <20201002235608.10953-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 03 Oct 2020 09:25:53 +0000
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
Cc: Lewis.Huang@amd.com, Aric.Cyr@amd.com, Harry.Wentland@amd.com,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Alexander.Deucher@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com
Content-Type: multipart/mixed; boundary="===============0711119464=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0711119464==
Content-Type: multipart/signed; boundary="Sig_/rWUpIF9.qf2Wcc_y9HSfktQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rWUpIF9.qf2Wcc_y9HSfktQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qingqing,

On Fri, 2 Oct 2020 19:56:08 -0400 Qingqing Zhuo <qingqing.zhuo@amd.com> wro=
te:
>
> [Why]
> ifdef mismatch.
>=20
> [How]
> Update to the correct flag.
>=20
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: <stable@vger.kernel.org>

This needs a Fixes: tag (if possible) and the error message, please.

--=20
Cheers,
Stephen Rothwell

--Sig_/rWUpIF9.qf2Wcc_y9HSfktQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl93z9sACgkQAVBC80lX
0GxOKQf+PUvWRbiUOrNb64ItXGzhQEdFADSBzIRFBA5E2N2PYjoUjl7T2OTeWcuG
bb1SPP6a1jScNoPQfAQz1XI63Kn3YpNq27gn1bOE1aNMI7R2WcRT5/JLBRYCk89n
qujr3DvotA3AefL/wGnVpDQWzjqpMUyoLdyQrezNb+O29o5/hNtzEWfvuEtC2QSK
84ck3igrQ0z7qiU6xlOw6aY1t6IDFbAji4KVBci093Lhh+9/QnjqZEZw+bJH2if7
Lo/n7K5tbNS7vAOKbSsSSyq88dvunnw1WNJzQzRyCSjk9BEPWufvpWeoDmR8SX/J
+qpXMx/3azlzhYtzzxhkhFF8XLp3ew==
=2D+W
-----END PGP SIGNATURE-----

--Sig_/rWUpIF9.qf2Wcc_y9HSfktQ--

--===============0711119464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0711119464==--
