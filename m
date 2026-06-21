Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B85CD98F0
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jun 2026 04:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA6B10E2FC;
	Sun, 21 Jun 2026 04:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="i4sQ3m9M";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbNNinOr";
	dkim-atps=neutral
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5759310E2FC
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 04:45:49 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 990BE140008F;
 Sun, 21 Jun 2026 00:45:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 21 Jun 2026 00:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1782017148; x=1782103548; bh=VFL8rhOy/T
 ygG710KVmqIvfTJ0NcfSfLHkpUR/8EIdg=; b=i4sQ3m9MMy1eoCfcx+9tN1yduZ
 puARCDzePk+633ENy1GcYa8vUo29wZ+jyPEthsQf7cTb5XYp0XrmNvKnhcQjMMNR
 /ugl5EeJM6Nni78Xy/BfwAruUP0fx32oOPpbRbNtFlcueUkx3e1f585SWpEUjMge
 LHpln/jIJJl+5A0gf5VZ46Quh8yNf09ki0YLVmZT9b27C0UJvVirCmunvutKkqnC
 O2Jym58g66XFbXy/M6WiSGhG3Gx6x9I6FYgpzqyhuJfgLdZGXPOW5jQon1JeNekB
 bptKOTIbo5Ts+8mjfIdeHQFFkB94B4BzmT/z+ZlivJA223AAN65nk4rY/Q1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782017148; x=1782103548; bh=VFL8rhOy/TygG710KVmqIvfTJ0NcfSfLHkp
 UR/8EIdg=; b=YbNNinOrtCAV0jDRZ26aFqzkPPodqMr7cpwdTCCJFeV2Cq47m/O
 Jf7VhXOvPN5vkuSIHcwGJOhTzFX+/GprwVQ4DSPi3SZj/kKb/WFrr5wn/NR2MPtn
 Z8lcx1QQmLiKl15ddpLtC4Qv4VmncOHghseyz5XGz4/I8tNO45isz2pbFMceeAdU
 XHeSEvlQOyD985SuBcstrvXNriNmusiDZlG07wSbKrrduerkrNY5sYKiP75oeRnw
 Pv8J8/aH89jQwv0DdRs3yTIj/dZdl2XRmu+mYm1XoFg4Ijgtea+beazXia/hjZCV
 5xgRHX5HV8wvfyzlNanLpj28omRwde8ajRw==
X-ME-Sender: <xms:e2w3akrp4V_d3OHNmEqfNcluEd2dxb1uAXoHFYUO4lOBAJquNwRA9Q>
 <xme:e2w3anO3zH7xY9MYkmyzXRBTpJVHZr1hOlH9n0-JBUy_T5F95a1BSQntC4FnAgIO1
 IDB48jTOTHIRHzU3h1xguDK9kDp2f0wIKDUj5MokkvvYghcb1FQZSwT>
X-ME-Received: <xmr:e2w3atqmpTVnBPVkIM75C7dMjitB_-jPKbZTPWF87OLZXjVmtmlSa0iFakE>
X-ME-Proxy-Cause: dmFkZTEupPvtXITDtuGeFeHmNzzZGDonF/i6nB6KyS7wh3CbobJ+yupfsEW0YexyAT38RC
 E97q/cBODiS3I8Sd2nzT3+qnPJgtlGTI/un+hzE4G556On9JiVUDdniVb71ajdczQuUQKy
 HJTOzOEGZMmyHX/9kCqxAX4aQ1rnP6qsKUW8a6NptutR2bKnVAEwL/0wOUMF2p/SAY6NC1
 hVLCv8v2+EJgi+lZvl+38RIvEBRDR9Oa7RZsUE75gb3o6dwMCsa9zNkbudd5aPgGjbuyCt
 m11demwlCtOpizHYhxmb4HU7K3fkYbwtlrIammOZji6AYbzWt0b+R5ClNGspBhg1AGunhw
 iQXSnPGFxkioKoYNvSaksTA2YvgRlAtVnDIqD7SyyFKw+Ef7miv4ooKV1zFE3FaxRj6F8L
 X/1VJ84Sv65ZgIPFQxpGlHwyO4+QvrMoAxKClY9Xh/YKl5WnVxKBcCwbWuJhNt9RBrmKsM
 aLR9lxlqV7lfPIgOSxkMdmcBPS/FYd4Cc+RYbXifXv+RwCFJBNpEyr1Y0O3N+iwVCEqCHI
 JNlKfXYLceFQcZVE7IMNDkz5/4KKB0Sh1TBL7xy1/SiU41HuTl12Wq3j5oTxBowrSsd9x+
 3KR2uUldRwWbETySSCp2elnsQlmRq8SsZFqSrbRwkJXxho09OLpHMNWTBZug
X-ME-Proxy: <xmx:e2w3aivo3Lg_Ml9c_IalfvISjZ2YQwoat7XfZHbLwVujoN9l8J5Ycw>
 <xmx:e2w3ak1UZ9wU36oWWH1r2gIwv665J8V1Wjy2mCJrHe2hzf8wrlIqMQ>
 <xmx:e2w3alGKugN58eXBmdXNOOFZ1n6Y2nM_7vpZgpYHFY0pG9j1RBfatQ>
 <xmx:e2w3ansTHoNfnglRarXda1tp2A6sE9S_PfQVlpFOEt8ixz_aC9Z8bA>
 <xmx:fGw3alzwj-itWAttqb3wgJskbAKv5MySY-hD3C8qNpgc6qM4CM0EWqJ2>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 00:45:47 -0400 (EDT)
From: Christopher Snowhill <chris@kode54.net>
To: Leo Li <sunpeng.li@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 mario.limonciello@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 timur.kristof@gmail.com, xaver.hugl@kde.org, mario.kleiner.de@gmail.com
Subject: Re: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling
 onto vupdate_no_lock
Message-ID: <178201714645.462317.668789820541080671@copycat>
User-Agent: Dodo
Date: Sat, 20 Jun 2026 21:45:46 -0700
In-Reply-To: <178201192189.342393.2311541158926687068@copycat>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-2-sunpeng.li@amd.com>
 <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
 <cbeaa22b-530b-4fb7-bfe1-813d127d3595@amd.com>
 <178201017016.57979.9123750843778970394@copycat>
 <178201192189.342393.2311541158926687068@copycat>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============2250668937904870351=="
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

--===============2250668937904870351==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Sat 20 Jun 2026 08:18:41 PM , Christopher Snowhill wrote:
>=20
>=20
> On Sat 20 Jun 2026 07:49:30 PM , Christopher Snowhill wrote:
> >=20
> >=20
> > On Wed 17 Jun 2026 10:32:51 AM , Leo Li wrote:
> > >=20
> > >=20
> > > On 2026-06-17 00:35, Matthew Schwartz wrote:
> > > > On 6/16/26 1:18 PM, sunpeng.li@amd.com wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > >> index c9916ed0ddc14..8a6b732cf80c8 100644
> > > >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > >> @@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(str=
uct drm_crtc *crtc, bool enable)
> > > >>  			drm_crtc_vblank_restore(crtc);
> > > >>  	}
> > > >> =20
> > > >> -	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > > >> +	/*
> > > >> +	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to del=
iver
> > > >> +	 * vblank and pageflip completion events, so enable it whenever vb=
lank
> > > >> +	 * is enabled. On DCE, vupdate is only needed in VRR mode.
> > > >> +	 */
> > > >> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0) {
> > > >> +		rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
> > > >> +	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > > >=20
> > > > Hi Leo (dropping Stable),
> > > >=20
> > > > This arms VUPDATE_NO_LOCK on all of DCN, but amdgpu_dm_handle_vrr_tra=
nsition() still disables it when switching from VRR active -> inactive. This =
causes a new flip_done timed out event when a compositor like gamescope disab=
les VRR while it's already active.
> > >=20
> > > Good catch, I wonder why the kms_vrr IGT tests did not catch this...
> > > I'll roll your fix into v2 with your signed-off-by and co-authored-by.
> > >=20
> > > Thanks,
> > > Leo
> >=20
> > The Stable backport is also needed for 7.1.1. I tested it specifically
> > there, and ran into the same exact VRR transition issue, unknowingly.
> > Except in this case, it was with LabWC, configured with VRR set to
> > fullscreen only, so it was disabling it immediately on configure. Oh
> > well. I'm building 7.1.1 with the backport and this workaround rolled
> > into it now, and will report back if there are any further issues.
> >=20
> > -Christopher
>=20
> Dang, looks like I don't get a free pass with this patch, since the
> function in question doesn't plumb that state directly in 7.1.1.

Looks like I can do some backporting too. Here's a free backport of the
same patch series to 7.1.1:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c198a0b..da7ed11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9851,8 +9851,16 @@ static void update_stream_irq_parameters(
 static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
                                            struct dm_crtc_state *new_state)
 {
+       struct amdgpu_device *adev =3D drm_to_adev(new_state->base.crtc->dev);
        bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
        bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
+       /*
+        * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completion
+        * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
+        * vblank is enabled, so it must not be toggled with the VRR state.
+        * Only DCE gates vupdate on VRR.
+        */
+       bool vrr_gates_vupdate =3D amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=
=3D 0;

        if (!old_vrr_active && new_vrr_active) {
                /* Transition VRR inactive -> active:
@@ -9863,7 +9871,8 @@ static void amdgpu_dm_handle_vrr_transition(struct
dm_crtc_state *old_state,
                 * We also need vupdate irq for the actual core vblank
handling
                 * at end of vblank.
                 */
-               WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc,
true) !=3D 0);
+               if (vrr_gates_vupdate)
+
WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) !=3D 0);
                WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
                drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR
off->on: Get vblank ref\n",
                                 __func__, new_state->base.crtc->base.id);
@@ -9871,7 +9880,8 @@ static void amdgpu_dm_handle_vrr_transition(struct
dm_crtc_state *old_state,
                /* Transition VRR active -> inactive:
                 * Allow vblank irq disable again for fixed refresh rate.
                 */
-               WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc,
false) !=3D 0);
+               if (vrr_gates_vupdate)
+
WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) !=3D 0);
                drm_crtc_vblank_put(new_state->base.crtc);
                drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR
on->off: Drop vblank ref\n",
                                 __func__, new_state->base.crtc->base.id);


Cool, only one line changed. And no need to plumb the function
parameter.

>=20
> >=20
> > >=20
> > > >=20
> > > > I had to fix it up with something like:
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > index e09c0eb9f865..ee337ca816cf 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > @@ -10085,8 +10085,16 @@ static void amdgpu_dm_handle_vrr_transition(=
struct amdgpu_display_manager *dm,
> > > >  					    struct dm_crtc_state *old_state,
> > > >  					    struct dm_crtc_state *new_state)
> > > >  {
> > > > +	struct amdgpu_device *adev =3D dm->adev;
> > > >  	bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
> > > >  	bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
> > > > +	/*
> > > > +	 * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completi=
on
> > > > +	 * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
> > > > +	 * vblank is enabled, so it must not be toggled with the VRR state.
> > > > +	 * Only DCE gates vupdate on VRR.
> > > > +	 */
> > > > +	bool vrr_gates_vupdate =3D amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=
=3D 0;
> > > > =20
> > > >  	if (!old_vrr_active && new_vrr_active) {
> > > >  		/* Transition VRR inactive -> active:
> > > > @@ -10097,7 +10105,8 @@ static void amdgpu_dm_handle_vrr_transition(s=
truct amdgpu_display_manager *dm,
> > > >  		 * We also need vupdate irq for the actual core vblank handling
> > > >  		 * at end of vblank.
> > > >  		 */
> > > > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true)=
 !=3D 0);
> > > > +		if (vrr_gates_vupdate)
> > > > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true=
) !=3D 0);
> > > >  		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
> > > >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR off->=
on: Get vblank ref\n",
> > > >  				 __func__, new_state->base.crtc->base.id);
> > > > @@ -10113,7 +10122,8 @@ static void amdgpu_dm_handle_vrr_transition(s=
truct amdgpu_display_manager *dm,
> > > >  		/* Transition VRR active -> inactive:
> > > >  		 * Allow vblank irq disable again for fixed refresh rate.
> > > >  		 */
> > > > -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false=
) !=3D 0);
> > > > +		if (vrr_gates_vupdate)
> > > > +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, fals=
e) !=3D 0);
> > > >  		drm_crtc_vblank_put(new_state->base.crtc);
> > > >  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR on->o=
ff: Drop vblank ref\n",
> > > >  				 __func__, new_state->base.crtc->base.id);
> > > >=20
> > > > Feel free to fold some version of this into the next version if it ma=
kes sense, or pick it up with my s-o-b.
> > > >=20
> > > > Thanks,
> > > > Matthew
> > > >=20
> > >=20

--===============2250668937904870351==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmo3bHoACgkQjWyYR59K
3nHmyg//eQaecyfK4uGpVyPR9B8lKp0Mv6cVstVpjK7r4qcftZJzXerAbtHlXfa1
UZXgBCAwmTzmgEFWqZPYUAKjWzo5sHksW9yAijWDsYxId6KsRuUpBC1m5BZI1VQm
JA49lbsREa6261Cxgv0sOFpiGb1wpyvWCwX3LErcE1fJi747BObGBpnxg5EwBElP
LAHRTerfUtQ4bJKWR79TxCKkCFbalyfPB/G035ZQTlrn40hFp4rKSPhMN7DRt3LQ
g+3wBdlWkV2A8kG4VBsw8NZr5xNHHvprWX0SBndHDi8RqpijEUcFX0a4R0pVH0nm
PyIZC+bt3ZlM9elkVBKZqk0TrwD3WW3DhO+vYsqLK9cUa6csA1oApL9l/Y4ahb1W
MvjUNfFvNMUTuIkR66r3bX7P0WqxaIJQTqRARwGoy7kI4mg6LQFBPjGhQvPR//zU
JCGWlLaIHuipvCx2dFEx7qPH2r22cNV7/A1Kq+Frt0vo1qZLO5AJwwkaxE8cPkeX
+Ba0xJy0Tt4WxljmxWyHDnkkCFqdfxKjQSKqbMQCjHqp6RJKQIgBJk3TUMa2mjeS
g5Ics2jeqRc9wYHLB6iXcKaRckScW9NbG9wE9bzGkId6aMyorAhVJAFtWfqo93gl
aZYwygQKutkCIGKqs/pzJTTRL71/ubrVLeabmAvWW6jaHLDhhJE=
=yVKU
-----END PGP SIGNATURE-----

--===============2250668937904870351==--
