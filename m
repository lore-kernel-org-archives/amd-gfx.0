Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91DC27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 07:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF86210EA48;
	Wed, 19 Jun 2024 07:13:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9CC10E5C8;
 Tue, 18 Jun 2024 09:18:45 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 23ADE1C00A1; Tue, 18 Jun 2024 11:11:12 +0200 (CEST)
Date: Tue, 18 Jun 2024 11:11:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jesse Zhang <jesse.zhang@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
 shashank.sharma@amd.com, guchun.chen@amd.com, Philip.Yang@amd.com,
 mukul.joshi@amd.com, xiaogang.chen@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 13/14] drm/amdgpu: fix dereference null
 return value for the function amdgpu_vm_pt_parent
Message-ID: <ZnFPL2BeQOEGPO6Q@duo.ucw.cz>
References: <20240605120455.2967445-1-sashal@kernel.org>
 <20240605120455.2967445-13-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qwPPwx+eAXd6Ui24"
Content-Disposition: inline
In-Reply-To: <20240605120455.2967445-13-sashal@kernel.org>
X-Mailman-Approved-At: Wed, 19 Jun 2024 07:13:04 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--qwPPwx+eAXd6Ui24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit a0cf36546cc24ae1c95d72253c7795d4d2fc77aa ]
>=20
> The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
> To make the code more robust, check the pointer parent.

If this can happen, it should not WARN().

If this can not happen, we don't need the patch in stable.

Best regards,
							Pavel
						=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qwPPwx+eAXd6Ui24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnFPLwAKCRAw5/Bqldv6
8sZ2AKDD6aIoYQ3yGufGiJLfSd+7EFemwwCgvQub4Gk5IihPZeUyKiGRl6v9BjM=
=Jpw4
-----END PGP SIGNATURE-----

--qwPPwx+eAXd6Ui24--
