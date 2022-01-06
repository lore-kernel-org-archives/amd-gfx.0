Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D15EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 09:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EC310E6B9;
	Thu,  6 Jan 2022 09:29:15 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5168B10E6B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 09:29:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AA9EEB81FF3;
 Thu,  6 Jan 2022 09:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96BCC36AEB;
 Thu,  6 Jan 2022 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641461351;
 bh=sFkWcJ+pgWcCd34k/SgKqT6L+iE9l9xET5me3NI3n50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ttf2RRlossLF7mtUyscACUEPFaeH8SAyw3Qd+BZfDuEOor9GID76T4x9dk1FLefx/
 W6ykBtY9GfWYUte8ZBj+KRaw5CbGahDivf+gethodd9FNvjcL50E1NIloa6EwLIF3X
 aOEIqD1iZq1EA9Nl5RHE2oRF0Tm3Dmf8dMb5/38dj/7pWaauhXMmt/DGcaGk0s7Hbz
 lissSKej2hQVxqzNU0IlQKFQCzHeggSUfrPikCou8/pc9aFJMAWmxT7D+yfx4F92Xw
 iDCRN2/OvmQRWxgz3DNv+s+U/mAU/o4tOABlnOot9YOhJloBJK7yp8BkqgdSI2Fe/6
 sovyv0EPY2PpA==
Date: Thu, 6 Jan 2022 10:29:08 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: Bug: amdgpu stutter and spam `Fence fallback timer expired`
 after suspend
Message-ID: <Yda2ZKhvclIxbrad@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Konstantin Kharlamov <hi-angel@yandex.ru>,
 linux-i2c@vger.kernel.org, bibby.hsieh@mediatek.com,
 amd-gfx@lists.freedesktop.org
References: <7143a7147978f4104171072d9f5225d2ce355ec1.camel@yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l9suco8s8577Jsb/"
Content-Disposition: inline
In-Reply-To: <7143a7147978f4104171072d9f5225d2ce355ec1.camel@yandex.ru>
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


--l9suco8s8577Jsb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Should I send a revert, or is there a way to fix this?

You are the second one to report this problem and so far, there has been
no response from the authors. I will prepare a revert and CC all
involved people. Thank you for the nagging!


--l9suco8s8577Jsb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHWtmAACgkQFA3kzBSg
Kba7qxAAkUtqMhuL7R1RN4uGF+PewfyGLRSLbv7Js+pTSOPJuRrH1wwNX/EH+0EL
Go/DtB4v2368248mVOpj9Ck7DUygUfCzdhc3CbV6TFG+8ouaBdI4KN/vnYOTTRHU
NFhbuymrHbAaMmts3qQA5P18mTVYJFJnTPMYE7uKqnjU9tzDXxDeC7RS8Np9Eb23
sA67mZh9sQe90lXpguHWAqf/YYiSp4iKMHEUsRUQvVgC0NWVVw5ZQamHE9uYrIE5
xI0RaCxC7BsBEaXx101Fjmv5vRRNt4MhJDJpyjB/U3XzysHLFY8vNxIvasND7cWA
vTZuAJqZolEpWA//2ibimkByGtVjeZLpOYBoVhcws34iSHJsYwXOkpY5OC9Z+fk3
o6WHEm6g2nd1fd8YlFf2z7d4d2IPc04wpsFmyfK/j6+EqT4SagqvKC6tGDeFHayB
jWav3ihR3CfGngPqUYxCaRnCmrZ1H8UjlXOY2LqiW+9Uc0DoXq/ZzcSoirBG/iir
AzxcYRKpCS4h5jVzDU0FFKgEA8OswdYQPOFtmnw2K1hERTT6x4yJ8AIIAYOw0/Qq
YUmlAqcNFcIkX9oTa50iV72d+RlCRs0bLIhkI/DpCbkKdo3WCxbqV6dzgAL2n7Eo
5hjgWq8sf70QZsd09ckt6BCWs1/DFMiQ2xZ/bmTl7rose+6hghU=
=nJls
-----END PGP SIGNATURE-----

--l9suco8s8577Jsb/--
