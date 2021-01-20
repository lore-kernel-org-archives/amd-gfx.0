Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA4C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 21:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8500D235DD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8500D235DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E926E450;
	Wed, 20 Jan 2021 21:34:34 +0000 (UTC)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688DD6E456;
 Wed, 20 Jan 2021 20:47:33 +0000 (UTC)
Received: from kevin (unknown [IPv6:2600:1011:b148:a411:ca09:c6a2:9f17:bbdd])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: alyssa)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A42EC1F44890;
 Wed, 20 Jan 2021 20:47:27 +0000 (GMT)
Date: Wed, 20 Jan 2021 15:47:22 -0500
From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 1/1] drm/scheduler: Job timeout handler returns status (v3)
Message-ID: <20210120204722.GA6883@kevin>
References: <20210120200959.163533-1-luben.tuikov@amd.com>
 <20210120200959.163533-2-luben.tuikov@amd.com>
MIME-Version: 1.0
In-Reply-To: <20210120200959.163533-2-luben.tuikov@amd.com>
X-Mailman-Approved-At: Wed, 20 Jan 2021 21:34:32 +0000
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 kernel test robot <lkp@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Rob Herring <robh@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Eric Anholt <eric@anholt.net>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 dri-devel@lists.freedesktop.org, Russell King <linux+etnaviv@armlinux.org.uk>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Qiang Yu <yuq825@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: multipart/mixed; boundary="===============1529589960=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============1529589960==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Panfrost hunks

	Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAmAIltUACgkQ/v5QWgr1
WA1Gyg//aTG0SHbVtkDsd68epa5WomHMoVAt/5Y6U/6pBtMSFN5m5hCpXOsVlZ/l
wkyWfx0kKH+vSasLZycGq7wYb7MH3pY1cvyiauzUin/s/iU1frzX1jlPuJ/mEOct
1sQe6qpKEujIUVYp2b/P9oAAi9VrjUAM2WYc66fWzTwtnMi6YK15ajqXjmbaRnvu
DdYGdRk3i9cO+OpL5fEteKThWy+rRRfGNZ3fHX4MRrJr0G9viSQExI4JgPEE2Woz
67tJN3/VO4rTfnaawxb8hP3YAjaN3wDacu0bO6fjmTf+Le+gYZqwH5J8QwDovsCl
5U2XODp3zlLvZGLsCdtwCRCByk/vQ4oZo1ysQOupcPsztZWoIhvx58f51dLdz9++
EMA6B7o+g27AxBJQ2DAGy2vLerR31+P/aZTgp/oFcxM0MpekyBr/GjEBZJKz4nLK
Afj9AnP+FsvU41jnqQdcyBHzg7LOAnYlY1RnndMjwJHKC5kXRdklmOr33SPjmFf7
0iVh3bytKpDvg+j3Pmmkdbc/6Onr0tQ0DNOrluYXlCrdofABtNhhvW95x9yrI3Cp
A9P7UHOZYbNgVCIVwlr/uGaR/GMCCRnhN7kp+0YOzWCmsvWNjQ6R0c2h9R10GoQW
0yhNRpkckm+edX5OhlJSknmbUKP1b/eJwonJEqHpUDxFEpIBWa8=
=GzA6
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--===============1529589960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1529589960==--
