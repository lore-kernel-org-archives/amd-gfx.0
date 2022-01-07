Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3834C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 20:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2408710EBB2;
	Fri,  7 Jan 2022 20:24:20 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCF510E6F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 20:24:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CFD0D61F91;
 Fri,  7 Jan 2022 20:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03700C36AED;
 Fri,  7 Jan 2022 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641587057;
 bh=UAfnoL86ZB98XRycStRMpkOz27mbd1CkSVdgWDPqoVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CxkoS7+Aruk4/7+DqCXCZLAKViPpVIKZ8uuz2N0VissXeC5dmsrNGJYQMzstfKqOI
 qx0035OhIEnWvgUoYFR7FSJohaEz7RiyTGpo5d8KCi2gCWAv7RgPx61b4LQ3CB5cAF
 Ydj5T5Y2hK7fAUOXwXTcv/byHv9SQeThwWiU8ktKIW8WH6z0Hzu99KiFJzioskuug6
 OWmXt1HANu88VFJpunrjjaoFSkz0uddR+MBM0nYjHPnxHaDzgtjPXeTvXzVc/FydaQ
 beAL6cWYZqSg3Wc2VguIik0UTma2i8LQCRBDqk2v3GIldXITLUyKLCxD2ltWpqSmY3
 +JD0M6V4P7MCQ==
Date: Fri, 7 Jan 2022 21:24:10 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
Message-ID: <Ydihaksfmm6TiG8y@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Konstantin Kharlamov <hi-angel@yandex.ru>,
 linux-i2c@vger.kernel.org, bibby.hsieh@mediatek.com,
 amd-gfx@lists.freedesktop.org
References: <20220106122452.18719-1-wsakernel!org>
 <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S/gKSxHGeHhRRdpK"
Content-Disposition: inline
In-Reply-To: <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
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
Cc: amd-gfx@lists.freedesktop.org, linux-i2c@vger.kernel.org,
 bibby.hsieh@mediatek.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--S/gKSxHGeHhRRdpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> 	Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>

Thanks!

> By the way, shouldn't the patch include a field=20
>=20
> 	Cc: <stable@vger.kernel.org> # 5.14+

Yes, but I add such lines only when applying to my tree. If I add it
when sending out patches, the mail gets CCed to stable although the
patch is not upstream yet.


--S/gKSxHGeHhRRdpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHYoWYACgkQFA3kzBSg
KbbyBxAAmoMZVtND7b+hYvwEhq6vE1IWvlD+tkGACi94UWfnxie12sV1lBgFQuth
lBcs1jvh1AUyht/cgN7zJP4hYoGpAUFmITs5lxx/JKBYXGMVVqMy/UFRSEgBxfJ0
ZM0F5YjCOn811vHck+Z9rpPfJcaqv3i0Ox5sPHQtr+LoKkLWQwgcvtjcnqGje0nH
bTE+TU+GzRBXr+kDlERSrGDOLfGOLvccwhfEWrPCHlUi6SdmgoO4LI88pjuzIMYO
AMYUI+TvCyjWcSizhoyX76GDphU/zgFgUvvlkhwnzBmuWrOYIhRik0EDIyr3FEld
mQQ9scebHvrDLj9JTj22TmW6qS3MaDouSxLyb2SBvczx44kB55Vu48V1Ta1v6b9R
RD0WOP1NR5X2CUHIQN90hOF4Df/HfNa2b09nbS2x5TwUVvsGl56+Xu0N2ijWMgJt
3V8Y4h3iU6CxnIo4OihDdfaCWRMTaffA1zrbhGTvcobrZiqY5EAGGojxYZTjEySY
WTTraD1YRwBeKKu5kAbd5zN20hXyqZV5GSpd0P4lpDU6AtJ6ANf9F6Wlacp9Bxtz
67EsjrxTg/bZEsWYUwc3BNRgAZej/q8orXr/fLhirphGCLFtIecU3YL4jcALcZap
4yaJRgqinw84Z01huSBEP//sOyvIPgCuiTKQgWz2WR7FMzsQU1k=
=JJG0
-----END PGP SIGNATURE-----

--S/gKSxHGeHhRRdpK--
