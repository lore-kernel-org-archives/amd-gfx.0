Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2072CD4F26
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jun 2026 02:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C01710E2E2;
	Sun, 21 Jun 2026 02:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="aSdXuYBC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKfKhRsj";
	dkim-atps=neutral
X-Greylist: delayed 395 seconds by postgrey-1.36 at gabe;
 Sun, 21 Jun 2026 02:56:08 UTC
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A619310E2E2
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 02:56:08 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id BAB31EC0211;
 Sat, 20 Jun 2026 22:49:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 20 Jun 2026 22:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1782010172; x=1782096572; bh=1ivmjOBmJ5
 eM+WC4bF6pRdTnhX9iLm15zV4hQYPkrp0=; b=aSdXuYBCTFmpdmR9hlAsd3Vu/E
 iLeXxA32gbyrkoVk50Mp4PcBdm+mhp30kuesgFUMaJWBw13JK2Onbh2LtZuAnBNN
 4ACF7ae8Vg2kkneo7I2emuoGKL5mcOgazSsiLivYA/f4JcfUC/fhRRMm0TwH5M+D
 O303t1z4l06Lh7mECDPnImAL3z/lUzI1t0M0k30U2PYjDqhvmtKSYiOe0G/wHKxJ
 Ovmy/MnhAjxQDXT5QvO01eQHdcVUGL34nuc7ICHcQ0a11ZxZlQjF9gjlXdqZQdyr
 EHMUMuy2VLkPb4Fwga9PhHOeJ/hae1VJVz1d3C/nXZVSacCd1DmcoaGkuHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782010172; x=1782096572; bh=1ivmjOBmJ5eM+WC4bF6pRdTnhX9iLm15zV4
 hQYPkrp0=; b=TKfKhRsjGnGfQ/LZirmNewZMxA8mI1usqg+2ABYVtipvY1ctde0
 USXyb83FBT6hxl48eJQbK1VSHE8OotV9bpvVrii0RLM6sROoa3XYOaQI4OggwYjW
 tTq8Cd2nSsKG7hGR90dINz3iqLxm70GvD0sTGWhEoGOgaIZ0waJEFbcKEHedABTW
 jr88Y91GumS5VurhzJApn9ChipRCoPRYt7NFM1MdEpHnpbD3iypKve4FkgWzx8JR
 T+zjSy+BhX98t1Qp46nlH0hPiNk3CivOe+idigoVz56VfzqEHoDaDkMa5Ko29MOt
 4+QjuoeND5Nz3T8CDe7ljUmQYbOQoaFabwg==
X-ME-Sender: <xms:PFE3agYvPgog5qYt_bx1UiK_ifcQXtMGwlPH9b6hSbNHApOMIGYUqA>
 <xme:PFE3an9QDUDIQSmWx8V20MR5ASLQ1cJpSVdPctl-m0cbnrHNsnygYnerAbAG2inBl
 nrCu85gxaW2lzWwHtdJxohHLEu4voCfzpnTrMgMtvyksYcQq93NyWQ>
X-ME-Received: <xmr:PFE3avaYtwbg43pz61zdNXORZqJMezXipfoGOhcORRjvlIIu47mbK4dmyHQ>
X-ME-Proxy-Cause: dmFkZTG0HY3Mj5QdLP7k3idEvfsdqctGw/DFvevkVsp6UJ/8NghMpBi2tq5HOfFeHbLTmw
 ze7uNQC7ksIVJHpzZ2Z1y8W8ePFrNEmjMcYAotWxeaw6qmYB+DPMNZ8xxLKSy3IafO7nB1
 eJDhil8fxAxFcaY+0uPfuASei0JTOkSwpwqBzEX36jhY72ZHcbQBDpeeONZi1KETyLOdi8
 tzc6xXcYZktK0AKpqlrdiXfOUKXfIJPOSwwMbcVdUrfs0GFTvO0CQSXZxsXb08dYvsu9bR
 74q/M2vmFGl2zduRQM4arawRdoXCq9Af3ILk9iLxRkMUGN5fI9iQnyD2Gwukj4UfUuoUZR
 Zu7G+EbOBE+5KAWbwlodbvjrx4tChyN8AfUhroZRa7uHwD0vCWSYN3Lfszv6tW+v9/J7zk
 X3g7c7NKq0kDZ7Pde215zgSHJjIqn0MiU/IFaQYylNz7V/rdj/E538mt2rbA1yLEgLvljU
 rkvw7DqiOARFR6MOgBtSQJ+tCEuuqSlM3dRa8oFutdkoGgUkTAgKbKNoSIk4Xp0yJUiKdI
 XTaNNLug6TirGreMCetEZExLCK2cjS+cemwEtKzki82Hj6DgA81mqwtQ9ZEmk2eBH00BA5
 K4YXQAU3aqXEXt2ZNHqVPBbHLNmNx8LZb9Qh+Xo5DcGbex3lmH136k1WPpyA
X-ME-Proxy: <xmx:PFE3ahcm1lY69M2xPUn4OX_nK9RFYbHgCanMpIRiHd_-xq3krWLfug>
 <xmx:PFE3asm5uMoQk7bLlb7I3aI9P5FX1MY5xDAcSSv7a9gG5hMam9iaCA>
 <xmx:PFE3ah0o4LOhcUQfrlk4plXnSuhhN_BEMW5gBKLNI3kJtiLoFz0_1w>
 <xmx:PFE3aleL966OurBwQptQ3jdpMAOwERfBp93GtXB4xTvC_yf6_tcsNQ>
 <xmx:PFE3ajjxtZW_Q1JOvyuM3nPqRr8eDL7-jw1SeFAbz5NJI5V_7JRsnlFv>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 22:49:31 -0400 (EDT)
From: Christopher Snowhill <chris@kode54.net>
To: Leo Li <sunpeng.li@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 mario.limonciello@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 timur.kristof@gmail.com, xaver.hugl@kde.org, mario.kleiner.de@gmail.com
Subject: Re: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling
 onto vupdate_no_lock
Message-ID: <178201017016.57979.9123750843778970394@copycat>
User-Agent: Dodo
Date: Sat, 20 Jun 2026 19:49:30 -0700
In-Reply-To: <cbeaa22b-530b-4fb7-bfe1-813d127d3595@amd.com>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-2-sunpeng.li@amd.com>
 <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
 <cbeaa22b-530b-4fb7-bfe1-813d127d3595@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============3362420732073399958=="
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

--===============3362420732073399958==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Wed 17 Jun 2026 10:32:51 AM , Leo Li wrote:
>=20
>=20
> On 2026-06-17 00:35, Matthew Schwartz wrote:
> > On 6/16/26 1:18 PM, sunpeng.li@amd.com wrote:
> >=20
> > [...]
> >=20
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> >> index c9916ed0ddc14..8a6b732cf80c8 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> >> @@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struct =
drm_crtc *crtc, bool enable)
> >>  			drm_crtc_vblank_restore(crtc);
> >>  	}
> >> =20
> >> -	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> >> +	/*
> >> +	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
> >> +	 * vblank and pageflip completion events, so enable it whenever vblank
> >> +	 * is enabled. On DCE, vupdate is only needed in VRR mode.
> >> +	 */
> >> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0) {
> >> +		rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
> >> +	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> >=20
> > Hi Leo (dropping Stable),
> >=20
> > This arms VUPDATE_NO_LOCK on all of DCN, but amdgpu_dm_handle_vrr_transit=
ion() still disables it when switching from VRR active -> inactive. This caus=
es a new flip_done timed out event when a compositor like gamescope disables =
VRR while it's already active.
>=20
> Good catch, I wonder why the kms_vrr IGT tests did not catch this...
> I'll roll your fix into v2 with your signed-off-by and co-authored-by.
>=20
> Thanks,
> Leo

The Stable backport is also needed for 7.1.1. I tested it specifically
there, and ran into the same exact VRR transition issue, unknowingly.
Except in this case, it was with LabWC, configured with VRR set to
fullscreen only, so it was disabling it immediately on configure. Oh
well. I'm building 7.1.1 with the backport and this workaround rolled
into it now, and will report back if there are any further issues.

-Christopher

>=20
> >=20
> > I had to fix it up with something like:
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e09c0eb9f865..ee337ca816cf 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10085,8 +10085,16 @@ static void amdgpu_dm_handle_vrr_transition(stru=
ct amdgpu_display_manager *dm,
> >  					    struct dm_crtc_state *old_state,
> >  					    struct dm_crtc_state *new_state)
> >  {
> > +	struct amdgpu_device *adev =3D dm->adev;
> >  	bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
> >  	bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
> > +	/*
> > +	 * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completion
> > +	 * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
> > +	 * vblank is enabled, so it must not be toggled with the VRR state.
> > +	 * Only DCE gates vupdate on VRR.
> > +	 */
> > +	bool vrr_gates_vupdate =3D amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D =
0;
> > =20
> >  	if (!old_vrr_active && new_vrr_active) {
> >  		/* Transition VRR inactive -> active:
> > @@ -10097,7 +10105,8 @@ static void amdgpu_dm_handle_vrr_transition(struc=
t amdgpu_display_manager *dm,
> >  		 * We also need vupdate irq for the actual core vblank handling
> >  		 * at end of vblank.
> >  		 */
> > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) !=
=3D 0);
> > +		if (vrr_gates_vupdate)
> > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) !=
=3D 0);
> >  		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
> >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR off->on: =
Get vblank ref\n",
> >  				 __func__, new_state->base.crtc->base.id);
> > @@ -10113,7 +10122,8 @@ static void amdgpu_dm_handle_vrr_transition(struc=
t amdgpu_display_manager *dm,
> >  		/* Transition VRR active -> inactive:
> >  		 * Allow vblank irq disable again for fixed refresh rate.
> >  		 */
> > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) !=
=3D 0);
> > +		if (vrr_gates_vupdate)
> > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) !=
=3D 0);
> >  		drm_crtc_vblank_put(new_state->base.crtc);
> >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR on->off: =
Drop vblank ref\n",
> >  				 __func__, new_state->base.crtc->base.id);
> >=20
> > Feel free to fold some version of this into the next version if it makes =
sense, or pick it up with my s-o-b.
> >=20
> > Thanks,
> > Matthew
> >=20
>=20

--===============3362420732073399958==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmo3UToACgkQjWyYR59K
3nGoqhAAp8tPbgfcKAAjIoH7C5vpJ2Gn+m+I5HtGqRaKXCctA5qN+sxrMy1nnPyg
Q49EAu+Y/Rj0BkIeSfP7TH9wyL98p+B1fSgQHqOPhYdpAfydSXIsTi9+LNj/p0y8
VmDEU38WcEzjrXA2xKfHXqTbxRsrk7xsrrAqIXC8DbvEzWdOYa9s4CF265RxzZLL
RrBWMydGvVL1jAxaQLiD+obos5Fn0ZNPcfAe23CGaWPtbVPursT5nGm/lVLoG8S1
ewaWxqtD2z/EnN/NpVK4LZj05GOhMrlxn8eqllgZwkYUHaJEsiWqreIoI2lT/NdS
Bjw08sGbk830xIKb0J+EPBPivbYIy0z3ws36SAS6CEl2OAcX+dJwDenFl/zKgsqr
UvMh+NvH6QBErSm7UmuJKPKMeMSyFlv8rUeOTo6tOPBEdxS6F21uSkK4SyoU6Gxq
j9CUhMX+omzq6G0rEJzcL76SkVljU7IKBFOxNq56N+Oyk+k1p7+pwEv6VkOf6L3/
nA9mPUuvVfWWyfggtrQqUh8pdz0P9yGYgxFmFsRAmVhW1y7DmS1yE0JHK3s3nvlH
CdgBL+SEbENTFVB0ngXVHxFzAc8wWBB3JYGjJeXZvqwuBZFXZX4soPNJYdalaZ0p
/D53reOlLTJuGs2oVV+YJChs7hDcBt1zpdeinkpQfBeK+mh/XYI=
=ax08
-----END PGP SIGNATURE-----

--===============3362420732073399958==--
