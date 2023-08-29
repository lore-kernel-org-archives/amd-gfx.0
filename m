Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89420C83F14
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 11:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C83D10E21B;
	Tue, 29 Aug 2023 11:23:11 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995D810E21B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SARmsvrjrvXQXfi20kD1+4flj57CoBX123XOR9FQtec=; b=P1IIcJxE05tdC/gSIgVNquGS2h
 FwVt2FFaybAt/6c8XFtdVI8cy9GnGvK3OsJqXkuRR7f+ykkEc3o8qvBSAh2pwGf4EBBN9QXW2sBqf
 k0WRsZSNAJdwPgL/Bpax241YXzjw/KLPQdCaaEIYi5hkNyIFM+/GH/zuwRsSLgoFfl4xAPUaW1PFg
 gyseK+wxruL3KLwvJivsP+MjpPsyMAxk8Z2djpqlfs14LN0aAl+mrvvq4Zil27RHnBFIsCtC61lfQ
 cqUDamoNy+JhkjxujSd2PhW0/eajA/bn375a0RVG+8mBLS0GPHqtYlLhDELySJcVTGHeWqJim2kAf
 lnojGO8w==;
Received: from [38.44.68.151] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qawoM-00GoeA-Vj; Tue, 29 Aug 2023 13:23:07 +0200
Date: Tue, 29 Aug 2023 10:22:57 -0100
From: Melissa Wen <mwen@igalia.com>
To: Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH 6/7] Revert "drm/amd/display: Implement zpos property"
Message-ID: <20230829112257.g3aqvtztfncviy6y@mail.igalia.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
 <20230726193155.2525270-7-aurabindo.pillai@amd.com>
 <20230818082558.y6no2dvvmzszelc7@mail.igalia.com>
 <d173a412-d43e-4a5d-a0f8-e2a0c3eb719b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2vdvwhijjlijnrnn"
Content-Disposition: inline
In-Reply-To: <d173a412-d43e-4a5d-a0f8-e2a0c3eb719b@amd.com>
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
Cc: stylon.wang@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Choi <Nicholas.Choi@amd.com>, agustin.gutierrez@amd.com,
 kernel-dev@igalia.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Joshua Ashton <joshua@froggi.es>, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--2vdvwhijjlijnrnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/18, Leo Li wrote:
>=20
>=20
> On 2023-08-18 04:25, Melissa Wen wrote:
> > On 07/26, Aurabindo Pillai wrote:
> > > This reverts commit 6c8ff1683d30024c8cff137d30b740a405cc084e.
> > >=20
> > > This patch causes IGT test case 'kms_atomic@plane-immutable-zpos' to
> > > fail on AMDGPU hardware.
> > >=20
> > > Cc: Joshua Ashton <joshua@froggi.es>
> > > Signed-off-by: Nicholas Choi <Nicholas.Choi@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 -------=
--
> > >   1 file changed, 9 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > index 2198df96ed6f..8eeca160d434 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > @@ -1468,15 +1468,6 @@ int amdgpu_dm_plane_init(struct amdgpu_display=
_manager *dm,
> > >   		drm_plane_create_blend_mode_property(plane, blend_caps);
> > >   	}
> > > -	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> > > -		drm_plane_create_zpos_immutable_property(plane, 0);
> > > -	} else if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> > > -		unsigned int zpos =3D 1 + drm_plane_index(plane);
> > > -		drm_plane_create_zpos_property(plane, zpos, 1, 254);
> > > -	} else if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> > > -		drm_plane_create_zpos_immutable_property(plane, 255);
> > > -	}
> >=20
> > Hi Jay and Nicholas,
> >=20
> > I'm examining this regression and, looking at the test code, I consider
> > this failure is caused by an incorrect assumption in the IGT test in
> > which any zpos values must be in the normalized range of 0 and N planes
> > per CRTC.
> >=20
> > 	for (int k =3D 0; k < n_planes; k++) {
> > 		int zpos;
> > 		igt_plane_t *temp;
> >=20
> > 		temp =3D &display->pipes[pipe->pipe].planes[k];
> >=20
> > 		if (!igt_plane_has_prop(temp, IGT_PLANE_ZPOS))
> > 			continue;
> >=20
> > 		zpos =3D igt_plane_get_prop(temp, IGT_PLANE_ZPOS);
> >=20
> > 		igt_assert_lt(zpos, n_planes);  // test case fails here
> >=20
> > 		plane_ptr[zpos] =3D temp;
> > 	}
> >=20
> >=20
> > I didn't find anything in the DRM documentation that imposes this
> > behavior. Also, the plane composition in the test is working correctly
> > with this patch and without this likely-misleading assert. In addition,
> > enabling zpos property increases the coverage of
> > `kms_atomic@plane-immutable-zpos` test (previously this part of the test
> > was just bypassed), so it's not a regression per se. Therefore, I'm
> > inclined to send a fix to IGT, instead of implementing a behavior that
> > fit the test but may not fit well AMD display machinery.
> >=20
> > But first I wonder if you guys find any other test or visual check that
> > fail with this feature?
> >=20
> > I checked other IGT KMS plane tests and AMD MPO tests (in `amd_plane`)
> > and results are preserved. If there are no other issues besides IGT
> > plane-immutable-zpos, I'll proceed with sending the change to IGT.
> >=20
> > Thanks,
> >=20
> > Melissa
>=20
> Hi Melissa,
>=20
> Thanks for taking a look at the IGT test. Looks like the IGT failures
> are the only concerns, and I agree that it doesn't make sense to require
> zpos to be normalized between 0 and number of planes.

Hi Leo,

Thanks for the feedback.

I've also checked that msm driver creates zpos properties in a similar
way of this commit here, so I sent and applied the IGT test change:
https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/cb77add45011b129e=
21f3cb2a4089a73dde56179

With that, could you guys revert this commit reversion?

Thanks,

Melissa

>=20
> Thanks,
> Leo
>=20
> >=20
> > > -
> > >   	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY &&
> > >   	    plane_cap &&
> > >   	    (plane_cap->pixel_format_support.nv12 ||
> > > --=20
> > > 2.41.0
> > >=20

--2vdvwhijjlijnrnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmTt1QkACgkQwqF3j0dL
ehwRThAArzZH50tvl3RCCN3LPeVNBY8gAYnVDldKPL5suvcJ7pA/SB34opR8p7Ls
8ay5gMmtL1YqoKpwJRoqcdm57JPc5xAzfDZCKLmhk9sqZbgOoz1nli38UlTnkpzX
va/uqWZGSDUaw3tm+YnI6KlveExGFNL/V1vG95mMOwr2w14hOTwlGmvKSDXzcDrk
rcFx+pNFcti9kfqTrL12sE4z/7B7OfioWvP6orFnMENNoZpo8S1QxycsOszWQypi
uheavrb05qL5mphUSBemffUZnyG7fIH1MnlRLQAgx+P2EQxWyoh0G5yhCgWlWz9P
McCny8kUdFC7PmMTozRtoSGHZaH8BnzkRgiLQJDwFHNnN4LzQyveQseli/AYFIr2
TacJnTsJ7VSYq9+zuucn5yTAke7t2AV1iANrK6qCooq/TzpyBleYXrgCBSesjLVc
HSgNnu8a/a/0g7VCY0Qgf6+NTRmLA5DWGe7NN+URFuxtx67t/QM+A2ysm0ws7n6h
b+UreKmJLb1fPmARUQdwWTPQOJryfIKdfRoK0J692jzS9335FF0L6r3LlEDyryrI
b7E/ISDPB4Lpp+3smVgQAYKIz5hyIHihHVccfYcS93a6hKysUUSND7d2Mh9GKA/Y
JqP0MrUjB6STrT8w21ApJ8/j5UFZ5nDTE/0Xs2mB8XjKMQdYBKo=
=nZGF
-----END PGP SIGNATURE-----

--2vdvwhijjlijnrnn--
