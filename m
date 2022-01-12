Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 09:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E29113512;
	Wed, 12 Jan 2022 09:32:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773D7113525
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 09:32:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AB98A618D5;
 Wed, 12 Jan 2022 09:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FBDC36AEA;
 Wed, 12 Jan 2022 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641979976;
 bh=v1hvtKAaxy/THVYhBJu+JN0Ofk0qcb2ouwGb4TAUGUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bmilo3hyiTmaJAN04zcSML1dfLz3GMCyIU20G6F+ZYZVJMBYQWeh3Xkpwyxz2LUxf
 9me1UCusCZ7MpXICHzSilMkPNAQLbiCLK1kTZAVUbVSNNNVpEjDulwFm0+VOb8S0dH
 J2KklY9e45ik2C4DY0CKT6d8opUD2l5MhjW8v+vH93c3iIuMRJdJHjmlWdHmiEYRuK
 HqsTHtKz/i1+/D121rCadNLl9yPEydPh9RIKx5xQTvZsuZl+FiwkKh/LT7sj8lUefT
 7YtpXWsHmdcJ65XR7EDsQIl/3IosJXIx8u3Qd5paJh+qlvqheyAni5ALaTc/AvDurV
 Cprt5SutneWNA==
Date: Wed, 12 Jan 2022 10:32:53 +0100
From: Wolfram Sang <wsa@kernel.org>
To: linux-i2c@vger.kernel.org
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
Message-ID: <Yd6gRR0jtqhRLwtB@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>,
 Konstantin Kharlamov <hi-angel@yandex.ru>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220106122452.18719-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="khzXD0fBZjVVSddA"
Content-Disposition: inline
In-Reply-To: <20220106122452.18719-1-wsa@kernel.org>
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
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Konstantin Kharlamov <hi-angel@yandex.ru>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--khzXD0fBZjVVSddA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Thu, Jan 06, 2022 at 01:24:52PM +0100, Wolfram Sang wrote:
> This largely reverts commit 5a7b95fb993ec399c8a685552aa6a8fc995c40bd. It
> breaks suspend with AMD GPUs, and we couldn't incrementally fix it. So,
> let's remove the code and go back to the drawing board. We keep the
> header extension to not break drivers already populating the regulator.
> We expect to re-add the code handling it soon.
>=20
> Reported-by: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>
> Link: https://lore.kernel.org/r/1295184560.182511.1639075777725@mail.yaho=
o.com
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Link: https://lore.kernel.org/r/7143a7147978f4104171072d9f5225d2ce355ec1.=
camel@yandex.ru
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1850
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

So, it has been reverted now. Is someone of the original patch
submitters interested in re-adding it? And would the reporters of the
regression be available for further testing?

Thanks and happy hacking,

   Wolfram


--khzXD0fBZjVVSddA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHeoEUACgkQFA3kzBSg
KbbbJhAAn5xNNoemF53yiy5cNxFmZNExFWhUga4Ib3kd6rySwJtFUHhvS2YkRgc5
FJekjLbWQuKFo3E+YWpsKyjVE+m7a+/cuFZ2y16m5FZ4iO5OPk26znW+dil1FuoA
F6n7OrN4Xbkcu7n2MbEk28T/9E8yg693TgZvy2+I2YHbo1T7YB8HGOed/p30T20S
iihk6udli3cnoBqYXiojwxM3FeYQkXOtWp1vcrreDzYtkGG8r/efWFoVwDj5WOn7
hO/QtiOcYj0unc087DDA9pT7ZtM76zy/AbIuDKKTjJ5Z8w+B5/oql0pNPWzwMAc0
/6N8MacMyoPhkBYxuysuw2NHsG9uuXEVYra0xzniHX6XJbp9fH9tkrs+cB8CO/6F
IPj9roj82MIJsd58mSv3GHiXCwNKQPwGCOfb2JDshaJuWfcTLTq5K2VD5Jzp4uXS
tNVQFLIu/+OtxT55NKDWRJXWWCQ7L2wTT6irBpRN86AE8sfreY5ja/7m368s9zHA
W4kkF4CiU9YVAdBe/+auy8zsezoJDsEtPQgjfrdMGZ9O+uc6kqqMWCg7X4wKP8rX
oSA+uBYlBNqZCkX5OVy3OJd2Q2FbzorjMIg72yCzzfw8gEXgwDctGWzpIWcgWtOn
D8puyOhzjFazcSr7ixU++G+P9r2Boc3Kg258edrg6SF6EMMnN9s=
=7V7P
-----END PGP SIGNATURE-----

--khzXD0fBZjVVSddA--
