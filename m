Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EADC43464
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 13:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273B421789
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AFg8rJ8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273B421789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46876E2C0;
	Mon, 21 Sep 2020 13:14:31 +0000 (UTC)
Received: from fanzine.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0EC6E245;
 Mon, 21 Sep 2020 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID;
 bh=fDLgJXux/jRKs3pMveWM95iw4736sPWZKd6xbDbBR1s=; 
 b=AFg8rJ8mI4p77lFEAjmTestdzWgZC5/suP0QGy767a/qDRvNU7q+RO25W/I1ct3Zg47ZkLyWudVChe0aYu0a6/tbiBrdfWbtChwBDnsTI+7NNqrhihhrJPA2sTWcEnMxa+SAcDiffJHhmXVsz1Xnw4idJFm15VMMI14AMxWfu3tExRijvGkVBc93VJ9SUrqe+D4yYQtqJin4KwB7HqXuobv86zOrSNd1kUOYmt2JrpuCkE2zT59sM87fZuSMbWGp+5EnlAlSg9J+FT4FBlI93BaDEtQ/OoMafesYmnmQyyP4GZAcJK4atCzp4fwCpdxMKamwEXfiwuf6U2XeAWhHkw==;
Received: from 11.red-79-157-245.dynamicip.rima-tde.net ([79.157.245.11]
 helo=fourier) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kKGqq-0002IQ-OO; Mon, 21 Sep 2020 10:07:08 +0200
Message-ID: <4eaa69879014a406424b9702dd6574a305f4c98e.camel@igalia.com>
Subject: XDC 2020 feedback and comments
From: Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= <siglesias@igalia.com>
To: "events@lists.x.org" <events@lists.x.org>, 
 "xorg-devel@lists.freedesktop.org"
 <xorg-devel@lists.freedesktop.org>, "wayland-devel@lists.freedesktop.org"
 <wayland-devel@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "mesa-dev@lists.freedesktop.org"
 <mesa-dev@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "etnaviv@lists.freedesktop.org"
 <etnaviv@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
Date: Mon, 21 Sep 2020 10:03:32 +0200
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 21 Sep 2020 13:14:30 +0000
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
Cc: "board@foundation.x.org" <board@foundation.x.org>
Content-Type: multipart/mixed; boundary="===============1410681450=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============1410681450==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-evhoVZFKP3ts0eEigqE1"


--=-evhoVZFKP3ts0eEigqE1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Huge thanks again to the entire team from Intel, for their great work
organizing XDC 2020, our first virtual conference!

As usual we're looking for feedback on both XDC itself, and the CFP
process and program selection. Both about what was great and should be
kept for next year's edition, and where there's room for improvement.

The board does keep some notes, for those interested in what we have
already:

- XDC notes for prospective organizers:=20
https://www.x.org/wiki/Events/RFP/

- CFP notes: https://www.x.org/wiki/Events/PapersCommittee/

If you want to send in your comments in private, please send them to
the X.org Foundation board: board@foundation.x.org

Cheers,

Sam

--=-evhoVZFKP3ts0eEigqE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAl9oXlQACgkQf/S6MvF9
w0PiNA/+Jj6uBmncvTzk2d85o0AkBPwReXMxso8OY4eO3wIF5OZxU9SlNUguRAKL
o+1G26DR76H8CmbClqFlGdQAisyABN3TsHrfPiHvjAw+DQajktptD6zFgUH2PBhj
KqceS/Fm/1Glcy4CJoQjo44e4XR03wDV4of93y/J6PKvxxk809EvRIC/PTbaSE7M
CRJTZsCLJCr6C9JQtTg5VoQW9QAcruNq7PLZuDsOqM7lGeObupRQjCUd62DA4Qtq
CR1LIqCkp8A6fdyQBJNljgNz46bexvg+8z1rrPsE6BhQco9hFsU70fUQK1JXTIGl
s97bqNaO0kt0C0pgId452l9OfjCJMOzNJJktlMQMQE++j8ZrM7lNf03clzWfUy3s
MHF7XjrGKqfOZU04zd302BCS9YawmNAc7rchOwFCVe9BtHoGZvkms0CrcoRgu63s
tSNijUyPnVeHodlObtltZ2JRi8WgaBctMOmuEVGkhR57GF9vnv6rOcPVnVBUwOs9
zdXepyalMddJ3xSnM6mvpQWMFcley1uuBVgdv5JkMPEOFHEbfXSFYP1oIICpRwDM
ulcIniZpFNZ97ztElEoPvHnswoelUvKWpyln4uQ+Vx1G/S429CknqWKtl+Hfz468
sA6n1lrT+1VVAtHoeLrZDpeinMlwTxj9f7XZlZ+ANeRul5C6FIY=
=iiSO
-----END PGP SIGNATURE-----

--=-evhoVZFKP3ts0eEigqE1--


--===============1410681450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1410681450==--

