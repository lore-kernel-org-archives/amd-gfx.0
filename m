Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA034CD4F26
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jun 2026 03:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDE110E2E3;
	Sun, 21 Jun 2026 03:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="mg+BEo8h";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhZJoXKq";
	dkim-atps=neutral
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372FC10E2E3
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 03:18:45 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 645A3EC01BF;
 Sat, 20 Jun 2026 23:18:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sat, 20 Jun 2026 23:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1782011924; x=1782098324; bh=IUPllBveJ0
 JfKj9JEviMLX7O3Q2WYbg5yLpR3KDbofk=; b=mg+BEo8hD4ESNxolR4KMWbh5rP
 Mwj0jX07YeGxroZGQM+WXwR3n1BU9YvfBJy8QbV9BzS1vUbKcuuKNCVnZO2EV9Ks
 gM3iJSGBpmRKs+nITXQxs7SiT1nOvSho6/DDpnokPIqsIxP2DoToW0o0EKiPqhAb
 rVUTYGyf/f6JcJbJi0mTscbfJkCDqeX291v27BTfX9tHkbSRgUlsUtNg09ObrwX2
 yFF/O+G9fIBBwbw9fDrIm7vmbC0xJU92EB9pLMlhd9ONEfxEfQ5xBT8RgPhSQWq9
 VZtyGs+cyDMjTzApBVKeRh0AvtMP22+lwXDNK7BshU9Wf8AiylkD5IBxs8Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782011924; x=1782098324; bh=IUPllBveJ0JfKj9JEviMLX7O3Q2WYbg5yLp
 R3KDbofk=; b=HhZJoXKqjvLQtTcIU/4roO9D3MUvcoyKUIBj/msUx9veZspg3yS
 4xEsogU/nc+3Sa/B6PRIYoyZM2PL9XjxyjInHZu06O5gSN1TcZbXODBf2HLWiA/h
 PmAgKes7Q2HgqR17syeodI4krIB5yDpsNbvs0LvVRDPyUP43Lx9UcfcdH7BRCvBh
 x5Ti7XG1ZAMXotzUNU+yCwS2nT/nXWLBsQDZ2TE/Hg2m0wD04qczVR49hllzQXe8
 AugBKqEB6nP5r0ReNehVWMxgBR+GcWvaZdAYxdr6CCtnHeVC9t+y6k5j7HZ7Lhqx
 SZ185ieh2ho3xp4bVQJgelePzOA7px64CkQ==
X-ME-Sender: <xms:E1g3alEa8_MSKzvLZvC5_7Muz01OUlI0LcKq_7QAJaRr_w9lh05wsw>
 <xme:E1g3am7hnkAzygRWS9UMklnmQdQiOaAjOM-_9InS33eZjO0Healau16kXBqr6GILq
 MZZkAYMRbDKifFjWEhFzbHyjFV6UtrlS9FoOvH08timQMhij63Okt-F>
X-ME-Received: <xmr:E1g3arkIPeuTpk1tir2amzgFj_maEpAU95OLBzFoPyHsuovXGHN1vFDfVcY>
X-ME-Proxy-Cause: dmFkZTFuW9EbJ/PEWEbdHiBeF//0Er6WGoV5jRluJDbshLG7tXiTbuNBJwLh+KuwVBS04g
 b6JOWKLpU2Drfg4DiXjoWpI3Xg1UJ5cP/Gj7jEGiLYQUZ7cOVuOnRj8ZKZTeWGowEy1Ivn
 VINZOApvWfAwGw/cVJfE/PaYbT6MuF6ImQxrwanwiWAT0zkwYhTZj8BRdDLpDDS9FLWer8
 w476kSbn//0EQmlPhYK4QaLW4TVder2KOjenTbDZgEv8/OYGPJKoK4xgDmEP/P3mlGXJnp
 aX7vBeTE9facu7F37ATQGv1OJCqbQmZfmuioj2i9AI0gFoDsjoxGvOJe5VKwkG3jLoGaFP
 KBPx6w5PyQK8wmsvfEKuwD6b46VMm3HpYdY0xH0Z2nowqIdx1Md6T7aXZhPxq8J9fE8fRt
 u5/bmvtDujKqIdi8O3qAM8YN6YjP0eKcOZnT0qx5ZTwTOBOBYz+jP/HISZlYcXwAAoLvg2
 MWLiYKuo1JN6oTVqmmu0Iz7Slm2nPJ+csX0+IAlZXI0/uFPydibp369arv13usDoyoxHwq
 n/V7cOIrhkm/qQNbUUD6lYDcIssR/aNAhSunVn4cLpJ89bHO6Li70x2WWZfDGjoq2RbGRb
 8djbdZdlBkcabjlpCMCj8mACb6KwvrCLt0BIhcqIXSlLb0a7xRSNZcnhGaFw
X-ME-Proxy: <xmx:E1g3ah7u06dqCTy13AIQY7y16uD-iPi61zZvvD_i0tHr8nDJktuBvA>
 <xmx:E1g3asQu8cCa9aZk_-b_sQtD6E8o1Wa6hGffBJMraM7-aNTGDxkktQ>
 <xmx:E1g3avx4Z8Q56ZfQ_XIi5Q-75nXTLu3TXGrEoAhtOwasaVupHtCMFg>
 <xmx:E1g3akpU0ToJxGLLHxLG8XhhTGFKVlMgYYlgO2Gq4GTQ9m7yPvqaLg>
 <xmx:FFg3amudHsqvQHeXlvxo1irQi_iUVncny9Nlrn7IQNOPGhIkKH2OXVbb>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 23:18:43 -0400 (EDT)
From: Christopher Snowhill <chris@kode54.net>
To: Leo Li <sunpeng.li@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 mario.limonciello@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 timur.kristof@gmail.com, xaver.hugl@kde.org, mario.kleiner.de@gmail.com
Subject: Re: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling
 onto vupdate_no_lock
Message-ID: <178201192189.342393.2311541158926687068@copycat>
User-Agent: Dodo
Date: Sat, 20 Jun 2026 20:18:41 -0700
In-Reply-To: <178201017016.57979.9123750843778970394@copycat>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-2-sunpeng.li@amd.com>
 <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
 <cbeaa22b-530b-4fb7-bfe1-813d127d3595@amd.com>
 <178201017016.57979.9123750843778970394@copycat>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============4880694945784095273=="
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

--===============4880694945784095273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Sat 20 Jun 2026 07:49:30 PM , Christopher Snowhill wrote:
>=20
>=20
> On Wed 17 Jun 2026 10:32:51 AM , Leo Li wrote:
> >=20
> >=20
> > On 2026-06-17 00:35, Matthew Schwartz wrote:
> > > On 6/16/26 1:18 PM, sunpeng.li@amd.com wrote:
> > >=20
> > > [...]
> > >=20
> > >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > >> index c9916ed0ddc14..8a6b732cf80c8 100644
> > >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > >> @@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struc=
t drm_crtc *crtc, bool enable)
> > >>  			drm_crtc_vblank_restore(crtc);
> > >>  	}
> > >> =20
> > >> -	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > >> +	/*
> > >> +	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliv=
er
> > >> +	 * vblank and pageflip completion events, so enable it whenever vbla=
nk
> > >> +	 * is enabled. On DCE, vupdate is only needed in VRR mode.
> > >> +	 */
> > >> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0) {
> > >> +		rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
> > >> +	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > >=20
> > > Hi Leo (dropping Stable),
> > >=20
> > > This arms VUPDATE_NO_LOCK on all of DCN, but amdgpu_dm_handle_vrr_trans=
ition() still disables it when switching from VRR active -> inactive. This ca=
uses a new flip_done timed out event when a compositor like gamescope disable=
s VRR while it's already active.
> >=20
> > Good catch, I wonder why the kms_vrr IGT tests did not catch this...
> > I'll roll your fix into v2 with your signed-off-by and co-authored-by.
> >=20
> > Thanks,
> > Leo
>=20
> The Stable backport is also needed for 7.1.1. I tested it specifically
> there, and ran into the same exact VRR transition issue, unknowingly.
> Except in this case, it was with LabWC, configured with VRR set to
> fullscreen only, so it was disabling it immediately on configure. Oh
> well. I'm building 7.1.1 with the backport and this workaround rolled
> into it now, and will report back if there are any further issues.
>=20
> -Christopher

Dang, looks like I don't get a free pass with this patch, since the
function in question doesn't plumb that state directly in 7.1.1.

>=20
> >=20
> > >=20
> > > I had to fix it up with something like:
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index e09c0eb9f865..ee337ca816cf 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -10085,8 +10085,16 @@ static void amdgpu_dm_handle_vrr_transition(st=
ruct amdgpu_display_manager *dm,
> > >  					    struct dm_crtc_state *old_state,
> > >  					    struct dm_crtc_state *new_state)
> > >  {
> > > +	struct amdgpu_device *adev =3D dm->adev;
> > >  	bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
> > >  	bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
> > > +	/*
> > > +	 * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completion
> > > +	 * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
> > > +	 * vblank is enabled, so it must not be toggled with the VRR state.
> > > +	 * Only DCE gates vupdate on VRR.
> > > +	 */
> > > +	bool vrr_gates_vupdate =3D amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=
=3D 0;
> > > =20
> > >  	if (!old_vrr_active && new_vrr_active) {
> > >  		/* Transition VRR inactive -> active:
> > > @@ -10097,7 +10105,8 @@ static void amdgpu_dm_handle_vrr_transition(str=
uct amdgpu_display_manager *dm,
> > >  		 * We also need vupdate irq for the actual core vblank handling
> > >  		 * at end of vblank.
> > >  		 */
> > > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) !=
=3D 0);
> > > +		if (vrr_gates_vupdate)
> > > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) =
!=3D 0);
> > >  		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
> > >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR off->on=
: Get vblank ref\n",
> > >  				 __func__, new_state->base.crtc->base.id);
> > > @@ -10113,7 +10122,8 @@ static void amdgpu_dm_handle_vrr_transition(str=
uct amdgpu_display_manager *dm,
> > >  		/* Transition VRR active -> inactive:
> > >  		 * Allow vblank irq disable again for fixed refresh rate.
> > >  		 */
> > > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) =
!=3D 0);
> > > +		if (vrr_gates_vupdate)
> > > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false)=
 !=3D 0);
> > >  		drm_crtc_vblank_put(new_state->base.crtc);
> > >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR on->off=
: Drop vblank ref\n",
> > >  				 __func__, new_state->base.crtc->base.id);
> > >=20
> > > Feel free to fold some version of this into the next version if it make=
s sense, or pick it up with my s-o-b.
> > >=20
> > > Thanks,
> > > Matthew
> > >=20
> >=20

--===============4880694945784095273==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmo3WBEACgkQjWyYR59K
3nErXhAAhPzw+MGd9gRISs7R5i32EcVXVeyW1035AfH6UNOGCF9GUIB3COrDnGn7
YBGh10vXU43+LLuoT2C+kQmE7J2P6ktQR97fEIY0lP4R8LQtB4TlyMPD6fPi7+lG
wZBFeBNV6Rzqzzf6oA2e0JiXrj7c8FChE85fyvc7uHVJxXSaRXLPcGOpdtAReJg6
wQbbOqdIE9BXnARlUVFRKMUfiSSX8W317KfjysrgPs39HYtAiyVREmNBTd606xQZ
CJl+dv3qugjLK01Icvcc+MkG5dR75dWjvOQPoCJZkZXGKIOwAMAGIAT1yLOkG6Px
wC4JcQsISfutAJ0v6dnrLpXVhoGMhoQgyamxD2sxYflkXSQmTIlV/XMppiksPeW8
ZnBIZg8X5Gbmv3Oo0nXVx7CYAtii2RWvypiuvKCY8D6WItHiEEyBNbYojn8ze8jI
mHuP+fwSD0/x6EoQC+ER4qG3KG/1nZ4Kjn1YQPZkbDt23idaTThLWkZrvvkJuBfA
KrM0OE6RCvXzQSZc8vNbvzyhT4+zqeO1Cx7/l8R+x6tLFeouUzTGH5/q1hNpFNkn
E42wRoCz3mBNAZW6RrvgLu8qBDMi1xpwazqPuiC1tmWDnsFnRLzsxYHphI1fFRHn
QjWkG/VOd30I8zRfqkwCygWkZ6ut75dzqjMbv/IzInoRYkmn7qw=
=K3a0
-----END PGP SIGNATURE-----

--===============4880694945784095273==--
