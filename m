Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 13:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE2B24685
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 13:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE2B24685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bastelmap.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9696E060;
	Tue, 28 Jan 2020 13:15:24 +0000 (UTC)
Received: from dd10814.kasserver.com (dd10814.kasserver.com [85.13.133.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDF16E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 13:15:22 +0000 (UTC)
Received: from zeus.ad.home.arpa (p5B0559DD.dip0.t-ipconnect.de [91.5.89.221])
 by dd10814.kasserver.com (Postfix) with ESMTPSA id 3B5841200E04;
 Tue, 28 Jan 2020 14:15:20 +0100 (CET)
Date: Tue, 28 Jan 2020 14:15:19 +0100
From: Andreas Messer <andi@bastelmap.de>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: avoid page fault during gpu reset
Message-ID: <20200128131518.GB12260@zeus.ad.home.arpa>
References: <e034c038-f7a5-4bb0-8ec8-2f1a4d089436@email.android.com>
MIME-Version: 1.0
In-Reply-To: <e034c038-f7a5-4bb0-8ec8-2f1a4d089436@email.android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1535511175=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============1535511175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2020 at 07:01:36PM +0000, Koenig, Christian wrote:
>=20
>=20
> Am 25.01.2020 19:47 schrieb Andreas Messer <andi@bastelmap.de>:
> When backing up a ring, validate pointer to avoid page fault.
> [ cut description / kernel messages ]=20
>=20
> NAK, that was suggested multiple times now and is essentially the wrong
> approach.
>
> The problem is that the value is invalid because the hardware is not
> functional any more. Returning here without backing up the ring just
> papers over the real problem.
>=20
> This is just the first occurance of this and you would need to fix a
> couple of hundred register accesses (both inside and outside of the
> driver) to make that really work reliable.

Sure, it wont fix the hardware. But since the page fault is most prominent
part in kernel log, people will continue suggesting it. With that change,
the kernel messages are full of ring and atom bios timeouts and might make
users more likely to consider a hardware issue in the first place. Anyway:

> The only advice I can give you is to replace the hardware. From
> experience those symptoms mean that your GPU will die rather soon.

I think my hardware is fine. I have monitored gpu temp and fan pwm now for
a while and found the pwm to be driven at ~60% only although the gpu
already got quite high temperature during gameplay. When forcing the pwm
to ~80% no crash occurs anymore. I suppose it is not the GPU crashing but
instead the VRMs, not getting enough airflow.

I have compared the Bios fan tables of my card with them of other cards
bios (downloaded from web) of same GPU type and similar design.
Although they differ in cooler construction and used fan, all of them
despite one model have exactly the same fan regulation points with PWMHigh
at 80% for 90=B0C. This single model with other settings has 100% for this
temp and generally much more sane looking regulation curve.

I suppose most of the vendors just copied some reference design,
maybe the vendor's windows driver adjust the curve to a better one,
I don't know.

I think I'll add some sysfs attributes or module parameter to adjust=20
the curve to my needs.

> [ Patch cut out ]

cheers,
Andreas



--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABEIAB0WIQQo7oQ45ojZkjZhx1OQs7qqjCuvUQUCXjAz5gAKCRCQs7qqjCuv
UUsGAKCuYZzRVRbPana9UoOePkx5Bw98dwCgkiLHcZo1dFuGcHaha8Lqr9Jpwt8=
=q0GI
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--===============1535511175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1535511175==--
